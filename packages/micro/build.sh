#! /bin/sh

apk update

apk add \
go \
make \
file

cd source

CGO_ENABLED=0 make build

ldd micro
file micro
