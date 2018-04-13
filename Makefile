.PHONY: default
default:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/defconfig -C buildroot

%:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/defconfig -C buildroot $*

.PHONY: toolchain
toolchain:
	$(MAKE) O=$(CURDIR)/toolchain BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/toolchain.config -C buildroot

.PHONY: toolchain-%
toolchain-%:
	$(MAKE) O=$(CURDIR)/toolchain BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/toolchain.config -C buildroot $*

.PHONY: install-%
install-%:
	cp xen.cfg /boot/
	cp output/images/xen.efi /boot/xen-buildroot.efi
	cp output/images/bzImage /boot/bzImage-buildroot
	dd if=output/images/rootfs.ext4 of=/dev/$*
