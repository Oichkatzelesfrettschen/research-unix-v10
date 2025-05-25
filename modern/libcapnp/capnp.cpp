#include "capnp.h"
#include <capnp/message.h>
#include <capnp/serialize.h>

struct capnp_msg {
    capnp::MallocMessageBuilder builder;
};

extern "C" {

int capnp_init(void) {
    return 0;
}

capnp_msg* capnp_msg_create(void) {
    return new capnp_msg{};
}

void capnp_msg_destroy(capnp_msg* msg) {
    delete msg;
}

int capnp_write_fd(capnp_msg* msg, int fd) {
    capnp::writeMessageToFd(fd, msg->builder);
    return 0;
}

}
