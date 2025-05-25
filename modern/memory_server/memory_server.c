#include <stdio.h>
#include "../libcapnp/capnp.h"

int main(void)
{
    if (capnp_init() != 0) {
        fprintf(stderr, "capnp init failed\n");
        return 1;
    }
    printf("memory_server stub\n");
    return 0;
}
