#!/usr/bin/env sh
# Install 64-bit kernel modules for Raspbian, and build 32-bit userland
# by andrum99

# This script must be run under a 32-bit userland on a 64-bit kernel

# Copy 64-bit kernel modules from where build64.sh left them
mkdir mods
cd mods
tar xvf ../64-bit-zfs-modules.tar.gz
cp -a * /lib/modules/4.19.75-v8+

# Load the modules
sudo ldconfig
sudo depmod -a
sudo modprobe zfs

# build 32-bit part of zfs-linux

sudo apt install raspberrypi-kernel-headers

# https://github.com/zfsonlinux/zfs/wiki/Building-ZFS
sudo apt install -y autoconf automake libtool gawk alien fakeroot ksh
sudo apt install -y zlib1g-dev uuid-dev libattr1-dev libblkid-dev libselinux-dev libudev-dev
sudo apt install -y libacl1-dev libaio-dev libdevmapper-dev libelf-dev
sudo apt install -y python3 python3-dev python3-setuptools python3-cffi

make clean || true
make distclean || true

./autogen.sh
autoreconf --install --force
./configure --with-linux=/home/pi/linux-raspberrypi-kernel_1.20190925-1

make -s -j$(nproc)
sudo make install
