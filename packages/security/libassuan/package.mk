# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libassuan"
PKG_VERSION="2.5.3"
PKG_SHA256="91bcb0403866b4e7c4bc1cc52ed4c364a9b5414b3994f718c70303f7f765e702"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.gnupg.org/"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/libassuan/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libgpg-error"
PKG_LONGDESC="A General purpose cryptographic library."
PKG_TOOLCHAIN="autotools"
# libgcrypt-1.7.x fails to build with LTO support
# see for example https://bugs.gentoo.org/show_bug.cgi?id=581114
#
#
			    #CC_FOR_BUILD=$HOST_CC \
  #                           ac_cv_sys_symbol_underscore=no \
  #                           --enable-asm \
  #                           --with-gnu-ld \
#

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET=" \
                             --with-libgpg-error-prefix=$SYSROOT_PREFIX/usr \
			     --enable-static --disable-shared \
                             --disable-doc"
}

#post_makeinstall_target() {
  #sed -e "s:\(['= ]\)\"/usr:\\1\"$SYSROOT_PREFIX/usr:g" -i src/$PKG_NAME-config
  #cp src/$PKG_NAME-config $SYSROOT_PREFIX/usr/bin

  #rm -rf $INSTALL/usr/bin
##}
