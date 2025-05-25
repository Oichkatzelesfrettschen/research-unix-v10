#ifndef SPINLOCK_H
#define SPINLOCK_H

#include <stdint.h>

#if defined(__GCC_DESTRUCTIVE_SIZE)
#define SPINLOCK_CACHE_LINE_SIZE __GCC_DESTRUCTIVE_SIZE
#elif defined(__x86_64__) || defined(__i386__)
#define SPINLOCK_CACHE_LINE_SIZE 64
#elif defined(__aarch64__) || defined(__arm__)
#define SPINLOCK_CACHE_LINE_SIZE 64
#elif defined(__powerpc64__) || defined(__powerpc__)
#define SPINLOCK_CACHE_LINE_SIZE 128
#else
#define SPINLOCK_CACHE_LINE_SIZE 64
#endif

static inline unsigned spinlock_cache_line_size(void)
{
    return SPINLOCK_CACHE_LINE_SIZE;
}

#ifndef CACHE_LINE_SIZE
#define CACHE_LINE_SIZE SPINLOCK_CACHE_LINE_SIZE
#endif

#ifdef USE_TICKET_LOCK
typedef struct {
    volatile unsigned next;
    volatile unsigned owner;
} spinlock_t __attribute__((aligned(CACHE_LINE_SIZE)));
#else
typedef struct {
    volatile int locked;
} spinlock_t __attribute__((aligned(CACHE_LINE_SIZE)));
#endif

#define SPINLOCK_INITIALIZER {0}

#ifdef SMP_ENABLED
void spin_lock(spinlock_t *lock);
void spin_unlock(spinlock_t *lock);
#else
#define spin_lock(l) ((void)0)
#define spin_unlock(l) ((void)0)
#endif

#endif /* SPINLOCK_H */
