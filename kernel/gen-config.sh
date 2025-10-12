#! /bin/sh

apt-get update

apt-get install -y \
build-essential \
flex \
bison

cp storage.config source/
cp cmdline.config source/
cp framebuffer.config source/

cd source

make defconfig
./scripts/kconfig/merge_config.sh .config storage.config cmdline.config framebuffer.config
cp .config ../config-6.17
rm storage.config
rm cmdline.config
rm framebuffer.config