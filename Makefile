.PHONY: test clean

test:
	@echo "Running C23 tests..."
	@cd modern/tests && ./c23_test.sh

clean:
	@rm -f modern/tests/c23_hello modern/tests/output.txt
