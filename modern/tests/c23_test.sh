#!/bin/sh
# Build and run the C23 demo program.
CC=${CC:-clang}
set -e
$CC -std=c23 -Wall -Wextra -Werror c23_hello.c -o c23_hello
./c23_hello > output.txt
if grep -q "Hello from C23" output.txt; then
    echo "C23 executable ran successfully"
    exit 0
else
    echo "C23 executable failed" >&2
    exit 1
fi
