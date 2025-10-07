#! /usr/bin/env bash

set -euo pipefail

mount /dev/loop0p1 esp
rm -rf esp/efi
mkdir -p esp/efi/boot/
cp kernel/source/bootx64.efi esp/efi/boot/
