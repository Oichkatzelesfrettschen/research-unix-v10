set(SPINLOCK_SRC ${CMAKE_SOURCE_DIR}/v10/ipc/spinlock.c)
include_directories(${CMAKE_SOURCE_DIR}/v10/ipc/h)

set(CMAKE_C_STANDARD 23)
set(TEST_C_FLAGS "-pthread -DSMP_ENABLED")

add_executable(c23_hello c23_hello.c)
target_compile_options(c23_hello PRIVATE -std=c2x)

add_executable(spinlock_test spinlock_test.c ${SPINLOCK_SRC})
target_compile_options(spinlock_test PRIVATE ${TEST_C_FLAGS})
target_link_libraries(spinlock_test PRIVATE pthread)

add_executable(thread_spinlock_stress thread_spinlock_stress.c ${SPINLOCK_SRC})
target_compile_options(thread_spinlock_stress PRIVATE ${TEST_C_FLAGS})
target_link_libraries(thread_spinlock_stress PRIVATE pthread)

add_executable(process_spinlock_stress process_spinlock_stress.c ${SPINLOCK_SRC})
target_compile_options(process_spinlock_stress PRIVATE ${TEST_C_FLAGS})
target_link_libraries(process_spinlock_stress PRIVATE pthread)

add_executable(ptrace_concurrency_test ptrace_concurrency_test.c)
target_compile_options(ptrace_concurrency_test PRIVATE ${TEST_C_FLAGS})
target_link_libraries(ptrace_concurrency_test PRIVATE pthread)

add_executable(spinlock_fairness spinlock_fairness.c ${SPINLOCK_SRC})
target_compile_options(spinlock_fairness PRIVATE ${TEST_C_FLAGS} -DUSE_TICKET_LOCK)
target_link_libraries(spinlock_fairness PRIVATE pthread)
