# Usage: source tools/cross-env.sh <target-triple-prefix>
# Example: source tools/cross-env.sh i386-linux-gnu-
# Sets CROSS_COMPILE, CC, AR, AS, LD, RANLIB and STRIP variables.

if [ -z "$1" ]; then
    echo "usage: . tools/cross-env.sh <target-triple-prefix>" >&2
    return 1
fi

export CROSS_COMPILE="${1}"

export CC="${CC:-${CROSS_COMPILE}gcc}"
export AR="${AR:-${CROSS_COMPILE}ar}"
export AS="${AS:-${CROSS_COMPILE}as}"
export LD="${LD:-${CROSS_COMPILE}ld}"
export RANLIB="${RANLIB:-${CROSS_COMPILE}ranlib}"
export STRIP="${STRIP:-${CROSS_COMPILE}strip}"

