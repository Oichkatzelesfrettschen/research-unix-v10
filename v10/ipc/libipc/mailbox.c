#include <stdlib.h>
#include <string.h>
#include "../h/mailbox.h"

void mailbox_init(mailbox_t *mb)
{
    mb->lock = (spinlock_t)SPINLOCK_INITIALIZER;
    mb->head = mb->tail = NULL;
}

static message_t *message_alloc(const void *buf, size_t len)
{
    message_t *m = (message_t *)malloc(sizeof(message_t));
    if(!m)
        return NULL;
    m->data = (char *)malloc(len);
    if(!m->data) {
        free(m);
        return NULL;
    }
    memcpy(m->data, buf, len);
    m->len = len;
    m->next = NULL;
    return m;
}

ipc_status mailbox_send(mailbox_t *mb, const void *buf, size_t len)
{
    message_t *m = message_alloc(buf, len);
    if(!m)
        return IPC_STATUS_ERROR;
    spin_lock(&mb->lock);
    if(mb->tail)
        mb->tail->next = m;
    else
        mb->head = m;
    mb->tail = m;
    spin_unlock(&mb->lock);
    return IPC_STATUS_SUCCESS;
}

ipc_status mailbox_recv(mailbox_t *mb, void *buf, size_t *len)
{
    spin_lock(&mb->lock);
    message_t *m = mb->head;
    if(!m) {
        spin_unlock(&mb->lock);
        return IPC_STATUS_ERROR;
    }
    mb->head = m->next;
    if(mb->tail == m)
        mb->tail = NULL;
    spin_unlock(&mb->lock);

    if(buf && *len >= m->len)
        memcpy(buf, m->data, m->len);
    *len = m->len;
    free(m->data);
    free(m);
    return IPC_STATUS_SUCCESS;
}

ipc_status exo_send(mailbox_t *target, const void *buf, size_t len)
{
    return mailbox_send(target, buf, len);
}

ipc_status exo_recv(mailbox_t *mb, void *buf, size_t *len)
{
    return mailbox_recv(mb, buf, len);
}

