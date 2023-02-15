# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="TexturePacker"
PKG_VERSION="0"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_DEPENDS_HOST="lzo:host libpng:host libjpeg-turbo:host giflib:host"
PKG_DEPENDS_UNPACK="kodi"
PKG_NEED_UNPACK="$(get_pkg_directory $MEDIACENTER)"
PKG_LONGDESC="kodi-platform:"

PKG_CMAKE_SCRIPT="$(get_build_dir $MEDIACENTER)/tools/depends/native/TexturePacker/CMakeLists.txt"

PKG_CMAKE_OPTS_HOST="-Wno-dev -DCMAKE_MODULE_PATH=$(get_build_dir $MEDIACENTER)/cmake/modules -DCMAKE_SOURCE_DIR=$(get_build_dir $MEDIACENTER)"



pre_configure_host() {
  export CXXFLAGS="$CXXFLAGS -std=c++11 -DTARGET_POSIX -DTARGET_LINUX -D_LINUX -I$(get_build_dir $MEDIACENTER)/xbmc/platform/linux"
  CMAKE_PREFIX_PATH="${CMAKE_PREFIX_PATH} $(get_build_dir lzo)/.${TARGET_NAME}"
  export CMAKE_PREFIX_PATH
  Lzo2_DIR="$(get_build_dir lzo)/.${TARGET_NAME}"
  export Lzo_DIR
  echo "we haoyq check: Lzo2_DIR =$Lzo2_DIR"
  CMAKE_MODULE_PATH="$CMAKE_MODULE_PATH $(get_build_dir $MEDIACENTER)/cmake/modules"
  export CMAKE_MODULE_PATH
  echo "we haoyq check CMAKE_MODULE_PATH:$CMAKE_MODULE_PATH"
  echo "we add sylb-link for CMake Error at CMakeLists.txt:40 (add_executable): Cannot find source file: /fam/erichao/funhome.tv.4/build.FunHomeTV-Generic.x86_64-1.0.1/kodi-19.5-Matrix/tools/depends/native/TexturePacker/xbmc/guilib/XBTF.cpp"
  ln -s $(get_build_dir $MEDIACENTER)/xbmc $(get_build_dir $MEDIACENTER)/tools/depends/native/TexturePacker/xbmc
  ls -l $(get_build_dir $MEDIACENTER)/tools/depends/native/TexturePacker/xbmc
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp TexturePacker $TOOLCHAIN/bin
}
