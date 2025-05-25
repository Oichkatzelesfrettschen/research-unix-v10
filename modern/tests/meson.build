project('modern_tests', 'c')

add_project_arguments('-std=c23', '-Wall', '-Wextra', '-Werror',
                      '-D_POSIX_C_SOURCE=200809L', '-D_GNU_SOURCE',
                      language: 'c')

smp_def = '-DSMP_ENABLED'
spinlock_src = '../../v10/ipc/spinlock.c'
mailbox_src = '../../v10/ipc/libipc/mailbox.c'

c23_hello = executable('c23_hello', 'c23_hello.c', install: false)
spinlock_test = executable('spinlock_test', ['spinlock_test.c', spinlock_src],
                           c_args: [smp_def], install: false)
thread_spinlock_stress = executable('thread_spinlock_stress', ['thread_spinlock_stress.c', spinlock_src],
                                    c_args: [smp_def], install: false)
process_spinlock_stress = executable('process_spinlock_stress', ['process_spinlock_stress.c', spinlock_src],
                                     c_args: [smp_def], install: false)
ptrace_concurrency_test = executable('ptrace_concurrency_test', 'ptrace_concurrency_test.c', install: false)
spinlock_fairness = executable('spinlock_fairness', ['spinlock_fairness.c', spinlock_src],
                               c_args: [smp_def, '-DUSE_TICKET_LOCK'], install: false)
mqueue_ordering_test = executable('mqueue_ordering_test', 'mqueue_ordering_test.c',
                                  link_args: ['-lrt'], install: false)
mqueue_blocking_test = executable('mqueue_blocking_test', 'mqueue_blocking_test.c',
                                  link_args: ['-lrt'], install: false)
mqueue_overflow_test = executable('mqueue_overflow_test', 'mqueue_overflow_test.c',
                                  link_args: ['-lrt'], install: false)
mqueue_timeout_test = executable('mqueue_timeout_test', 'mqueue_timeout_test.c',
                                 link_args: ['-lrt'], install: false)
mailbox_timeout_test = executable('mailbox_timeout_test', ['mailbox_timeout_test.c', spinlock_src, mailbox_src],
                                  c_args: [smp_def], install: false)

sh = find_program('sh')

test('c23_test', sh, args: ['c23_test.sh'], workdir: meson.current_source_dir())
test('spinlock_test', sh, args: ['spinlock_test.sh'], workdir: meson.current_source_dir())
test('thread_spinlock_stress', sh, args: ['thread_spinlock_stress.sh'], workdir: meson.current_source_dir())
test('process_spinlock_stress', sh, args: ['process_spinlock_stress.sh'], workdir: meson.current_source_dir())
test('ptrace_concurrency_test', sh, args: ['ptrace_concurrency_test.sh'], workdir: meson.current_source_dir())
test('spinlock_fairness', spinlock_fairness)
test('mqueue_ordering_test', mqueue_ordering_test)
test('mqueue_blocking_test', mqueue_blocking_test)
test('mqueue_overflow_test', mqueue_overflow_test)
test('mqueue_timeout_test', mqueue_timeout_test)
test('mailbox_timeout_test', mailbox_timeout_test)
