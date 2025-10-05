#! /usr/bin/env bash

set -euo pipefail

if [ ! -d busybox ]; then
  git clone --depth 1 --branch 1_36_1 https://git.busybox.net/busybox
fi

cp build-busybox.sh busybox/


podman run \
-v $(pwd)/busybox:/root/busybox \
-w /root/busybox \
--rm \
-it \
localhost/musl-builder:1 \
sh # -c "/root/busybox/build-busybox.sh"
