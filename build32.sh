#!/usr/bin/env sh
# Install 64-bit kernel modules for Raspbian, and build 32-bit userland
# by andrum99

# This script must be run under a 32-bit userland on a 64-bit kernel

# Copy 64-bit kernel modules from where build64 left them
mkdir mods
cd mods
tar xvf ../64-bit-zfs-modules.tar.gz
cp -a * /lib/modules/4.19.75-v8+

# Load the modules
sudo ldconfig
sudo depmod -a
sudo modprobe zfs
sudo zpool status
