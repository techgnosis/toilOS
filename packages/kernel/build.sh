#! /bin/sh

cd source

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

cp storage.config source/
cp cmdline.config source/

# you have to use defconfig
# the config made by tinyconfig does not have all the fields
# so you can't merge storage.config
make defconfig


./scripts/kconfig/merge_config.sh .config storage.config cmdline.config
