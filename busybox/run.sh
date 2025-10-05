#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch 1_36_1 \
  https://git.busybox.net/busybox source
fi

cp build-busybox.sh source/


podman run \
-v $(pwd)/source:/root/source \
-w /root/source \
--rm \
localhost/musl-builder:1 \
sh -c "/root/source/build-busybox.sh"
