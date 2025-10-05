#! /bin/sh

# Configure for mdev and static linking
make defconfig
exit
# Enable mdev and static build
sed -i 's/# CONFIG_MDEV is not set/CONFIG_MDEV=y/' .config
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config

# Build
make CC="gcc -static" LDFLAGS="-static"

# Copy output
cp busybox /output/busybox

# Verify static
if ldd busybox 2>&1 | grep -q "not a dynamic executable"; then
    echo "BusyBox is statically linked"
else
    echo "Error: BusyBox is not static" >&2
    exit 1
fi
