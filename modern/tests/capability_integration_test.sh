#!/bin/sh
set -e
CC=${CC:-clang}
# Build libraries and server
make -C ../libcapnp CC=$CC >/dev/null
make -C ../memory_server CC=$CC >/dev/null
# Build client
$CC -std=c23 -Wall -Wextra -Werror capability_client.c ../libcapnp/libcapnp.a -o capability_client
# Run server and client
../memory_server/memory_server &
server_pid=$!
./capability_client > capability_client_output.txt
kill $server_pid || true
if grep -q "capnp init ok" capability_client_output.txt; then
    echo "capability integration test passed"
    exit 0
else
    echo "capability integration test failed" >&2
    exit 1
fi
