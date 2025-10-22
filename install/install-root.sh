#! /usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

function cleanup {
    set +e
    losetup -d /dev/loop0 &> /dev/null
    umount /dev/loop0p2 &> /dev/null
}

trap cleanup EXIT

set -exuo pipefail

losetup -P /dev/loop0 disk.raw

mkdir -p root
mount /dev/loop0p2 root

# delete as much as possible
# only /root and /var are kept
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
ln -s busybox root/os/ip
ln -s busybox root/os/ps
ln -s busybox root/os/ls

# sbase
cp ../packages/sbase/source/cat root/os/
cp ../packages/sbase/source/chmod root/os/
cp ../packages/sbase/source/chown root/os/
cp ../packages/sbase/source/cp root/os/
cp ../packages/sbase/source/mv root/os/
cp ../packages/sbase/source/rm root/os/
cp ../packages/sbase/source/which root/os/
cp ../packages/sbase/source/env root/os/
cp ../packages/sbase/source/mkdir root/os/
cp ../packages/sbase/source/rmdir root/os/
cp ../packages/sbase/source/touch root/os/
cp ../packages/sbase/source/touch root/os/
cp ../packages/sbase/source/grep root/os/

# etc
mkdir root/etc
cp ../packages/etc/inittab root/etc/
cp ../packages/etc/fstab root/etc/
cp ../packages/etc/passwd root/etc/
cp ../packages/etc/group root/etc/
cp ../packages/etc/resolv.conf root/etc/
cp ../packages/etc/profile root/etc/

# system directories
mkdir root/sys
mkdir root/proc
mkdir root/run
mkdir root/dev

# we don't delete them in the beginning since they are state
# but they need to be created if they are not there
if [ ! -d root/root ]; then
  mkdir root/root
fi

if [ ! -d root/var ]; then
  mkdir root/var
fi

umount /dev/loop0p2
losetup -d /dev/loop0
