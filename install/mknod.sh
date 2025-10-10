#! /usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

set -euo pipefail

mknod /dev/loop0 b 7 0

chown root:disk /dev/loop0

chmod 660 /dev/loop0
