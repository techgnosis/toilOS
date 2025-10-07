#! /usr/bin/env bash

set -euo pipefail

losetup /dev/loop0 disk.raw

mount /dev/loop0p2 root

if [ ! -d root/os ]; then
    mkdir root/os
fi

cp ../busybox/source/busybox root/os/busybox
cp ../micro/source/micro root/os/micro
cp ../files/init.sh root/os/init.sh

if [ ! -d root/etc ]; then
    mkdir root/etc
fi

cp ../files/inittab root/etc/inittab
cp ../files/passwd root/etc/passwd
cp ../files/group root/etc/group
cp ../files/resolv.conf root/etc/resolv.conf
