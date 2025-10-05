#! /os/sh

mount -t proc none /proc
mount -t sysfs none /sys
mknod /dev/console c 5 1
mknod /dev/tty1 c 4 1
mknod /dev/null c 1 3
mknod /dev/zero c 1 5
chmod 600 /dev/console
chmod 600 /dev/tty1
chmod 666 /dev/null
chmod 666 /dev/zero
