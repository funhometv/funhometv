# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2023 eric hao (e.hao@aol.com)

PKG_NAME="dnspython"
PKG_VERSION="2.3.0"
PKG_SHA256="224e32b03eb46be70e12ef6d64e0be123a64e621ab4c0822ff6d450d52a540b9"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.org/project/dnspython/"
PKG_URL="https://files.pythonhosted.org/packages/91/8b/522301c50ca1f78b09c2ca116ffb0fd797eadf6a76085d376c01f9dd3429/dnspython-2.3.0.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="dnspython is a DNS toolkit for Python. It supports almost all record types. It can be used for queries, zone transfers, and dynamic updates. It supports TSIG authenticated messages and EDNS0."
PKG_TOOLCHAIN="manual"
# in order to check if the host is registerd ok. we haoyq @2023-2-20

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
  python3 setup.py build 
#--cross-compile
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/*/tests
}
