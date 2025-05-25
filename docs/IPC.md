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
Mailbox operations return an `ipc_status` value:

- `IPC_STATUS_SUCCESS` – operation completed successfully.
- `IPC_STATUS_TIMEOUT` – the timeout expired before completion.
- `IPC_STATUS_ERROR` – a generic failure occurred.

## Example usage
The snippet below sends a message and waits up to one second (100 ticks)
for a reply:

```c
struct mbox *req = mbox_open("req");
struct mbox *resp = mbox_open("resp");
struct msg m = { .cmd = PING };

mbox_send(req, &m, 0);           /* block until sent */
if (mbox_recv(resp, &m, 100) == IPC_STATUS_SUCCESS) {
    /* process reply */
} else {
    /* timeout or error */
}
```

User programs may include `<mailbox_t.h>` and call the `Recv_T` helper,
which simply forwards to `mailbox_recv_t` with the given timeout:

```c
size_t len = sizeof(m);
if (Recv_T(resp, &m, &len, 50) == 0) {
    /* got a message within 50 ticks */
}
```
