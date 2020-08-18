#!/bin/bash
set -x

#SDCARD=/media/johnr/a70226db-d7db-4c1c-82d6-bbef8c41f203
SDCARD=/mnt/media2


#
#   Now finish up by copying the rootfs to disk
#
sudo rsync -avD rootfs/* $SDCARD


#
#   Waits until all the disk data is written
#
sync;sync;

