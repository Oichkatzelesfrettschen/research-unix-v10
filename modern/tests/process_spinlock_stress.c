#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <unistd.h>
#include "../../v10/ipc/h/spinlock.h"

#define PROCESSES 4
#define ITERATIONS 10000

typedef struct {
    SPINLOCK_ALIGNED spinlock_t lock;
    int counter;
} shared_t;

int main(void)
{
    shared_t *shared = mmap(NULL, sizeof(shared_t), PROT_READ|PROT_WRITE,
                            MAP_SHARED|MAP_ANONYMOUS, -1, 0);
    if(shared == MAP_FAILED) {
        perror("mmap");
        return 1;
    }
    shared->lock = (spinlock_t)SPINLOCK_INITIALIZER;
    shared->counter = 0;

    for(int i = 0; i < PROCESSES; i++) {
        pid_t pid = fork();
        if(pid == 0) {
            for(int j = 0; j < ITERATIONS; j++) {
                spin_lock(&shared->lock);
                shared->counter++;
                spin_unlock(&shared->lock);
            }
            _exit(0);
        }
    }

    for(int i = 0; i < PROCESSES; i++)
        wait(NULL);

    printf("counter=%d\n", shared->counter);
    int expected = PROCESSES * ITERATIONS;
    return shared->counter == expected ? 0 : 1;
}
