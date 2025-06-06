cmake_minimum_required(VERSION 3.16)
if(NOT CMAKE_C_COMPILER)
    set(CMAKE_C_COMPILER clang)
endif()
project(modern_tests C)
set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
add_compile_options(-Wall -Wextra -Werror)
add_compile_definitions(_POSIX_C_SOURCE=200809L _GNU_SOURCE)

find_package(Threads REQUIRED)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../compat/posix ${CMAKE_CURRENT_BINARY_DIR}/posix)

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/../compat
    ${CMAKE_CURRENT_SOURCE_DIR}/../../v10/ipc/h
)

set(SPINLOCK_SRC ${CMAKE_CURRENT_SOURCE_DIR}/../../v10/ipc/spinlock.c)
set(MAILBOX_SRC ${CMAKE_CURRENT_SOURCE_DIR}/../../v10/ipc/libipc/mailbox.c)

add_executable(c23_hello c23_hello.c)
target_link_libraries(c23_hello PRIVATE posix Threads::Threads)

add_executable(spinlock_test spinlock_test.c ${SPINLOCK_SRC})
target_compile_definitions(spinlock_test PRIVATE SMP_ENABLED)
target_link_libraries(spinlock_test PRIVATE posix Threads::Threads)

add_executable(thread_spinlock_stress thread_spinlock_stress.c ${SPINLOCK_SRC})
target_compile_definitions(thread_spinlock_stress PRIVATE SMP_ENABLED)
target_link_libraries(thread_spinlock_stress PRIVATE posix Threads::Threads)

add_executable(process_spinlock_stress process_spinlock_stress.c ${SPINLOCK_SRC})
target_compile_definitions(process_spinlock_stress PRIVATE SMP_ENABLED)
target_link_libraries(process_spinlock_stress PRIVATE posix Threads::Threads)

add_executable(ptrace_concurrency_test ptrace_concurrency_test.c)
target_link_libraries(ptrace_concurrency_test PRIVATE posix Threads::Threads)

add_executable(spinlock_fairness spinlock_fairness.c ${SPINLOCK_SRC})
target_compile_definitions(spinlock_fairness PRIVATE SMP_ENABLED USE_TICKET_LOCK)
target_link_libraries(spinlock_fairness PRIVATE posix Threads::Threads)

add_executable(mqueue_ordering_test mqueue_ordering_test.c)
target_link_libraries(mqueue_ordering_test PRIVATE posix Threads::Threads rt)

add_executable(mqueue_blocking_test mqueue_blocking_test.c)
target_link_libraries(mqueue_blocking_test PRIVATE posix Threads::Threads rt)

add_executable(mqueue_overflow_test mqueue_overflow_test.c)
target_link_libraries(mqueue_overflow_test PRIVATE posix rt)

add_executable(mqueue_timeout_test mqueue_timeout_test.c)
target_link_libraries(mqueue_timeout_test PRIVATE posix rt)

add_executable(mailbox_timeout_test mailbox_timeout_test.c ${SPINLOCK_SRC} ${MAILBOX_SRC})
target_compile_definitions(mailbox_timeout_test PRIVATE SMP_ENABLED)
target_link_libraries(mailbox_timeout_test PRIVATE posix Threads::Threads)

add_executable(posix_wrappers_test posix_wrappers_test.c)
target_link_libraries(posix_wrappers_test PRIVATE posix Threads::Threads)
add_executable(capability_client capability_client.c)
target_link_libraries(capability_client PRIVATE Threads::Threads)

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

add_test(NAME mqueue_ordering_test COMMAND $<TARGET_FILE:mqueue_ordering_test>)
add_test(NAME mqueue_blocking_test COMMAND $<TARGET_FILE:mqueue_blocking_test>)
add_test(NAME mqueue_overflow_test COMMAND $<TARGET_FILE:mqueue_overflow_test>)
add_test(NAME mqueue_timeout_test COMMAND $<TARGET_FILE:mqueue_timeout_test>)
add_test(NAME mailbox_timeout_test COMMAND $<TARGET_FILE:mailbox_timeout_test>)
add_test(NAME posix_wrappers_test
    COMMAND /bin/sh ${CMAKE_CURRENT_SOURCE_DIR}/posix_wrappers_test.sh)
set_tests_properties(posix_wrappers_test PROPERTIES WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_test(NAME capability_integration_test
    COMMAND /bin/sh ${CMAKE_CURRENT_SOURCE_DIR}/capability_integration_test.sh)
set_tests_properties(capability_integration_test PROPERTIES WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
