#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch v0.5.5 \
  https://github.com/youki-dev/youki.git source
fi
