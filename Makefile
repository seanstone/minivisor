.PHONY: default
default:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/defconfig -C buildroot

%:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/defconfig -C buildroot $*

.PHONY: toolchain
toolchain:
	$(MAKE) O=$(CURDIR)/toolchain BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/toolchain.config -C buildroot

.PHONY: toolchain-%
toolchain-%:
	$(MAKE) O=$(CURDIR)/toolchain BR2_EXTERNAL=$(CURDIR) BR2_DEFCONFIG=$(CURDIR)/configs/toolchain.config -C buildroot $*

.PHONY: install-%
install-%:
	cp configs/xen.cfg /boot/
	cp output/images/xen.efi /boot/xen-buildroot.efi
	cp output/images/bzImage /boot/bzImage-buildroot
	dd if=output/images/rootfs.ext4 of=/dev/$*

.PHONY: ct-ng-%
ct-ng-%:
	ct-ng -C ct-ng $*
