CROSS_COMPILE ?=
CC = $(CROSS_COMPILE)clang
CFLAGS ?= -std=c23 -Wall -Wextra -Werror -I../../v10/ipc/capnp
LIBCAPNP = ../../v10/ipc/capnp/libcapnp.a

all: memserver

memserver: memserver.o $(LIBCAPNP)
	$(CC) $(CFLAGS) memserver.o $(LIBCAPNP) -o $@

memserver.o: memserver.c ../../v10/ipc/capnp/capnp.h
	$(CC) $(CFLAGS) -c memserver.c -o $@

$(LIBCAPNP):
	$(MAKE) -C ../../v10/ipc/capnp CROSS_COMPILE=$(CROSS_COMPILE)

clean:
	rm -f memserver memserver.o
	$(MAKE) -C ../../v10/ipc/capnp clean

.PHONY: all clean
