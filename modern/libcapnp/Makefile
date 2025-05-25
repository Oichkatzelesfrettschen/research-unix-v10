CC ?= clang
CFLAGS ?= -Wall -Wextra -Werror -fPIC

LIB = libcapnp.a
OBJS = capnp.o

all: $(LIB)

$(LIB): $(OBJS)
	ar rcs $@ $(OBJS)

clean:
	rm -f $(LIB) $(OBJS)
