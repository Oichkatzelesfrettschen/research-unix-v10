CROSS_COMPILE ?=
CC ?= $(CROSS_COMPILE)gcc
CFLAGS ?= -O
CFLAGS += -std=c23 -I .. -Wall -Werror

SRC_C := $(wildcard *.c)
OBJ := $(SRC_C:.c=.o)

.PHONY: all clean

all: $(OBJ)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ)
