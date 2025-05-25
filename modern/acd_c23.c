#include <stdio.h>

void print_args(int argc, char *argv[]);
void lock_acquire(void);
void lock_release(void);

int main(int argc, char *argv[])
{
    lock_acquire();
    print_args(argc, argv);
    lock_release();
    return 0;
}
