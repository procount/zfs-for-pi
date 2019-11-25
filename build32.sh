#!/usr/bin/env sh
# Install 64-bit kernel modules for Raspbian, and build 32-bit userland
# by andrum99

# build 32-bit part of zfs-linux

sudo apt install raspberrypi-kernel-headers

# https://github.com/zfsonlinux/zfs/wiki/Building-ZFS
sudo apt install -y autoconf automake libtool gawk alien fakeroot ksh libssl-dev
sudo apt install -y zlib1g-dev uuid-dev libattr1-dev libblkid-dev libselinux-dev libudev-dev
sudo apt install -y libacl1-dev libaio-dev libdevmapper-dev libelf-dev
sudo apt install -y python3 python3-dev python3-setuptools python3-cffi

make clean || true
make distclean || true

./autogen.sh
autoreconf --install --force
./configure

make -s -j6
sudo make install
