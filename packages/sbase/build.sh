#! /bin/sh

apk add \
musl-dev \
musl \
make \
gcc

cd source
make clean
CC="/usr/bin/x86_64-alpine-linux-musl-gcc -static" LDFLAGS="-static" make
