# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2019 EricHao (funhome.tv)

PKG_NAME="php"
PKG_VERSION="7.4.33"
PKG_SHA256="924846abf93bc613815c55dd3f5809377813ac62a9ec4eb3778675b82a27b927"
PKG_ARCH="any"
PKG_LICENSE="Apache LICENSE"
PKG_SITE="https://www.php.net"
PKG_URL="https://www.php.net/distributions/php-7.4.33.tar.xz"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain zlib openssl expat pcre apache2 curl libxml2 libmcrypt libxslt libiconv mariadb icu4c libjpeg-turbo libzip freetype oniguruma memcached gmp imagemagick"
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
  MARIADB_DIR_TARGET=$(get_build_dir mariadb)/.$TARGET_NAME
  LIBMCRYPT_DIR_TARGET=$(get_build_dir libmcrypt)/.$TARGET_NAME
  APACHE2_DIR=$(get_build_dir apache2)/.$TARGET_NAME
  ICU_DIR=$(get_build_dir icu4c)/.$TARGET_NAME
  LIBICONV_DIR=$(get_build_dir libiconv)/.$TARGET_NAME
  GETTEXT_DIR=$(get_build_dir gettext)/.$TARGET_NAME
  #LIBXML2_DIR=$(get_build_dir libxml2)
  #IMAGEMAGICK_DIR=$(get_build_dir imagemagick)/.$TARGET_NAME

#according to https://github.com/docker-library/php/pull/839 
# in order to   Enable large file support (on 32bit systems)
#839 

# 20200815  haoyq we
  CFLAGS+="  -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 "

  CFLAGS+=" -DSQLITE_OMIT_LOAD_EXTENSION"
# for opcache shm
#CFLAGS+=" -DHAVE_SHM_IPC"
  #CFLAGS+=" -DUSE_MMAP -DUSE_SHM -DUSE_SHM_OPEN"


  CFLAGS+=" -I$APACHE2_DIR/usr/include"
  CFLAGS+=" -I$ICU_DIR/usr/include"

  # Dynamic Library support
  LDFLAGS+=" -ldl -lpthread"
  LDFLAGS+=" -L$ICU_DIR/usr/lib"

  # libiconv
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include"
  LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib/iconv -liconv"

  #libzip
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/lib/libzip/include"
  #LIBZIP_HEADER_DIR= " -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/lib/libzip/include"
  LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib -lzip"
  #libxml
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/libxml2 -I$SYSROOT_PREFIX/usr/include/libxml2/libxml"
  LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib -lxml2"



  # overwrite mysql library location
  #LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib -lmysqlclient"
  #upper line replaced with the following LDFLAGS line # we haoyq 20200323 added for funhome.tv.4
  LDFLAGS+=" -L${MARIADB_DIR_TARGET}/libmariadb/libmariadb -lmysqlclient"
  export CFLAGS="$CFLAGS"
  export CXXFLAGS="$CFLAGS"
  export CPPFLAGS="$CFLAGS"
    #--with-pdo-sqlite=$SYSROOT_PREFIX/usr \
    #--with-sqlite3=$SYSROOT_PREFIX/usr \

    #--enable-fileinfo \
    #--enable-dom \
    #--with-xsl=$SYSROOT_PREFIX/usr \
    #--with-pear \
    #--enable-ftp \
    #--with-mcrypt=$LIBMCRYPT_DIR_TARGET/usr \

    #--with-mysql-sock=/run/mysql.sock \
    #--with-gd=$SYSROOT_PREFIX/usr \
    #--with-pdo-mysql=$MARIADB_DIR_TARGET/usr \
    #--with-mysql=mysqlnd \
    
    # we temporalrally not enable fpm for test of opcache performance
    #--with-config-file-path=/storage/.kodi/userdata/addon_data/service.web.lamp/srvroot/conf \

#fileinfo enabled acording to nextcloud admin maunal for recommended packages.
# details in https://docs.nextcloud.com/server/16/admin_manual/installation/source_installation.html#example-installation-on-ubuntu-18-04-lts-server
# and opcache enabled ,same as caching-configuration

