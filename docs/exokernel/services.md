# Exokernel Services

This repository experiments with an exokernel style where most OS
functionality is provided by optional user-level services.  Services
communicate using a very small message-passing API built around
capability tokens.  Each service registers a name and a handler
function.  Clients construct a `srv_message` structure containing a
message type, payload data and the token for the target service.  The
core service dispatcher validates the token before invoking the
registered handler.

## Directory layout

```
v10/sys/services/
    services.c      dispatcher and registration logic
    services.h      public API
    fs_proxy.c      example filesystem proxy
    proc_manager.c  simple process manager
```

Individual service objects are built into the kernel just like other
subsystems.  The top-level `v10/sys/Makefile` now includes the new
`services` subdirectory.

## Example services

### Filesystem proxy
The filesystem proxy shows how a service can expose file operations.
Clients first send an `FS_OPEN` message with the path to open.  Subsequent
`FS_READ` or `FS_WRITE` messages operate on the resulting handle.  Real
error handling is minimal as the code is only a demonstration.

### Process manager
`proc_manager.c` provides two operations: spawning a command with
`PROC_SPAWN` and terminating a process with `PROC_KILL`.  Capability
tokens ensure that only authorized clients may manage processes.

## Capability model
Tokens are simple 32-bit values associated with each registered service.
A client must supply the correct token in its message or the dispatcher
rejects the request.  This mechanism is lightweight but sufficient for
experimentation with isolated kernel services.
