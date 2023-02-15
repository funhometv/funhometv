# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020 eric hao (e.hao@aol.com)

PKG_NAME="text-unidecode"
PKG_VERSION="1.2"
PKG_SHA256="5a1375bb2ba7968740508ae38d92e1f889a0832913cb1c447d5e2046061a396d"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.org/project/text-unidecode/"
PKG_URL="https://files.pythonhosted.org/packages/f0/a2/40adaae7cbdd007fb12777e550b5ce344b56189921b9f70f37084c021ca4/text-unidecode-1.2.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_LONGDESC="Faker is a Python package that generates fake data for you."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
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
