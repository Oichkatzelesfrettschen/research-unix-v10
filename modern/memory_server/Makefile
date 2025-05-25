CC ?= clang
CFLAGS ?= -Wall -Wextra -Werror

all: memory_server

memory_server: memory_server.c ../libcapnp/libcapnp.a
	$(CC) $(CFLAGS) $< ../libcapnp/libcapnp.a -o $@

clean:
	rm -f memory_server
