#include "services.h"
#include <stdio.h>
#include <string.h>

/* simple message types */
#define FS_OPEN  1
#define FS_READ  2
#define FS_WRITE 3

static int
fs_handler(struct srv_message *msg)
{
    static FILE *f = NULL;

    switch (msg->type) {
    case FS_OPEN:
        f = fopen(msg->data, "r+");
        return f ? 0 : -1;
    case FS_READ:
        if (!f)
            return -1;
        msg->size = fread(msg->data, 1, sizeof(msg->data), f);
        return msg->size > 0 ? 0 : -1;
    case FS_WRITE:
        if (!f)
            return -1;
        return fwrite(msg->data, 1, msg->size, f) == msg->size ? 0 : -1;
    default:
        return -1;
    }
}

int
fs_proxy_init(void)
{
    return srv_register("fs", fs_handler, 0xdeadbeef);
}
