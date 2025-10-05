#! /usr/bin/env bash

set -euo pipefail

podman run \
-v $(pwd)/source:/root/source \
-w /root/source \
-it \
--rm \
alpine:3.20 \
sh
