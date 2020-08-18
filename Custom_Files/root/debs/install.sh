#!/bin/bash
set -x

dpkg -i libck-connector0_0.4.5-3.1ubuntu2_armhf.deb
echo ""
dpkg -i libkrb5support0_1.12+dfsg-2ubuntu5.4_armhf.deb
echo ""
dpkg -i libk5crypto3_1.12+dfsg-2ubuntu5.4_armhf.deb
echo ""
dpkg -i libkeyutils1_1.5.6-1_armhf.deb
echo ""
dpkg -i libkrb5-3_1.12+dfsg-2ubuntu5.4_armhf.deb
echo ""
dpkg -i libgssapi-krb5-2_1.12+dfsg-2ubuntu5.4_armhf.deb
echo ""
dpkg -i libwrap0_7.6.q-25_armhf.deb
echo ""
dpkg -i libedit2_3.1-20130712-2_armhf.deb
echo ""
dpkg -i openssh-client_1%3a6.6p1-2ubuntu2.13_armhf.deb
echo ""
dpkg -i openssh-sftp-server_1%3a6.6p1-2ubuntu2.13_armhf.deb
echo ""
dpkg -i openssh-server_1%3a6.6p1-2ubuntu2.13_armhf.deb
echo ""

apt-get install -f
