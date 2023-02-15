# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2020 FunHome.TV (e.hao@aol.com)

PKG_NAME="pyxbmct"
PKG_VERSION="1.0"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL=""
#https://ftp.mirrorservice.org/sites/mirrors.kodi.tv/addons/matrix/script.module.pyxbmct/script.module.pyxbmct-1.3.1+matrix.1.zip
#https://github.com/romanvm/script.module.pyxbmct/releases/download/v.1.3.0a/script.module.pyxbmct-1.3.0.zip
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="skin"
PKG_SHORTDESC="Kodi language package for don't download but native with kodi"
PKG_LONGDESC="Kodi native language in chinese"
PKG_TOOLCHAIN="manual"

#PKG_IS_ADDON="yes"
#PKG_ADDON_NAME="script.module.pyxbmct"
#PKG_ADDON_TYPE="xbmc.python.module"

#addon() {
makeinstall_target(){
  #ADDON_INSTALL_DIR=$INSTALL/usr/share/kodi/addons/$PKG_NAME
  ADDON_INSTALL_DIR=$INSTALL/usr/share/kodi/addons
  #mkdir -p $ADDON_BUILD/
  mkdir -p $ADDON_INSTALL_DIR
    #cp -a $PKG_DIR/conffiles/* $ADDON_BUILD/$PKG_ADDON_ID
    #
    # old wrong way unzip $PKG_DIR/conffiles/script.module.pyxbmct-1.3.1+matrix.1.zip -d $ADDON_BUILD
    #
    #  we install pyxmbct needed 2 six package in one package. and all these 3 package should be put in kodi manifest . in kodi/package.mk
    unzip $PKG_DIR/conffiles/script.module.pyxbmct-1.3.1.zip -d $ADDON_INSTALL_DIR
    unzip $PKG_DIR/conffiles/script.module.six-1.13.0.zip -d $ADDON_INSTALL_DIR
    unzip $PKG_DIR/conffiles/script.module.kodi-six-0.1.3.zip -d $ADDON_INSTALL_DIR


}

