#!/bin/bash
set -e
set -x

LOOPDEV=$(losetup -f)
losetup -P ${LOOPDEV} $1

fdisk -u ${LOOPDEV} --wipe always <<EOF
p
g
n


+100M
t
1
n


+100M
p
w
EOF

mkfs.fat -F32 -s2 ${LOOPDEV}p1
#yes | mkfs.ext4 ${LOOPDEV}p2

mkdir -p mnt
mount ${LOOPDEV}p2 mnt
mkdir -p mnt/boot
mount ${LOOPDEV}p1 mnt/boot

mkdir -p mnt/boot/efi/boot/
#cp startup.nsh mnt/boot/
cp output/images/bzImage mnt/boot/efi/boot/bootx64.efi
dd if=output/images/rootfs.ext4 of=${LOOPDEV}p2

sync
umount mnt/boot
umount mnt

losetup -d ${LOOPDEV}
