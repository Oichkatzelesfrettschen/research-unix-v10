#ifndef SPINLOCK_H
#define SPINLOCK_H

#include <stdint.h>

#if defined(__x86_64__) || defined(__i386__)
static inline unsigned spinlock_cache_line_size(void)
{
    unsigned int eax, ebx, ecx, edx;
    eax = 0x80000006;
    __asm__ __volatile__("cpuid" : "=a"(eax), "=b"(ebx), "=c"(ecx), "=d"(edx) : "a"(eax));
    if(ecx & 0xFF)
        return ecx & 0xFF;
    return 64;
}
#else
static inline unsigned spinlock_cache_line_size(void)
{
    return 64;
}
#endif

#ifndef CACHE_LINE_SIZE
#define CACHE_LINE_SIZE 64
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
