#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch v0.43.1 \
  https://github.com/zellij-org/zellij.git source
fi
