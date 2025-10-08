#! /usr/bin/env bash

set -euo pipefail

sudo mknod /dev/loop0 b 7 0

sudo chown root:disk /dev/loop0

sudo chmod 660 /dev/loop0
