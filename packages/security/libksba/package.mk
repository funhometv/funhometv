# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libksba"
PKG_VERSION="1.3.5"
PKG_SHA256="41444fd7a6ff73a79ad9728f985e71c9ba8cd3e5e53358e70d5f066d35c1a340"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.gnupg.org/"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/libksba/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libgpg-error"
PKG_LONGDESC="A General purpose cryptographic library."
PKG_TOOLCHAIN="autotools"
# libgcrypt-1.7.x fails to build with LTO support
# see for example https://bugs.gentoo.org/show_bug.cgi?id=581114

#
                             #ac_cv_sys_symbol_underscore=no \
#                             --enable-asm \
#                             --with-gnu-ld \
#

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET=" \
                             --with-libgpg-error-prefix=$SYSROOT_PREFIX/usr \
			      --enable-shared=no \
                              --enable-static=yes \
                             --disable-doc"
}

#post_makeinstall_target() {
  #sed -e "s:\(['= ]\)\"/usr:\\1\"$SYSROOT_PREFIX/usr:g" -i src/$PKG_NAME-config
  #cp src/$PKG_NAME-config $SYSROOT_PREFIX/usr/bin

  #rm -rf $INSTALL/usr/bin
##}
