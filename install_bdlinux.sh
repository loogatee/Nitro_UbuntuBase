#!/bin/bash
set -x

LINUX_DIR=/home/johnr/linux-imx6
SDCARD=/media/johnr/a70226db-d7db-4c1c-82d6-bbef8c41f203
UBUNTU_NAME="ubuntu-base-14.04.5-base-armhf.tar.gz"



#
#   The Custom files need to have the correct owner/group
#     - All files owned by root
#     - All files are root group except for /etc/shadow
#
sudo find Custom_Files -exec chown root {} \; -exec chgrp root {} \;
sudo chgrp shadow Custom_Files/etc/shadow


sudo rm -rf rootfs
mkdir rootfs


#
#   use wget to grab the ubuntu core release
#
#wget http://cdimage.ubuntu.com/ubuntu-base/releases/14.04.5/release/$UBUNTU_NAME

cp ~/Downloads/$UBUNTU_NAME .


#
#   un-zip and un-tar the Ubuntu_Core files
#
cd rootfs; sudo tar --numeric-owner -xzvf ../$UBUNTU_NAME; cd ..


#
#   The .tar.gz file is no longer needed
#
rm -f ./$UBUNTU_NAME


#
#   Modifies the stock Ubuntu Core Release with these files
#
#sudo rsync -avD ../Nitro_UbuntuBase/rootfs/* .


#
#    An example of a simple addition to an existing file
#    
#sudo sed -i "\$aalias dir='ls -CF'" ./root/.bashrc

#
#   Removes passwd from root
#
#sudo sed -i "s/root:x:0/root::0/g" ./etc/passwd


#
#   Copy kernel images and device tree .dtb to local rootfs
#
#sudo cp $LINUX_DIR/vmlinux                                      ./boot
#sudo cp $LINUX_DIR/arch/arm/boot/uImage                         ./boot
#sudo cp $LINUX_DIR/arch/arm/boot/zImage                         ./boot
#sudo cp $LINUX_DIR/arch/arm/boot/dts/imx6q-sabrelite-nolcd.dtb  ./boot/imx6q-sabrelite.dtb


#
#   Prepare for module build by creating a destination directory
#
#sudo rm -rf /tmp/tmpXX
#mkdir  /tmp/tmpXX


#
#   Saves the current working directory, so we can return here again later
#
#pushd .


#
#   Make the modules
#
#cd $LINUX_DIR; export ARCH=arm; make INSTALL_MOD_PATH=/tmp/tmpXX modules_install


#
#   Get rid of the symbolic links
#
#find /tmp/tmpXX/lib/modules -type l -exec rm -f {} \;


#
#   Now return to the directory location that we saved earlier
#
#popd


#
#   Copy the modules to the local rootfs
#
#sudo rsync -avD /tmp/tmpXX/lib/modules/* ./lib/modules/


#
#   Now finish up by copying the rootfs to disk
#
#sudo rsync -avD * $SDCARD


#
#   Waits until all the disk data is written
#
sync;sync;

