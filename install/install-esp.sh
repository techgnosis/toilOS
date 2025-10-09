#! /usr/bin/env bash

set -exuo pipefail

losetup -P /dev/loop0 disk.raw

rm -rf ./esp
mkdir esp
mount /dev/loop0p1 esp

mkdir -p esp/efi/boot/
cp ../packages/kernel/source/arch/x86/boot/bzImage esp/efi/boot/bootx64.efi

umount /dev/loop0p1
losetup -d /dev/loop0
