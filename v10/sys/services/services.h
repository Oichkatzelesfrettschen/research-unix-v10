#ifndef SERVICES_H
#define SERVICES_H

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define SRV_NAME_LEN 16
#define SRV_MAX_MSG  256

struct srv_message {
    int type;                /* message type */
    uint32_t token;          /* capability token */
    size_t size;             /* number of valid bytes in data */
    char data[SRV_MAX_MSG];  /* payload */
};

typedef int (*srv_handler_t)(struct srv_message *msg);

int srv_register(const char *name, srv_handler_t handler, uint32_t token);
int srv_send(const char *name, struct srv_message *msg);

#ifdef __cplusplus
}
#endif

#endif /* SERVICES_H */
