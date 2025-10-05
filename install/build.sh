#! /usr/bin/env bash

set -euo pipefail

podman build -t toilOS:1 Containerfile
