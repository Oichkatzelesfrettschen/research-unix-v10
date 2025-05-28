#ifndef MODERN_COMPAT_POSIX_WAIT_H
#define MODERN_COMPAT_POSIX_WAIT_H

#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#endif

pid_t posix_waitpid(pid_t pid, int *status, int options);

#ifdef __cplusplus
}
#endif

#endif /* MODERN_COMPAT_POSIX_WAIT_H */
