# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="pygobject"
PKG_VERSION="3.42.2"
PKG_SHA256="21524cef33100c8fd59dc135948b703d79d303e368ce71fa60521cc971cd8aa7"
PKG_LICENSE="LGPL"
PKG_SITE="https://pygobject.readthedocs.io/"
PKG_URL="https://files.pythonhosted.org/packages/fe/40/9afaeb8d3b453fb8596fcb6c7bc2b64e434868c91eda19955742778eff74/PyGObject-3.42.2.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 glib libffi"
PKG_LONGDESC="A convenient wrapper for the GObject+ library for use in Python programs."
#PKG_TOOLCHAIN="autotools"
#PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--enable-thread --disable-introspection"

pre_configure_target() {
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python3-config --includes)"
  export PYTHON=python3
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share/pygobject
}
