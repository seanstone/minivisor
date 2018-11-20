################################################################################
#
# SeaBIOS
#
################################################################################

SEABIOS_VERSION = rel-1.12.0
SEABIOS_SITE = https://github.com/qemu/seabios
SEABIOS_SITE_METHOD := git
SEABIOS_LICENSE = LGPL-3.0
SEABIOS_LICENSE_FILES = COPYING
SEABIOS_DEPENDENCIES =
SEABIOS_INSTALL_TARGET = YES

define SEABIOS_BUILD_CMDS
  $(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D)
endef

define SEABIOS_INSTALL_TARGET_CMDS
  $(INSTALL) -D -m 0755 $(@D)/out/bios.bin $(TARGET_DIR)/usr/share/qemu/
endef

$(eval $(generic-package))
