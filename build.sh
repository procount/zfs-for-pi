#!/usr/bin/env sh
# Build script for ZFS on Raspberry Pi
# by andrum99
# Based on https://gist.github.com/Alexey-Tsarev/d5809e353e756c5ce2d49363ed63df35

set -e
set -x

CUR_PWD="$(pwd)"
cd "$(dirname $0)"

if [ ! -d zfs ]; then
    # https://github.com/zfsonlinux/zfs/wiki/Building-ZFS
    sudo apt-get install -y build-essential autoconf automake libtool gawk alien fakeroot ksh
    sudo apt-get install -y zlib1g-dev uuid-dev libattr1-dev libblkid-dev libselinux-dev libudev-dev
    sudo apt-get install -y libacl1-dev libaio-dev libdevmapper-dev libssl-dev libelf-dev
    sudo apt-get install -y python3 python3-dev python3-setuptools python3-cffi

    #sudo apt-get install -y linux-headers-$(uname -r)
    #sudo apt-get install raspberrypi-kernel-headers

    sudo apt-get install -y git
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
./configure --with-linux=/home/pi/linux-raspberrypi-kernel_1.20190925-1

make -s -j$(nproc)
sudo make install

#sudo ldconfig

#sudo depmod -a
#sudo modprobe zfs
#sudo zpool import -a
#sudo zpool import -a -d /dev

cd "${CUR_DIR}"
