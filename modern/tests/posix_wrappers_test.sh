#!/bin/sh
set -e
CC=${CC:-clang}
$CC -std=c23 -Wall -Wextra -Werror \
    posix_wrappers_test.c ../compat/posix/posix.c -o posix_wrappers_test
./posix_wrappers_test > posix_wrappers_output.txt
if grep -q "posix wrapper tests passed" posix_wrappers_output.txt; then
    echo "posix wrappers test passed"
    exit 0
else
    echo "posix wrappers test failed" >&2
    exit 1
fi

