# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020 eric hao (e.hao@aol.com)

PKG_NAME="qrcode"
PKG_VERSION="6.1"
PKG_SHA256="505253854f607f2abf4d16092c61d4e9d511a3b4392e60bff957a68592b04369"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.org/project/qrcode/"
PKG_URL="https://files.pythonhosted.org/packages/19/d5/6c7d4e103d94364d067636417a77a6024219c58cd6e9f428ece9b5061ef9/qrcode-6.1.tar.gz"
PKG_SHORTDESC="a qrcode generator in python"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="A Quick Response code is a two-dimensional pictographic code used for its fast readability and comparatively large storage capacity. The code consists of black modules arranged in a square pattern on a white background. The information encoded can be made up of any kind of data (e.g., binary, alphanumeric, or Kanji symbols)"
PKG_TOOLCHAIN="manual"

pre_make_target() {
#haoyq add a fix for python 2.7 there  is not replace for the list error. and we only use en_US the default.
  #sed -i "s/locale = locale.replace('-', '_') if locale else DEFAULT_LOCALE/locale = DEFAULT_LOCALE/" faker/factory.py
  #export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
:
}


make_target() {
  python3 setup.py build 
#--cross-compile
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

#post_makeinstall_target() {
#  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
#  rm -rf $INSTALL/usr/lib/python*/site-packages/*/tests
#}
