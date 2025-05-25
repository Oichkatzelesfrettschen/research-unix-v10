#include <mqueue.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>

#define QUEUE_NAME "/mq_blocking_test"
#define MSG "ping"
#define MSG_SIZE 16

static void *sender(void *arg)
{
    (void)arg;
    mqd_t mq = mq_open(QUEUE_NAME, O_WRONLY);
    if(mq == (mqd_t)-1) {
        perror("mq_open child");
        exit(1);
    }
    usleep(500000); // send after 0.5s
    if(mq_send(mq, MSG, strlen(MSG), 0) < 0) {
        perror("mq_send");
        exit(1);
    }
    mq_close(mq);
    return NULL;
}

int main(void)
{
    struct mq_attr attr = {0};
    attr.mq_maxmsg = 10;
    attr.mq_msgsize = MSG_SIZE;
    mq_unlink(QUEUE_NAME);
    mqd_t mq = mq_open(QUEUE_NAME, O_CREAT|O_RDONLY, 0600, &attr);
    if(mq == (mqd_t)-1) {
        perror("mq_open");
        return 1;
    }
    pthread_t tid;
    if(pthread_create(&tid, NULL, sender, NULL) != 0) {
        perror("pthread_create");
        return 1;
    }
    char buf[MSG_SIZE];
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    ssize_t n = mq_receive(mq, buf, sizeof(buf), NULL);
    clock_gettime(CLOCK_MONOTONIC, &end);
    pthread_join(tid, NULL);
    if(n < 0) {
        perror("mq_receive");
        return 1;
    }
    double elapsed = end.tv_sec - start.tv_sec +
                     (end.tv_nsec - start.tv_nsec)/1e9;
    buf[n] = '\0';
    int ok = strcmp(buf, MSG) == 0 && elapsed >= 0.5;
    mq_close(mq);
    mq_unlink(QUEUE_NAME);
    printf("elapsed=%.2f\n", elapsed);
    return ok ? 0 : 1;
}
