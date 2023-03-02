# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-2019 Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2019-present FunHome.TV

PKG_NAME="funhome-settings"
PKG_VERSION="2023.2.28"
PKG_SHA256="05948716bcf18aa39ba63d3d9fe8dc5db59199aae0bc123d9406b31b855be500"
PKG_LICENSE="BSL"
PKG_SITE="https://funhome.tv"
PKG_URL="https://github.com/erickhao/funhome-settings/archive/refs/tags/v2023.2.28.tar.gz"
#PKG_DEPENDS_TARGET="toolchain Python3 connman pygobject dbus-python faker transmissionrpc zerotier nextcloud apache2 mariadb php gnupg transmission resource.language.zh_cn qrcode pyxbmct"
PKG_DEPENDS_TARGET="toolchain Python3 connman dbussy faker transmissionrpc zerotier nextcloud apache2 mariadb php gnupg transmission resource.language.zh_cn qrcode pyxbmct dnspython"
#PKG_DEPENDS_TARGET="toolchain Python3 connman pygobject pydbus faker transmissionrpc zerotier nextcloud apache2 mariadb php gnupg transmission resource.language.zh_cn qrcode pyxbmct"
PKG_LONGDESC="funhome-settings: is a settings dialog for funhome"

PKG_PYTHON_VERSION=python3.8

PKG_MAKE_OPTS_TARGET="DISTRONAME=$DISTRONAME ROOT_PASSWORD=$ROOT_PASSWORD"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET setxkbmap"
else
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bkeymaps"
fi

post_makeinstall_target() {
  mkdir -p $INSTALL/etc
    cp $PKG_DIR/license/funhome.lic $INSTALL/etc
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/mount_shared_folder.sh $INSTALL/usr/bin
  #modify libreelec to funhometv
  #mkdir -p $INSTALL/usr/lib/libreelec
  mkdir -p $INSTALL/usr/lib/funhometv
    #cp $PKG_DIR/scripts/* $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/* $INSTALL/usr/lib/funhometv

  #ADDON_INSTALL_DIR=$INSTALL/usr/share/kodi/addons/service.libreelec.settings
  ADDON_INSTALL_DIR=$INSTALL/usr/share/kodi/addons/service.funhometv.settings

  $TOOLCHAIN/bin/python3 -Wi -t -B $TOOLCHAIN/lib/$PKG_PYTHON_VERSION/compileall.py $ADDON_INSTALL_DIR/resources/lib/ -f
  #rm -rf $(find $ADDON_INSTALL_DIR/resources/lib/ -name "*.py")

  $TOOLCHAIN/bin/python3 -Wi -t -B $TOOLCHAIN/lib/$PKG_PYTHON_VERSION/compileall.py $ADDON_INSTALL_DIR/oe.py -f
  #rm -rf $ADDON_INSTALL_DIR/oe.py
}

post_install() {
  enable_service backup-restore.service
  enable_service factory-reset.service
}

#pre_configure_target() {
#add chinese
#sed -i.hfx 's|"Turkish":"resource.language.tr_tr","Ukrainian":"resource.language.uk_ua"}|"Turkish":"resource.language.tr_tr","Ukrainian":"resource.language.uk_ua","Chinese":"resource.language.zh_cn"}|' src/resources/lib/oeWindows.py

#}
