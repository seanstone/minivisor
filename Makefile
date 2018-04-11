.PHONY: default
default:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) -C buildroot

%:
	$(MAKE) O=$(CURDIR)/output BR2_EXTERNAL=$(CURDIR) -C buildroot $*

#linux-menuconfig: host-ccache
