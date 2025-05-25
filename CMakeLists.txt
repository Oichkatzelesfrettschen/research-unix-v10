cmake_minimum_required(VERSION 3.16)

# Prefer clang if no compiler was chosen by the user
if(NOT DEFINED CMAKE_C_COMPILER)
    set(CMAKE_C_COMPILER clang CACHE STRING "C compiler" FORCE)
endif()

project(ResearchUnixV10 C)

add_subdirectory(v10/sys)
add_subdirectory(modern/tests)
