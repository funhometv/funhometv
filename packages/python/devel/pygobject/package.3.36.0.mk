# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="pygobject"
PKG_VERSION="3.36.0"
PKG_SHA256="b97f570e55017fcd3732164811f24ecf63983a4834f61b55b0aaf64ecefac856"
PKG_LICENSE="LGPL"
PKG_SITE="https://pygobject.readthedocs.io/"
PKG_URL="https://files.pythonhosted.org/packages/3e/b5/f4fd3351ed074aeeae30bff71428f38bc42187e34c44913239a9dc85a7fc/PyGObject-3.36.0.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 glib libffi"
PKG_LONGDESC="A convenient wrapper for the GObject+ library for use in Python programs."
#PKG_TOOLCHAIN="autotools"
#PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--enable-thread --disable-introspection"

pre_configure_target() {
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python3-config --includes)"
  export PYTHON=python3

  #in order to make 
  sed -i "s/master/2.63.3/" $PKG_BUILD/subprojects/glib.wrap
  sed -i "s/master/1.63.2/" $PKG_BUILD/subprojects/gobject-introspection.wrap
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share/pygobject
}
