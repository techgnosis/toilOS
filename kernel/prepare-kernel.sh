#! /usr/bin/env bash

set -exuo pipefail

if [ -f bzImage ]; then
  rm bzImage
fi

if [ -f BOOTX64.EFI ]; then
  rm BOOTX64.EFI
fi

cp source/arch/x86/boot/bzImage .

objcopy \
--add-section .linux="bzImage" \
--change-section-vma .linux=0x1000000 \
--set-section-flags .linux=load \
--file-alignment 512 \
--section-alignment 4096 \
-O pei-x86-64 \
-S ./bzImage \
BOOTX64.EFI

rm ./bzImage

#--add-section .cmdline=cmdline.txt \
#--set-section-flags .cmdline=contents,alloc,load,readonly,data \
#--change-section-vma .cmdline=0x2000000 \
