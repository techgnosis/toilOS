#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch v0.7 \
  https://codeberg.org/dwl/dwl.git source
fi
