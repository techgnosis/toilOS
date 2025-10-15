#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch 0.1 \
  git://git.suckless.org/sbase source
fi
