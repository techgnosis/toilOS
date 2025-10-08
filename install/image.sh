#! /usr/bin/env bash

set -euo pipefail

echo "Creating raw disk image disk.raw"
dd if=/dev/zero of=disk.raw bs=1M count=8192 &> image.log

echo "Attaching /dev/loop0 to disk.raw"
losetup /dev/loop0 disk.raw &> image.log

echo "Creating partition table"
sfdisk /dev/loop0 &> image.log << EOF
label: gpt
start=2048, size=2097152, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name="EFI System Partition"
start=2099200, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, name="Linux Root"
EOF

echo "Restart loopback to create partition nodes"
losetup -d /dev/loop0 &> image.log
modprobe -r loop &> image.log
modprobe loop &> image.log
losetup -P /dev/loop0 disk.raw &> image.log

echo "Formatting ESP"
mkfs.fat  /dev/loop0p1 &> image.log
echo "Formatting root"
mkfs.ext4 /dev/loop0p2 &> image.log

echo "Detaching loopback from disk.raw"
losetup -d /dev/loop0 &> image.log
