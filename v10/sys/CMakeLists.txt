file(GLOB KERNEL_C
    os/*.c
    vm/*.c
    md/*.c
    io/*.c
    fs/*.c
    ml/*.c
    inet/*.c)

file(GLOB KERNEL_ASM
    os/*.s
    vm/*.s
    md/*.s
    io/*.s
    fs/*.s
    ml/*.s
    inet/*.s)

# Header files reside relative to this directory
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(unix ${KERNEL_C} ${KERNEL_ASM})

# The historical build used -nostdlib when linking
set_target_properties(unix PROPERTIES LINK_FLAGS "-nostdlib")
