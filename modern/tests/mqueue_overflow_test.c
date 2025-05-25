#include <mqueue.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>

#define QUEUE_NAME "/mq_overflow_test"
#define MSG_SIZE 16

int main(void)
{
    struct mq_attr attr = {0};
    attr.mq_maxmsg = 2;
    attr.mq_msgsize = MSG_SIZE;
    mq_unlink(QUEUE_NAME);
    mqd_t mq = mq_open(QUEUE_NAME, O_CREAT|O_RDWR | O_NONBLOCK, 0600, &attr);
    if(mq == (mqd_t)-1) {
        perror("mq_open");
        return 1;
    }
    if(mq_send(mq, "one", 3, 0) < 0) {
        perror("mq_send1");
        return 1;
    }
    if(mq_send(mq, "two", 3, 0) < 0) {
        perror("mq_send2");
        return 1;
    }
    int r = mq_send(mq, "three", 5, 0);
    int ok = (r == -1 && errno == EAGAIN);
    mq_close(mq);
    mq_unlink(QUEUE_NAME);
    return ok ? 0 : 1;
}
