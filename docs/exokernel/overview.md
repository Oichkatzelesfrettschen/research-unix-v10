# Exokernel Overview

This document sketches the high level goals for the exokernel variant of
Research UNIX.  The intention is to combine the performance benefits of
an exokernel with a familiar userland environment.

## Goals

### Exo-kernel Performance
The kernel design aims to minimize abstractions so that applications can
manage hardware resources directly.  User level libraries are expected to
implement higher level services without sacrificing speed.

### POSIX Compatibility
Applications should build with standard POSIX interfaces.  Where
necessary, compatibility layers map POSIX calls to the lower level
exo-kernel primitives.

### Microkernel Services
Only essential mechanisms remain in the privileged kernel: memory
management, scheduling, and IPC.  Device drivers and filesystems run in
user space as separate services.

### Security Model
Processes rely on capability grants to access hardware resources.
Isolation between services is enforced by the minimal kernel and the
capability checks.

## Building

Follow the cross compilation steps described in the README (lines 73–110).
The helper script [`tools/cross-env.sh`](../../tools/cross-env.sh) sets up
the necessary environment variables before invoking the build system.
