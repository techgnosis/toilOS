#! /usr/bin/env bash

set -euo pipefail

podman run \
-v $(pwd)/source:/root/source \
-w /root/source \
-it \
--rm \
localhost/musl-builder:1 \
sh
