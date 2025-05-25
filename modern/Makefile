CC=clang
CFLAGS=-std=c23 -Wall -Wextra -pedantic

SRCS=acd_c23.c args.c spinlock.c
OBJS=$(SRCS:.c=.o)

all: acd

acd: $(OBJS)
$(CC) $(CFLAGS) $(OBJS) -o $@

clean:
rm -f $(OBJS) acd

.PHONY: all clean
