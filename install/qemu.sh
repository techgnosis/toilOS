#! /usr/bin/env bash

set -exuo pipefail

qemu-system-x86_64 \
-enable-kvm \
-m 2G \
-boot menu=on \
-bios /usr/share/edk2/ovmf/OVMF_CODE.fd \
-drive file=disk.raw,format=raw \
-serial stdio


#-drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/ovmf/OVMF_CODE.fd \
#-drive if=pflash,format=raw,file=./OVMF_VARS.fd \
