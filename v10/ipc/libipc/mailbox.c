#include <stdlib.h>
#include <string.h>
#include "../h/mailbox.h"
#include <sys/types.h>
#include <unistd.h>

/*
 * per-process mailboxes
 */
ipc_mailbox proc_mailboxes[NPROC];
static int mb_initialized;

static void
init_proc_mailboxes(void)
{
    int i;

    if(mb_initialized)
        return;
    for(i=0; i<NPROC; i++)
        mailbox_init(&proc_mailboxes[i].box);
    mb_initialized = 1;
}

ipc_mailbox *
ipc_get_mailbox(pid_t pid)
{
    if(pid < 0 || pid >= NPROC)
        return NULL;
    init_proc_mailboxes();
    return &proc_mailboxes[pid];
}

ipc_mailbox *
ipc_current_mailbox(void)
{
    return ipc_get_mailbox(getpid());
}

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

int mailbox_send(mailbox_t *mb, const void *buf, size_t len)
{
    message_t *m = message_alloc(buf, len);
    if(!m)
        return -1;
    spin_lock(&mb->lock);
    if(mb->tail)
        mb->tail->next = m;
    else
        mb->head = m;
    mb->tail = m;
    spin_unlock(&mb->lock);
    return 0;
}

int mailbox_recv(mailbox_t *mb, void *buf, size_t *len)
{
    spin_lock(&mb->lock);
    message_t *m = mb->head;
    if(!m) {
        spin_unlock(&mb->lock);
        return -1;
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
    return 0;
}

int exo_send(mailbox_t *target, const void *buf, size_t len)
{
    return mailbox_send(target, buf, len);
}

int exo_recv(mailbox_t *mb, void *buf, size_t *len)
{
    return mailbox_recv(mb, buf, len);
}

