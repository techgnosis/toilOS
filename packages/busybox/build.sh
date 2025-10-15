#! /bin/sh

cd source
make clean
cp ../config-1.36.1 .config

CC="musl-gcc -static" LDFLAGS="-static" make

make allnoconfig
