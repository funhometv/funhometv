# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="elfutils"
PKG_VERSION="0.186"
PKG_SHA256="7f6fb9149b1673d38d9178a0d3e0fb8a1ec4f53a9f4c2ff89469609879641177"
PKG_LICENSE="GPL"
PKG_SITE="https://sourceware.org/elfutils/"
PKG_URL="https://sourceware.org/elfutils/ftp/0.186/elfutils-0.186.tar.bz2"
PKG_DEPENDS_HOST="make:host zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib elfutils:host"
PKG_LONGDESC="A collection of utilities to handle ELF objects."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="utrace_cv_cc_biarch=false \
                           --disable-nls \
                           --with-zlib \
                           --without-bzlib \
			   --disable-libdebuginfod \
			   --disable-debuginfod \
                           --without-lzma"

PKG_CONFIGURE_OPTS_HOST="utrace_cv_cc_biarch=false \
                           --disable-nls \
                           --with-zlib \
                           --without-bzlib \
			   --disable-libdebuginfod \
			   --disable-debuginfod \
                           --without-lzma"
