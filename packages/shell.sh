#! /usr/bin/env bash

set -euo pipefail

podman run \
-v $(pwd):/root \
-w /root \
-it \
--rm \
alpine:3.22.1 \
sh
