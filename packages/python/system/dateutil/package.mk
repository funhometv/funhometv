# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020 eric hao (e.hao@aol.com)

PKG_NAME="dateutil"
PKG_VERSION="2.8.1"
PKG_SHA256="73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.org/project/Faker/"
PKG_URL="https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz"

PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host pip:host"
PKG_LONGDESC="dateutil for python"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
}

make_target() {
  python3 setup.py build 
}

makeinstall_target() {
  exec_thread_safe python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/*/tests
}
