#ifndef MAILBOX_H
#define MAILBOX_H

#include <stddef.h>
#include <sys/types.h>
#include "spinlock.h"

typedef struct message {
    struct message *next;
    size_t len;
    char *data;
} message_t;

typedef struct mailbox {
    spinlock_t lock;
    message_t *head;
    message_t *tail;
} mailbox_t;

/* per-process mailbox wrapper */
typedef struct ipc_mailbox {
    mailbox_t box;
    /* additional metadata */
} ipc_mailbox;

void mailbox_init(mailbox_t *mb);
int mailbox_send(mailbox_t *mb, const void *buf, size_t len);
int mailbox_recv(mailbox_t *mb, void *buf, size_t *len);

ipc_mailbox *ipc_get_mailbox(pid_t pid);
ipc_mailbox *ipc_current_mailbox(void);

int exo_send(mailbox_t *target, const void *buf, size_t len);
int exo_recv(mailbox_t *mb, void *buf, size_t *len);

#endif /* MAILBOX_H */
