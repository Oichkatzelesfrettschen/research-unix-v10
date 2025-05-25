#!/bin/sh
set -e
CC=${CC:-clang}
$CC -std=c23 -Wall -Wextra -Werror -pthread ptrace_concurrency_test.c -o ptrace_concurrency_test
./ptrace_concurrency_test > ptrace_concurrency_output.txt
if grep -q "ptrace concurrency test completed" ptrace_concurrency_output.txt; then
    echo "ptrace concurrency test passed"
    exit 0
else
    echo "ptrace concurrency test failed" >&2
    exit 1
fi
