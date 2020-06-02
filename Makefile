.PHONY: default
default: all

%:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/defconfig -C buildroot $*

.PHONY: install-%
install-%:
	cp output/images/bzImage /boot/bzImage-buildroot
	dd if=output/images/rootfs.ext4 of=/dev/$*
