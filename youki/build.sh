#! /bin/sh

apk add \
musl-dev \
linux-headers \
curl \
gcc \
libseccomp-dev

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.85.0

source ~/.cargo/env

cargo build --release --target aarch64-unknown-linux-musl --no-default-features --features v2

#cargo build --release --target x86_64-unknown-linux-musl --no-default-features --features v2
