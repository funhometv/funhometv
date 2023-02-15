# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="dbus-python"
PKG_VERSION="1.2.8"
PKG_SHA256="abf12bbb765e300bf8e2a1b2f32f85949eab06998dbda127952c31cb63957b6f"
PKG_LICENSE="GPL"
PKG_SITE="https://freedesktop.org/wiki/Software/dbus"
PKG_URL="https://dbus.freedesktop.org/releases/dbus-python/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 Python3 dbus dbus-glib"
PKG_LONGDESC="D-BUS is a message bus, used for sending messages between applications."
PKG_BUILD_FLAGS="+lto"

PKG_PYTHON_VERSION=python3.8

pre_configure_target() {
  export PYTHON_CONFIG="$SYSROOT_PREFIX/usr/bin/python3-config"
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python3-config --includes)"
  export PYTHON_LIBS="$($SYSROOT_PREFIX/usr/bin/python3-config --ldflags --embed)"
  export PYTHON_VERSION=3.8
}

#post_makeinstall_target() {
#  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
#  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"
#}
