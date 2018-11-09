#!/bin/sh
qemu-system-x86_64 \
	-m 6144 \
	-enable-kvm \
	-cpu core2duo,vendor=GenuineIntel \
	-smp 2,sockets=1,cores=2,threads=1 \
	-rtc clock=vm,base=localtime \
	-smbios type=2 \
	-machine accel=kvm,usb=off,vmport=off,kernel_irqchip=on \
	-device i82801b11-bridge,id=pci.1,bus=pci.0,addr=0x1e \
	-device pci-bridge,chassis_nr=2,id=pci.2,bus=pci.1,addr=0x1 \
	-device ahci,id=sata0,bus=pci.2,addr=0x5 \
	-drive file=/dev/sda12,if=none,media=disk,id=drive-sata0-0-0,format=raw \
	-device ide-hd,bus=sata0.0,drive=drive-sata0-0-0,id=sata0-0-0,bootindex=1 \
	-usb \
	-device usb-mouse \
	-device usb-kbd \
	-display fbdev \
	-drive file=/usr/share/ovmf/ovmf_code_x64.bin,if=pflash,format=raw,unit=0,readonly=on \
	-drive file=/usr/share/ovmf/ovmf_vars_x64.bin,if=pflash,format=raw,unit=1 \
