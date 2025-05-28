#include "fork.h"
#include "pipe.h"
#include "mmap.h"
#include <unistd.h>
#include <sys/mman.h>

pid_t posix_fork(void)
{
    return fork();
}

int posix_pipe(int pipefd[2])
{
    return pipe(pipefd);
}

void *posix_mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
{
    return mmap(addr, length, prot, flags, fd, offset);
}

int posix_msync(void *addr, size_t length, int flags)
{
    return msync(addr, length, flags);
}
