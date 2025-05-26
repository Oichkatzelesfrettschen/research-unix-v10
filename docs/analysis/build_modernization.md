# Build Modernization Plan

This note outlines the current build system layout and sketches a path toward a modern CMake-based workflow.

## Current Makefile tree
- **Root `Makefile`:** dispatches to `engine/kernel` for the kernel and `engine/modern/tests` for test programs.
- **`engine/kernel/Makefile`:** compiles the Research UNIX kernel from subdirectories (`os`, `vm`, `md`, `io`, `fs`, `ml`, `inet`).
- **`engine/modern/tests/Makefile`:** builds a small suite of C23 test programs and stress tests.
- **Other directories:** the repository contains roughly 150 additional `Makefile`s for utilities, the Jerq environment, and assorted tools. A quick count shows:

```sh
$ find . -name Makefile | wc -l
155
```

These auxiliary files follow no single convention and rely on traditional `make`.

## Proposed CMake workflow
1. Introduce a top-level `CMakeLists.txt` that configures the project to use Ninja and the Clang toolchain.
2. Set default language standards to C23 and C++23.
3. Gradually replace existing `Makefile`s with CMake targets while preserving the ability to build legacy components.

### Milestones
1. **Convert `engine/modern/tests`:** provide simple CMake examples and verify Ninja builds on Linux.
2. **Convert `engine/kernel`:** model the kernel build with CMake object libraries and custom linker scripts.
3. **Convert `jerq` and related utilities:** migrate graphics and demo programs.
4. **Convert remaining directories (`r70`, `tools`, etc.):** replace ad-hoc builds and remove obsolete Makefiles.

Each milestone should leave the repository in a working state so incremental progress can be tested with Ninja and Clang.

