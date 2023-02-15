# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="22.1.7"
PKG_SHA256="da838eb2cf11d0e08d0e9944f6bd4d96987fdc59ea2856f8c70a31a82b355d89"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://archive.mesa3d.org/mesa-22.1.7.tar.xz"
PKG_DEPENDS_TARGET="toolchain expat libdrm zstd Mako:host "
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="+lto"

get_graphicdrivers
#  we haoyq removed the asm @ 2022/1/1
#                       -Dasm=true \
	#
#-Ddri-drivers=${DRI_DRIVERS// /,} \  
# removed by we haoyq @ 2022/1/1 for Mesa\'s main branch no longer has any "classic" drivers, use the "amber" branch instead.
#
# added -Damber=true  for older drivers
#
# removed  for zstd
		       #-Dzstd=true \
		       #-Damber=true \

PKG_MESON_OPTS_TARGET=" \
                       -Dgallium-drivers=${GALLIUM_DRIVERS// /,} \
                       -Dgallium-extra-hud=false \
                       -Dgallium-xvmc=false \
                       -Dgallium-omx=disabled \
                       -Dgallium-nine=false \
                       -Dgallium-opencl=disabled \
                       -Dvulkan-drivers=auto \
                       -Dshader-cache=true \
                       -Dshared-glapi=true \
                       -Dopengl=true \
                       -Dgbm=true \
                       -Degl=true \
                       -Dglvnd=false \
                       -Dvalgrind=false \
                       -Dlibunwind=false \
                       -Dlmsensors=false \
                       -Dbuild-tests=false \
                       -Dselinux=false \
                       -Dosmesa=false"

echo "================================we haoyq check PKG_MESON_OPTS_TARGET now is "
echo ${PKG_MESON_OPTS_TARGET}

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xorgproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 libxshmfence libXrandr"
  export X11_INCLUDES=
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=x11 -Ddri3=true -Dglx=dri"
elif [ "$DISPLAYSERVER" = "weston" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET wayland wayland-protocols"
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=wayland,x11 -Ddri3=false -Dglx=disabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=auto -Ddri3=false -Dglx=disabled"
fi

if [ "$LLVM_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET elfutils llvm"
  export LLVM_CONFIG="$SYSROOT_PREFIX/usr/bin/llvm-config-host"
  PKG_MESON_OPTS_TARGET+=" -Dllvm=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dllvm=false"
fi

if [ "$VDPAU_SUPPORT" = "yes" -a "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=false"
fi

# && listcontains "$GRAPHIC_DRIVERS" "(r600|radeonsi)  --- removed by haoyq we @ 2023/1/1
if [ "$VAAPI_SUPPORT" = "yes" ] ; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libva"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=false"
fi

if listcontains "$GRAPHIC_DRIVERS" "vmware"; then
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=false"
fi

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_MESON_OPTS_TARGET+=" -Dgles1=false -Dgles2=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgles1=false -Dgles2=false"
fi



echo "================================we haoyq check PKG_MESON_OPTS_TARGET now after some change is "
echo ${PKG_MESON_OPTS_TARGET}

echo "current directory:"
pwd

# Temporary workaround:
# Listed libraries are static, while mesa expects shared ones. This breaks the
# dependency tracking. The following has some ideas on how to address that.
# https://github.com/LibreELEC/LibreELEC.tv/pull/2163
pre_configure_target() {
  if [ "$DISPLAYSERVER" = "x11" ]; then
    export LIBS="-lxcb-dri3 -lxcb-dri2 -lxcb-xfixes -lxcb-present -lxcb-sync -lxshmfence -lz "
  fi
  #mesa should use drm , so we changed the build file.  we haoyq @2023/1/1
  #sed -i "s/with_dri_platform = 'none'/with_dri_platform='drm'/" ../meson.build

  if [ "$VAAPI_SUPPORT" = "yes" ] ; then
    export  LIB_DIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib:${TOOLCHAIN}/lib"
    export PKG_CONFIG_LIBDIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/pkgconfig"
    export PKG_CONFIG_PATH="${TOOLCHAIN}/lib/pkgconfig:${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/share/pkgconfig"
    export CFLAGS=" ${CFLAGS} -I${TOOLCHAIN}/include -L${TOOLCHAIN}/lib -L${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib"
    export CPPFLAGS="${CFLAGS}"
    export CXXFLAGS="${CFLAGS}"
    ## in order to make meson found libva in version 2.5 not version 1.5 , we haoyq added @2023/1/3
    echo "we check ----: LIB_DIR=${LIB_DIR}; PKG_CONFIG_LIBDIR=${PKG_CONFIG_LIBDIR}; PKG_CONFIG_PATH=${PKG_CONFIG_PATH} ; CFLAGS=${CFLAGS}"
  fi
}

#post_makeinstall_target() {
  # removed we haoyq @ 2023/1/1 , we dont use nvidia drivers.
#:
  # Similar hack is needed on EGL, GLES* front. Might as well drop it and test the GLVND?
  #if [ "$DISPLAYSERVER" = "x11" ]; then
    # rename and relink for cooperate with nvidia drivers
  #  rm -rf $INSTALL/usr/lib/libGL.so
  #  rm -rf $INSTALL/usr/lib/libGL.so.1
  #  ln -sf libGL.so.1 $INSTALL/usr/lib/libGL.so
  #  ln -sf /var/lib/libGL.so $INSTALL/usr/lib/libGL.so.1
  #  mv $INSTALL/usr/lib/libGL.so.1.2.0 $INSTALL/usr/lib/libGL_mesa.so.1
  #fi
#}
