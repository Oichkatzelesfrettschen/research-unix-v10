project('research-unix-v10', ['c', 'cpp', 'asm'])

use_capnp = get_option('use_capnp')

subdir('v10/sys')
subdir('modern/tests')

if use_capnp
    subdir('modern/libcapnp')
    subdir('modern/memory_server')
endif
