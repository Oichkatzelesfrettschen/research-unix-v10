#include <stdio.h>
#include <stdint.h>
#include "../../v10/ipc/capnp/capnp.h"

int main(int argc, char **argv)
{
    const char *path = argc > 1 ? argv[1] : "msg.bin";
    FILE *f = fopen(path, "wb");
    if(!f) {
        perror("fopen");
        return 1;
    }
    uint32_t msg[2];
    capnp_write_u32(msg, 0, 0x12345678);
    capnp_write_u32(msg, 1, 4096);
    fwrite(msg, sizeof(uint32_t), 2, f);
    fclose(f);
    return 0;
}
