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
cp ../config-1.36.1 .config

CC="musl-gcc -static" LDFLAGS="-static" make
