#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include "../../v10/ipc/h/mailbox.h"
#include "../../v10/ipc/h/mailbox_t.h"

static mailbox_t mb1, mb2;

static void *sender1(void *arg)
{
    (void)arg;
    struct timespec ts1 = {0};
    ts1.tv_nsec = 100000000; /* 100ms */
    nanosleep(&ts1, NULL); /* 10 ticks */
    const char msg[] = "one";
    mailbox_send(&mb1, msg, sizeof(msg));
    return NULL;
}

static void *sender2(void *arg)
{
    (void)arg;
    struct timespec ts2 = {0};
    ts2.tv_nsec = 200000000; /* 200ms */
    nanosleep(&ts2, NULL); /* 20 ticks */
    const char msg[] = "two";
    mailbox_send(&mb2, msg, sizeof(msg));
    return NULL;
}

int main(void)
{
    mailbox_init(&mb1);
    mailbox_init(&mb2);

    pthread_t t1, t2;
    pthread_create(&t1, NULL, sender1, NULL);
    pthread_create(&t2, NULL, sender2, NULL);

    char buf[8];
    size_t len = sizeof(buf);
    int r1 = Recv_T(&mb2, buf, &len, 15);
    int ok1 = (r1 == -1);

    len = sizeof(buf);
    int r2 = Recv_T(&mb1, buf, &len, 15);
    int ok2 = (r2 == 0 && strcmp(buf, "one") == 0);

    len = sizeof(buf);
    int r3 = Recv_T(&mb2, buf, &len, 30);
    int ok3 = (r3 == 0 && strcmp(buf, "two") == 0);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    return (ok1 && ok2 && ok3) ? 0 : 1;
}
