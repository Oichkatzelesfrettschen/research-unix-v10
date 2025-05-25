#!/bin/sh
set -e
# Build client if not built via Makefile
clang -std=c23 -Wall -Wextra -Werror capnp_client.c \
    -I ../../v10/ipc/capnp -L ../../v10/ipc/capnp -lcapnp -o capnp_client
./capnp_client msg.bin
../../tools/memserver/memserver msg.bin > capnp_out.txt
if grep -q "addr=0x12345678" capnp_out.txt; then
    echo "capnp example passed"
    exit 0
else
    echo "capnp example failed" >&2
    exit 1
fi
