#include "sys/sched.h"

#ifdef SPINLOCK_UNIPROCESSOR

void sched_lock_acquire(void) {}
void sched_lock_release(void) {}

#else
SPINLOCK_ALIGNED spinlock_t sched_lock = SPINLOCK_INITIALIZER;

void sched_lock_acquire(void)
{
    spin_lock(&sched_lock);
}

void sched_lock_release(void)
{
    spin_unlock(&sched_lock);
}
#endif

