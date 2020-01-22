#!/usr/bin/env sh
# Build script for ZFS on Raspberry Pi
# by andrum99
# Based on https://gist.github.com/Alexey-Tsarev/d5809e353e756c5ce2d49363ed63df35

# This script must be run in a 64-bit userland on a Raspberry Pi running Raspbian. For example, under the 64-bit systemd-nspawn
# container provided by sakaki - see https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=232417&p=1566755&hilit=zfs#p1566212

set -e
set -x

CUR_DIR="$(pwd)"
cd ~

# Install required packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential bison flex bc libssl-dev wget git

# Build Linux kernel. Most of this we don't use - we just need the
# kernel headers and the Module.symvers

wget https://github.com/raspberrypi/linux/archive/raspberrypi-kernel_1.20200114-1.tar.gz
tar -xvf raspberrypi-kernel_1.20200114-1.tar.gz
cd linux-raspberrypi-kernel_1.20200114-1
KERNEL=kernel8
make bcm2711_defconfig
make -j6
make modules_prepare
make modules -j6

# build ZFS 64-bit modules

if [ ! -d zfs ]; then
    # https://github.com/zfsonlinux/zfs/wiki/Building-ZFS
    sudo apt install -y autoconf automake libtool gawk alien fakeroot ksh
    sudo apt install -y zlib1g-dev uuid-dev libattr1-dev libblkid-dev libselinux-dev libudev-dev
    sudo apt install -y libacl1-dev libaio-dev libdevmapper-dev libelf-dev
    sudo apt install -y python3 python3-dev python3-setuptools python3-cffi

    #sudo apt install -y linux-headers-$(uname -r)
    #sudo apt install raspberrypi-kernel-headers

    git clone https://github.com/zfsonlinux/zfs.git
fi

cd zfs
git checkout .
git checkout zfs-0.8.2
#git pull
#git branch

make clean || true
make distclean || true

./autogen.sh
autoreconf --install --force
./configure --with-linux=/home/pi/linux-raspberrypi-kernel_1.20200114-1

make -s -j6
sudo make install

sudo mv /lib/modules/4.19.93-v8 /lib/modules/4.19.93-v8+
tar -cvzf /home/pi/64-bit-zfs-modules-4.19.93.tar.gz /lib/modules/4.19.93-v8+/
echo "Now switch to a 32-bit kernel and run build32.sh"

cd "${CUR_DIR}"
