#ifndef SERVICES_H
#define SERVICES_H

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define SRV_NAME_LEN 16
#define SRV_MAX_MSG  256

/**
 * @brief IPC message structure used by the service layer.
 */
struct srv_message {
    int type;                /**< Message type */
    uint32_t token;          /**< Capability token */
    size_t size;             /**< Number of valid bytes in data */
    char data[SRV_MAX_MSG];  /**< Payload buffer */
};

typedef int (*srv_handler_t)(struct srv_message *msg);

/**
 * @brief Register a service handler.
 *
 * @param name    Null-terminated service name.
 * @param handler Callback invoked when a message is received.
 * @param token   Capability token used for authentication.
 * @return 0 on success, -1 on failure.
 */
int srv_register(const char *name, srv_handler_t handler, uint32_t token);

/**
 * @brief Send a message to a named service.
 *
 * @param name Service name previously registered.
 * @param msg  Pointer to the message to deliver. The token field must match
 *             the registration token.
 * @return 0 on success, -1 on failure.
 */
int srv_send(const char *name, struct srv_message *msg);

#ifdef __cplusplus
}
#endif

#endif /* SERVICES_H */
