ARCH ?= $(shell uname -m)
CROSS_COMPILE ?=
CC ?= $(CROSS_COMPILE)gcc
CFLAGS ?= -O
LDFLAGS ?=
SMP ?= 0

ifeq ($(SMP),1)
SPINLOCK=-DSPINLOCK_TICKET
else
SPINLOCK=-DSPINLOCK_UNIPROCESSOR
endif

CFLAGS += -std=c23 $(SPINLOCK) -I.

export CROSS_COMPILE ARCH CC CFLAGS SMP

SUBDIRS = os vm md io fs ml inet
SRC_C := $(foreach d,$(SUBDIRS),$(wildcard $(d)/*.c))
SRC_S := $(foreach d,$(SUBDIRS),$(wildcard $(d)/*.s))
OBJ := $(SRC_C:.c=.o) $(SRC_S:.s=.o)

KERNEL = unix

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS) $(KERNEL)

$(SUBDIRS):
	$(MAKE) -C $@

$(KERNEL): $(OBJ)
$(CC) $(LDFLAGS) -nostdlib -o $@ $(OBJ)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	for d in $(SUBDIRS); do $(MAKE) -C $$d clean; done
	rm -f $(OBJ) $(KERNEL)

