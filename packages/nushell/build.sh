#! /bin/sh

set -exuo pipefail

apk update

apk add \
musl-dev \
curl \
gcc \
openssl-dev \
perl \
make


if [ ! -d /root/.rustup ]; then
  curl -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.87.0
fi

cd source
source ~/.cargo/env

#export CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER=/usr/bin/x86_64-alpine-linux-musl-gcc
export RUSTFLAGS="-C target-feature=+crt-static -C link-arg=-static -C link-arg=-no-pie"
cargo build \
--release \
--target x86_64-unknown-linux-musl \
--no-default-features \
--features rustls-tls \
--workspace
