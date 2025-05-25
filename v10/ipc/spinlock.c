#include "h/spinlock.h"

SPINLOCK_ALIGNED spinlock_t ipc_lock = SPINLOCK_INITIALIZER;

#if defined(SMP_ENABLED) && !defined(SPINLOCK_UNIPROCESSOR)
#ifndef USE_TICKET_LOCK
void spin_lock(spinlock_t *lock)
{
    while (atomic_flag_test_and_set_explicit(&lock->locked, memory_order_acquire)) {
        /* busy wait */
    }
}

void spin_unlock(spinlock_t *lock)
{
    atomic_flag_clear_explicit(&lock->locked, memory_order_release);
}
#else
void spin_lock(spinlock_t *lock)
{
    unsigned ticket = atomic_fetch_add_explicit(&lock->next, 1u, memory_order_relaxed);
    while (atomic_load_explicit(&lock->owner, memory_order_acquire) != ticket) {
        /* busy wait */
    }
}

void spin_unlock(spinlock_t *lock)
{
    atomic_fetch_add_explicit(&lock->owner, 1u, memory_order_release);
}
#endif
#endif /* SMP_ENABLED */

static unsigned detected_cache_line_size;

#if defined(__x86_64__) || defined(__i386__)
static void cpuid(unsigned int leaf, unsigned int subleaf,
                  unsigned int *a, unsigned int *b,
                  unsigned int *c, unsigned int *d)
{
#if defined(__i386__) && defined(__PIC__)
    __asm__ volatile("xchgl %%ebx, %1; cpuid; xchgl %%ebx, %1"
                     : "=a"(*a), "=&r"(*b), "=c"(*c), "=d"(*d)
                     : "0"(leaf), "2"(subleaf));
#else
    __asm__ volatile("cpuid"
                     : "=a"(*a), "=b"(*b), "=c"(*c), "=d"(*d)
                     : "0"(leaf), "2"(subleaf));
#endif
}

static unsigned detect_cache_line_size_x86(void)
{
    unsigned a, b, c, d;
    cpuid(1, 0, &a, &b, &c, &d);
    unsigned size = ((b >> 8) & 0xff) * 8;
    if (size == 0) {
        cpuid(0x80000006, 0, &a, &b, &c, &d);
        size = c & 0xff;
    }
    return size;
}
#endif

#if defined(__aarch64__)
static unsigned detect_cache_line_size_aarch64(void)
{
    unsigned long ctr;
    __asm__ volatile("mrs %0, ctr_el0" : "=r"(ctr));
    unsigned dminline = (ctr >> 16) & 0xf;
    return 4u << dminline;
}
#endif

static unsigned detect_cache_line_size(void)
{
#if defined(__x86_64__) || defined(__i386__)
    unsigned size = detect_cache_line_size_x86();
    return size ? size : SPINLOCK_CACHE_LINE_SIZE;
#elif defined(__aarch64__)
    unsigned size = detect_cache_line_size_aarch64();
    return size ? size : SPINLOCK_CACHE_LINE_SIZE;
#else
    return SPINLOCK_CACHE_LINE_SIZE;
#endif
}

unsigned spinlock_runtime_cache_line_size(void)
{
    if (detected_cache_line_size == 0)
        detected_cache_line_size = detect_cache_line_size();
    return detected_cache_line_size;
}
