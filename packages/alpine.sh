#! /usr/bin/env bash

set -euo pipefail

podman run \
-v $(pwd):/work \
-w /work \
-it \
--rm \
alpine:3.20.1 \
sh
