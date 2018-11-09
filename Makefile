.PHONY: default
default: all

%:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/defconfig -C buildroot $*

.PHONY: prep
prep: ct-ng-defconfig defconfig

.PHONY: ct-ng-defconfig
ct-ng-defconfig:
	mkdir -p toolchain
	cp configs/ct-ng.config toolchain/.config

.PHONY: ct-ng-savedefconfig
ct-ng-savedefconfig:
	cp toolchain/.config configs/ct-ng.config

.PHONY: ct-ng-%
ct-ng-%:
	cd toolchain && ct-ng $*

.PHONY: install-%
install-%:
	cp output/images/bzImage /boot/bzImage-buildroot
	dd if=output/images/rootfs.ext4 of=/dev/$*
