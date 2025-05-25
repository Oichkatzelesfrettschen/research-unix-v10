.PHONY: all kernel test check clean

all: kernel test

kernel:
	$(MAKE) -C v10/sys

test: check

check:
	$(MAKE) -C modern/tests check

clean:
	$(MAKE) -C v10/sys clean
	$(MAKE) -C modern/tests clean
