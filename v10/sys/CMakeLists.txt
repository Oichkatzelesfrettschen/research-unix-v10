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
option(SERVICES "Enable optional services" OFF)
option(BUILD_LIBPOSIX "Build libposix.a" OFF)
option(LINK_SERVICES "Link microkernel services" OFF)
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

if(SERVICES)
    file(GLOB SERVICE_SRC_C
        "services/*.c"
    )
    file(GLOB SERVICE_SRC_S
        "services/*.s"
    )
    add_library(services STATIC ${SERVICE_SRC_C} ${SERVICE_SRC_S})
endif()

# ensure scheduler lock support is built
list(APPEND SRC_C os/sched_lock.c)
list(REMOVE_DUPLICATES SRC_C)

file(GLOB SRC_S
    "os/*.s"
    "vm/*.s"
    "md/*.s"
    "io/*.s"
    "fs/*.s"
    "ml/*.s"
    "inet/*.s"
)

if(BUILD_LIBPOSIX)
    file(GLOB POSIX_SRC
        "libposix/*.c"
    )
    add_library(posix STATIC ${POSIX_SRC})
endif()

add_executable(unix ${SRC_C} ${SRC_S})

# Do not use the standard C library for linking
target_link_options(unix PRIVATE -nostdlib)

if(BUILD_LIBPOSIX)
    target_link_libraries(unix PRIVATE posix)
endif()

if(LINK_SERVICES AND SERVICES)
    target_link_libraries(unix PRIVATE services)
endif()

