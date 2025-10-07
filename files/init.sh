#! /os/sh

mount -t proc none /proc
mount -t sysfs none /sys
mount -t tmpfs tmpfs /run

# getty 38400 tty1
