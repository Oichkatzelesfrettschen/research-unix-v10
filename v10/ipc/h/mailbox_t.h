#ifndef MAILBOX_T_H
#define MAILBOX_T_H

#include "mailbox.h"

int mailbox_recv_t(mailbox_t *mb, void *buf, size_t *len, unsigned timeout);

static inline int Recv_T(mailbox_t *mb, void *buf, size_t *len, unsigned timeout)
{
    return mailbox_recv_t(mb, buf, len, timeout);
}

#endif /* MAILBOX_T_H */
