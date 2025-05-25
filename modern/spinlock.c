#include <stdatomic.h>

static atomic_flag lock = ATOMIC_FLAG_INIT;

void lock_acquire(void)
{
    while (atomic_flag_test_and_set(&lock)) {
        ;
    }
}

void lock_release(void)
{
    atomic_flag_clear(&lock);
}
