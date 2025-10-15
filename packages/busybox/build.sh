#! /bin/sh

apk update

apk add \
perl \
musl-dev \
gcc \
make \
linux-headers

cp custom.config source/
cd source
make clean
male allnoconfig



CC="musl-gcc -static" LDFLAGS="-static" make
