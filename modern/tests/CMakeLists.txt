cmake_minimum_required(VERSION 3.16)
set(CMAKE_C_COMPILER clang)
project(modern_tests C)
set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
add_compile_definitions(_POSIX_C_SOURCE=200809L _GNU_SOURCE)

find_package(Threads REQUIRED)

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/../compat
    ${CMAKE_CURRENT_SOURCE_DIR}/../../v10/ipc/h
)

set(SPINLOCK_SRC ${CMAKE_CURRENT_SOURCE_DIR}/../../v10/ipc/spinlock.c)

add_executable(c23_hello c23_hello.c)
target_link_libraries(c23_hello PRIVATE Threads::Threads)

add_executable(spinlock_test spinlock_test.c ${SPINLOCK_SRC})
target_compile_definitions(spinlock_test PRIVATE SMP_ENABLED)
target_link_libraries(spinlock_test PRIVATE Threads::Threads)

add_executable(thread_spinlock_stress thread_spinlock_stress.c ${SPINLOCK_SRC})
target_compile_definitions(thread_spinlock_stress PRIVATE SMP_ENABLED)
target_link_libraries(thread_spinlock_stress PRIVATE Threads::Threads)

add_executable(process_spinlock_stress process_spinlock_stress.c ${SPINLOCK_SRC})
target_compile_definitions(process_spinlock_stress PRIVATE SMP_ENABLED)
target_link_libraries(process_spinlock_stress PRIVATE Threads::Threads)

add_executable(ptrace_concurrency_test ptrace_concurrency_test.c)
target_link_libraries(ptrace_concurrency_test PRIVATE Threads::Threads)

add_executable(spinlock_fairness spinlock_fairness.c ${SPINLOCK_SRC})
target_compile_definitions(spinlock_fairness PRIVATE SMP_ENABLED USE_TICKET_LOCK)
target_link_libraries(spinlock_fairness PRIVATE Threads::Threads)

enable_testing()
add_test(NAME c23_test
    COMMAND /bin/sh ${CMAKE_CURRENT_SOURCE_DIR}/c23_test.sh)
set_tests_properties(c23_test PROPERTIES WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_test(NAME spinlock_test
    COMMAND /bin/sh ${CMAKE_CURRENT_SOURCE_DIR}/spinlock_test.sh)
set_tests_properties(spinlock_test PROPERTIES WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_test(NAME thread_spinlock_stress
    COMMAND /bin/sh ${CMAKE_CURRENT_SOURCE_DIR}/thread_spinlock_stress.sh)
set_tests_properties(thread_spinlock_stress PROPERTIES WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_test(NAME process_spinlock_stress
    COMMAND /bin/sh ${CMAKE_CURRENT_SOURCE_DIR}/process_spinlock_stress.sh)
set_tests_properties(process_spinlock_stress PROPERTIES WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_test(NAME ptrace_concurrency_test
    COMMAND /bin/sh ${CMAKE_CURRENT_SOURCE_DIR}/ptrace_concurrency_test.sh)
set_tests_properties(ptrace_concurrency_test PROPERTIES WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_test(NAME spinlock_fairness COMMAND $<TARGET_FILE:spinlock_fairness>)
