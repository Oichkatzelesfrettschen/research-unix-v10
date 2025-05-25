# Set CROSS_COMPILE using `source tools/cross-env.sh <arch>`
CROSS_COMPILE ?=
CC ?= $(CROSS_COMPILE)gcc
CFLAGS = -std=c23 -pthread -I ../compat -I ../../v10/ipc/h -DSMP_ENABLED
SPINLOCK_SRC = ../../v10/ipc/spinlock.c

TESTS = c23_hello spinlock_test thread_spinlock_stress \
	process_spinlock_stress ptrace_concurrency_test spinlock_fairness

all: $(TESTS)

c23_hello: c23_hello.c
	$(CC) $(CFLAGS) $< -o $@

spinlock_test: spinlock_test.c $(SPINLOCK_SRC)
	$(CC) $(CFLAGS) $< $(SPINLOCK_SRC) -o $@

thread_spinlock_stress: thread_spinlock_stress.c $(SPINLOCK_SRC)
	$(CC) $(CFLAGS) $< $(SPINLOCK_SRC) -o $@

process_spinlock_stress: process_spinlock_stress.c $(SPINLOCK_SRC)
	$(CC) $(CFLAGS) $< $(SPINLOCK_SRC) -o $@

ptrace_concurrency_test: ptrace_concurrency_test.c
	$(CC) $(CFLAGS) $< -o $@

spinlock_fairness: spinlock_fairness.c $(SPINLOCK_SRC)
	$(CC) $(CFLAGS) -DUSE_TICKET_LOCK $< $(SPINLOCK_SRC) -o $@

check: all
	./c23_test.sh
	./spinlock_test.sh
	./thread_spinlock_stress.sh
	./process_spinlock_stress.sh
	./ptrace_concurrency_test.sh
	./spinlock_fairness

clean:
	rm -f $(TESTS) *.txt
