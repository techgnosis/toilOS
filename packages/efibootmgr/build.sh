#! /bin/sh

apk add \
perl \
musl-dev \
gcc \
make \
linux-headers \
efivar-dev

cd source
make clean

CC="musl-gcc -static" LDFLAGS="-static" make
