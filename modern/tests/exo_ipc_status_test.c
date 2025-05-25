#include <string.h>
#include "../../v10/ipc/h/mailbox.h"
#include "../../v10/ipc/h/mailbox_t.h"

int main(void)
{
    mailbox_t mb;
    mailbox_init(&mb);
    const char msg[] = "hi";
    if (exo_send(&mb, msg, sizeof(msg)) != EXO_IPC_STATUS_SUCCESS)
        return 1;
    char buf[8];
    size_t len = sizeof(buf);
    if (exo_recv(&mb, buf, &len) != EXO_IPC_STATUS_SUCCESS)
        return 1;
    if (len != sizeof(msg) || strcmp(buf, msg) != 0)
        return 1;
    len = sizeof(buf);
    if (mailbox_recv_t(&mb, buf, &len, 5) != EXO_IPC_STATUS_TIMEOUT)
        return 1;
    return 0;
}
