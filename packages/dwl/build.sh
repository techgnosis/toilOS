#! /bin/sh

cd source

apk add \
musl-dev \
gcc \
make \
linux-headers \
wayland-dev \
wayland-static \
wlroots-dev \
wlroots-static \
libxkbcommon-static \
pkgconf \
wayland-protocols

CC="musl-gcc -static" LDFLAGS="-static" make
