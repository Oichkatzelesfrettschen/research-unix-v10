#include "services.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>

#define PROC_SPAWN 1
#define PROC_KILL  2

static int
proc_handler(struct srv_message *msg)
{
    switch (msg->type) {
    case PROC_SPAWN:
        msg->data[msg->size] = '\0';
        return system(msg->data);
    case PROC_KILL:
        if (msg->size < sizeof(int))
            return -1;
        int pid;
        memcpy(&pid, msg->data, sizeof(int));
        return kill(pid, SIGTERM);
    default:
        return -1;
    }
}

int
proc_manager_init(void)
{
    return srv_register("proc", proc_handler, 0xcafebabe);
}
