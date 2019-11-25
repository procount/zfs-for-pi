# zfs-for-pi
ZFS for the Raspberry Pi.

This repository contains packages which can be installed directory on a Raspberry Pi running Raspbian. The packages contain 64-bit kernel modules, together with 32-bit userland and configuration elements. It has to be done that way on Raspbian at the moment, since Raspbian does not have a native 64-bit userland.

I have no intention of creating 32-bit kernel modules for ZFS. Running ZFS on a 32-bit system is known to be problematic. If you want 32-bit kernel modules, you will need to build them yourself.
