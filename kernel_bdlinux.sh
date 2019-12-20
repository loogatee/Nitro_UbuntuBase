#!/bin/sh
set -x


LINUX_DIR=/opt/linux-imx6
SDCARD=/media/jreed/bd5deb8b-84f7-4909-a674-0d0b626c120f



#
#   Copy kernel images and device tree .dtb to local rootfs
#
sudo cp $LINUX_DIR/vmlinux                                 $SDCARD/boot
sudo cp $LINUX_DIR/arch/arm/boot/uImage                    $SDCARD/boot
sudo cp $LINUX_DIR/arch/arm/boot/zImage                    $SDCARD/boot
sudo cp $LINUX_DIR/arch/arm/boot/dts/imx6q-nitrogen6x.dtb  $SDCARD/boot


#
#   Prepare for module build by creating a destination directory
#
sudo rm -rf /tmp/tmpXX
mkdir  /tmp/tmpXX


#
#   Saves the current working directory, so we can return here again later
#
pushd .


#
#   Make the modules
#
cd $LINUX_DIR; make INSTALL_MOD_PATH=/tmp/tmpXX modules_install


#
#   Get rid of the symbolic links
#
find /tmp/tmpXX/lib/modules -type l -exec rm -f {} \;


#
#   Now return to the directory location that we saved earlier
#
popd


#
#   Copy the modules to the local rootfs
#
sudo rsync -avD /tmp/tmpXX/lib/modules/* $SDCARD/lib/modules/



#
#   Waits until all the disk data is written
#
sync;sync;

