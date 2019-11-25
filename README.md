# zfs-for-pi
ZFS for the Raspberry Pi.

This repository contains build scripts to allow building ZFS on Raspbian.

## Procedure
1. Switch to a 64-bit kernel
2. Install the 64-bit systemd-nspawn from sakaki (see https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=232417&p=1566755&hilit=zfs#p1566212)
3. Run build64.sh within the 64-bit systemd-nspawn container
4. Run build32.sh
