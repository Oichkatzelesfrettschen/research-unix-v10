#ifndef MODERN_COMPAT_POSIX_FORK_H
#define MODERN_COMPAT_POSIX_FORK_H

#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#endif

pid_t posix_fork(void);

#ifdef __cplusplus
}
#endif

#endif /* MODERN_COMPAT_POSIX_FORK_H */
