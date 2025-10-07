# Image Prep

The gist is that you are going to make a raw image on disk, then partition it, and format it

block size doesn't matter much. 1M just maks it easy to calculate the size
```
dd if=/dev/zero of=disk.raw bs=1M count=8192
```

associate the loopback device with the raw image
```
losetup /dev/loop0 disk.raw
```

list the current associations to show it worked
```
losetup -l
```

make it GPT and normal EFI+Linux
```
fdisk /dev/loop0
```

this will create partition devices for the partitions in the img file
```
losetup -P /dev/loop0 disk.img
```

```
mkfs.vfat /dev/loop0p1
mkfs.ext4 /dev/loop0p2
```

detach the image from the loopback device after unmounting
```
losetup -d /dev/loop0
```

# Install

There are two install scripts
* install-esp.sh
* install.root.sh

They each mount a partition in the loopback device and copy files into it. They both assume the image is brand new and therefore empty.
