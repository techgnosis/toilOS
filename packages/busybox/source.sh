#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch 1_36_1 \
  https://git.busybox.net/busybox source
fi
