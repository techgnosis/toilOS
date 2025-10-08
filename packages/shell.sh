#! /usr/bin/env bash

set -euo pipefail

podman run \
--security-opt label=disable \
-v $(pwd):/source \
-w /source \
-it \
--rm \
alpine:3.20.1 \
sh
