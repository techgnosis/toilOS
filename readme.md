# toilOS

hard to use, easy to understand

Motivation
* understand every file on disk
* understand every running process
* understand every step of booting the system
* understand exactly what a modern distro does for you

toilOS is defined by what is not included. You have to do absolutely everything to get it setup and its as lean as possible.
* No boot loader. Hard dependency on EFI Boot Manager. BIOS not supported.
* No initramfs. Kernel includes all storage and filesystem drivers
* No dynamic linking. All executables are static linked with musl
* No service manager. The system starts with `busybox init` and that's it
* No networkmanager. Network devices are bootstrapped with `ip` and resolv.conf is manual
* No dhcpd. Static IPs only.

Inspiration
* Oasis - https://github.com/oasislinux/oasis
* EasyOS - https://easyos.org/about/how-and-why-easyos-is-different.html

TODO:
* busybox symlinks
* install Silverblue so I can use ostree eventually


### Boot
* The kernel has storage drivers compiled in.
* The kernel will automatically mount a devtmpfs. You do not need to do it.
* EFI Boot Manager -> Kernel -> devtmpfs -> /dev/sda -> /os/init
* using `busybox init` so that we can use inittab. I want inittab so that it can "respawn" a getty if I logout. If I launch a getty manually it will end when I logout
* not using `/etc/fstab`. Since I already have `/etc/inittab` then I am mounting via a script which gives me more options and you don't have to know the file format for `/etc/fstab`

### Repo structure
* Directories named for the binaries they build
* Each contains
    * `source` directory
    * source.sh - download the source
    * build.sh - install apk pacakges and build the source

###  filesystem layout
* /boot - EFI requires a separate fat32 EFI partition
* /os - instead of /usr, /bin, /sbin, , /lib, /opt
* /root - root is the only user so I don't need /home
* /etc - core tools require it
* /proc - valuable and essentially free, required by many tools
* /sys - must have for tools like `ip`
* /dev - must have
* /var - core tools require it



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

### Containers
* youki (instead of runc)
    * rust
    * built static already

### Editor
* micro

### Network
* busybox ip

### Files
* /etc/inittab - must have so that getty can respawn if you logout
* /etc/passwd - must have to be able to login
* /etc/group
* /etc/resolv.conf


### Wayland

It's probably not possible to static link a Wayland compositor. However, this is what I would do if I could.

#### Browser
* wpewebkit + minibrowser

#### Terminal emulator
* kitty

#### Wayland
* Needs to be musl friendly
* sway, dwl, river



### Install
Needs to happen from a running Linux host. Installation requires the `umoci` CLI

* fdisk the disk
* mkfs.ext4 the partition
* run install/build.sh
* run install/efi.sh to setup boot manager
