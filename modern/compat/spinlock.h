#ifndef MODERN_COMPAT_SPINLOCK_H
#define MODERN_COMPAT_SPINLOCK_H

#include <stdint.h>
#include <stdatomic.h>
#include <stdalign.h>

#ifndef ATOMIC_VAR_INIT
#define ATOMIC_VAR_INIT(value) (value)
#endif

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

#define SPINLOCK_ALIGNED alignas(CACHE_LINE_SIZE)
#ifdef USE_TICKET_LOCK
typedef struct {
    atomic_uint next;
    atomic_uint owner;
} spinlock_t;
#define SPINLOCK_INITIALIZER { ATOMIC_VAR_INIT(0), ATOMIC_VAR_INIT(0) }
#else
typedef struct {
    atomic_flag locked;
} spinlock_t;
#define SPINLOCK_INITIALIZER { ATOMIC_FLAG_INIT }
#endif

#ifdef SMP_ENABLED
void spin_lock(spinlock_t *lock);
void spin_unlock(spinlock_t *lock);
#else
#define spin_lock(l) ((void)0)
#define spin_unlock(l) ((void)0)
#endif

#endif /* MODERN_COMPAT_SPINLOCK_H */
