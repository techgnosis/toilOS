#! /usr/bin/env bash

set -exuo pipefail

qemu-system-x86_64 \
-enable-kvm \
-m 2G \
-drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/ovmf/OVMF_CODE.fd \
-drive if=pflash,format=raw,file=./OVMF_VARS.fd \
-drive file=disk.raw,format=raw,id=disk0,if=none \
-device ahci,id=ahci0 \
-device ide-hd,drive=disk0,bus=ahci0.0
