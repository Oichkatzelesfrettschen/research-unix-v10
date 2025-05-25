cmake_minimum_required(VERSION 3.16)

add_library(libcapnp STATIC
    capnp.cpp
)

target_include_directories(libcapnp PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(libcapnp PUBLIC capnp kj)
