CROSS_COMPILE ?=
CC ?= $(CROSS_COMPILE)gcc
CFLAGS ?= -O
CFLAGS += -std=c23 -I ..

SRC_C := $(wildcard *.c)
# ensure scheduler lock support is built
SRC_C += sched_lock.c
SRC_S := $(wildcard *.s)
OBJ := $(SRC_C:.c=.o) $(SRC_S:.s=.o)

.PHONY: all clean

all: $(OBJ)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ)
