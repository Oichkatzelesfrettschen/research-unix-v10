#ifndef V10_CAPNP_H
#define V10_CAPNP_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

uint32_t capnp_read_u32(const void *msg, size_t word);
void capnp_write_u32(void *msg, size_t word, uint32_t value);

#ifdef __cplusplus
}
#endif

#endif /* V10_CAPNP_H */
