#include "fork.h"
#include "pipe.h"
#include <unistd.h>

pid_t posix_fork(void)
{
    return fork();
}

int posix_pipe(int pipefd[2])
{
    return pipe(pipefd);
}
