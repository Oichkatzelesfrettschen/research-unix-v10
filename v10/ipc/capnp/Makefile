CROSS_COMPILE ?=
CC = $(CROSS_COMPILE)clang
AR = $(CROSS_COMPILE)ar
RANLIB = $(CROSS_COMPILE)ranlib
CFLAGS ?= -std=c23 -Wall -Wextra -Werror

LIB = libcapnp.a
OBJS = capnp.o

all: $(LIB)

$(LIB): $(OBJS)
	$(AR) rcs $@ $(OBJS)
	$(RANLIB) $@

capnp.o: capnp.c capnp.h
	$(CC) $(CFLAGS) -c capnp.c -o capnp.o

clean:
	rm -f $(OBJS) $(LIB)

.PHONY: all clean
