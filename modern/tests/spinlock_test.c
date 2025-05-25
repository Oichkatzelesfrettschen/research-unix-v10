#include <pthread.h>
#include <stdio.h>
#include "../compat/spinlock.h"

static SPINLOCK_ALIGNED spinlock_t lock = SPINLOCK_INITIALIZER;
static int counter = 0;

void *worker(void *arg)
{
    (void)arg;
    for(int i=0; i<100000; i++) {
        spin_lock(&lock);
        counter++;
        spin_unlock(&lock);
    }
    return NULL;
}

int main(void)
{
    pthread_t t1, t2;
    pthread_create(&t1, NULL, worker, NULL);
    pthread_create(&t2, NULL, worker, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    printf("counter=%d\n", counter);
    return counter==200000 ? 0 : 1;
}
