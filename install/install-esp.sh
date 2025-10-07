#! /usr/bin/env bash

set -euo pipefail

losetup /dev/loop0 disk.raw

rm -rf ./esp
mkdir esp
mount /dev/loop0p1 esp

mkdir -p esp/efi/boot/
cp kernel/source/bootx64.efi esp/efi/boot/
