#include <mqueue.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>

#define QUEUE_NAME "/mq_timeout_test"
#define MSG_SIZE 16

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
    struct timespec ts;
    clock_gettime(CLOCK_REALTIME, &ts);
    ts.tv_sec += 1; // 1 second timeout
    char buf[MSG_SIZE];
    int r = mq_timedreceive(mq, buf, sizeof(buf), NULL, &ts);
    int ok = (r == -1 && errno == ETIMEDOUT);
    mq_close(mq);
    mq_unlink(QUEUE_NAME);
    return ok ? 0 : 1;
}
