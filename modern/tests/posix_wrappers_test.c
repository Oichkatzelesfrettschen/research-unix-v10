#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/mman.h>

#include "../compat/posix/fork.h"
#include "../compat/posix/pipe.h"
#include "../compat/posix/mmap.h"

static int test_pipe(void) {
    int fds[2];
    if (posix_pipe(fds) != 0) {
        perror("pipe");
        return 1;
    }
    const char msg[] = "hello";
    if (write(fds[1], msg, sizeof(msg)) != sizeof(msg)) {
        perror("write");
        return 1;
    }
    char buf[sizeof(msg)];
    if (read(fds[0], buf, sizeof(buf)) != sizeof(msg)) {
        perror("read");
        return 1;
    }
    close(fds[0]);
    close(fds[1]);
    return memcmp(buf, msg, sizeof(msg)) == 0 ? 0 : 1;
}

static int test_fork_exec(void) {
    pid_t pid = posix_fork();
    if (pid < 0) {
        perror("fork");
        return 1;
    }
    if (pid == 0) {
        char *const argv[] = {"/bin/true", NULL};
        execv("/bin/true", argv);
        _exit(1);
    }
    int status;
    if (waitpid(pid, &status, 0) < 0) {
        perror("waitpid");
        return 1;
    }
    if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
        return 1;
    return 0;
}

static int test_mmap(void) {
    size_t page = 4096;
    void *p = posix_mmap(NULL, page, PROT_READ | PROT_WRITE,
                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (p == MAP_FAILED) {
        perror("mmap");
        return 1;
    }
    memset(p, 0xA5, page);
    if (posix_msync(p, page, MS_SYNC) != 0) {
        perror("msync");
        munmap(p, page);
        return 1;
    }
    if (munmap(p, page) != 0) {
        perror("munmap");
        return 1;
    }
    return 0;
}

int main(void) {
    if (test_pipe() != 0)
        return 1;
    if (test_fork_exec() != 0)
        return 1;
    if (test_mmap() != 0)
        return 1;
    printf("posix wrapper tests passed\n");
    return 0;
}

