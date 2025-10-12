#! /os/sh

set -euo pipefail

ip address add 192.168.0.201/24 broadcast 192.168.0.255 dev eth0

ip link set dev eth0 up

ip route add 0.0.0.0/0 via 192.168.0.1
