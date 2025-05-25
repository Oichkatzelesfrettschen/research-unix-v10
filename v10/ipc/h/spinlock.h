#ifndef SPINLOCK_H
#define SPINLOCK_H

#include <stdint.h>

#if defined(__x86_64__) || defined(__i386__)
static inline unsigned spinlock_cache_line_size(void)
{
#if defined(__i386__)
    unsigned int flags, tmp;

    __asm__ volatile(
        "pushfl\n\t"
        "popl %0\n\t"
        "movl %0,%1\n\t"
        "xorl $0x200000,%0\n\t"
        "pushl %0\n\t"
        "popfl\n\t"
        "pushfl\n\t"
        "popl %0\n\t"
        "xorl %1,%0"
        : "=&r"(flags), "=&r"(tmp)
        :
        : "cc");

    if (!(flags & 0x200000))
        return 64;
#endif

    unsigned int eax, ebx, ecx, edx;
    eax = 0x80000006;
    __asm__ __volatile__("cpuid"
                         : "=a"(eax), "=b"(ebx), "=c"(ecx), "=d"(edx)
                         : "a"(eax));
    if (ecx & 0xFF)
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
