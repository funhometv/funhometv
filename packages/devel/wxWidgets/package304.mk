# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2019 Funhome.tv

PKG_NAME="wxWidgets"
PKG_VERSION="3.0.4"
PKG_SHA256="96157f988d261b7368e5340afa1a0cad943768f35929c22841f62c25b17bf7f0"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.wxWidgets.org/"
PKG_URL="https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.4/wxWidgets-3.0.4.tar.bz2"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain "
PKG_SECTION="devel"
PKG_SHORTDESC="Cross-Platform GUI Library"
PKG_LONGDESC="wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET=" --disable-gui --enable-unicode --without-subdirs --without-expat "

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
