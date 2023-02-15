# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gmp"
PKG_VERSION="6.2.1"
PKG_SHA256="fd4829912cddd12f84181c3451cc752be224643e87fac497b69edddadc49b4f2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://gmplib.org"
PKG_URL="https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz"
PKG_DEPENDS_HOST="ccache:host m4:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating point numbers."
PKG_BUILD_FLAGS="+pic:host"

PKG_CONFIGURE_OPTS_HOST="--enable-cxx --enable-static --disable-shared"

pre_configure_host() {
  export CPPFLAGS="$CPPFLAGS -fexceptions"
}

