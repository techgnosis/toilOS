#! /bin/sh

apk update

apk add \
build-base \
bc \
flex \
bison \
perl \
openssl-dev \
elfutils-dev \
python3

make tinyconfig

make
