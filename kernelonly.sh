#!/bin/bash
set -x

HOSTNAME="imxyz6"

#LINUX_DIR=/mnt/extra4/linux-imx6-boundary-imx_3.10.17_1.0.2_ga
LINUX_DIR=/media/sd-sda2/linux-imx6-boundary-imx_3.10.17_1.0.2_ga



#
#   Copy kernel images and device tree .dtb to local rootfs
#
sudo cp $LINUX_DIR/vmlinux                                      /boot
sudo cp $LINUX_DIR/arch/arm/boot/uImage                         /boot
sudo cp $LINUX_DIR/arch/arm/boot/zImage                         /boot
sudo cp $LINUX_DIR/arch/arm/boot/dts/imx6q-sabrelite-nolcd.dtb  /boot/imx6q-sabrelite.dtb

##sudo cp $LINUX_DIR/arch/arm/boot/dts/imx6q-nitrogen6x.dtb       rootfs/boot/imx6q-sabrelite.dtb


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
cd $LINUX_DIR; export ARCH=arm; sudo make INSTALL_MOD_PATH=/tmp/tmpXX modules_install


#
#   Get rid of the symbolic links
#
sudo find /tmp/tmpXX/lib/modules -type l -exec rm -f {} \;


#
#   Now return to the directory location that we saved earlier
#
popd


#
#   Copy the modules to the local rootfs
#
sudo rsync -avD /tmp/tmpXX/lib/modules/* /lib/modules/











