#!/bin/sh
set -e

# ensure /root exists so genimage’s “mountpoint = /root” actually finds something
mkdir -p "${TARGET_DIR}/root"

# Ensure ttyGS0 and fstab entries are present
grep -q "GADGET_SERIAL" "${TARGET_DIR}/etc/inittab" \
	|| echo '/dev/ttyGS0::respawn:/sbin/getty -L  /dev/ttyGS0 0 vt100 # GADGET_SERIAL' >> "${TARGET_DIR}/etc/inittab"

grep -q "ubi0:persist" "${TARGET_DIR}/etc/fstab" \
	|| echo 'ubi0:persist	/root		ubifs	defaults	0	0' >> "${TARGET_DIR}/etc/fstab"
