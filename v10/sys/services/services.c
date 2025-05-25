#include "services.h"
#include <string.h>

#define MAX_SERVICES 32

struct srv_service {
    char name[SRV_NAME_LEN];
    srv_handler_t handler;
    uint32_t token;
};

static struct srv_service service_table[MAX_SERVICES];

int
srv_register(const char *name, srv_handler_t handler, uint32_t token)
{
    for (int i = 0; i < MAX_SERVICES; i++) {
        if (service_table[i].handler == NULL) {
            strncpy(service_table[i].name, name, SRV_NAME_LEN - 1);
            service_table[i].name[SRV_NAME_LEN - 1] = '\0';
            service_table[i].handler = handler;
            service_table[i].token = token;
            return 0;
        }
    }
    return -1;
}

int
srv_send(const char *name, struct srv_message *msg)
{
    for (int i = 0; i < MAX_SERVICES; i++) {
        if (service_table[i].handler && strncmp(service_table[i].name, name, SRV_NAME_LEN) == 0) {
            if (msg->token != service_table[i].token)
                return -1; /* capability mismatch */
            return service_table[i].handler(msg);
        }
    }
    return -1;
}
