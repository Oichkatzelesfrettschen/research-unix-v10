#include <pthread.h>
#include <stdio.h>
#include "../compat/spinlock.h"

#define THREADS 4
#define ITERATIONS 100000

static SPINLOCK_ALIGNED spinlock_t lock = SPINLOCK_INITIALIZER;
static int counter = 0;

void *worker(void *arg)
{
    for(int i = 0; i < ITERATIONS; i++) {
        spin_lock(&lock);
        counter++;
        spin_unlock(&lock);
    }
    return NULL;
}

int main(void)
{
    pthread_t t[THREADS];
    for(int i = 0; i < THREADS; i++)
        pthread_create(&t[i], NULL, worker, NULL);
    for(int i = 0; i < THREADS; i++)
        pthread_join(t[i], NULL);
    printf("counter=%d\n", counter);
    return counter == THREADS * ITERATIONS ? 0 : 1;
}
