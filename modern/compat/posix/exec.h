#ifndef MODERN_COMPAT_POSIX_EXEC_H
#define MODERN_COMPAT_POSIX_EXEC_H

#ifdef __cplusplus
extern "C" {
#endif

int posix_execve(const char *pathname, char *const argv[], char *const envp[]);

#ifdef __cplusplus
}
#endif

#endif /* MODERN_COMPAT_POSIX_EXEC_H */
