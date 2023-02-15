# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019 funhome.tv

PKG_NAME="kodi-theme-Estuary"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="http://funhome.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain kodi"
PKG_NEED_UNPACK="$(get_pkg_directory $MEDIACENTER)"
PKG_LONGDESC="Kodi Mediacenter default theme."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/kodi/addons/
    cp -a $(get_build_dir kodi)/.$TARGET_NAME/addons/skin.estuary $INSTALL/usr/share/kodi/addons/
    #cp -a $PKG_DIR/media/funhometv.png $INSTALL/usr/share/kodi/addons/skin.estuary/
    #the icon of funhometv.png should be put by kodi's package.mk file , with which is replace the content of it.
    sed -i -e "s/LibreELEC/FunHomeTV/"  \
	    -e "s/service.libreelec.settings/service.funhometv.settings/" \
	    -e "s/libreelec.png/funhometv.png/" \
	    $INSTALL/usr/share/kodi/addons/skin.estuary/xml/Settings.xml
    
    #replace with CJK enabled version of otf fonts with name unchanged
    #we just switch from default font to arial ttf to make size small and less memory 
    #we have a test to overwrite the fonts. 20200410
    mkdir -p $INSTALL/usr/share/kodi/addons/skin.estuary/fonts
    cp -v $PKG_DIR/fonts/NotoSansCJKsc-Bold.otf $INSTALL/usr/share/kodi/addons/skin.estuary/fonts/NotoSans-Bold.ttf
    #cp -v $PKG_DIR/fonts/NotoSansCJKsc-Regular.otf $INSTALL/usr/share/kodi/addons/skin.estuary/fonts/NotoSans-Regular.ttf
    #we use SourceHanSans-Normal.ttc to replace Regular for a test , in order to not out of font box. 20200412 not work
    cp -v $PKG_DIR/fonts/SourceHanSansSC-Regular.otf $INSTALL/usr/share/kodi/addons/skin.estuary/fonts/NotoSans-Regular.ttf
    cp -v $PKG_DIR/fonts/NotoSansMonoCJKsc-Regular.otf $INSTALL/usr/share/kodi/addons/skin.estuary/fonts/NotoMono-Regular.ttf
    cp -v $PKG_DIR/fonts/NotoSansCJKsc-Thin.otf $INSTALL/usr/share/kodi/addons/skin.estuary/fonts/Roboto-Thin.ttf
    # target
    #/usr/share/kodi/addons/skin.estuary/fonts/NotoMono-Regular.ttf
    #/usr/share/kodi/addons/skin.estuary/fonts/NotoSans-Bold.ttf
    #/usr/share/kodi/addons/skin.estuary/fonts/NotoSans-Regular.ttf
    #/usr/share/kodi/addons/skin.estuary/fonts/Roboto-Thin.ttf
    #source NotoSansCJKsc-Bold.otf  NotoSansCJKsc-Regular.otf  NotoSansMonoCJKsc-Regular.otf
}
