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

./scripts/kconfig/merge_config.sh .config storage.config
