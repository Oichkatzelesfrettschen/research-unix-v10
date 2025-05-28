#ifndef MODERN_COMPAT_POSIX_MMAP_H
#define MODERN_COMPAT_POSIX_MMAP_H

#include <sys/types.h>
#include <sys/mman.h>

#ifdef __cplusplus
extern "C" {
#endif

void *posix_mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
int posix_msync(void *addr, size_t length, int flags);

#ifdef __cplusplus
}
#endif

#endif /* MODERN_COMPAT_POSIX_MMAP_H */
