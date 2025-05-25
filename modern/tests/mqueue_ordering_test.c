#include <mqueue.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

#define QUEUE_NAME "/mq_ordering_test"
#define MSG_SIZE 32
#define MSG_COUNT 3

static const char *messages[MSG_COUNT] = {"msg1", "msg2", "msg3"};

static void *receiver(void *arg)
{
    mqd_t mq = *(mqd_t *)arg;
    char buf[MSG_SIZE];
    for(int i=0;i<MSG_COUNT;i++) {
        ssize_t n = mq_receive(mq, buf, sizeof(buf), NULL);
        if(n < 0) {
            perror("mq_receive");
            exit(1);
        }
        buf[n] = '\0';
        if(strcmp(buf, messages[i]) != 0) {
            fprintf(stderr, "expected %s got %s\n", messages[i], buf);
            exit(1);
        }
    }
    return NULL;
}

int main(void)
{
    struct mq_attr attr = {0};
    attr.mq_maxmsg = 10;
    attr.mq_msgsize = MSG_SIZE;
    mq_unlink(QUEUE_NAME);
    mqd_t mq = mq_open(QUEUE_NAME, O_CREAT|O_RDWR, 0600, &attr);
    if(mq == (mqd_t)-1) {
        perror("mq_open");
        return 1;
    }

    pthread_t tid;
    if(pthread_create(&tid, NULL, receiver, &mq) != 0) {
        perror("pthread_create");
        return 1;
    }
    for(int i=0;i<MSG_COUNT;i++) {
        if(mq_send(mq, messages[i], strlen(messages[i]), 0) < 0) {
            perror("mq_send");
            return 1;
        }
    }
    pthread_join(tid, NULL);
    mq_close(mq);
    mq_unlink(QUEUE_NAME);
    puts("ordering ok");
    return 0;
}
