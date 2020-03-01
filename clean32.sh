#!/usr/bin/env sh
# zfs-for-pi
# Clean up instructions for 32-bit userland
# by andrum99

set -e
set -x

# Get RELEASE and KVERSION strings from version file
. ./version

echo "32-bit ZFS modules were installed into /lib/modules/${KVERSION}-v7l/extra"
echo "Assuming you've no other out of tree modules, to clean up 32-bit modules"
echo "simply delete this directory, then run sudo depmod -a"
