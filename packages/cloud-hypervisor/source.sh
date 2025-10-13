#! /usr/bin/env bash

set -euo pipefail

if [ ! -d source ]; then
  git clone \
  --depth 1 \
  --branch v48.0 \
  https://github.com/cloud-hypervisor/cloud-hypervisor.git source
fi
