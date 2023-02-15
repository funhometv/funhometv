# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2019 Funhome.tv

PKG_NAME="libevent"
PKG_VERSION="2.1.11"
PKG_SHA256="a65bac6202ea8c5609fd5c7e480e6d25de467ea1917c08290c521752f147283d"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://libevent.org/"
PKG_URL="https://github.com/libevent/libevent/releases/download/release-$PKG_VERSION-stable/libevent-$PKG_VERSION-stable.tar.gz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="Event notification library"
PKG_LONGDESC="The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file descriptor or after a timeout has been reached. Furthermore, libevent also
 support callbacks due to signals or regular timeouts.  libevent is meant to replace the event loop found in event driven network servers. An application just needs to call event_dispatch() and th
en add or remove events dynamically without having to change the event loop. "
PKG_TOOLCHAIN="configure"

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
