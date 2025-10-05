#! /usr/bin/env bash

set -euo pipefail

podman build -t musl-builder .
