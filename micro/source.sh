#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch v2.0.14 \
  https://github.com/zyedidia/micro.git source
fi
