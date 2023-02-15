# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="meson"
PKG_VERSION="1.0.0"
PKG_SHA256="a2ada84d43c7e57400daee80a880a1f5003d062b2cb6c9be1747b0db38f2eb8d"
PKG_LICENSE="Apache"
PKG_SITE="http://mesonbuild.com"
#PKG_URL="https://github.com/mesonbuild/meson/releases/download/0.64.1/meson-0.64.1.tar.gz"
PKG_URL="https://github.com/mesonbuild/meson/archive/refs/tags/1.0.0.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host pathlib:host"
PKG_LONGDESC="High productivity build system"
PKG_TOOLCHAIN="manual"

make_host() {
  python3 setup.py build
}

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=$TOOLCHAIN --skip-build

  # Avoid using full path to python3 that may exceed 128 byte limit.
  # Instead use PATH as we know our toolchain is first.
  sed -e '1 s/^#!.*$/#!\/usr\/bin\/env python3/' -i $TOOLCHAIN/bin/meson
}
