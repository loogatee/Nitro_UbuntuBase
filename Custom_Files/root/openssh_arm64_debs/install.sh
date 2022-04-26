#!/bin/bash
set -x

dpkg -i libck-connector0_0.4.5-3.1ubuntu2_arm64.deb
echo ""
dpkg -i libkrb5support0_1.12+dfsg-2ubuntu4_arm64.deb
echo ""
dpkg -i libk5crypto3_1.12+dfsg-2ubuntu4_arm64.deb
echo ""
dpkg -i libkeyutils1_1.5.6-1_arm64.deb
echo ""
dpkg -i libkrb5-3_1.12+dfsg-2ubuntu4_arm64.deb
echo ""
dpkg -i libgssapi-krb5-2_1.12+dfsg-2ubuntu4_arm64.deb
echo ""
dpkg -i libwrap0_7.6.q-25_arm64.deb
echo ""
dpkg -i libedit2_3.1-20130712-2_arm64.deb
echo ""
dpkg -i openssh-client_6.6p1-2ubuntu1_arm64.deb
echo ""
dpkg -i openssh-sftp-server_6.6p1-2ubuntu1_arm64.deb
echo ""
dpkg -i openssh-server_6.6p1-2ubuntu1_arm64.deb
echo ""

apt-get install -f
