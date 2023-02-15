# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2019 EricHao (funhome.tv)

PKG_NAME="php"
PKG_VERSION="7.3.10"
PKG_SHA256="fb670723a9b8fda31c89529f27e0dda289d8af4b6ce9f152c8010876639c0fb4"
PKG_ARCH="any"
PKG_LICENSE="Apache LICENSE"
PKG_SITE="https://www.php.net"
PKG_URL="https://www.php.net/distributions/php-7.3.10.tar.gz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain zlib openssl apr apr-util expat pcre apache2 curl libxml2 libmcrypt libxslt libiconv mariadb icu4c libjpeg-turbo libzip"
#PKG_SECTION="[location under packages, e.g. database]"
PKG_SECTION="network"
PKG_SHORTDESC="[the web server run time scripts]"
PKG_LONGDESC="[ PHP is a popular general-purpose scripting language that is especially suited to web development.  Fast, flexible and pragmatic, PHP powers everything from your blog to the most popular websites in the world.  ]"
PKG_TOOLCHAIN="configure"
#PKG_TOOLCHAIN="autotools"

#PKG_BUILD_FLAGS="-gold"
#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#PKG_CONFIGURE_OPTS_TARGET=" --with-apxs2=$TOOLCHAIN/$TARGET_NAME/sysroot/usr/bin/apxs 
# APXS_FILE=$(get_build_dir apache2)/.install_pkg/usr/bin/apxs
#
#
  MARIADB_DIR_TARGET=$(get_build_dir mariadb)/.install_pkg
  LIBMCRYPT_DIR_TARGET=$(get_build_dir libmcrypt)/.install_pkg
  APACHE2_DIR=$(get_build_dir apache2)/.install_pkg
  ICU_DIR=$(get_build_dir icu4c)/.install_pkg

  CFLAGS+=" -DSQLITE_OMIT_LOAD_EXTENSION"
  CFLAGS+=" -I$APACHE2_DIR/usr/include"
  CFLAGS+=" -I$ICU_DIR/usr/include"

  # Dynamic Library support
  LDFLAGS+=" -ldl -lpthread"
  LDFLAGS+=" -L$ICU_DIR/usr/lib"

  # libiconv
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/iconv"
  LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib/iconv -liconv"

  #libzip
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/lib/libzip/include -I$SYTROOT_PREFIX/usr/include"
  LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib -lzip"


  # overwrite mysql library location
  CFLAGS+=" -L$MARIADB_DIR_TARGET/usr/lib -lmysqlclient"
  export CFLAGS="$CFLAGS"
  export CXXFLAGS="$CFLAGS"
  export CPPFLAGS="$CFLAGS"
  #  --with-pdo-mysql=$MARIADB_DIR_TARGET/usr \
    #--enable-pdo \
    #--with-pdo-sqlite=$SYSROOT_PREFIX/usr \
    #--with-sqlite3=$SYSROOT_PREFIX/usr \

    #--enable-zip \
    #--with-libzip=$SYSROOT_PREFIX/usr/lib \


PKG_CONFIGURE_OPTS_TARGET=" --with-apxs2=/home/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/apache2-2.4.41/.install_pkg/usr/bin/apxs \
    --disable-pcntl \
    --without-pcntl \
    --enable-cli \
    --enable-opcache \
    --with-pear \
    --with-config-file-path=/storage/.kodi/userdata/addon_data/service.web.lamp/srvroot/conf \
    --localstatedir=/var \
    --enable-sockets \
    --enable-session \
    --enable-posix \
    --enable-mbstring \
    --enable-dom \
    --enable-ctype \
    --enable-ftp \
    --with-openssl-dir=$SYSROOT_PREFIX/usr \
    --enable-libxml \
    --enable-xml \
    --enable-xmlreader \
    --enable-xmlwriter \
    --enable-simplexml \
    --enable-fileinfo \
    --with-curl=$SYSROOT_PREFIX/usr \
    --with-openssl=$SYSROOT_PREFIX/usr \
    --with-zlib=$SYSROOT_PREFIX/usr \
    --with-bz2=$SYSROOT_PREFIX/usr \
    --with-zlib=$SYSROOT_PREFIX/usr \
    --with-iconv \
    --with-icu-dir=$ICU_DIR/usr \
    --with-xsl=$SYSROOT_PREFIX/usr \
    --enable-intl \
    --disable-cgi \
    --with-gettext \
    --without-gmp \
    --enable-json \
    --disable-sysvmsg \
    --disable-sysvsem \
    --disable-sysvshm \
    --enable-filter \
    --enable-calendar \
    --with-pcre-regex \
    --with-mcrypt=$LIBMCRYPT_DIR_TARGET/usr \
    --with-mysql=$MARIADB_DIR_TARGET/usr \
    --with-mysql-sock=/run/mysql.sock \
    --with-gd \
    --enable-gd-native-ttf \
   --enable-gd-jis-conv \
    --enable-exif \
    --with-jpeg-dir=$SYSROOT_PREFIX/usr \
    --with-freetype-dir=$SYSROOT_PREFIX/usr \
    --with-png-dir=$SYSROOT_PREFIX/usr \
"

#--with-xml \#
#PKG_MAKE_OPTS_TARGET=" -l$TOOLCHAIN/$TARGET_NAME/sysroot/usr/lib/libpcre.so "

