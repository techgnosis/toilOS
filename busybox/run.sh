#! /usr/bin/env bash

set -euo pipefail

cp build.sh source/

podman run \
-v $(pwd)/source:/root/source \
-w /root/source \
--rm \
alpine:3.20 \
sh -c "/root/source/build.sh"

cp source/busybox .
