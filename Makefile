.PHONY: test clean

test:
	@echo "Running C23 tests..."
	@cd modern/tests && ./c23_test.sh
	@echo "Running spinlock tests..."
	@cd modern/tests && ./spinlock_test.sh

clean:
	@rm -f modern/tests/c23_hello modern/tests/output.txt
	@rm -f modern/tests/spinlock_test modern/tests/spinlock_output.txt
