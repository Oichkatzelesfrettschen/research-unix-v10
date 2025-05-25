#ifndef MODERN_COMPAT_POSIX_PIPE_H
#define MODERN_COMPAT_POSIX_PIPE_H

#ifdef __cplusplus
extern "C" {
#endif

int posix_pipe(int pipefd[2]);

#ifdef __cplusplus
}
#endif

#endif /* MODERN_COMPAT_POSIX_PIPE_H */
