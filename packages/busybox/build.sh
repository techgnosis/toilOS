#! /bin/sh

apk update

apk add \
perl \
musl-dev \
gcc \
make \
linux-headers

cd source
make clean
make defconfig

CC="musl-gcc -static" LDFLAGS="-static" make
