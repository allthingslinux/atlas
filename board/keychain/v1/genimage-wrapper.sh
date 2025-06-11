#!/bin/sh
set -e

echo "wrapper running genimage.sh with arguments: $@"
ORIG="$(dirname "$0")"/../../../buildroot/support/scripts/genimage.sh

# First arg from Buildroot is the images dir; second *may* be the rootfs dir,
# or it may be an option (e.g. “-c”).  Detect which.
TMP_IMG_DIR="$1"
NEXT="$2"
if [ -d "$NEXT" ]; then
    WORKDIR="$NEXT"
    shift 2
else
    WORKDIR="$TMP_IMG_DIR"
    shift 1
fi

TMPWRAP="$(mktemp -d)"

# genimage.sh expects $TMPWRAP/root/root as the rootfs mountpoint
mkdir -p "$TMPWRAP/root/root"
cp -a "${WORKDIR}/." "$TMPWRAP/root/root"

exec "$ORIG" "$TMPWRAP" "$WORKDIR" "$@"