#! /bin/sh

apk update

apk add \
go \
make

cd source

CGO_ENABLED=0 make build
