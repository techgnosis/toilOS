#! /usr/bin/env bash

set -euo pipefail

mount /dev/loop0p1 boot
rm -rf boot/efi
mkdir -p boot/efi/boot/
cp kernel/source/vmlinuz boot/efi/boot/bootx64.efi
