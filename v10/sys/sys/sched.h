#pragma once

#include "../../ipc/h/spinlock.h"

#ifdef SMP_ENABLED
extern spinlock_t sched_lock;
#endif

void sched_lock_acquire(void);
void sched_lock_release(void);
void sched_lock_init(void);

