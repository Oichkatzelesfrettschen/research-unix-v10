# Build Modernization

This note describes improvements to the build helpers.

## cross-env.sh

The `tools/cross-env.sh` script sets environment variables for cross
compilation.  Source it with the desired target prefix:

```sh
. tools/cross-env.sh i386-linux-gnu-
```

The script populates `CROSS_COMPILE`, `CC`, `AR`, `AS`, `LD`, `RANLIB`
and `STRIP` for GNU style toolchains.  To use LLVM utilities instead of
GCC tools, pass `--llvm` before the prefix:

```sh
. tools/cross-env.sh --llvm i386-linux-gnu-
```

In this mode `CC` becomes `clang --target=i386-linux-gnu` and the archive
and linker tools are switched to their `llvm-` equivalents.
