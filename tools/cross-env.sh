# Usage: source tools/cross-env.sh [--llvm] <target-triple-prefix>
# Example: source tools/cross-env.sh i386-linux-gnu-
# Sets CROSS_COMPILE, CC, AR, AS, LD, RANLIB and STRIP variables.

if [ "$1" = "--llvm" ]; then
    USE_LLVM=1
    shift
else
    USE_LLVM=0
fi

if [ -z "$1" ]; then
    echo "usage: . tools/cross-env.sh [--llvm] <target-triple-prefix>" >&2
    return 1
fi

arch="$1"

case "$arch" in
    x86_64)
        prefix="x86_64-linux-gnu-"
        ;;
    i[3-6]86|x86)
        prefix="i686-linux-gnu-"
        ;;
    armv7|arm)
        prefix="arm-linux-gnueabi-"
        ;;
    aarch64)
        prefix="aarch64-linux-gnu-"
        ;;
    vax)
        prefix="vax-unknown-linux-gnu-"
        ;;
    *)
        prefix="${arch}-linux-gnu-"
        ;;
esac

export CROSS_COMPILE="${prefix}"

if [ $USE_LLVM -eq 1 ]; then
    TRIPLE=${CROSS_COMPILE%-}
    export CC="${CC:-clang --target=${TRIPLE}}"
    export AR="${AR:-llvm-ar}"
    export AS="${AS:-llvm-as}"
    export LD="${LD:-ld.lld}"
    export RANLIB="${RANLIB:-llvm-ranlib}"
    export STRIP="${STRIP:-llvm-strip}"
else
    export CC="${CC:-${CROSS_COMPILE}gcc}"
    export AR="${AR:-${CROSS_COMPILE}ar}"
    export AS="${AS:-${CROSS_COMPILE}as}"
    export LD="${LD:-${CROSS_COMPILE}ld}"
    export RANLIB="${RANLIB:-${CROSS_COMPILE}ranlib}"
    export STRIP="${STRIP:-${CROSS_COMPILE}strip}"
fi
