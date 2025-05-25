cmake_minimum_required(VERSION 3.16)

project(research_unix_v10 C ASM CXX)

option(USE_CAPNP "Enable Cap'n Proto support" OFF)

add_subdirectory(v10/sys)
add_subdirectory(modern/tests)

if(USE_CAPNP)
    add_subdirectory(modern/libcapnp)
    add_subdirectory(modern/memory_server)
endif()
