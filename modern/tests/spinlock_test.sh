#!/bin/sh
set -e
cc -pthread spinlock_test.c ../../v10/ipc/spinlock.c -I ../../v10/ipc/h -DSMP_ENABLED -o spinlock_test
./spinlock_test > spinlock_output.txt
if grep -q "counter=200000" spinlock_output.txt; then
    echo "spinlock test passed"
    exit 0
else
    echo "spinlock test failed" >&2
    exit 1
fi
