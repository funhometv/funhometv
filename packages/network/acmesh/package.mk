# SPDX-License-Identifier: GPL-2.0
# copyright HaoYiQuan uucoin@163.com 2022
#

PKG_NAME="acmesh"
PKG_VERSION="3.0.5"
PKG_SHA256="a19132ed65491409a8d8a93c264dcbcf265a91d45a46de674811b93f5995398f"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/acmesh-official/acme.sh/"
PKG_URL="https://github.com/acmesh-official/acme.sh/archive/refs/tags/3.0.5.tar.gz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain curl openssl"
PKG_SECTION="network"
PKG_SHORTDESC="A pure Unix shell script implementing ACME client protocol"
PKG_LONGDESC="An ACME Shell script: acme.sh"
PKG_TOOLCHAIN="configure"   
# a dummy configure which we make
# PKG_TOOLCHAIN="auto"


# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
pre_configure_target() {
  cat<<EOF >Makefile
all: release
install:
	echo "OK"
release:
	echo "OK"
EOF

cat<<EOF_CF >configure
#!/bin/sh
echo "OK"
EOF_CF
chmod 755 configure

}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration

makeinstall_target() {
#copy from libreELEC.tv/scripts/install

echo "PKG_DIR=$PKG_DIR;INSTALL=$INSTALL;"
ls -l $PKG_DIR/conffiles
mkdir -p $INSTALL/usr/www/acmesh
cp -Pv $PKG_DIR/conffiles/3.0.5.tar.gz  $INSTALL/usr/www/acmesh
cp -Pv ${PKG_DIR}/conffiles/dns_funhometv.sh ${INSTALL}/usr/www/acmesh
cp -Pv ${PKG_DIR}/conffiles/reloadcmd.sh ${INSTALL}/usr/www/acmesh

}
