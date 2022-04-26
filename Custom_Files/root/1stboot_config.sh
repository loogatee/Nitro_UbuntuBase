#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime

locale-gen en_US.UTF-8
dpkg-reconfigure locales
#apt-get update
#apt-get -y install openssh-server


cd debs; ./install.sh; cd ..;



#
/bin/sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
/usr/bin/service ssh restart

#apt-get -y install busybox-static
#ln -s /bin/busybox /sbin/udhcpd
#apt-get -y install iptables
#
#sed -n '
#1,/^ENDOFFILE/ {
#   /^exit 0/i modprobe g_multi file=/dev/mmcblk0p2 cdrom=0 stall=0 removable=1 nofua=1 iManufacturer=LOOG  iSerialNumber=5050 iProduct=loog2 host_addr=00:1D:7B:11:22:33\n
#   /^exit 0/i sleep 1\n
#   /^exit 0/i ifconfig usb0 192.168.7.2 netmask 255.255.255.252 up\n
#   /^exit 0/i /sbin/udhcpd -S /etc/udhcpd.conf\n
#   /^exit 0/i iptables -F
#   /^exit 0/i iptables -t nat -F
#   /^exit 0/i iptables -t mangle -F
#   /^exit 0/i iptables -X
#   /^exit 0/i iptables -t nat -X
#   /^exit 0/i iptables -t mangle -X
#   /^exit 0/i iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#   /^exit 0/i iptables -A FORWARD -i usb0 -j ACCEPT
#   /^exit 0/i echo 1 > /proc/sys/net/ipv4/ip_forward\n
#   p
#}' </etc/rc.local >/tmp/t.local

sync

#mv /tmp/t.local /etc/rc.local
#chmod 755 /etc/rc.local

addgroup --gid 222 johnr
adduser --home /home/johnr --shell /bin/bash --uid 222 --gid 222 johnr
usermod -aG sudo johnr


