#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include "../../v10/ipc/h/spinlock.h"

static SPINLOCK_ALIGNED spinlock_t lock = SPINLOCK_INITIALIZER;
static int order[2] = {-1, -1};
static int index = 0;

void *worker(void *arg)
{
    long id = (long)arg;
    spin_lock(&lock);
    order[id] = index++;
    spin_unlock(&lock);
    return NULL;
}

int main(void)
{
    pthread_t t1, t2;

    /* Hold the lock so both threads queue up */
    spin_lock(&lock);
    pthread_create(&t1, NULL, worker, (void *)0);
    usleep(10000); /* ensure thread 0 waits first */
    pthread_create(&t2, NULL, worker, (void *)1);
    usleep(10000);
    spin_unlock(&lock);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if(order[0] == 0 && order[1] == 1) {
        printf("spinlock fairness test passed\n");
        return 0;
    } else {
        printf("spinlock fairness test failed: order=%d,%d\n", order[0], order[1]);
        return 1;
    }
}
