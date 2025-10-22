#! /usr/bin/env bash

set -exuo pipefail

qemu-system-x86_64 \
-machine q35 \
-enable-kvm \
-m 2G \
-drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/ovmf/OVMF_CODE.fd \
-drive if=pflash,format=raw,file=./OVMF_VARS.fd \
-drive file=disk.raw,format=raw,id=disk0,if=none \
-device virtio-blk-pci,drive=disk0 \
-device virtio-gpu-pci \
-vga none \
-display gtk


#-nic none \
#-netdev user,id=net0 \
#-device virtio-net-pci,netdev=net0 \
