#! /bin/sh

apk update

apk add \
go \
make \
file \
git

cd source

CGO_ENABLED=0 make build
