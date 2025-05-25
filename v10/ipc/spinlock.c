#include "h/spinlock.h"

spinlock_t ipc_lock = SPINLOCK_INITIALIZER;

#ifdef SMP_ENABLED
#ifndef USE_TICKET_LOCK
void spin_lock(spinlock_t *lock)
{
    while(__sync_lock_test_and_set(&lock->locked, 1)) {
        while(lock->locked)
            ;
    }
}

void spin_unlock(spinlock_t *lock)
{
    __sync_lock_release(&lock->locked);
}
#else
void spin_lock(spinlock_t *lock)
{
    unsigned ticket = __sync_fetch_and_add(&lock->next, 1);
    while(__sync_val_compare_and_swap(&lock->owner, ticket, ticket) != ticket) {
        /* busy wait */
    }
}

void spin_unlock(spinlock_t *lock)
{
    __sync_fetch_and_add(&lock->owner, 1);
}
#endif
#endif /* SMP_ENABLED */
