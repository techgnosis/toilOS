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

cd source

make mrproper
cp ../config-6.17 .config
make bzImage
