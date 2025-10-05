#! /usr/bin/env bash

set -euo pipefail

efibootmgr \
--create \
--disk /dev/sda \
--part 1 \
--label "toilOS" \
--loader vmlinuz-linux \
--unicode ' root=/dev/sda2 init=/os/init'
