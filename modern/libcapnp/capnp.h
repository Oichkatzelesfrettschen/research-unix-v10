#ifndef LIBCAPNP_CAPNP_H
#define LIBCAPNP_CAPNP_H

#ifdef __cplusplus
extern "C" {
#endif

int capnp_init(void);

typedef struct capnp_msg capnp_msg;

capnp_msg* capnp_msg_create(void);
void capnp_msg_destroy(capnp_msg* msg);
int capnp_write_fd(capnp_msg* msg, int fd);

#ifdef __cplusplus
}
#endif

#endif /* LIBCAPNP_CAPNP_H */
