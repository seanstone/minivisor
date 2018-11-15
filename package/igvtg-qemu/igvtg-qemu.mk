################################################################################
#
# Igvtg-qemu
#
################################################################################

IGVTG_QEMU_VERSION = 3.0.0
IGVTG_QEMU_SOURCE = qemu-$(IGVTG_QEMU_VERSION).tar.xz
IGVTG_QEMU_SITE = https://download.qemu.org
IGVTG_QEMU_LICENSE = GPL-2.0, LGPL-2.1, MIT, BSD-3-Clause, BSD-2-Clause, Others/BSD-1c
IGVTG_QEMU_LICENSE_FILES = COPYING COPYING.LIB
# NOTE: there is no top-level license file for non-(L)GPL licenses;
#       the non-(L)GPL license texts are specified in the affected
#       individual source files.

#-------------------------------------------------------------
# Target-qemu

IGVTG_QEMU_DEPENDENCIES = host-pkgconf host-python libglib2 zlib pixman

# Need the LIBS variable because librt and libm are
# not automatically pulled. :-(
IGVTG_QEMU_LIBS = -lrt -lm

IGVTG_QEMU_VARS = \
	LIBTOOL=$(HOST_DIR)/bin/libtool \
	PYTHON=$(HOST_DIR)/bin/python2 \
	PYTHONPATH=$(TARGET_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages

IGVTG_QEMU_OPTS += 	--target-list=x86_64-softmmu \
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
define IGVTG_QEMU_CONFIGURE_CMDS
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

define IGVTG_QEMU_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IGVTG_QEMU_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(IGVTG_QEMU_MAKE_ENV) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
