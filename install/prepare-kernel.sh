#! /usr/bin/env bash

set -exuo pipefail

cp ../packages/kernel/source/arch/x86/boot/bzImage .

objcopy \
--add-section .cmdline=cmdline.txt \
--change-section-vma .cmdline=0x30000 \
--add-section .linux="bzImage" \
--change-section-vma .linux=0x1000000 \
--set-section-flags .linux=load \
--file-alignment 512 \
--section-alignment 4096 \
-O pei-x86-64 \
-S ./bzImage \
BOOTX64.EFI
