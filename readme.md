# toilOS

hard to use, easy to understand


* Single user. It's just root and there are not any tools to suggest there is any other way
* Nothing automated

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
* GoKrazy - https://gokrazy.org/
* Chimera Linux - https://chimera-linux.org/
* Void Linux - https://voidlinux.org/
* Linux From Scratch - https://www.linuxfromscratch.org/

## Themes
This OS has no purpose. These are some ideas.
* ZigOS - system has nothing but zig. have to write your own userland.
* Zig+Golang - only syscalls.
* docsOS - everything is absurdly documented. Read all about every executable and every line of every config file
* Super transparent? Integrate Cilium?

### Every step
* If the EFI boot manager has nothing in NVRAM for the ESP then it defaults to looking for `\EFI\BOOT\BOOTX64.EFI`
* The kernel is sitting in the ESP at `\EFI\BOOT\` and it is named `BOOTX64.EFI`
* The kernel is an EFI Application and so it is launched directly from EFI without a boot loader
* The kernel has storage drivers compiled in so we don't need an initramfs
* Absent an initramfs, the kernel will automatically mount a devtmpfs at /dev
* The kernel has an embedded CMDLINE that has the root and where the init process is so it mounts the root and runs init
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
* /etc/fstab - technically not required but if I use fstab then I don't need a custom init script so it works out in the end

### Browser
* wpewebkit + minibrowser

### Terminal emulator
* Can't be a modern GPU rendered one like kitty or alacritty
* Must support software rendering

### Wayland
* Needs to be musl friendly
* must use software rendering
* dwl or velox (velox has been proven by Oasis)

### UEFI
OVMF on QEMU, configured with efibootmgr


### Boot loader
All machines need some software that you can tell where to find your kernel and how to launch it. UEFI includes software called the UEFI Boot Manager.

The boot manager can only launch EFI Applications. These are files with the same format as Windows executables (PE files) but they are compiled against EFI backends like GNU-EFI and EDK2 instead of Windows. The Linux kernel bzImage is not a PE file by default, however you can enable a feature called the EFI Stub. The EFI Stub is a tiny PE that is attached to the kernel that boots directly from the boot manager and then launches the kernel.

The combination of the boot manager and the EFI Stub means that you don't need GRUB or systemd-boot. You can configure the boot manager directly and cut out the middle man.

You can modify the boot manager using tools like efibootmgr. Modifying the boot manger means adding or removing entries from a list that displays when you turn on your machine. Those entries include a display name and a path to a kernel. The kernels must reside on an EFI System Parition (ESP), which is a partition that is labelled as type EFI and formatted as FAT32.
