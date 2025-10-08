#! /bin/sh

apk add \
perl \
musl-dev \
gcc \
make \
linux-headers

cp minimal.config source
cd source
make clean
cp minimal.config .config
make oldconfig # sets all missing options to No

make CC="gcc -static" LDFLAGS="-static"
