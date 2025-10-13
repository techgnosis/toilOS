#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch 0.107.0 \
  https://github.com/nushell/nushell.git source
fi
