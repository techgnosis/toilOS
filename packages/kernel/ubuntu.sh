#! /usr/bin/env bash

set -euo pipefail

echo "KERNEL SHELL"

podman run \
-v $(pwd):/work \
-w /work \
-it \
--rm \
ubuntu:24.04 \
bash
