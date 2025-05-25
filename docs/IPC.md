# IPC Status Codes

The IPC library functions that send and receive connection information now
return the `ipc_status` enumeration defined in `v10/ipc/h/ipc.h`.

| Status Constant | Meaning |
|-----------------|---------|
| `IPC_STATUS_SUCCESS` | Operation completed successfully. |
| `IPC_STATUS_TIMEOUT` | The operation timed out. |
| `IPC_STATUS_QUEUE_FULL` | The target queue is full or temporarily unable to accept data. |
| `IPC_STATUS_INVALID_TARGET` | The requested destination was invalid or unavailable. |
| `IPC_STATUS_ERROR` | A generic error occurred. |

When checking results from `_info_read`, `_info_write`, `_reply_read`,
`_reply_write`, `_fd_read` and `_fd_write`, compare the return value
against `IPC_STATUS_SUCCESS`.