#  --enable-pcntl  for watts.update said :
#  watts:/storage/nextcloud $ ./occ upgrade
#  The process control (PCNTL) extensions are required in case you want to interrupt long running commands - see https://www.php.net/manual/en/book.pcntl.php

PKG_CONFIGURE_OPTS_TARGET=" --with-apxs2=$SYSROOT_PREFIX/usr/bin/apxs \
    --prefix=$SYSROOT_PREFIX/usr \
    --enable-pcntl \
    --disable-phar \
    --enable-ctype \
    --with-curl=$SYSROOT_PREFIX/usr \
    --enable-dom \
    --enable-gd \
    --with-iconv-dir=$LIBICONV_DIR/usr  \
    --enable-json \
    --with-libxml \
    --enable-mbstring \
    --with-openssl-dir=$SYSROOT_PREFIX/usr \
    --with-openssl=$SYSROOT_PREFIX/usr \
    --enable-posix \
    --enable-session \
    --enable-simplexml \
    --enable-xmlreader \
    --enable-xmlwriter \
    --enable-pdo \
    --enable-mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --disable-fileinfo \
    --with-zip \
    --with-bz2=$SYSROOT_PREFIX/usr \
    --with-gettext=$GETTEXT_DIR \
    --enable-intl \
    --with-zlib=$SYSROOT_PREFIX/usr \
    --enable-cli \
    --enable-xml \
    --enable-opcache \
    --with-config-file-path=/etc \
    --localstatedir=/var \
    --enable-sockets \
    --enable-exif \
    --disable-cgi \
    --with-gmp \
    --disable-sysvmsg \
    --disable-sysvsem \
    --disable-sysvshm \
    --enable-filter \
    --disable-calendar \
    --with-pcre-regex \
    --enable-gd-jis-conv \
    --with-jpeg \
    --with-freetype \
    --with-png \
    --enable-fpm \
    --with-fpm-user=daemon \
    --with-fpm-group=daemon \
    --with-fpm-systemd \
    --enable-bcmath \
    --enable-fileinfo \
    --enable-apcu \
    --with-imagick=$SYSROOT_PREFIX/usr \
"
#temp remove imagick 20210618 we haoyq FIXME
    #--with-imagick=$SYSROOT_PREFIX/usr \

#echo " libiconv directory is [ $LIBICONV_DIR  ]"
#echo " libintl.h should in $SYSROOT_PREFIX/usr/include=========!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
#--with-xml \#
#PKG_MAKE_OPTS_TARGET=" -l$TOOLCHAIN/$TARGET_NAME/sysroot/usr/lib/libpcre.so "

