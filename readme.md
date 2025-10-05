# toilOS

hard to use, easy to understand

toilOS is defined by what is not included. You have to do absolutely everything to get it setup.
* No boot loader. Hard dependency on EFI Boot Manager. BIOS not supported.
* No initramfs. Kernel includes all storage and filesystem drivers
* No dynamic linking. All executables are static linked with musl
* No service manager. The system starts with `busybox init` and that's it
* No networkmanager. Network devices are bootstrapped with `ip` and resolv.conf is manual
* No dhcpd. Static IPs only.

Inspiration
* Oasis - https://github.com/oasislinux/oasis
* EasyOS - https://easyos.org/about/how-and-why-easyos-is-different.html


### Repo structure
* Directories named for the binaries they build
* Each contains
    * `source` directory
    * source.sh - download the source
    * build.sh - install apk pacakges and build the source
    * run.sh - run build.sh in an alpine container

###  filesystem layout
It would be fun to experiment with a simpler OS. Something like
* /os (instead of /boot, /usr, /bin, /sbin)
* /home
* /etc
* /proc
* /sys
* /dev
* /var (includes /var/tmp)



### Kernel
* with all the needed disk drivers. I don’t want an initramfs.
* Need to figure out what drivers I need
* Needs EFI Stub
* make tinyconfig

### Init
* busybox init

### Shell
* busybox getty
* busybox login

### Core utils
* busybox is great but lacks features sometimes
* coreutils-rs
* sbase

### Filesystems
* busybox mount

### Devices
* busybox mdev
* Not udevd
* /dev/console
* /dev/tty1
* /dev/null
* /dev/zero

### Editor
* micro

### Network
* busybox ip

### Files
* /etc/inittab - must have so that getty can respawn if you logout
* /etc/passwd - must have to be able to login
* /etc/group
* /etc/resolv.conf


### LIKELY WONT WORK

#### Containers
* podman
* buildah
* youki (instead of runc)
    * rust
    * built static already

#### Browser
* wpewebkit + minibrowser

#### Terminal emulator
* kitty

#### Wayland
* Needs to be musl friendly
* sway, dwl, river



### Install
Needs to happen from a running Linux host

* fdisk the disk
* mkfs.ext4
* mkdir
* copy all the files
* run efibootmgr to setup boot
