# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="check"
PKG_VERSION="0.15.2"
PKG_SHA256="998d355294bb94072f40584272cf4424571c396c631620ce463f6ea97aa67d2e"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/libcheck/check"
PKG_URL="https://github.com/libcheck/check/archive/refs/tags/0.15.2.tar.gz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="A unit testing framework for C"
PKG_LONGDESC="Check is a unit testing framework for C. It features a simple interface for defining unit tests, putting little in the way of the developer. Tests are run in a separate address space, so Check can catch both assertion failures and code errors that cause segmentation faults or other signals. "
PKG_TOOLCHAIN="autotools"

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
