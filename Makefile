.PHONY: all kernel test check clean

ARCH ?= $(shell uname -m)
CROSS_COMPILE ?=

all: kernel test

kernel:
	$(MAKE) -C v10/sys ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)

test: check

check:
	$(MAKE) -C modern/tests check

clean:
	$(MAKE) -C v10/sys clean
	$(MAKE) -C modern/tests clean
