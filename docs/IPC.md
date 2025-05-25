# Mailbox IPC

This note outlines the semantics of the mailbox based interprocess
communication (IPC) primitives used throughout the code base.  It also
describes the timeout mechanism and gives a short usage example.

## Semantics
* A *mailbox* is a FIFO queue of fixed-size messages.
* Senders append messages to the queue; receivers remove them in the order
  they were posted.
* If the queue is full, a sender blocks until space becomes available.
* If the queue is empty, a receiver blocks until a message arrives.
* Mailboxes may be shared by multiple writers and readers.

## Timeout mechanism
The blocking send and receive operations accept an optional timeout
value expressed in system ticks.  Internally they use the kernel's
`timeout()` facility to wake up waiters that exceed the limit.  When a
timeout expires, the operation returns with an error code and no
message is transferred.

### Status codes
Mailbox operations return an `exo_ipc_status` value:

- `EXO_IPC_STATUS_SUCCESS` – operation completed successfully.
- `EXO_IPC_STATUS_TIMEOUT` – the timeout expired before completion.
- `EXO_IPC_STATUS_ERROR` – a generic failure occurred.

## Example usage
The snippet below sends a message and waits up to one second (100 ticks)
for a reply:

```c
struct mbox *req = mbox_open("req");
struct mbox *resp = mbox_open("resp");
struct msg m = { .cmd = PING };

mbox_send(req, &m, 0);           /* block until sent */
if (mbox_recv(resp, &m, 100) == EXO_IPC_STATUS_SUCCESS) {
    /* process reply */
} else {
    /* timeout or error */
}
```

User programs may include `<mailbox_t.h>` and call the `Recv_T` helper,
which simply forwards to `mailbox_recv_t` with the given timeout:

```c
size_t len = sizeof(m);
if (Recv_T(resp, &m, &len, 50) == EXO_IPC_STATUS_SUCCESS) {
    /* got a message within 50 ticks */
}
```

### Global mailbox queue

The header `<mailbox_global.h>` exposes a fixed array of mailboxes
named `ipcs`.  `MAILBOX_BUFSZ` specifies the number of entries.  A
convenience routine `exo_ipc_queue_recv_timed()` waits for a message
from one of these mailboxes with a timeout:

```c
size_t len = sizeof(buf);
exo_ipc_status r = exo_ipc_queue_recv_timed(0, buf, &len, 10);
```

The array is initialised on first use and the function returns the same
status codes as `mailbox_recv_t`.
