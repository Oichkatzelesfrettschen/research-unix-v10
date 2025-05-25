#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

static int test_pipe(void) {
    int fds[2];
    if (pipe(fds) != 0) {
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
    pid_t pid = fork();
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

int main(void) {
    if (test_pipe() != 0)
        return 1;
    if (test_fork_exec() != 0)
        return 1;
    printf("posix wrapper tests passed\n");
    return 0;
}
