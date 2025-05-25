#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "../../v10/ipc/capnp/capnp.h"

int main(int argc, char **argv)
{
    const char *file = NULL;
    if(argc > 1)
        file = argv[1];

    FILE *fp = file ? fopen(file, "rb") : stdin;
    if(!fp) {
        perror("fopen");
        return 1;
    }

    uint32_t buf[2];
    while(fread(buf, sizeof(uint32_t), 2, fp) == 2) {
        uint32_t addr = capnp_read_u32(buf, 0);
        uint32_t len  = capnp_read_u32(buf, 1);
        printf("addr=0x%08x len=%u\n", addr, len);
    }

    if(file)
        fclose(fp);
    return 0;
}
