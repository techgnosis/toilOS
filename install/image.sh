#! /usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

set -exuo pipefail

rm disk.raw

dd if=/dev/zero of=disk.raw bs=1M count=8192

losetup /dev/loop0 disk.raw

sfdisk /dev/loop0 << EOF
label: gpt
start=2048, size=2097152, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name="EFI System Partition"
start=2099200, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, name="Linux Root"
EOF

losetup -d /dev/loop0
modprobe -r loop
modprobe loop
losetup -P /dev/loop0 disk.raw
echo "waiting for partition device nodes to populate"
sleep 10



mkfs.fat  /dev/loop0p1
mkfs.ext4 /dev/loop0p2

losetup -d /dev/loop0
