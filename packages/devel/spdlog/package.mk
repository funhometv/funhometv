# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spdlog"
PKG_VERSION="1.11.0"
PKG_SHA256="ca5cae8d6cac15dae0ec63b21d6ad3530070650f68076f3a4a862ca293a858bb"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://sourceforge.net/projects/spdlog.mirror/"
PKG_URL="https://github.com/gabime/spdlog/archive/refs/tags/v1.11.0.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Fast C++ logging library."
PKG_LONGDESC="spdlog is a header only library. Just copy the files under include to your build tree and use a C++11 compiler. It provides a python like formatting API using the bundled fmt lib. spdlog takes the 'include what you need' approach, your code should include the features that actually needed."
# PKG_TOOLCHAIN="auto"

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
