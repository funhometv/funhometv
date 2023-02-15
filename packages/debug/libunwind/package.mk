# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libunwind"
PKG_VERSION="1.6.2"
PKG_SHA256="4a6aec666991fb45d0889c44aede8ad6eb108071c3554fcdff671f9c94794976"
PKG_LICENSE="GPL"
PKG_SITE="http://www.nongnu.org/libunwind/"
PKG_URL="http://download.savannah.nongnu.org/releases/libunwind/libunwind-1.6.2.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="library to determine the call-chain of a program"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
			   --enable-shared"

makeinstall_target() {
  make DESTDIR=$SYSROOT_PREFIX install
}
