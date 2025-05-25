# Usage: source tools/cross-env.sh <architecture>
# Example: source tools/cross-env.sh x86_64
#
# Exports CROSS_COMPILE, CC, AR, AS, LD, RANLIB and STRIP variables
# according to the selected architecture.  The script is meant to be
# sourced before invoking make.

if [ -z "$1" ]; then
    echo "usage: . tools/cross-env.sh <architecture>" >&2
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

export CC="${CC:-${CROSS_COMPILE}gcc}"
export AR="${AR:-${CROSS_COMPILE}ar}"
export AS="${AS:-${CROSS_COMPILE}as}"
export LD="${LD:-${CROSS_COMPILE}ld}"
export RANLIB="${RANLIB:-${CROSS_COMPILE}ranlib}"
export STRIP="${STRIP:-${CROSS_COMPILE}strip}"

