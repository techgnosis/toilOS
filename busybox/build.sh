#! /bin/sh

apk add perl
make clean
make defconfig

sed -i 's/# CONFIG_MDEV is not set/CONFIG_MDEV=y/' .config
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config

make CC="gcc -static" LDFLAGS="-static"
