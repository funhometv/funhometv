# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="pygobject"
PKG_VERSION="3.40.0"
PKG_SHA256="98d83f71e6313dadc29793450fec23b2eaa5c3f1c4b073d0a4f9c31b5cdb5fca"
PKG_LICENSE="LGPL"
PKG_SITE="https://pygobject.readthedocs.io/"
PKG_URL="https://files.pythonhosted.org/packages/a0/fa/0cfaa64ad7a4cd94fd74b698fcc8987ed780fce1651fecc6604f86f604cd/PyGObject-3.40.0.tar.gz"
#PKG_DEPENDS_HOST="gobject-introspection:host"
PKG_DEPENDS_TARGET="toolchain Python3 glib libffi gobject-introspection"
PKG_LONGDESC="A convenient wrapper for the GObject+ library for use in Python programs."
#PKG_TOOLCHAIN="autotools"
#PKG_TOOLCHAIN="configure"

#PKG_CONFIGURE_OPTS_TARGET="--enable-thread --disable-introspection"
PKG_MESON_OPTS_TARGET=" -Dpycairo=disabled \
			-Dtests=false"


pre_configure_target() {
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python3-config --includes)"
  echo " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! we haoyq check: PYTHON_INCLUDES=$PYTHON_INCLUDES"
  export PYTHON=python3
  #export  LIB_DIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib:${TOOLCHAIN}/lib"
  #export PKG_CONFIG_LIBDIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/pkgconfig"
  #export PKG_CONFIG_PATH="${TOOLCHAIN}/lib/pkgconfig:${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/share/pkgconfig"

  #export CFLAGS=" ${CFLAGS} -I${TOOLCHAIN}/include $PYTHON_INCLUDES -L${TOOLCHAIN}/lib -L${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib "
  export CFLAGS=" ${CFLAGS} -I${TOOLCHAIN}/include $PYTHON_INCLUDES  -L${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib "
  export CPPFLAGS="${CFLAGS}"
  export CXXFLAGS="${CFLAGS}"
  echo "we check ----: LIB_DIR=${LIB_DIR}; PKG_CONFIG_LIBDIR=${PKG_CONFIG_LIBDIR}; PKG_CONFIG_PATH=${PKG_CONFIG_PATH} ; CFLAGS=${CFLAGS}"
}

#post_makeinstall_target() {
#  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
#  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"
#
#  rm -rf $INSTALL/usr/bin
#  rm -rf $INSTALL/usr/share/pygobject
#}
