cmake_minimum_required(VERSION 3.16)

add_library(posix STATIC posix.c)

target_include_directories(posix PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
