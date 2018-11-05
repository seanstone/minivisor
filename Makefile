.PHONY: default
default:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/defconfig -C buildroot

%:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/defconfig -C buildroot $*

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
