# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2019 EricHao (funhome.tv)

	#config=./configure --prefix=/home/ubuntu/localAPM/local --with-apr=/home/ubuntu/localAPM/local --with-expat=/home/ubuntu/localAPM/local
PKG_NAME="apr-util"
PKG_VERSION="1.6.1"
PKG_SHA256="b65e40713da57d004123b6319828be7f1273fbc6490e145874ee1177e112c459"
PKG_ARCH="any"
PKG_LICENSE="Apache LICENSE"
PKG_SITE="https://apr.apache.org"
PKG_URL="http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-util-$PKG_VERSION.tar.gz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain apr expat"
#PKG_SECTION="[location under packages, e.g. database]"
PKG_SECTION="web"
PKG_SHORTDESC="[the web server required parts]"
PKG_LONGDESC="The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations. "
PKG_TOOLCHAIN="configure"
#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
APR_DIR=$(get_build_dir apr)/.$TARGET_NAME
PKG_CONFIGURE_OPTS_TARGET="--with-apr=${APR_DIR} "

pre_configure_target() {

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
#
#
# in order to feed the apr-util with apr-1-config,we copy from the depending apr
####################### end of copy from apr-1-config ########
# change to execurable 
#chmod 775 apr-1-config

#  do something, or drop it
echo "TARGET is :'${TARGET}'"
echo "INSTALL is :${INSTALL}"

}
