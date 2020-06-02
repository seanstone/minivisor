################################################################################
#
# OVMF
#
################################################################################

OVMF_VERSION = edk2-stable202002
OVMF_SITE = https://github.com/tianocore/edk2.git
OVMF_SITE_METHOD := git
OVMF_GIT_SUBMODULES = YES
OVMF_LICENSE = BSD
OVMF_LICENSE_FILES = License.txt
OVMF_DEPENDENCIES =
OVMF_INSTALL_TARGET = YES

define OVMF_BUILD_CMDS
  CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" $(BR2_EXTERNAL)/package/ovmf/build.sh $(@D)
endef

define OVMF_INSTALL_TARGET_CMDS
  $(INSTALL) -D -m644 $(@D)/Build/OvmfX64/RELEASE_GCC5/FV/OVMF_CODE.fd $(TARGET_DIR)/usr/share/ovmf/ovmf_code_x64.bin
  $(INSTALL) -D -m644 $(@D)/Build/OvmfX64/RELEASE_GCC5/FV/OVMF_VARS.fd $(TARGET_DIR)/usr/share/ovmf/ovmf_vars_x64.bin
endef

$(eval $(generic-package))
