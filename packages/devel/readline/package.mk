# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023	Eric Hao (e.hao@aol.com)

PKG_NAME="readline"
PKG_VERSION="8.2"
PKG_SHA256="3feb7171f16a84ee82ca18a36d7b9be109a52c04f492a053331d7d1095007c35"
PKG_LICENSE="GPL3"
PKG_SITE="http://www.gnu.org/software/readline/"
PKG_URL="http://ftpmirror.gnu.org/readline/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="bash_cv_wcwidth_broken=no \
                           --disable-shared \
                           --enable-static \
                           --with-curses"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share/readline
}
