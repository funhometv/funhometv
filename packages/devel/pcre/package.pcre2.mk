# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pcre"
PKG_VERSION="10.42"
PKG_SHA256="8d36cd8cb6ea2a4c2bb358ff6411b0c788633a2a45dabbf1aeb4b701d1b5e840"
PKG_LICENSE="OSS"
PKG_SITE="http://www.pcre.org/"
PKG_URL="https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.bz2"
PKG_DEPENDS_HOST="gcc:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A set of functions that implement regular expression pattern matching."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_HOST="--prefix=$TOOLCHAIN \
             --enable-static \
             --enable-utf8\
             --enable-unicode-properties \
	     --enable-pcre2-8 \
	     --enable-pcre2-16 \
	     --enable-pcre2-32 \
             --with-gnu-ld"
#haoyq removed disable-shared,because we need it in apache2 web server
PKG_CONFIGURE_OPTS_TARGET=" --enable-shared \
             --enable-static \
             --enable-utf8\
	     --enable-pcre2-8 \
             --enable-pcre2-16 \
	     --enable-pcre2-32
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
