#! /bin/sh

set -exuo pipefail

apk update

apk add \
perl \
musl-dev \
gcc \
make \
linux-headers \
efivar-dev \
pkgconf \
efivar-dev \
popt-dev \
gettext-dev

export EFIDIR=BOOT

cd source
make deps install
make efibootmgr-static