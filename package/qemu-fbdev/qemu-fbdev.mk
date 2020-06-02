################################################################################
#
# qemu-fbdev
#
################################################################################

QEMU_FBDEV_VERSION = e5b3b11
QEMU_FBDEV_SITE = git://github.com/seanstone/qemu.git
QEMU_FBDEV_SITE_METHOD = git
QEMU_FBDEV_GIT_SUBMODULES = YES
QEMU_FBDEV_LICENSE = GPL-2.0, LGPL-2.1, MIT, BSD-3-Clause, BSD-2-Clause, Others/BSD-1c
QEMU_FBDEV_LICENSE_FILES = COPYING COPYING.LIB
# NOTE: there is no top-level license file for non-(L)GPL licenses;
#       the non-(L)GPL license texts are specified in the affected
#       individual source files.

#-------------------------------------------------------------
# Target-qemu

QEMU_FBDEV_DEPENDENCIES = host-pkgconf host-python libglib2 zlib pixman

# Need the LIBS variable because librt and libm are
# not automatically pulled. :-(
QEMU_FBDEV_LIBS = -lrt -lm

QEMU_FBDEV_VARS = \
	LIBTOOL=$(HOST_DIR)/bin/libtool \
	PYTHON=$(HOST_DIR)/bin/python2 \
	PYTHONPATH=$(TARGET_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages

QEMU_FBDEV_OPTS += 	--target-list=x86_64-softmmu \
					--enable-system \
					--disable-linux-user \
					--disable-bsd-user \
					--enable-tools \
					--enable-kvm \
    				--disable-xen \
					--enable-vnc \
					--disable-spice \
					--disable-sdl \
					--enable-vgt \
					--disable-gtk \
					--enable-vhost-net \
					--disable-opengl \
					--audio-drv-list= \
					--disable-usb-redir \
					--disable-docs \
					--disable-curses \
					--enable-fbdev

# Override CPP, as it expects to be able to call it like it'd
# call the compiler.
define QEMU_FBDEV_CONFIGURE_CMDS
	( cd $(@D); \
		LIBS='$(IGVTG_QEMU_LIBS)' \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		CPP="$(TARGET_CC) -E" \
		$(IGVTG_QEMU_VARS) \
		./configure \
			--prefix=/usr \
			--cross-prefix=$(TARGET_CROSS) \
			--enable-attr \
			--disable-slirp \
			--disable-virtfs \
			--disable-brlapi \
			--disable-curl \
			--disable-bluez \
			--disable-vde \
			--disable-linux-aio \
			--disable-cap-ng \
			--disable-rbd \
			--disable-libiscsi \
			--disable-strip \
			--disable-seccomp \
			--disable-sparse \
			$(IGVTG_QEMU_OPTS) \
	)
endef

define QEMU_FBDEV_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

# define QEMU_FBDEV_INSTALL_TARGET_CMDS
# endef

$(eval $(generic-package))
