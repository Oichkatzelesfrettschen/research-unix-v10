.PHONY: test clean check

test: check

check:
	$(MAKE) -C modern/tests check

clean:
	$(MAKE) -C modern/tests clean
