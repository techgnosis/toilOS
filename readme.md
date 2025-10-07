# toilOS

hard to use, easy to understand

## Motivation
* understand every file on disk
* understand every running process
* understand every step of booting the system
* understand exactly what a modern distro does for you

## Design
toilOS is defined by what is not included. You have to do absolutely everything to get it setup and its as lean as possible.
* No boot loader. Hard dependency on EFI Boot Manager. BIOS not supported.
* No initramfs. Kernel includes all storage and filesystem drivers
* No dynamic linking. All executables are static linked with musl
* No service manager. The system starts with `busybox init` and that's it
* No networkmanager. Network devices are bootstrapped with `ip` and resolv.conf is manual
* No dhcpd. Static IPs only.


## Inspiration
* Oasis - https://github.com/oasislinux/oasis
* EasyOS - https://easyos.org/about/how-and-why-easyos-is-different.html

## Themes
This OS has no purpose. These are some ideas.
* ZigOS - system has nothing but zig. have to write your own userland.
* Zig+Golang - only syscalls.
* docsOS - everything is absurdly documented. Read all about every executable and every line of every config file

### Every step
* If the EFI boot manager has nothing in NVRAM for the device then it defaults to looking for `\EFI\BOOT\BOOTX64.EFI`
* The kernel is sitting in the ESP at `\EFI\BOOT\` and it is named `BOOTX64.EFI`
* The kernel is an EFI application and so it is launched directly from EFI without a boot loader
* The kernel has storage drivers compiled in so we don't need an initramfs
* Absent an initramfs, the kernel will automatically mount a devtmpfs
* We told the kernel what partition has the root and where the init process is so it mounts the root and runs init
* init can technically be anything executable but usually a purpose-built init process responds to signals and does some handy things. init is actually `busybox init` so that we can use inittab. I want inittab so that it can "respawn" a getty if I logout. If I launch a getty manually it will end when I logout. I'm tempted to let that happen but there's no way to fix it if you logout. You would just have to restart. That seems overly toil-ish even for me. Or does it...


### Repo structure
* Directories named for the binaries they build
* Each contains
    * `source` directory
    * source.sh - download the source into `source` directory
    * build.sh - install apk packages and build the source

###  filesystem layout
* /boot - EFI requires a separate fat32 EFI partition
* /os - instead of /usr, /bin, /sbin, /lib, /opt
* /root - root is the only user so I don't need /home
* /etc - core tools require it
* /proc - valuable and essentially free, required by many tools
* /sys - must have for tools like `ip`
* /dev - must have



### Kernel
* with all the needed disk drivers. I don’t want an initramfs.
* Need to figure out what drivers I need
* Needs EFI Stub
* Must embed the CMDLINE into the kernel. Can't have any VM config required.
* `ukify build --linux=/mnt/disk/boot/vmlinuz --initrd=/mnt/disk/boot/initrd.img --cmdline="root=/dev/vda1 ro console=ttyS0" --output=/mnt/esp/EFI/BOOT/BOOTX64.EFI`

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


#### Browser
* wpewebkit + minibrowser

#### Terminal emulator
* Can't be a modern GPU rendered one like kitty or alacritty
* Must support software rendering

#### Wayland
* Needs to be musl friendly
* must use software rendering
* dwl or velox (velox has been proven by Oasis)
