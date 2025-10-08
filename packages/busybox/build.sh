#! /bin/sh

apk add \
perl \
musl-dev \
gcc \
make \
linux-headers

cd source
make clean
make defconfig

make CC="/usr/bin/x86_64-alpine-linux-musl-gcc -static" LDFLAGS="-static"