pre_configure_target() {

echo "pre config !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

#### according to https://www.php.net/manual/en/install.pecl.static.php 
#### install pear in place 
echo "current directory: in following line"
pwd
#mkdir -p ../ext/apcu
tar xvfz $PKG_DIR/pear/apcu-5.1.20.tgz -C ../ext
mv ../ext/apcu-5.1.20 ../ext/apcu
#mkdir -p ../ext/imagick
tar xvfz $PKG_DIR/pear/imagick-3.4.4.tgz -C ../ext
mv ../ext/imagick-3.4.4 ../ext/imagick
echo "check if rename work.."
ls -l ../ext/apcu 
ls -l ../ext/imagick
echo "remove configure"
ls -l ../configure
rm ../configure 
echo "current directory"
pwd
PROJECTCD=(`pwd`)
cd .. 
echo "regenerate configure file"
./buildconf --force
ls -l configure
echo "$PROJECTCD  We changed to it."
cd $PROJECTCD

echo "after pear inject. use it in configure"
# copy from samba's pre_configure_target
# in order to remove the duplicate of struct iovec
#
  #if [ "$TARGET_ARCH" = "arm" ]; then
 # export CFLAGS+=" -DAPR_IOVEC_DEFINED  -lpthread -lpcre  -L$TOOLCHAIN/$TARGET_NAME/sysroot/usr/lib "
 # fi
  MARIADB_DIR_TARGET=$(get_build_dir mariadb)/.$TARGET_NAME
  LIBMCRYPT_DIR_TARGET=$(get_build_dir libmcrypt)/.$TARGET_NAME
  APACHE2_DIR=$(get_build_dir apache2)/.$TARGET_NAME
  ICU_DIR=$(get_build_dir icu4c)/.$TARGET_NAME

#according to https://github.com/docker-library/php/pull/839
# in order to   Enable large file support (on 32bit systems)
#839

# 20200815 haoyq we
  CFLAGS+="  -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 "



  CFLAGS+=" -DSQLITE_OMIT_LOAD_EXTENSION -O0 "
# for opcache shm and patch 1001
  CFLAGS+=" -DHAVE_SHM_IPC -DHAVE_SHM_MMAP_ANON"
  CFLAGS+=" -DUSE_MMAP -DUSE_SHM -DUSE_SHM_OPEN"
 # -DUSE_SHM -DUSE_SHM_OPEN"
  CFLAGS+=" -I$APACHE2_DIR/usr/include"
  CFLAGS+=" -I$ICU_DIR/usr/include"

	# for libintl.h
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include "

  #libzip
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/lib/libzip/include"
  #LIBZIP_HEADER_DIR= " -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/lib/libzip/include"
  # Dynamic Library support
  LDFLAGS+=" -ldl -lpthread"
  LDFLAGS+=" -L$ICU_DIR/usr/lib"

  # libiconv
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/iconv"
  LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib/iconv -liconv"

  LIBICONV_DIR=$(get_build_dir libiconv)
  echo " libiconv directory is [ $LIBICONV_DIR  ]"

  #we haoyq @ 2023/1/13 new apache 2.4.54 maybe support cross compile, apr.h is missing in compiling php , after removed the fixes of apache's config.mk , so we should told php where is apr.h
  #found apr.h in toolchain/x86_64-libreelec-linux-gnu/sysroot/usr/include/apr-1
  CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/apr-1"
  
  #imagemagick  we haoyq 20210618 FIXME
  # drwxrwxr-x 2 eric eric 4096 Jun 17 23:54 Magick++
  # drwxrwxr-x 2 eric eric 4096 Jun 17 23:54 MagickCore
  # -rw-r--r-- 1 eric eric  713 Jun 18 06:41 Magick++.h
  # drwxrwxr-x 2 eric eric 4096 Jun 17 23:54 MagickWand
  IMAGEMAGICKDIR="$SYSROOT_PREFIX/usr/include/ImageMagick-7"
  IMAGEMAGICKPPDIR="$IMAGEMAGICKDIR/Magick++"
  IMAGEMAGICKCOREDIR="$IMAGEMAGICKDIR/MagickCore"
  IMAGEMAGICKWANDDIR="$IMAGEMAGICKDIR/MagickWand"

  #we told the PREFIX as custom we haoyq 
  #IM_IMAGEMAGICK_PREFIX="$SYSROOT_PREFIX/usr";export IM_IMAGEMAGICK_PREFIX

  #CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/ImageMagick-7 -I$IMAGEMAGICKPPDIR -I$IMAGEMAGICKCOREDIR -I$IMAGEMAGICKWANDDIR"
  #LDFLAGS+=" -L$SYSROOT_PREFIX/usr/lib/ImageMagick-7.0.10"

  # overwrite mysql library location
  # modified for funhome.tv.4 we haoyq 20200323
  CFLAGS+=" -L$MARIADB_DIR_TARGET/libmariadb/libmariadb -lmysqlclient"
  export CFLAGS="$CFLAGS"
  export CXXFLAGS="$CFLAGS"
  export CPPFLAGS="$CFLAGS"

#  APXS_FILE=$(get_build_dir apache2)/.install_pkg/usr/bin/apxs
#  chmod +x $APXS_FILE
#
#
#  we are cross compiling ; remove the usless "/usr ;" for Badness
echo `pwd`
echo "-----------------------------------------------------------before sed -------------------------------"
ls -l ../configure
sed -i.orig "s#/usr;#$SYSROOT_PREFIX/usr ; #g" ../configure
echo "-----------------------------------------------------------after sed --------------------------------"
ls -l ../configure

# change imagemagick's '/usr ' to our SYSROOT_PREFIX 's '/usr' 
sed -i "s#prefix=/usr#prefix=$SYSROOT_PREFIX/usr #g" $SYSROOT_PREFIX/usr/bin/MagickWand-config

## in 37847 line of configure 
## replace with the following line 
#  for i in $PHP_GETTEXT /usr/local /home/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/toolchain/armv7ve-libreelec-linux-gnueabi/sysroot/usr; do

#sed -i.orig1 '37847s#^.*$#for i in $PHP_GETTEXT /usr/local /home/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/toolchain/armv7ve-libreelec-linux-gnueabi/sysroot/usr; do#' ../configure

#echo "-----------------------------------------------------------after 2th sed --------------------------------"
#ls -l ../configure
# as https://stackoverflow.com/questions/4743080/how-can-i-force-php-to-use-the-libiconv-version-of-iconv-instead-of-the-centos-in
#sed -i.orig2 '40383s#^.*$#$iconv_impl_name=""#' ../configure

#echo "-----------------------------------------------------------after 3th sed --------------------------------"
#ls -l ../configure



}
post_configure_target() {
  : # dummy
  # quick hack
  # not for new
  
  # add haoyq for ""
  
  sed -i "s|-I/usr/include|-I$SYSROOT_PREFIX/usr/include|g" Makefile
  sed -i "s|-I\"/usr/include\"|-I$SYSROOT_PREFIX/usr/include $LIBZIP_HEADER_DIR|g" Makefile

  sed -i "s|-L/usr/lib|-L$SYSROOT_PREFIX/usr/lib|g" Makefile

  echo " removing the +nothing "
  sed -i 's"+nothing""' ../ext/standard/crc32.c

#  PHP_BIN=$(which php)

#  sed -i "s|PHP_EXECUTABLE =.*|PHP_EXECUTABLE = $PHP_BIN|g" Makefile
#  sed -i 's|$(top_builddir)/$(SAPI_CLI_PATH)|dummy_sapi_cli_path|g' Makefile
  echo "post configure target"

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






##echo "two typedef patch !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

##sed -i 's"#define ulong unsigned long"typedef unsigned long ulong;"'    /home/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/php-7.2.23/.armv7ve-libreelec-linux-gnueabi/main/php_config.h
#define ulong unsigned long
#typedef unsigned long ulong;
##sed -i 's"#define uint unsigned int"typedef unsigned int uint;"'    /home/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/php-7.2.23/.armv7ve-libreelec-linux-gnueabi/main/php_config.h

#define uint unsigned int
#typedef unsigned int uint;



}

