#! /usr/bin/env bash

set -euo pipefail

podman run \
--security-opt label=disable \
-v $(pwd):/source \
-w /source \
-it \
--rm \
alpine:3.22.1 \
sh

#podman run -v $(pwd):/source -w /source -it --rm alpine:3.22.1 sh -c "ls -Zd /source"

#sudo chcon -t container_file_t -R /var/home/jamesmusselwhite/code/toilOS/packages/busybox
sudo restorecon -v -F -R /var/home/jamesmusselwhite/code/toilOS/packages/busybox
