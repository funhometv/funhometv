# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2021 eric hao (e.hao@aol.com)

PKG_NAME="pip"
PKG_VERSION="20.0.2"
PKG_SHA256="7db0c8ea4c7ea51c8049640e8e6e7fde949de672bfa4949920675563a5a6967f"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.org/project/Faker/"
PKG_URL="https://files.pythonhosted.org/packages/8e/76/66066b7bc71817238924c7e4b448abdb17eb0c92d645769c223f9ace478f/pip-20.0.2.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="The PyPA recommended tool for installing Python packages."
PKG_TOOLCHAIN="manual"
# in order to install dateutil of python module/package . 2021/05/26 haoyq

#make_host() {
  #  python2 bootstrap.py
#  python2 -m ensurepip --default-pip
#  python3 -m ensurepip --default-pip
  #python3 bootstrap.py
#}

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
}

make_target() {
  python3 setup.py build --cross-compile
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/*/tests
}
