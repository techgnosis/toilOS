#! /bin/sh

apk add --no-cache \
perl \
musl-dev \
gcc \
make \
cmake \
pkgconf \
linux-headers



make clean
make defconfig

sed -i 's/# CONFIG_MDEV is not set/CONFIG_MDEV=y/' .config
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config

make CC="gcc -static" LDFLAGS="-static"
