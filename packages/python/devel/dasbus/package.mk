# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="dasbus"
PKG_VERSION="1.7"
PKG_SHA256="a8850d841adfe8ee5f7bb9f82cf449ab9b4950dc0633897071718e0d0036b6f6"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/rhinstaller/dasbus"
PKG_URL="https://files.pythonhosted.org/packages/37/79/9c5984d723ffbe2e839ee649690f3e1fa6544ab6a17a5150e5ac14a47072/dasbus-1.7.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 glib libffi gobject-introspection pygobject"
PKG_LONGDESC="This DBus library is written in Python 3, based on GLib and inspired by pydbus."
PKG_TOOLCHAIN="manual"

#pre_make_target() {
#haoyq add a fix for python 2.7 or 3 there  is not replace for the list error. and we only use en_US the default.
#  sed -i "s/locale = locale.replace('-', '_') if locale else DEFAULT_LOCALE/locale = DEFAULT_LOCALE/" faker/factory.py
#  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
#}


make_target() {
  python3 setup.py build 
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}


#PKG_TOOLCHAIN="autotools"
#PKG_TOOLCHAIN="configure"

##PKG_CONFIGURE_OPTS_TARGET="--enable-thread --disable-introspection"
#PKG_MESON_OPTS_TARGET=" -Dpycairo=disabled \
#			-Dtests=false"
#
#
#pre_configure_target() {
#  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python3-config --includes)"
#  echo " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! we haoyq check: PYTHON_INCLUDES=$PYTHON_INCLUDES"
#  export PYTHON=python3
#  #export  LIB_DIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib:${TOOLCHAIN}/lib"
#  #export PKG_CONFIG_LIBDIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/pkgconfig"
#  #export PKG_CONFIG_PATH="${TOOLCHAIN}/lib/pkgconfig:${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/share/pkgconfig"
#
#  #export CFLAGS=" ${CFLAGS} -I${TOOLCHAIN}/include $PYTHON_INCLUDES -L${TOOLCHAIN}/lib -L${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib "
#  export CFLAGS=" ${CFLAGS} -I${TOOLCHAIN}/include $PYTHON_INCLUDES  -L${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib "
#  export CPPFLAGS="${CFLAGS}"
#  export CXXFLAGS="${CFLAGS}"
#  echo "we check ----: LIB_DIR=${LIB_DIR}; PKG_CONFIG_LIBDIR=${PKG_CONFIG_LIBDIR}; PKG_CONFIG_PATH=${PKG_CONFIG_PATH} ; CFLAGS=${CFLAGS}"
#}

#post_makeinstall_target() {
#  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
#  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"
#
#  rm -rf $INSTALL/usr/bin
#  rm -rf $INSTALL/usr/share/pygobject
#}
