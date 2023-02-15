# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2020 FunHome.TV (e.hao@aol.com)

PKG_NAME="resource.language.zh_cn"
PKG_VERSION="1.0"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="skin"
PKG_SHORTDESC="Kodi language package for don't download but native with kodi"
PKG_LONGDESC="Kodi native language in chinese"
PKG_TOOLCHAIN="manual"

#PKG_IS_ADDON="yes" #we changed to not a addon, but a package.
#PKG_ADDON_NAME="resources.language.zh_cn"
#PKG_ADDON_TYPE="xbmc.gui.skin"

#addon() {  # we changed to not a addon , but a package
makeinstall_target(){
  #ADDON_INSTALL_DIR=$INSTALL/usr/share/kodi/addons/$PKG_NAME
  ADDON_INSTALL_DIR=$INSTALL/usr/share/kodi/addons
  #mkdir -p $ADDON_BUILD/
  mkdir -p $ADDON_INSTALL_DIR
    #cp -a $PKG_DIR/conffiles/* $ADDON_BUILD/$PKG_ADDON_ID
    #unzip $PKG_DIR/conffiles/resources.language.zh_cn-9.0.16.zip -d $ADDON_BUILD
    unzip $PKG_DIR/conffiles/resource.language.zh_cn-9.0.16.zip -d $ADDON_INSTALL_DIR
}

