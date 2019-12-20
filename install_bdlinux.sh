#!/bin/sh
set -x


LINUX_DIR=/opt/linux-imx6
SDCARD=/media/jreed/6e120ed0-30d4-48a7-b6a0-df4fd71943d4


#
#   The Custom files need to have the correct owner/group
#     - All files owned by root
#     - All files are root group except for /etc/shadow
#
sudo find rootfs -exec chown root {} \; -exec chgrp root {} \;
sudo chgrp shadow rootfs/etc/shadow


#
#   use wget to grab the ubuntu core release
#
cd ..; wget http://cdimage.ubuntu.com/ubuntu-core/releases/14.04.1/release/ubuntu-core-14.04.1-core-armhf.tar.gz


#
#   Ubuntu Core files will go into the rootfs directory
#
mkdir -p UbuntuCore_rootfs; cd UbuntuCore_rootfs


#
#   un-zip and un-tar the Ubuntu_Core files
#
sudo tar --numeric-owner -xzvf ../ubuntu-core-14.04.1-core-armhf.tar.gz


#
#   The .tar.gz file is no longer needed
#
rm -f ../ubuntu-core-14.04.1-core-armhf.tar.gz


#
#   Modifies the stock Ubuntu Core Release with these files
#
sudo rsync -avD ../UbuntuCore_CustomFiles_BD/rootfs/* .


#
#    An example of a simple addition to an existing file
#    
sudo sed -i "\$aalias dir='ls -CF'" ./root/.bashrc


#
#   Copy kernel images and device tree .dtb to local rootfs
#
sudo cp $LINUX_DIR/vmlinux                                 ./boot
sudo cp $LINUX_DIR/arch/arm/boot/uImage                    ./boot
sudo cp $LINUX_DIR/arch/arm/boot/zImage                    ./boot
sudo cp $LINUX_DIR/arch/arm/boot/dts/imx6q-nitrogen6x.dtb  ./boot


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
sudo rsync -avD /tmp/tmpXX/lib/modules/* ./lib/modules/


#
#   Now finish up by copying the rootfs to disk
#
sudo rsync -avD * $SDCARD


#
#   Waits until all the disk data is written
#
sync;sync;

