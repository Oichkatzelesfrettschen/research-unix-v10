#!/bin/sh
set -e
cc -std=c23 -pthread thread_spinlock_stress.c ../../v10/ipc/spinlock.c -I ../compat -I ../../v10/ipc/h -DSMP_ENABLED -o thread_spinlock_stress
./thread_spinlock_stress > thread_spinlock_output.txt
if grep -q "counter=400000" thread_spinlock_output.txt; then
    echo "thread spinlock stress test passed"
    exit 0
else
    echo "thread spinlock stress test failed" >&2
    exit 1
fi
