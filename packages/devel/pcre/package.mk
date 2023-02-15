# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pcre"
PKG_VERSION="8.45"
PKG_SHA256="4dae6fdcd2bb0bb6c37b5f97c33c2be954da743985369cddac3546e3218bffb8"
PKG_LICENSE="OSS"
PKG_SITE="http://www.pcre.org/"
PKG_URL="https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.bz2"
PKG_DEPENDS_HOST="gcc:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A set of functions that implement regular expression pattern matching."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_HOST="--prefix=$TOOLCHAIN \
             --enable-static \
             --enable-utf8 \
             --enable-unicode-properties \
             --with-gnu-ld"
#haoyq removed disable-shared,because we need it in apache2 web server
PKG_CONFIGURE_OPTS_TARGET=" --enable-shared \
             --enable-static \
             --enable-utf8 \
             --enable-pcre16 \
             --enable-unicode-properties \
             --with-gnu-ld"

#post_makeinstall_target() {

#haoyq we should have pcre in usr/bin
#  rm -rf $INSTALL/usr/bin
#haoyq remove not target's libpcre.so for a try

#glib use pcre , so we haoyw should not remove the libpcre.so*
#rm -fr $TOOLCHAIN/lib/libpcre.so*
#echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!remove libpcre.so.* in $TOOLCHAIN/lib/libpcre.so"
  

#  sed -e "s:\(['= ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/bin/$PKG_NAME-config
#}
