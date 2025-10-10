#! /usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

set -exuo pipefail

losetup -P /dev/loop0 disk.raw

if [ ! -d esp ]; then
    mkdir esp
fi
mount /dev/loop0p1 esp

if [ -d esp/efi ]; then
  rm -rf esp/efi
fi

mkdir -p esp/EFI/BOOT

cp BOOTX64.EFI esp/EFI/BOOT/BOOTX64.EFI
#cp shellx64.efi esp/EFI/BOOT/BOOTX64.EFI


umount /dev/loop0p1
losetup -d /dev/loop0
rmdir esp
