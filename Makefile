.PHONY: all kernel test check clean

ARCH ?= $(shell uname -m)
CROSS_COMPILE ?=
# Default to clang for building test utilities
CC = clang

all: kernel test

kernel:
	$(MAKE) -C v10/sys ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)

test: check
ifeq ($(CAPNP),1)
	$(MAKE) -C modern/libcapnp CC=$(CC) all
	$(MAKE) -C modern/memory_server CC=$(CC) all
	$(MAKE) -C modern/tests CC=$(CC) mailbox_timeout_test exo_ipc_status_test posix_wrappers_test capability_client
	./modern/memory_server/memory_server & \
	memsrv_pid=$$!; \
	./modern/tests/mailbox_timeout_test; \
	./modern/tests/exo_ipc_status_test; \
	./modern/tests/capability_integration_test.sh; \
	kill $$memsrv_pid
endif

check:
	$(MAKE) -C modern/tests CC=$(CC) check

clean:
	$(MAKE) -C v10/sys clean
	$(MAKE) -C modern/tests clean
	$(MAKE) -C modern/memory_server clean
	$(MAKE) -C modern/libcapnp clean
