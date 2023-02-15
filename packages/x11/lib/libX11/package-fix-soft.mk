# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libX11"
PKG_VERSION="1.6.5"
PKG_SHA256="4d3890db2ba225ba8c55ca63c6409c1ebb078a2806de59fb16342768ae63435d"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros xtrans libXau libxcb"
PKG_LONGDESC="LibX11 is the main X11 library containing all the client-side code to access the X11 windowing system."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-loadable-i18n \
                           --disable-loadable-xcursor \
                           --enable-xthreads \
                           --disable-xcms \
                           --enable-xlocale \
                           --disable-xlocaledir \
                           --enable-xkb \
                           --with-keysymdefdir=$SYSROOT_PREFIX/usr/include/X11 \
                           --disable-xf86bigfont \
                           --enable-malloc0returnsnull \
                           --disable-specs \
                           --without-xmlto \
                           --without-fop \
                           --enable-composecache \
                           --disable-lint-library \
                           --disable-ipv6 \
                           --without-launchd \
                           --without-lint"

# for stub-soft.h not found
# gnu/stubs-soft.h: No such file or directory


pre_configure_target() {

# for stub-soft.h not found
#CFLAGS+=" -D__ARM_PCS_VFP=1"
#export CFLAGS="$CFLAGS"
#  export CXXFLAGS="$CFLAGS"
#  export CPPFLAGS="$CFLAGS"
cp -Pv $SYSROOT_PREFIX/usr/include/gnu/stubs-hard.h $SYSROOT_PREFIX/usr/include/gnu/stubs-soft.h

}
