#!/bin/bash
set -x

dpkg -i libidn11_1.28-1ubuntu2.2_armhf.deb;                                   echo ""
dpkg -i libsasl2-modules-db_2.1.25.dfsg1-17build1_armhf.deb;                  echo ""
dpkg -i libsasl2-2_2.1.25.dfsg1-17build1_armhf.deb;                           echo ""
dpkg -i libroken18-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;         echo ""
dpkg -i libasn1-8-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;          echo ""
dpkg -i libhcrypto4-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;        echo ""
dpkg -i libwind0-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;           echo ""
dpkg -i libheimbase1-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;       echo ""
dpkg -i libhx509-5-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;         echo ""
dpkg -i libkrb5-26-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;         echo ""
dpkg -i libheimntlm0-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;       echo ""
dpkg -i libgssapi3-heimdal_1.6~git20131207+dfsg-1ubuntu1.2_armhf.deb;         echo ""
dpkg -i librtmp0_2.4+20121230.gitdf6c518-1ubuntu0.1_armhf.deb;                echo ""
dpkg -i libldap-2.4-2_2.4.31-1+nmu2ubuntu8.5_armhf.deb;                       echo ""
dpkg -i libcurl3-gnutls_7.35.0-1ubuntu2.20_armhf.deb;                         echo ""
dpkg -i libcurl3_7.35.0-1ubuntu2.20_armhf.deb;                                echo ""
dpkg -i liberror-perl_0.17-1.1_all.deb;                                       echo ""
dpkg -i git-man_1%3a1.9.1-1ubuntu0.10_all.deb;                                echo ""
dpkg -i git_1%3a1.9.1-1ubuntu0.10_armhf.deb;                                  echo ""


apt-get install -f
