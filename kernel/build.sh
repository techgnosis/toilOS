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

make defconfig # you have to use defconfig. tinyconfig is missing entries so can't merge

./scripts/kconfig/merge_config.sh .config storage.config
