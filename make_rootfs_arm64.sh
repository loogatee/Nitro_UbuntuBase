#!/bin/bash
set -x

HOSTNAME="imx8zzz"

LINUX_DIR=/mnt/extra4/linux-imx6-boundary-imx_3.10.17_1.0.2_ga
UBUNTU_NAME="ubuntu-base-14.04.6-base-arm64.tar.gz"


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
#wget http://cdimage.ubuntu.com/ubuntu-base/releases/14.04.6/release/$UBUNTU_NAME

cp /mnt/extra4/Downloads/$UBUNTU_NAME .


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
sudo rsync -avD Custom_Files/* rootfs

#
#   serial-console needs to be executable
#
sudo chmod 755 rootfs/bin/serial-console


#
#    An example of a simple addition to an existing file
#    
sudo sed -i "\$aalias dir='ls -CF'" rootfs/root/.bashrc
sudo sed -i "\$aalias dir='ls -CF'" rootfs/etc/bash.bashrc

#
#   Removes passwd from root
#
sudo sed -i "s/root:x:0/root::0/g" rootfs/etc/passwd


#
#   Overwrites the default hostname
#
sudo /bin/bash -c "echo $HOSTNAME >   rootfs/etc/hostname"

#
#   /etc/hosts
#
sudo /bin/bash -c "echo 127.0.0.1 localhost $HOSTNAME >   rootfs/etc/hosts"

#
#   Creates /etc/resolv.conf
#
sudo rm -f                                          rootfs/etc/resolv.conf
sudo /bin/bash -c "echo nameserver 8.8.8.8 >        rootfs/etc/resolv.conf"
#sudo ln -s rootfs/run/resolvconf/resolv.conf        rootfs/etc/resolv.conf

#
#  None of the tty conf's are really needed
#
sudo rm -f rootfs/etc/init/tty?.conf

sudo rm -rf rootfs/root/debs
sudo rm -rf rootfs/root/debs_gcc
sudo rm -rf rootfs/root/debs_git


#
#   Copy kernel images and device tree .dtb to local rootfs
#
#sudo cp $LINUX_DIR/vmlinux                                      rootfs/boot
#sudo cp $LINUX_DIR/arch/arm/boot/uImage                         rootfs/boot
#sudo cp $LINUX_DIR/arch/arm/boot/zImage                         rootfs/boot
#sudo cp $LINUX_DIR/arch/arm/boot/dts/imx6q-sabrelite-nolcd.dtb  rootfs/boot/imx6q-sabrelite.dtb

##sudo cp $LINUX_DIR/arch/arm/boot/dts/imx6q-nitrogen6x.dtb       rootfs/boot/imx6q-sabrelite.dtb


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
#cd $LINUX_DIR; export ARCH=arm; sudo make INSTALL_MOD_PATH=/tmp/tmpXX modules_install


#
#   Get rid of the symbolic links
#
#sudo find /tmp/tmpXX/lib/modules -type l -exec rm -f {} \;


#
#   Now return to the directory location that we saved earlier
#
#popd


#
#   Copy the modules to the local rootfs
#
#sudo rsync -avD /tmp/tmpXX/lib/modules/* rootfs/lib/modules/


sudo rsync -avD /mnt/extra4/modules/* rootfs/lib/modules/
sudo rsync -avD /mnt/extra4/boot/*    rootfs/boot/

sudo rm rootfs/6* rootfs/u-boo*



#
#   Changes debs to openssh_arm64_edebs
#
sudo sed -i "s/debs/openssh_arm64_debs/" rootfs/root/1stboot_config.sh

#
#    Mod ifconfig cmd at the end
#    
sudo sed -i "\$aifconfig eth0 192.168.7.2 netmask 255.255.255.0 broadcast 192.168.7.255" rootfs/root/1stboot_config.sh
