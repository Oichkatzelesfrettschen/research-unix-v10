#include "h/spinlock.h"

SPINLOCK_ALIGNED spinlock_t ipc_lock = SPINLOCK_INITIALIZER;

#ifdef SMP_ENABLED
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
