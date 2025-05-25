CC ?= cc
CFLAGS ?= -O
LDFLAGS ?=
SMP ?= 0

ifeq ($(SMP),1)
SPINLOCK=-DSPINLOCK_TICKET
else
SPINLOCK=-DSPINLOCK_UNIPROCESSOR
endif

CFLAGS += $(SPINLOCK) -I.

SUBDIRS = os vm md io fs ml inet
SRC_C := $(foreach d,$(SUBDIRS),$(wildcard $(d)/*.c))
SRC_S := $(foreach d,$(SUBDIRS),$(wildcard $(d)/*.s))
OBJ := $(SRC_C:.c=.o) $(SRC_S:.s=.o)

KERNEL = unix

.PHONY: all clean

all: $(KERNEL)

$(KERNEL): $(OBJ)
$(CC) $(LDFLAGS) -nostdlib -o $@ $(OBJ)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(KERNEL)

