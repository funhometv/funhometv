# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="cpio"
PKG_VERSION="2.13"
PKG_SHA256="eab5bdc5ae1df285c59f2a4f140a98fc33678a0bf61bdba67d9436ae26b46f6d"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/cpio/"
PKG_URL="http://ftpmirror.gnu.org/cpio/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="toolchain"
PKG_LONGDESC="A program to manage archives of files."

pre_configure_target() {
# hack to prevent a build error                                                                                                         
  CFLAGS="${CFLAGS} -fcommon "
  LDFLAGS="${LDFLAGS} -fcommon "
}                                                                                                                                       

pre_configure_host() {
  CFLAGS="${CFLAGS} -fcommon"
}