#makeinstall_target() {
#  export INSTALL_DEV=$(pwd)/.install_pkg

#  mkdir -p $INSTALL_DEV/etc/
#  cp $(get_build_dir apache2)/.install_pkg/etc/httpd.conf $INSTALL_DEV/etc/httpd.conf


#  make -j1 install INSTALL_ROOT=$INSTALL_DEV $PKG_MAKEINSTALL_OPTS_TARGET
  
  
################## the following i never used ############  
  #sed -i "s|install-pear-installer:.*|install-pear-installer:\ndummy123:|g" Makefile

#  #
#  sed -i 's|@$(top_builddir)/sapi/cli/php|php|g' Makefile

#  sed -i "/prefix/ s|/usr|$INSTALL_DEV/usr|" $INSTALL_DEV/usr/bin/phpize
#  sed -i "/extension_dir/ s|/usr|$INSTALL_DEV/usr|" $INSTALL_DEV/usr/bin/php-config
#  sed -i "/prefix/ s|/usr|$INSTALL_DEV/usr|" $INSTALL_DEV/usr/bin/php-config

#  sed -i "/phpdir=/ s|phpdir=.*|phpdir=\"$INSTALL_DEV/usr/lib/build\"|" $INSTALL_DEV/usr/bin/phpize
#  ############# end of never used ################
#}
pre_makeinstall_target() {
## fix $(INSTALL_ROOT) to $SYSROOT_PREFIX

sed -i.hfx "s|\$(INSTALL_ROOT)|$SYSROOT_PREFIX|g" Makefile

#in funhome.tv.4  SYSROOT_PREFIX shared modified , we cannot use the shared directory, so we copy the apache2 httpd.conf to php target directory for a try to feed apxs. we haoyq 20200323
 mkdir -p $INSTALL/etc/
 cp -Pv $PKG_DIR/conffiles/httpd.conf $INSTALL/etc/httpd.conf
 mkdir -p $SYSROOT_PREFIX/etc
 cp -Pv $PKG_DIR/conffiles/httpd.conf $SYSROOT_PREFIX/etc



}

