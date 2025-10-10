#! /usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

set -exuo pipefail

losetup -P /dev/loop0 disk.raw

mount /dev/loop0p2 root
rm -rf root/os
rm -rf root/etc

mkdir root/os
cp ../packages/busybox/source/busybox root/os/
cp ../packages/micro/source/micro root/os/
cp ../packages/scripts/network-up.sh root/os/

# busybox symlinks
ln -s busybox root/os/sh
ln -s busybox root/os/mount
ln -s busybox root/os/getty
ln -s busybox root/os/init
ln -s busybox root/os/login
ln -s busybox root/os/cat
ln -s busybox root/os/chmod
ln -s busybox root/os/chown
ln -s busybox root/os/cp
ln -s busybox root/os/mv
ln -s busybox root/os/rm
ln -s busybox root/os/dmesg

mkdir root/etc
cp ../packages/etc/inittab root/etc/
cp ../packages/etc/fstab root/etc/
cp ../packages/etc/passwd root/etc/
cp ../packages/etc/group root/etc/
cp ../packages/etc/resolv.conf root/etc/

umount /dev/loop0p2

losetup -d /dev/loop0
