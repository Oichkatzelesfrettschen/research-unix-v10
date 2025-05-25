#!/bin/sh
set -e
clang -std=c23 -Wall -Wextra -Werror -pthread process_spinlock_stress.c ../../v10/ipc/spinlock.c -I ../compat -I ../../v10/ipc/h -DSMP_ENABLED -o process_spinlock_stress
./process_spinlock_stress > process_spinlock_output.txt
if grep -q "counter=40000" process_spinlock_output.txt; then
    echo "process spinlock stress test passed"
    exit 0
else
    echo "process spinlock stress test failed" >&2
    exit 1
fi
