#! /usr/bin/env bash

set -euo pipefail

dd if=/dev/zero of=disk.raw bs=1M count=8192

losetup /dev/loop0 disk.raw

sfdisk /dev/loop0 <<< EOF
label: gpt
# Partition 1: 1GB EFI System Partition
# start= (omitted to use default start), size=1G, type=GUID, name="Partition Name"
, 1G, C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name="EFI System Partition"

# Partition 2: Fill the rest of the disk, Linux Filesystem
# start= (omitted to use default start after P1), size= (omitted to use max size), type=GUID, name="Partition Name"
, , 0FC63DAF-8483-4772-8E79-3D69D8477DE4, name="Linux Root"
EOF

losetup -P /dev/loop0 disk.img

mkfs.fat  /dev/loop0p1
mkfs.ext4 /dev/loop0p2

losetup -d /dev/loop0
