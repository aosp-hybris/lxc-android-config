#!/bin/sh

if [ -e $LXC_ROOTFS_PATH/dev/.android_boot_done ]; then
    exit 1
fi

mkdir $LXC_ROOTFS_PATH

mount -n -o bind,recurse /android $LXC_ROOTFS_PATH

rm -rf $LXC_ROOTFS_PATH/dev && mkdir -p $LXC_ROOTFS_PATH/dev

mkdir -p $LXC_ROOTFS_PATH/proc

# Create /dev/pts if missing
mkdir -p $LXC_ROOTFS_PATH/dev/pts

# Pass /sockets through
mkdir -p /dev/socket $LXC_ROOTFS_PATH/dev/socket
mount -n -o bind,rw /dev/socket $LXC_ROOTFS_PATH/dev/socket

# Make host can run /syste/bin/logcat
mkdir -p /dev/alog
mount -n -o bind,rw $LXC_ROOTFS_PATH/dev/alog /dev/alog 

# run config snippet scripts
run-parts /var/lib/lxc/android/pre-start.d || true

sed -i "/on nonencrypted/d" $LXC_ROOTFS_PATH/init.rc
