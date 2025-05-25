#!/bin/sh
set -e
clang -std=c23 -Wall -Wextra -Werror -pthread \
    mailbox_timeout_test.c ../../v10/ipc/libipc/mailbox.c \
    ../../v10/ipc/spinlock.c -I ../compat -I ../../v10/ipc/h \
    -DSMP_ENABLED -o mailbox_timeout_test
./mailbox_timeout_test
