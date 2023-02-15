# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present funhome.tv (https://funhome.tv)

PKG_NAME="xf86-video-nouveau"
PKG_VERSION="1.0.17"
PKG_SHA256="21e9233b2c6304b976c526729ba48660c16976a757a319fa95cc8a8605316105"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL2"
PKG_SITE="https://www.x.org/"
PKG_URL="https://www.x.org/releases/individual/driver/xf86-video-nouveau-1.0.17.tar.gz"
PKG_DEPENDS_TARGET="toolchain mesa libX11 xorg-server"
PKG_SHORTDESC="opensource nvidia video driver for the Xorg X server"
PKG_LONGDESC=" Open source Xorg X server driver for NVIDIA video cards.  The driver supports 2D acceleration and provides support for the following framebuffer depths: (15,) 16  and 24.  TrueColor visuals are supported for these depths.  Homepage https://gitlab.freedesktop.org/xorg/driver/xf86-video-nouveau"
# PKG_TOOLCHAIN="auto"

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
