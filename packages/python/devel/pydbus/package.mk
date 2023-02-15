# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="pydbus"
PKG_VERSION="0.6.0"
PKG_SHA256="4207162eff54223822c185da06c1ba8a34137a9602f3da5a528eedf3f78d0f2c"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/LEW21/pydbus"
PKG_URL="https://files.pythonhosted.org/packages/58/56/3e84f2c1f2e39b9ea132460183f123af41e3b9c8befe222a35636baa6a5a/pydbus-0.6.0.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 glib libffi gobject-introspection pygobject"
PKG_LONGDESC="Pythonic DBus library. We used to replace dbus-python which depends on dbus-glib that not threadsafe."
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
