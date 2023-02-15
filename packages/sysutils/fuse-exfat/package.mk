# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fuse-exfat"
PKG_VERSION="1.3.0"
PKG_SHA256="689bcb4a639acd2d45e6fa0ff455f7f18edb2421d4f4f42909943775adc0e375"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/relan/exfat"
PKG_URL="https://github.com/relan/exfat/archive/refs/tags/v1.3.0.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse"
PKG_LONGDESC="This project aims to provide a full-featured exFAT file system implementation for GNU/Linux other Unix-like systems as a FUSE module."
PKG_TOOLCHAIN="autotools"

#pre_configure_target(){

    #export FUSE_CFLAGS=" -I${SYSROOT_PREFIX}/usr/include/fuse3"
    #export FUSE_LIBS=" -L${SYSROOT_PREFIX}/usr/lib -lfuse3 -lpthread"
#}
