# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="pam"
PKG_VERSION="1.5.2"
PKG_SHA256="83661718a974ffd7caf97b87924811629a9b8169f704925fd0aad70a6e87fb90"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/linux-pam/linux-pam"
PKG_URL="https://github.com/linux-pam/linux-pam/archive/refs/tags/v1.5.2.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="Linux PAM (Pluggable Authentication Modules for Linux)"

PKG_CONFIGURE_OPTS_TARGET="--disable-doc "
PKG_TOOLCHAIN="configure"

pre_configure_target(){
#  cd ..
  echo "---------------------------------pam pre_configure_target ----------"
  pwd
  ./autogen.sh
#  cd -
}


