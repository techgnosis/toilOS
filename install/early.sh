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
-drive file=disk.raw,format=raw,id=disk0,if=none \
-device ahci,id=ahci0 \
-device ide-hd,drive=disk0,bus=ahci0.0 \
-append "init=/os/sh console=ttyS0,115200 earlycon=uart8250,io,0x3f8 debug loglevel=8" \
-kernel ../kernel/BOOTX64.EFI


#-debugcon file:debug.log -global isa-debugcon.iobase=0x402
