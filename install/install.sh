#! /usr/bin/env bash

set -euo pipefail

mount -t ext4 /dev/sdb1 /mnt/boot
mount -t ext4 /dev/sdb2 /mnt/root

cp ../kernel/source/vmlinuz /mnt/boot/vmlinuz

cp ../busybox/source/busybox /mnt/root/os/busybox
cp ../micro/source/micro /mnt/root/os/micro
cp ../files/init.sh /mnt/root/os/init.sh

cp ../files/inittab /mnt/root/etc/inittab
cp ../files/passwd /mnt/root/etc/passwd
cp ../files/group /mnt/root/etc/group
cp ../files/resolv.conf /mnt/root/etc/resolv.conf

umount /dev/sdb2
umount /dev/sdb1
