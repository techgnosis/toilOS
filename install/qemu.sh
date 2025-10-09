#! /usr/bin/env bash

set -euo pipefail

qemu-system-x86_64 \
-enable-kvm \
-m 16G \
-drive if=pflash,format=raw,readonly=on,file=OVMF_CODE.fd \
-drive if=pflash,format=raw,file=OVMF_VARS.fd \
-drive file=disk.raw,format=raw
