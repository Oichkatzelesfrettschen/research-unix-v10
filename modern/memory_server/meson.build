if not get_option('use_capnp')
    subdir_done()
endif

executable('memory_server', 'memory_server.c',
    include_directories: include_directories('..'),
    link_with: libcapnp)
