cmake_minimum_required(VERSION 3.16)

# Use clang by default if no compiler is specified
if(NOT CMAKE_C_COMPILER)
    set(CMAKE_C_COMPILER clang)
endif()

project(unix C ASM)

# Use C23
set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Option controlling the SMP spinlock implementation
option(SMP "Enable SMP support" OFF)
if(SMP)
    add_compile_definitions(SPINLOCK_TICKET SMP_ENABLED)
else()
    add_compile_definitions(SPINLOCK_UNIPROCESSOR)
endif()

# Include current directory for headers
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# Collect sources from each subdirectory
file(GLOB SRC_C
    "os/*.c"
    "vm/*.c"
    "md/*.c"
    "io/*.c"
    "fs/*.c"
    "ml/*.c"
    "inet/*.c"
)

file(GLOB SRC_S
    "os/*.s"
    "vm/*.s"
    "md/*.s"
    "io/*.s"
    "fs/*.s"
    "ml/*.s"
    "inet/*.s"
)

add_executable(unix ${SRC_C} ${SRC_S})

# Do not use the standard C library for linking
target_link_options(unix PRIVATE -nostdlib)

