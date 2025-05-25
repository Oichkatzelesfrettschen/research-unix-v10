# Microkernel Overview

This document collects notes about the simple microkernel used by the
modernized Research UNIX environment.

## Mailbox Usage

Every process is associated with an `ipc_mailbox` managed by the `libipc`
library.  The mailboxes reside in the global array `proc_mailboxes` indexed by
process ID.  Use `ipc_get_mailbox(pid)` to obtain another process's mailbox or
`ipc_current_mailbox()` for the current process.

Messages are queued with `mailbox_send()` and retrieved with
`mailbox_recv()`.  These helpers automatically initialise the per-process
mailboxes on first use.
