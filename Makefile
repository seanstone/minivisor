.PHONY: default
default:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/defconfig -C buildroot

%:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/defconfig -C buildroot $*

.PHONY: ct-ng-%
ct-ng-%:
	mkdir -p crosstool-ng/dl
	cd crosstool-ng && DEFCONFIG=$(CURDIR)/configs/ct-ng.config ./ct-ng $*

.PHONY: install-%
install-%:
	cp output/images/bzImage /boot/bzImage-buildroot
	dd if=output/images/rootfs.ext4 of=/dev/$*