post_makeinstall_target() {
#in order to make php install to system image ,we copy from sysroot
# or we can change the "configure --prefix" to point to the destdir

mkdir -p $INSTALL/usr/lib
cp -Pv $SYSROOT_PREFIX/usr/lib/*php* $INSTALL/usr/lib
mkdir -p $INSTALL/usr/bin
cp -Pv $SYSROOT_PREFIX/usr/bin/*php* $INSTALL/usr/bin
mkdir -p $INSTALL/etc
cp -Pv $SYSROOT_PREFIX/etc/httpd.conf  $INSTALL/etc/httpd.conf

#just add DESTDIR and install to it
make install DESTDIR=$INSTALL
#cp -P $PKG_REAL_BUILD/.libs/httpd $INSTALL/usr/bin/apache2
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!php is make installed :$INSTALL"
#copy opcache  FIXME why make install don't install it ?
cp -Pv $SYSROOT_PREFIX/usr/lib/extensions/no-debug-non-zts-20190902/opcache.so $INSTALL/usr/lib
#cp -Pv $(get_build_dir php)/modules/opcache.so $INSTALL/usr/lib
# enable opcache and put php.ini
cat ../php.ini-production $PKG_DIR/conffiles/php-opcache.ini > $INSTALL/etc/php.ini

#adjust memory_limit to 512M ; according to nextcloud document it should be 512M
sed -i "s|memory_limit = 128M|memory_limit = 512M|" $INSTALL/etc/php.ini

#copy php-fpm 
mkdir -p $INSTALL/usr/sbin
cp -Pv sapi/fpm/php-fpm $INSTALL/usr/sbin
mkdir -p $INSTALL/usr/lib/systemd/system
#we haoyq modified php-fpm.service from sapi/fpm/php-fpm.service , removed nodaemon, added mkdir /var/run/php
cp -Pv $PKG_DIR/conffiles/php-fpm.service $INSTALL/usr/lib/systemd/system
cp -Pv $PKG_DIR/conffiles/php-fpm.conf $INSTALL/etc
enable_service php-fpm.service
#adjust the directory to /usr/lib in installed php location, not $SYSROOT_PREFIX/usr/lib because of cross building
sed -i.hfx "s|$SYSROOT_PREFIX||g" $INSTALL/etc/httpd.conf

# copy iconv's lib thing to /usr/lib
# we haoyq  20200323 , because funhome.tv.4(Libreelec after 9.0.1) changed the shared SYSROOT_PREFIX to nonshared , we should copy the file from it's build directory.
# old way -- echo "cp $SYSROOT_PREFIX/usr/lib/iconv/* $INSTALL/usr/lib"
# cp -Pv  $SYSROOT_PREFIX/usr/lib/iconv/* $INSTALL/usr/lib
# new way
echo "cp ${BUILD}/image/system/usr/lib/iconv/* $INSTALL/usr/lib"
cp -Pv ${BUILD}/image/system/usr/lib/iconv/* $INSTALL/usr/lib

}

