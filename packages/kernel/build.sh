#! /bin/sh

export DEBIAN_FRONTEND=noninteractive
export TZ=UTC

apt-get update

apt-get install -y \
build-essential \
bc \
flex \
bison \
perl \
libssl-dev \
libelf-dev \
python3 \
git \
rsync

cp storage.config source/
cp cmdline.config source/

cd source

make mrproper
make defconfig
./scripts/kconfig/merge_config.sh .config storage.config cmdline.config
make bzImage
