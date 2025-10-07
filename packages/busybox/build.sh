#! /bin/sh

cd source

apk add \
perl \
musl-dev \
gcc \
make \
linux-headers



make clean
make defconfig

sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config

make CC="gcc -static" LDFLAGS="-static"
