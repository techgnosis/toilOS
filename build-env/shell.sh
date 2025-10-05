#! /usr/bin/env bash

set -euo pipefail

podman run \
-it \
--rm \
musl-builder:1 \
sh
