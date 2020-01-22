#!/usr/bin/env sh
# Run this script on a 64-bit kernel, with a 32-bit userland

# Update 64-bit kernel config so it can find the zfs modules we compiled in build64.sh
sudo ldconfig
sudo depmod -a
