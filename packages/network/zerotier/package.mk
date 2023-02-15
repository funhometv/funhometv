# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="zerotier"
PKG_VERSION="1.2.12"
PKG_SHA256="212799bfaeb5e7dff20f2cd83f15742c8e13b8e9535606cfb85abcfb5fb6fed4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://zerotier.com/"
PKG_URL="https://github.com/zerotier/ZeroTierOne/archive/1.2.12.tar.gz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network"
PKG_SHORTDESC="A Smart Ethernet Switch for Earth"
PKG_LONGDESC="ZeroTier is a smart programmable Ethernet switch for planet Earth. It allows all networked devices, VMs, containers, and applications to communicate as if they all reside in the same physical data center or cloud region."
PKG_TOOLCHAIN="make"

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}
make_target()
{
    cd ..
    #armv7l to armv7ve-libreelec-linux-gnueabi
    sed -i "s|armv7l|armv8a|g" make-linux.mk
    #arv7l to armv8a-libreelec-linux-gnueabihf # haoyq 20200325 for FunHome.pi4.

    #for pi4 haoyq we change armv5 to armv7ve 20200324
    sed -i "s|armv5|armv7ve|g" make-linux.mk
    sed -i "s|override DEFS+=-DZT_USE_MINIUPNPC|override DEFS+=-DZT_USE_MINIUPNPC -fPIC|g" make-linux.mk
    make -f make-linux.mk
}
# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration


post_install() {
    
    
    mkdir -p $INSTALL/usr/lib/systemd/system
      cp $PKG_DIR/system.d/* $INSTALL/usr/lib/systemd/system

    enable_service zerotier.service
    echo "enabled service zerotier"

}
 
