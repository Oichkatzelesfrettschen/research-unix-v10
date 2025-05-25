#ifndef MAILBOX_GLOBAL_H
#define MAILBOX_GLOBAL_H

#include "mailbox.h"

#ifndef MAILBOX_BUFSZ
#define MAILBOX_BUFSZ 16
#endif

extern struct mailbox ipcs[MAILBOX_BUFSZ];

exo_ipc_status exo_ipc_queue_recv_timed(int index, void *buf, size_t *len,
                                        unsigned timeout);

#endif /* MAILBOX_GLOBAL_H */

