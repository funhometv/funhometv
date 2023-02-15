# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="amule"
PKG_VERSION="2.3.2"
PKG_SHA256="f64720fdc8c6cfa06bdcd4ca3922d30a0ddddba9c897f5bec7605009c7683928"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://amule.org"
PKG_URL="https://sourceforge.net/projects/amule/files/aMule/2.3.2/aMule-2.3.2.tar.xz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain cryptopp wxWidgets"
PKG_SECTION="network"
PKG_SHORTDESC="aMule stands for all-platform Mule. "
PKG_LONGDESC="aMule is an eMule-like client for the eD2k and Kademlia networks, supporting multiple platforms."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET=" --enable-amule-daemon --enable-amulecmd --enable-webserver --enable-amule-gui --with-wxdir=$(get_build_dir wxWidgets) --with-wx-config=$(get_build_dir wxWidgets)/.install_pkg/usr/lib/wx/config"
#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
