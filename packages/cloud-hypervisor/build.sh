#! /bin/sh

set -exuo pipefail

apk update

apk add \
git \
musl-dev \
curl \
gcc \
make \
m4 \
bison \
flex \
libuuid \
openssl-dev \
perl


if [ ! -d /root/.rustup ]; then
  curl -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.88.0 --target x86_64-unknown-linux-musl
fi

cd source
source ~/.cargo/env

cargo build \
--release \
--target=x86_64-unknown-linux-musl \
--all

# --target=x86_64-unknown-linux-musl \
