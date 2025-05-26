#include "fork.h"
#include "pipe.h"
#include "wait.h"
#include "exec.h"

#include <unistd.h>
#include <sys/wait.h>

pid_t posix_fork(void)
{
    return fork();
}

int posix_pipe(int pipefd[2])
{
    return pipe(pipefd);
}

pid_t posix_waitpid(pid_t pid, int *status, int options)
{
    return waitpid(pid, status, options);
}

int posix_execve(const char *path, char *const argv[], char *const envp[])
{
    return execve(path, argv, envp);
}
