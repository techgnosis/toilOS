#! /usr/bin/env bash

set -euo pipefail

losetup /dev/loop0p0 disk.raw

mount /dev/loop0p1 boot

cp kernel/source/vmlinuz boot/EFI

if [ ! -d tree ]; then
  mkdir tree
  mkdir tree/boot
  mkdir tree/os
  mkdir tree/etc
fi

cp kernel/source/something tree/
