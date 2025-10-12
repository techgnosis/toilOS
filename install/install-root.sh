#! /usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

function cleanup {
    set +e
    losetup -d /dev/loop0
    umount /dev/loop0p2
}

trap cleanup EXIT

set -exuo pipefail

losetup -P /dev/loop0 disk.raw

if [ ! -d root ]; then
    mkdir root
fi
mount /dev/loop0p2 root
rm -rf root/os
rm -rf root/etc
rm -rf root/sys
rm -rf root/proc
rm -rf root/run
rm -rf root/dev

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
ln -s busybox root/os/clear
ln -s busybox root/os/cp
ln -s busybox root/os/mv
ln -s busybox root/os/rm
ln -s busybox root/os/ls
ln -s busybox root/os/ip
ln -s busybox root/os/which
ln -s busybox root/os/env
ln -s busybox root/os/mkdir
ln -s busybox root/os/rmdir
ln -s busybox root/os/touch
ln -s busybox root/os/ps


mkdir root/etc
cp ../packages/etc/inittab root/etc/
cp ../packages/etc/fstab root/etc/
cp ../packages/etc/passwd root/etc/
cp ../packages/etc/group root/etc/
cp ../packages/etc/resolv.conf root/etc/
cp ../packages/etc/profile root/etc/

mkdir root/sys
mkdir root/proc
mkdir root/run
mkdir root/dev

if [ ! -d root/root ]; then
  mkdir root/root
fi

umount /dev/loop0p2
losetup -d /dev/loop0
