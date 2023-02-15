# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# copyright (c) 2023 Eric Hao (e.hao@aol.com)

PKG_NAME="glu"
PKG_VERSION="9.0.2"
PKG_SHA256="6e7280ff585c6a1d9dfcdf2fca489251634b3377bfc33c29e4002466a38d02d4"
PKG_LICENSE="OSS"
PKG_SITE="http://cgit.freedesktop.org/mesa/glu/"
PKG_URL="ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.2.tar.xz"
PKG_DEPENDS_TARGET="toolchain mesa"
PKG_LONGDESC="libglu is the The OpenGL utility library"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
            --disable-debug \
            --disable-osmesa \
            --with-gnu-ld"
