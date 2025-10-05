#! /bin/sh

apk update

apk add \
build-base \
ncurses-dev \
bc \
flex \
bison \
perl \
openssl-dev \
elfutils-dev

make defconfig

make
