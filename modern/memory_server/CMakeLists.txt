if(NOT USE_CAPNP)
    return()
endif()

add_executable(memory_server memory_server.c)
target_include_directories(memory_server PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../libcapnp)
target_link_libraries(memory_server PRIVATE libcapnp)
