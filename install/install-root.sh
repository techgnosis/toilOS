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

mkdir root/etc
cp ../files/inittab root/etc/inittab
cp ../files/passwd root/etc/passwd
cp ../files/group root/etc/group
cp ../files/resolv.conf root/etc/resolv.conf
