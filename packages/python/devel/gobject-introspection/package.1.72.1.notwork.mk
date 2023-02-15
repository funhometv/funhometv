# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="gobject-introspection"
PKG_VERSION="1.72.1"
PKG_SHA256="012e313186e3186cf0fde6decb57d970adf90e6b1fac5612fe69cbb5ba99543a"
PKG_LICENSE="LGPL"
PKG_SITE="https://gitlab.gnome.org/GNOME/gobject-introspection"
PKG_URL="https://download.gnome.org/sources/gobject-introspection/1.72/gobject-introspection-1.72.1.tar.xz"
PKG_DEPENDS_TARGET="toolchain Python3 glib libffi"
PKG_LONGDESC="GObject introspection tools and libraries.A convenient wrapper for the GObject+ library for use in Python programs."
#PKG_TOOLCHAIN="autotools"
#PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="-gold"

#PKG_CONFIGURE_OPTS_TARGET="--enable-thread --disable-introspection"
##-Dgi_cross_pkgconfig_sysroot_path=$TOOLCHAIN/$TARGET_NAME/sysroot \

PKG_MESON_OPTS_TARGET=" -Dpython=python3 -Dcairo=disabled \
			-Dgi_cross_use_prebuilt_gi=true "


pre_configure_target() {
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python3-config --includes)"
  echo " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! we haoyq check: PYTHON_INCLUDES=$PYTHON_INCLUDES"
  export PYTHON=python3
  export  LIB_DIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib:${TOOLCHAIN}/lib"
  #export PKG_CONFIG_LIBDIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/pkgconfig"
  #export PKG_CONFIG_PATH="${TOOLCHAIN}/lib/pkgconfig:${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/share/pkgconfig"
  export CFLAGS=" ${CFLAGS} -I${TOOLCHAIN}/include $PYTHON_INCLUDES -L${TOOLCHAIN}/lib -L${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib "
  export CPPFLAGS="${CFLAGS}"
  export CXXFLAGS="${CFLAGS}"
  export GI_SCANNER_DEBUG=save-temps
  export LDFLAGS="$LDFLAGS -lpcre2-8 -lc -L${TOOLCHAIN}/lib -L${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib -lz -lm -lffi -lresolv ${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/libresolv.so.2 ${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/libgio-2.0.so -lz -lresolv ${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/libgmodule-2.0.so -ldl ${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/libgobject-2.0.so ${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/libglib-2.0.so ${TOOLCHAIN}/$TARGET_NAME/sysroot/usr/lib/libc.a ${TOOLCHAIN}/$TARGET_NAME/sysroot/usr/lib/libc.so.6 -lresolv"
#    ## in order to make meson found libva in version 2.5 not version 1.5 , we haoyq added @2023/1/3
  echo "we check --------------------------------------------------------------------: LIB_DIR=${LIB_DIR}; PKG_CONFIG_LIBDIR=${PKG_CONFIG_LIBDIR}; PKG_CONFIG_PATH=${PKG_CONFIG_PATH} ; CFLAGS=${CFLAGS} ; LDFLAGS=${LDFLAGS}"
}
#
#post_makeinstall_target() {
#  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
#  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"
#
#  rm -rf $INSTALL/usr/bin
#  rm -rf $INSTALL/usr/share/pygobject
#}
#
#
