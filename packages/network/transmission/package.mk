# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="transmission"
PKG_VERSION="2.94"
PKG_SHA256="35442cc849f91f8df982c3d0d479d650c6ca19310a994eccdaa79a4af3916b7d"
PKG_ARCH="any"
PKG_LICENSE="GPL2"
PKG_SITE="https://transmissionbt.com/"
PKG_URL="https://github.com/transmission/transmission-releases/raw/master/transmission-$PKG_VERSION.tar.xz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain zlib openssl automake autoconf libtool intltool libevent miniupnpc glib "
PKG_SECTION="network"
PKG_SHORTDESC="Transmission is a fast, easy, and free BitTorrent client"
PKG_LONGDESC="Transmission is a fast, easy, and free BitTorrent client. It comes in several flavors: A native Mac OS X GUI application ; GTK+ and Qt GUI applications for Linux, BSD, etc.  A headle
ss daemon for servers and routers ; A web UI for remote controlling any of the above .Visit https://transmissionbt.com/ for more information"
PKG_TOOLCHAIN="configure"

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it

#}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration

post_makeinstall_target() {
	mkdir -p $INSTALL/usr/lib/systemd/system
	cp -Pv $PKG_DIR/system.d/transmission.service $INSTALL/usr/lib/systemd/system


	#add a transsmision user for a test
	#add user
	# . for a different user  , we should make a different directory for transmission to download use.
   	#echo "add_user transmission"
   	#add_group transmission 65531
   	#add_user transmission x 65531 65531 "transmission" "/" "/bin/sh"

}

post_install(){
# we use it to download the updates
   	
	enable_service transmission.service

}
