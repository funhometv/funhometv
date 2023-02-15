# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present funhome.tv (https://funhome.tv)

PKG_NAME="xf86-video-vboxvideo"
PKG_VERSION="1.0.0"
PKG_SHA256="7fb6a3bfbcbe95438617f55a2f7ace4c0edec8ea8b7007777f389438b40cbfa4"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL2"
PKG_SITE="https://www.x.org/"
PKG_URL="https://www.x.org/releases/individual/driver/xf86-video-vboxvideo-1.0.0.tar.bz2"
PKG_DEPENDS_TARGET="toolchain mesa libX11 xorg-server"
PKG_SHORTDESC="VirtualBox guest video driver for the Xorg X server"
PKG_LONGDESC="xf86-video-vboxvideo - VirtualBox video driver for the Xorg X server. Homepage https://gitlab.freedesktop.org/xorg/driver/xf86-video-vbox"
# PKG_TOOLCHAIN="auto"

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
