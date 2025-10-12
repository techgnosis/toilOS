#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch 18 \
  https://github.com/rhboot/efibootmgr.git source
fi
