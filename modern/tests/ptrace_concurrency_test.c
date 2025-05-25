#define _XOPEN_SOURCE 700
#define _POSIX_C_SOURCE 200809L
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <time.h>

#define CHILDREN 4

static pid_t children[CHILDREN];

void *tracer(void *arg)
{
    pid_t pid = *(pid_t *)arg;
    if(ptrace(PTRACE_ATTACH, pid, NULL, NULL) == -1) {
        perror("ptrace attach");
        return (void *)1;
    }
    waitpid(pid, NULL, 0);
    ptrace(PTRACE_CONT, pid, NULL, NULL);
    struct timespec ts = {0};
    ts.tv_nsec = 100000000; /* 100ms */
    nanosleep(&ts, NULL);
    ptrace(PTRACE_DETACH, pid, NULL, NULL);
    return NULL;
}

int main(void)
{
    for(int i = 0; i < CHILDREN; i++) {
        pid_t pid = fork();
        if(pid == 0) {
            raise(SIGSTOP);
            pause();
            _exit(0);
        }
        children[i] = pid;
    }

    pthread_t th[CHILDREN];
    for(int i = 0; i < CHILDREN; i++)
        pthread_create(&th[i], NULL, tracer, &children[i]);
    for(int i = 0; i < CHILDREN; i++)
        pthread_join(th[i], NULL);

    for(int i = 0; i < CHILDREN; i++) {
        kill(children[i], SIGKILL);
        waitpid(children[i], NULL, 0);
    }

    printf("ptrace concurrency test completed\n");
    return 0;
}
