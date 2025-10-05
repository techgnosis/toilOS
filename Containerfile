from scratch

COPY kernel/source/vmlinuz /os/vmlinuz

COPY busybox/source/busybox /os/busybox

COPY micro/source/micro /os/micro

COPY files/init.sh /os/init.sh

COPY files/inittab /etc/inittab

COPY files/passwd /etc/passwd
COPY files/group /etc/group

COPY files/resolv.conf /etc/resolv.conf
