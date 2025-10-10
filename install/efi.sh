#! /usr/bin/env bash

set -exuo pipefail

if [ -f qemu_debug.log ]; then
  rm qemu_debug.log
fi

qemu-system-x86_64 \
-enable-kvm \
-m 2G \
-boot menu=on \
-drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/ovmf/OVMF_CODE.fd \
-drive if=pflash,format=raw,file=./OVMF_VARS.fd \
-kernel shellx64.efi \
-serial stdio
