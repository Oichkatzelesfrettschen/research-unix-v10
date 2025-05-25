.PHONY: all kernel test check clean capnp_tools

ARCH ?= $(shell uname -m)
CROSS_COMPILE ?=
CAPNP ?= 0

all: kernel test
ifeq ($(CAPNP),1)
all: capnp_tools
endif

kernel:
	$(MAKE) -C v10/sys ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) CAPNP=$(CAPNP)

test: check

check:
	$(MAKE) -C modern/tests CAPNP=$(CAPNP) check

clean:
	$(MAKE) -C v10/sys clean
	$(MAKE) -C modern/tests clean
ifeq ($(CAPNP),1)
	$(MAKE) -C v10/ipc/capnp clean
	$(MAKE) -C tools/memserver clean
endif

capnp_tools:
	$(MAKE) -C v10/ipc/capnp CROSS_COMPILE=$(CROSS_COMPILE)
	$(MAKE) -C tools/memserver CROSS_COMPILE=$(CROSS_COMPILE)
