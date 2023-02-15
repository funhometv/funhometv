# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-vmware"
PKG_VERSION="13.3.0"
PKG_SHA256="47971924659e51666a757269ad941a059ef5afe7a47b5101c174a6022ac4066c"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.vmware.com"
PKG_URL="http://xorg.freedesktop.org/releases/individual/driver/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain mesa libX11 xorg-server"
PKG_LONGDESC="xf86-video-vmware: The Xorg driver for vmware video"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-vmwarectrl-client \
                           --with-xorg-module-dir=$XORG_PATH_MODULES"

pre_configure_target(){

  #according to https://cgit.freebsd.org/ports/commit/?id=40e9ad50deb01802e7c8ae1aed068d3e2ab78d69
  #in order to fix error while compile : "usr/include/xorg/xf86Opt.h:44:10: error: two or more data types in declaration specifiers 44 |     Bool bool;"
  #but the patch maybe cannot apply for linux , because the different struct of source code.
  #we use sed to make the patch.
  echo "change saa/saa.h"
  ls -l ../saa/saa.h
  sed -i "s'#include <xf86.h>'#undef bool #include <xf86.h>'" ../saa/saa.h
  ls -l ../saa/saa.h

  echo "change vmwgfx/vmwgfx_driver.h"
  ls -l ../vmwgfx/vmwgfx_driver.h
  sed -i "s'#include <xf86.h>'#undef bool #include <xf86.h>'" ../vmwgfx/vmwgfx_driver.h
  ls -l ../vmwgfx/vmwgfx_driver.h

}
