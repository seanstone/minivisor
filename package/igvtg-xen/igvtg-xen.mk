################################################################################
#
# Igvtg-Xen
#
################################################################################

IGVTG_XEN_VERSION = 2018-q1-xengt-stable-4.10
IGVTG_XEN_SITE = https://github.com/intel/Igvtg-xen.git
IGVTG_XEN_SITE_METHOD := git
IGVTG_XEN_LICENSE = GPL-2.0
IGVTG_XEN_LICENSE_FILES = COPYING
IGVTG_XEN_DEPENDENCIES = host-acpica host-python xz

# Calculate XEN_ARCH
XEN_ARCH = x86_64

IGVTG_XEN_CONF_OPTS = --disable-ocamltools

IGVTG_XEN_CONF_ENV = PYTHON=$(HOST_DIR)/bin/python2
IGVTG_XEN_MAKE_ENV = \
	XEN_TARGET_ARCH=$(XEN_ARCH) \
	CROSS_COMPILE=$(TARGET_CROSS) \
	HOST_EXTRACFLAGS="-Wno-error" \
	$(TARGET_CONFIGURE_OPTS)

ifeq ($(BR2_PACKAGE_IGVTG_XEN_HYPERVISOR),y)
IGVTG_XEN_MAKE_OPTS += dist-xen
IGVTG_XEN_INSTALL_IMAGES = YES
define IGVTG_XEN_INSTALL_IMAGES_CMDS
	cp $(@D)/xen/xen $(BINARIES_DIR)
endef
else
IGVTG_XEN_CONF_OPTS += --disable-xen
endif

ifeq ($(BR2_PACKAGE_IGVTG_XEN_TOOLS),y)
IGVTG_XEN_DEPENDENCIES += dtc libaio libglib2 ncurses openssl pixman util-linux yajl
ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
IGVTG_XEN_DEPENDENCIES += argp-standalone
endif
IGVTG_XEN_INSTALL_TARGET_OPTS += DESTDIR=$(TARGET_DIR) install-tools
IGVTG_XEN_MAKE_OPTS += dist-tools
#IGVTG_XEN_CONF_OPTS += --with-extra-qemuu-configure-args="--disable-sdl"

define IGVTG_XEN_INSTALL_INIT_SYSV
	mv $(TARGET_DIR)/etc/init.d/xencommons $(TARGET_DIR)/etc/init.d/S50xencommons
	mv $(TARGET_DIR)/etc/init.d/xen-watchdog $(TARGET_DIR)/etc/init.d/S50xen-watchdog
	mv $(TARGET_DIR)/etc/init.d/xendomains $(TARGET_DIR)/etc/init.d/S60xendomains
endef
else
IGVTG_XEN_INSTALL_TARGET = NO
IGVTG_XEN_CONF_OPTS += --disable-tools
endif

#IGVTG_XEN_CONF_OPTS += --with-system-seabios=/usr/share/qemu/bios-256k.bin
#IGVTG_XEN_CONF_OPTS += --enable-ovmf
IGVTG_XEN_CONF_OPTS += --disable-qemu-traditional --with-system-qemu=/usr/bin/qemu-system-x86_64 --enable-rombios

$(eval $(autotools-package))