pre_configure_target() {

echo "pre config !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
# copy from samba's pre_configure_target
# in order to remove the duplicate of struct iovec
#
  #if [ "$TARGET_ARCH" = "arm" ]; then
 # export CFLAGS+=" -DAPR_IOVEC_DEFINED  -lpthread -lpcre  -L$TOOLCHAIN/$TARGET_NAME/sysroot/usr/lib "
 # fi
  MARIADB_DIR_TARGET=$(get_build_dir mariadb)/.install_pkg
  LIBMCRYPT_DIR_TARGET=$(get_build_dir libmcrypt)/.install_pkg
  APACHE2_DIR=$(get_build_dir apache2)/.install_pkg
  ICU_DIR=$(get_build_dir icu4c)/.install_pkg

  CFLAGS+=" -DSQLITE_OMIT_LOAD_EXTENSION -O0 "
  CFLAGS+=" -I$APACHE2_DIR/usr/include"
  CFLAGS+=" -I$ICU_DIR/usr/include"

  # Dynamic Library support
  LDFLAGS+=" -ldl -lpthread"
  LDFLAGS+=" -L$ICU_DIR/usr/lib"

  # libiconv
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/iconv"
  LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib/iconv -liconv"

  # overwrite mysql library location
  CFLAGS+=" -L$MARIADB_DIR_TARGET/usr/lib -lmysqlclient"
  export CFLAGS="$CFLAGS"
  export CXXFLAGS="$CFLAGS"
  export CPPFLAGS="$CFLAGS"

#  APXS_FILE=$(get_build_dir apache2)/.install_pkg/usr/bin/apxs
#  chmod +x $APXS_FILE


}
post_configure_target() {
  : # dummy
  # quick hack
  # not for new
  sed -i "s|-I/usr/include|-I$SYSROOT_PREFIX/usr/include|g" Makefile
  # add haoyq for ""
  sed -i "s|-I\"/usr/include\"|-I$SYSROOT_PREFIX/usr/include|g" Makefile

  sed -i "s|-L/usr/lib|-L$SYSROOT_PREFIX/usr/lib|g" Makefile

  PHP_BIN=$(which php)

  sed -i "s|PHP_EXECUTABLE =.*|PHP_EXECUTABLE = $PHP_BIN|g" Makefile
  sed -i 's|$(top_builddir)/$(SAPI_CLI_PATH)|dummy_sapi_cli_path|g' Makefile
}



#pre_configure_target() {
#PKG_CONFIGURE_OPTS_TARGET="ac_cv_file__dev_zero=yes \
#			  ac_cv_func_setpgrp_void=yes \
#			  apr_cv_tcp_nodelay_with_cork=yes "



pre_make_target() {

echo "should configure OK!!!!!!!!!!!!! ready for make !!!!!!!!!!!!!!!!!!!!!!!"
#remove the following from Makefile
#test_char.h: gen_test_char
#	./gen_test_char > test_char.h

#sed -i 's"test_char.h: gen_test_char""' server/Makefile
#sed -i 's"./gen_test_char > test_char.h""' server/Makefile
#pc local gen-test-char
#from https://www.cnblogs.com/zhangsf/archive/2013/08/21/3272960.html
#/home/ubuntu/localAPM/apache2/httpd-2.4.41/server/gen_test_char > /xtr/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/apache2-2.4.41/.armv7ve-libreelec-linux-gnueabi/server/test_char.h

sed -i 's"#define ulong unsigned long"typedef unsigned long ulong;"'    /home/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/php-7.3.10/.armv7ve-libreelec-linux-gnueabi/main/php_config.h
#define ulong unsigned long
#typedef unsigned long ulong;
sed -i 's"#define uint unsigned int"typedef unsigned int uint;"'    /home/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/php-7.3.10/.armv7ve-libreelec-linux-gnueabi/main/php_config.h

#define uint unsigned int
#typedef unsigned int uint;



}

makeinstall_target() {
  export INSTALL_DEV=$(pwd)/.install_pkg

  mkdir -p $INSTALL_DEV/etc/
  cp $(get_build_dir apache2)/.install_dev/etc/httpd.conf $INSTALL_DEV/etc/httpd.conf

  #sed -i "s|install-pear-installer:.*|install-pear-installer:\ndummy123:|g" Makefile

  #
  sed -i 's|@$(top_builddir)/sapi/cli/php|php|g' Makefile

  make -j1 install INSTALL_ROOT=$INSTALL_DEV $PKG_MAKEINSTALL_OPTS_TARGET

  sed -i "/prefix/ s|/usr|$INSTALL_DEV/usr|" $INSTALL_DEV/usr/bin/phpize
  sed -i "/extension_dir/ s|/usr|$INSTALL_DEV/usr|" $INSTALL_DEV/usr/bin/php-config
  sed -i "/prefix/ s|/usr|$INSTALL_DEV/usr|" $INSTALL_DEV/usr/bin/php-config

  sed -i "/phpdir=/ s|phpdir=.*|phpdir=\"$INSTALL_DEV/usr/lib/build\"|" $INSTALL_DEV/usr/bin/phpize
}


post_makeinstall_target() {

#cp -P $PKG_REAL_BUILD/.libs/httpd $INSTALL/usr/bin/apache2
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!php is make installed :$INSTALL"


}

