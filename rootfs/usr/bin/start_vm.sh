#!/bin/sh

#ip tuntap add dev tap0 mode tap
#ip link set tap0 up promisc on
#ip link set dev virbr0 up
#ip link set dev tap0 master virbr0

echo 1 > /sys/module/kvm/parameters/ignore_msrs

MY_OPTIONS="+pcid,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check"

qemu-system-x86_64 -enable-kvm -m 8192 -cpu host,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,$MY_OPTIONS \
	  -machine q35 \
	  -usb -device usb-kbd -device usb-mouse \
	  -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
	  -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF_CODE.fd \
	  -drive if=pflash,format=raw,file=/usr/share/OVMF_VARS-1024x768.fd \
	  -smbios type=2 \
	  -device ich9-intel-hda -device hda-duplex \
	  -device ich9-ahci,id=sata \
	  -drive id=OpenCoreBoot,if=none,snapshot=on,format=qcow2,file='/usr/share/OpenCore.qcow2' \
	  -device ide-hd,bus=sata.2,drive=OpenCoreBoot \
	  -drive id=MacHDD,if=none,file=/dev/sda9,format=raw \
	  -device ide-hd,bus=sata.4,drive=MacHDD \
	  -monitor stdio \
	  -vga vmware \
	  -display fbdev \
	  -device usb-host,hostbus=1,hostport=3

#-netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
