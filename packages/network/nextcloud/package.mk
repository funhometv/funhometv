# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# copyright (c) nextcloud (https://nextcloud.com)
# copyright (C) funhome.tv (https://funhome.tv)
#

PKG_NAME="nextcloud"
PKG_VERSION="16.0.5"
PKG_SHA256="8709c64fa776fd731c8e5f1ab25d592a2e690e5e18a81601cccf363795fae551"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://nextcloud.com"
PKG_URL="https://download.nextcloud.com/server/releases/nextcloud-16.0.5.tar.bz2"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain zlib openssl apache2 mariadb php p7zip"
PKG_SECTION="network"
PKG_SHORTDESC="Protecting your data -- The self-hosted productivity platform that keeps you in control"
PKG_LONGDESC="Nextcloud Files offers an on-premise Universal File Access and sync platform with powerful collaboration capabilities and desktop, mobile and web interfaces."
PKG_TOOLCHAIN="configure"
#can change to "manual" to not use the dummy Makefile and configure
#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

pre_configure_target() {
  cat<<EOF >Makefile
all: release
install:
	echo "OK"
release:
	echo "OK"
EOF

cat<<EOF_CF >configure
#!/bin/sh
echo "OK"
EOF_CF
chmod 755 configure

}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration

makeinstall_target() {
#copy from libreELEC.tv/scripts/install

echo "PKG_DIR=$PKG_DIR;INSTALL=$INSTALL;"
mkdir -p $INSTALL/etc
ls -l $PKG_DIR/conffiles
#we copy httpd.conf to overwrite the php installed php_mod . and make servername include from /storage/.kodi/apache/myservername.conf
cp -Pv $PKG_DIR/conffiles/httpd.conf $INSTALL/etc/httpd.conf
cp -Pv $PKG_DIR/conffiles/nextcloud.conf $INSTALL/etc/nextcloud.conf
#cp -Pv $PKG_DIR/conffiles/php-fpm.conf $INSTALL/etc/php-fpm.conf


#haoyq we just copy the compressed archive , because nextcloud is in {usb|HDD} disk , for nextcloud need to write to files. And in apachecertcp.sh aka. setup apache certificate and after soft reset and after hard reset , we just setup it as fresh install of FunHomeTV.

mkdir -p $INSTALL/usr/www/nextcloud
#upgrade to 16.0.8 at 2020.03.04
#cp -Pv $PKG_DIR/conffiles/nextcloud-18.0.3.tar.bz2  $INSTALL/usr/www/nextcloud
#upgrade to 21.0.2 at 2021.06.15
#cp -Pv $PKG_DIR/conffiles/nextcloud-21.0.2.tar.bz2  $INSTALL/usr/www/nextcloud
#upgrade to 25.0.1 at 2022.12.04
cp -Pv $PKG_DIR/conffiles/nextcloud-25.0.1.tar.bz2 $INSTALL/usr/www/nextcloud
#haoyq we added autoconfig.php for mariadb database and adjust the default directory for nextclouddata, in order to make user input less.
# document page : https://docs.nextcloud.com/server/16/admin_manual/configuation_server/automatic_configuration.html
# we not use autoconfig , but a config for user to known the username and set the password
# we should not use autoconfig, but modify it should take some time , and version depend?
cp -Pv $PKG_DIR/conffiles/autoconfig.php $INSTALL/usr/www/nextcloud

#according to https://docs.nextcloud.com/server/16/admin_manual/installation/source_installation.html#example-installation-on-ubuntu-18-04-lts-server
#we just copy the file in to web server root
#echo "$SYSROOT_PREFIX with contents that list as follows"
#ls -l $SYSROOT_PREFIX
#mkdir -p $SYSROOT_PREFIX/usr/www/nextcloud
#cp -R * $SYSROOT_PREFIX/usr/www/nextcloud
#echo "1st copy end"

# copy httpd.conf with 
# 1enable SSL 
# 2and php (fix make time generated path problem)
# 3and nextcloud.conf include 
# 4snakeoil-file directory set to /storage/.kodi/apache2/etc/...... 
#   and ready for certificate generate from funhome.tv lets encrypt 
# to the configure file 
echo "start copy httpd.conf and nextcloud.conf"
mkdir -p $INSTALL/etc
#cp -Pv $PKG_DIR/conffiles/httpd.conf $INSTALL/etc
cp -Pv $PKG_DIR/conffiles/nextcloud.conf $INSTALL/etc
mkdir -p $SYSROOT_PREFIX/etc
#cp -Pv $INSTALL/etc/httpd.conf $SYSROOT_PREFIX/etc/httpd.conf
cp -Pv $INSTALL/etc/nextcloud.conf $SYSROOT_PREFIX/etc/nextcloud.conf

#echo "start copy $INSTALL/var/www to $SYSROOT_PREFIX/var"
#cp -RPv $INSTALL/var/www $SYSROOT_PREFIX/var
#echo "2nd copy end"
#
#we should startup mariadb apache2  as service
# and setup the first mariadb data import
# import the sql with mariadb first run
#
}
post_install() {
:
#make directory for    SSLCertificateFile      /storage/.kodi/apache/etc/ssl/certs/ssl-cert-snakeoil.pem
#    SSLCertificateKeyFile /storage/.kodi/apache/etc/ssl/private/ssl-cert-snakeoil.key
#mkdir -p $INSTALL/storage/.kodi/apache/etc/ssl/certs
#mkdir -p $INSTALL/storage/.kodi/apache/etc/ssl/private

#touch $INSTALL/storage/.kodi/apache/etc/ssl/certs/ssl-cert-snakeoil.pem
#touch $INSTALL/storage/.kodi/apache/etc/ssl/private/ssl-cert-snakeoil.key

#the following is not used
#echo "makedir $SYSROOT_PREFIX/var/www/nextcloud"
#mkdir -p $SYSROOT_PREFIX/var/www/nextcloud
#echo "copy  to $SYSROOT_PREFIX/var/www/nextcloud"
#cp -RPv $  $SYSROOT_PREFIX/var/www/nextcloud
#echo "post_install copy end"
   #enable_service mariadb.service
   #enable_service apache2.service
}
