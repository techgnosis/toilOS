#! /usr/bin/env bash

set -euo pipefail

git clone --depth 1 --branch 1_36_1 https://git.busybox.net/busybox

cp build-busybox.sh busybox/

docker run \
-v $(pwd)/busybox:/root/busybox \
-w /root/busybox \
musl-builder:1 \
build.sh
