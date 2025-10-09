#! /usr/bin/env bash

set -euo pipefail

echo "KERNEL SHELL"

podman run \
--security-opt label=disable \
-v $(pwd):/source \
-w /source \
-it \
--rm \
ubuntu:24.04 \
bash
