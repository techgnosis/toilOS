Ken

Dedicated drive
Create the file tree from Arch
Make the filesystem a git repo from Arch
Create an EFI Boot Mgr entry to boot into your dedicated drive
Full static link everything wuth musl


Learn from Oasis
https://github.com/oasislinux/oasis

The most important component is busybox
https://linux.die.net/man/1/busybox


Build everything in a container. Make it easy to build this OS from any distro without making a mess

### Repo structure
* Directories named for the binaries they build
* Each contains
    * `source` directory
    * source.sh - download the source
    * build.sh - install apk pacakges and build the source
    * run.sh - run build.sh in an alpine container

###  filesystem layout
It would be fun to experiment with a simpler OS. Something like
* /os (includes the kernel and all tools)
* /home
* /etc
* the rest of the required filesystems like /proc



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
* /dev/tty*
* DO THIS LAST
    * Focus on chroot and static builds first

### Editor
* micro

### Network
* busybox ip

### Files
* /etc/inittab
* /etc/fstab
* /etc/passwd
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
