#! /usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

function cleanup {
    losetup -d /dev/loop0 &> /dev/null
    umount /dev/loop0p1 &> /dev/null
}

trap cleanup EXIT

set -exuo pipefail

losetup -P /dev/loop0 disk.raw
mount /dev/loop0p1 esp
mount /dev/loop0p2 root

tree esp
tree root

umount /dev/loop0p2
umount /dev/loop0p1
losetup -d /dev/loop0
