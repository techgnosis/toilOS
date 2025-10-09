#! /usr/bin/env bash

set -euo pipefail

losetup /dev/loop0 disk.raw

rm -rf ./root
mkdir root
mount /dev/loop0p2 root

mkdir root/os
cp ../packages/busybox/source/busybox root/os/
cp ../packages/micro/source/micro root/os/
cp ../packages/scripts/network-up.sh root/os/

# busybox symlinks
ln -s root/os/busybox root/os/sh
ln -s root/os/busybox root/os/mount
ln -s root/os/busybox root/os/getty
ln -s root/os/busybox root/os/init

mkdir root/etc
cp ../packages/etc/inittab root/etc/
cp ../packages/etc/fstab root/etc/
cp ../packages/etc/passwd root/etc/
cp ../packages/etc/group root/etc/
cp ../packages/etc/resolv.conf root/etc/

umount /dev/loop0p2

losetup -d /dev/loop0 disk.raw
