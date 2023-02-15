# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020 eric hao (e.hao@aol.com)

PKG_NAME="faker"
PKG_VERSION="1.0.8"
PKG_SHA256="6886d58f3c24d8ecdaa3740b138121614197ffd3e0adfb0cb02ca4e71e292dfe"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.org/project/Faker/"
PKG_URL="https://files.pythonhosted.org/packages/16/4f/721133ef55352a29727e48302444fb2dcc28f826524fd17497530e125ef3/Faker-1.0.8.tar.gz"

PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host six  dateutil text-unidecode"
PKG_LONGDESC="Faker is a Python package that generates fake data for you."
PKG_TOOLCHAIN="manual"

pre_make_target() {
#haoyq add a fix for python 2.7 or 3 there  is not replace for the list error. and we only use en_US the default.
  sed -i "s/locale = locale.replace('-', '_') if locale else DEFAULT_LOCALE/locale = DEFAULT_LOCALE/" faker/factory.py
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
}


make_target() {
  python3 setup.py build 
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/*/tests
}
