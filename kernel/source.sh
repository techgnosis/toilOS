#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch v6.17 \
  https://github.com/torvalds/linux.git source
fi

cp storage.config source/
cp build.sh source/
