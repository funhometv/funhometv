# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Eric Hao (e.hao@aol.com)

PKG_NAME="transmissionrpc"
PKG_VERSION="0.11"
PKG_SHA256="ec43b460f9fde2faedbfa6d663ef495b3fd69df855a135eebe8f8a741c0dde60"
PKG_LICENSE="MIT"
PKG_SITE="http://pypi.org/project/transmissionrpc"
PKG_URL="https://files.pythonhosted.org/packages/f5/f8/96a979b669a7219cb4299ea5512e1678ba7f59d91bd8a952c51405131768/transmissionrpc-0.11.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host six"
PKG_LONGDESC="This is transmissionrpc. This module helps using Python to connect to a Transmission JSON-RPC service. transmissionrpc is compatible with Transmission 1.31 and later."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
}

make_target() {
  python3 setup.py build 
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

#post_makeinstall_target() {
#  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
#  rm -rf $INSTALL/usr/lib/python*/site-packages/*/tests
#}

