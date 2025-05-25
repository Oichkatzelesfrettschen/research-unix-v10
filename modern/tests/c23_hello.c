#include <stdio.h>
#include <uchar.h>

int main(void) {
    const char8_t msg[] = u8"Hello from C23";
    printf("%s\n", (const char*)msg);
    return 0;
}
