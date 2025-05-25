#include "capnp.h"

uint32_t capnp_read_u32(const void *msg, size_t word)
{
    const uint32_t *p = (const uint32_t *)msg;
    return p[word];
}

void capnp_write_u32(void *msg, size_t word, uint32_t value)
{
    uint32_t *p = (uint32_t *)msg;
    p[word] = value;
}
