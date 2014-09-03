#!/bin/sh

# Check if android init exist or not
if [ ! -e /android/init ]; then
    exit 1
fi

# Create /dev/pts if missing
mkdir -p $LXC_ROOTFS_PATH/dev/pts

# Pass /sockets through
mkdir -p /dev/socket $LXC_ROOTFS_PATH/dev/socket
mount -n -o bind,rw /dev/socket $LXC_ROOTFS_PATH/dev/socket

# run config snippet scripts
run-parts /var/lib/lxc/android/pre-start.d || true

#sed -i "/on nonencrypted/d" $LXC_ROOTFS_PATH/init.rc

