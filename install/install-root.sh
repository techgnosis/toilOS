#! /usr/bin/env bash

set -euo pipefail

losetup /dev/loop0 disk.raw

rm -rf ./root
mkdir root
mount /dev/loop0p2 root

mkdir root/os
cp ../busybox/source/busybox root/os/busybox
cp ../micro/source/micro root/os/micro
cp ../files/init.sh root/os/init.sh

# busybox symlinks
ln -s root/os/busybox root/os/sh
ln -s root/os/busybox root/os/mount
ln -s root/os/busybox root/os/getty
ln -s root/os/busybox root/os/init

mkdir root/etc
cp ../files/inittab root/etc/inittab
cp ../files/passwd root/etc/passwd
cp ../files/group root/etc/group
cp ../files/resolv.conf root/etc/resolv.conf
