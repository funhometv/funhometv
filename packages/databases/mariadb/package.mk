# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mariadb"
PKG_VERSION="10.3.37"
PKG_REV="102"
PKG_SHA256="a7b25f3534eff9dd847ca19f3adf70a975ee572929c16b1cf7ef8930bf782677"
PKG_LICENSE="GPL2"
PKG_SITE="https://mariadb.org"
#PKG_URL="https://downloads.mariadb.org/MariaDB/${PKG_NAME}-${PKG_VERSION}/source/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_URL="https://downloads.mariadb.org/interstitial/mariadb-10.3.37/source/mariadb-10.3.37.tar.gz"
PKG_DEPENDS_HOST="toolchain ncurses:host"
PKG_DEPENDS_TARGET="toolchain binutils bzip2 libaio libxml2 lzo ncurses openssl systemd zlib mariadb:host"
PKG_SHORTDESC="MariaDB is a community-developed fork of the MySQL."
PKG_LONGDESC="MariaDB (${PKG_VERSION}) is a fast SQL database server and a drop-in replacement for MySQL."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="-gold"

#PKG_IS_ADDON="yes"
#PKG_SECTION="databases"
#PKG_ADDON_NAME="MariaDB SQL database server"
#PKG_ADDON_TYPE="xbmc.service"
post_unpack(){
# remove PLUGIN_AUTH_PAM for 10.4.12 and 10.3.22
#
echo "-----------------------------------------------------changing PLUGIN_AUTH_PAM------------"
sed -i "s/PLUGIN_AUTH_PAM YES/PLUGIN_AUTH_PAM NO/" ${PKG_BUILD}/cmake/build_configurations/mysql_release.cmake
grep -Hns PLUGIN_AUTH_PAM ${PKG_BUILD}/cmake/build_configurations/mysql_release.cmake

}
configure_package() {

# we haoyq added -DWITHOUT_TOKUDB=1 for cross-compile @ 2023/1/23

  PKG_CMAKE_OPTS_HOST=" \
    -DCMAKE_INSTALL_MESSAGE=NEVER \
    -DWITHOUT_TOKUDB=1 \
    -DSTACK_DIRECTION=-1 \
    -DHAVE_IB_GCC_ATOMIC_BUILTINS=1 \
    -DCMAKE_CROSSCOMPILING=OFF \
    import_executables"

  PKG_CMAKE_OPTS_TARGET=" \
    -DCMAKE_INSTALL_MESSAGE=NEVER \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_CONFIG=mysql_release \
    -DWITHOUT_TOKUDB=1 \
    -DFEATURE_SET=classic \
    -DSTACK_DIRECTION=1 \
    -DDISABLE_LIBMYSQLCLIENT_SYMBOL_VERSIONING=ON \
    -DCMAKE_CROSSCOMPILING=ON \
    -DIMPORT_EXECUTABLES=${PKG_BUILD}/.${HOST_NAME}/import_executables.cmake \
    -DWITHOUT_AWS_KEY_MANAGEMENT=ON \
    -DWITH_EXTRA_CHARSETS=complex \
    -DWITH_SSL=system \
    -DWITH_SSL=${SYSROOT_PREFIX}/usr \
    -DWITH_JEMALLOC=OFF \
    -DWITH_PCRE=bundled \
    -DWITH_ZLIB=bundled \
    -DWITH_EDITLINE=bundled \
    -DWITH_LIBEVENT=bundled \
    -DCONNECT_WITH_LIBXML2=bundled \
    -DSKIP_TESTS=ON \
    -DWITH_DEBUG=OFF \
    -DWITH_UNIT_TESTS=OFF \
    -DENABLE_DTRACE=OFF \
    -DSECURITY_HARDENED=OFF \
    -DWITH_EMBEDDED_SERVER=OFF \
    -DWITHOUT_SERVER=OFF \
    -DPLUGIN_AUTH_SOCKET=STATIC \
    -DDISABLE_SHARED=NO \
    -DENABLED_PROFILING=OFF \
    -DENABLE_STATIC_LIBS=OFF \
    -DMYSQL_UNIX_ADDR=/var/run/mysqld/mysqld.sock \
    -DWITH_SAFEMALLOC=OFF \
    -DWITHOUT_AUTH_EXAMPLES=ON"
}

make_host() {
  ninja ${NINJA_OPTS} import_executables
}

makeinstall_host() {
  :
}

### haoyq removed the following because we are not addons , but system installed . And we use the default install
#makeinstall_target() {
  # use only for addon
  #DESTDIR=${PKG_BUILD}/.install_addon ninja ${NINJA_OPTS} install
  #rm -rf "${PKG_BUILD}/.install_addon/usr/mysql-test"
#}

#addon() {
#  local ADDON="${ADDON_BUILD}/${PKG_ADDON_ID}"
#  local MARIADB="${PKG_BUILD}/.install_addon/usr"

#  mkdir -p ${ADDON}/bin
#  mkdir -p ${ADDON}/config

#  cp ${MARIADB}/bin/mysql \
#     ${MARIADB}/bin/mysqld \
#     ${MARIADB}/bin/mysqladmin \
#     ${MARIADB}/bin/mysql_secure_installation \
#     ${MARIADB}/bin/my_print_defaults \
#     ${MARIADB}/bin/resolveip \
#     ${MARIADB}/scripts/mysql_install_db \
#     ${ADDON}/bin

#  cp -PR ${MARIADB}/share ${ADDON}
#}
post_install() {
    #remove the mysql-test take 355M
    rm -fr $SYSROOT_PREFIX/usr/mysql-test
    rm -fr $PKG_BUILD/.install_pkg/usr/mysql-test
#we want the database start with the system
    echo "enable the mariadb.server"
    enable_service mariadb.service
#add user
    echo "passwdcheck---:adding user and group, dump the current passwd"
    cat ${INSTALL}/etc/passwd
    echo "add_user mysql"
    add_group mysql 65533
    add_user mysql x 65533 65533 "mariadb" "/" "/bin/sh"
    # install to /usr/mysql 
    #mkdir -p $SYSROOT_PREFIX/usr/mysql
    #make install DESTDIR=$SYSROOT_PREFIX/usr/mysql
    echo "passwdcheck---: after added user, dump the current passwd"
    cat ${INSTALL}/etc/passwd


}

