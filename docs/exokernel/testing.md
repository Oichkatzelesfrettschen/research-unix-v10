# Exokernel Testing

The prototype code under `modern/` includes a number of unit tests and
integration checks.  The simplest way to build and run them is

```sh
make check
```

This compiles the test programs in `modern/tests` and executes the full
suite, including the new POSIX wrapper tests.

Some integration tests rely on the capability-based memory server.  Enable
these by invoking the top-level `test` target with `CAPNP=1`:

```sh
make CAPNP=1 test
```

This builds `libcapnp`, starts the memory server for the duration of the
run and exercises the capability interaction tests.
