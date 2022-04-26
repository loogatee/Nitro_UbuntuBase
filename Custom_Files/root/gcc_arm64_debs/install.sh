#!/bin/bash
set -x

dpkg -i gcc-4.8-base_4.8.2-19ubuntu1_arm64.deb;        echo ""
dpkg -i libatomic1_4.8.2-19ubuntu1_arm64.deb;          echo ""
dpkg -i libgomp1_4.8.2-19ubuntu1_arm64.deb;            echo ""
dpkg -i libgmp10_5.1.3+dfsg-1ubuntu1_arm64.deb;        echo ""
dpkg -i libisl10_0.12.2-1_arm64.deb;                   echo ""
dpkg -i libmpfr4_3.1.2-1_arm64.deb;                    echo ""
dpkg -i libmpc3_1.0.1-1ubuntu1_arm64.deb;              echo ""
dpkg -i liblzo2-2_2.06-1.2ubuntu1_arm64.deb;           echo ""
dpkg -i libcloog-isl4_0.18.2-1_arm64.deb;              echo ""
dpkg -i libc6_2.19-0ubuntu6_arm64.deb;                 echo ""
dpkg -i libc-dev-bin_2.19-0ubuntu6_arm64.deb;          echo ""
dpkg -i linux-libc-dev_3.13.0-24.46_arm64.deb;         echo ""
dpkg -i libc6-dev_2.19-0ubuntu6_arm64.deb;             echo ""
dpkg -i libgcc-4.8-dev_4.8.2-19ubuntu1_arm64.deb;      echo ""
dpkg -i libstdc++-4.8-dev_4.8.2-19ubuntu1_arm64.deb;   echo ""

dpkg -i cpp-4.8_4.8.2-19ubuntu1_arm64.deb;             echo ""
dpkg -i binutils_2.24-5ubuntu3_arm64.deb;              echo ""
dpkg -i gcc-4.8_4.8.2-19ubuntu1_arm64.deb;             echo ""

dpkg -i bc_1.06.95-8ubuntu1_arm64.deb;                 echo ""
dpkg -i lzop_1.03-3_arm64.deb;                         echo ""
dpkg -i make_3.81-8.2ubuntu3_arm64.deb;                echo ""
dpkg -i rsync_3.1.0-2_arm64.deb;                       echo ""
dpkg -i u-boot-tools_2013.10-3_arm64.deb;              echo ""
dpkg -i cpp_4.8.2-1ubuntu6_arm64.deb;                  echo ""
dpkg -i gcc_4.8.2-1ubuntu6_arm64.deb;                  echo ""

#apt-get install -f
dpkg --configure --pending



#dpkg -i gcc-4.9-base_4.9.3-0ubuntu4_arm64.deb;      echo ""
#dpkg -i binutils-static_2.24-5ubuntu3_arm64.deb;    echo ""
