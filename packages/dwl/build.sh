#! /bin/sh

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

CC=musl-gcc LDFLAGS=-static make clean install
