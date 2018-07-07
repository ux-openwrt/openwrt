# 
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(INCLUDE_DIR)/netfilter.mk

# Networking

$(eval $(call KMOD_template,ATM,atm,\
	$(MODULES_DIR)/kernel/net/atm/atm.o \
	$(MODULES_DIR)/kernel/net/atm/br2684.o \
,CONFIG_ATM,,50,atm))

# Block devices

$(eval $(call KMOD_template,LOOP,loop,\
    $(MODULES_DIR)/kernel/drivers/block/loop.o \
,CONFIG_BLK_DEV_LOOP,,20,loop))

$(eval $(call KMOD_template,NBD,nbd,\
    $(MODULES_DIR)/kernel/drivers/block/nbd.o \
,CONFIG_BLK_DEV_NBD,,20,nbd))


# Filesystems

$(eval $(call KMOD_template,FS_CIFS,fs-cifs,\
	$(MODULES_DIR)/kernel/fs/cifs/cifs.o \
,CONFIG_CIFS,,30,cifs))

$(eval $(call KMOD_template,FS_MINIX,fs-minix,\
	$(MODULES_DIR)/kernel/fs/minix/*.o \
,CONFIG_MINIX_FS,,30,minix))

$(eval $(call KMOD_template,FS_EXT2,fs-ext2,\
	$(MODULES_DIR)/kernel/fs/ext2/*.o \
,CONFIG_EXT2_FS,,30,ext2))

$(eval $(call KMOD_template,FS_EXT3,fs-ext3,\
	$(MODULES_DIR)/kernel/fs/ext3/*.o \
	$(MODULES_DIR)/kernel/fs/jbd/*.o \
,CONFIG_EXT3_FS,,30,jbd ext3))

$(eval $(call KMOD_template,FS_HFSPLUS,fs-hfsplus,\
	$(MODULES_DIR)/kernel/fs/hfsplus/*.o \
,CONFIG_HFSPLUS_FS,,30,hfsplus))

$(eval $(call KMOD_template,FS_NFS,fs-nfs,\
	$(MODULES_DIR)/kernel/fs/lockd/*.o \
	$(MODULES_DIR)/kernel/fs/nfs/*.o \
	$(MODULES_DIR)/kernel/net/sunrpc/*.o \
,CONFIG_NFS_FS,,30,sunrpc lockd nfs))

$(eval $(call KMOD_template,FS_VFAT,fs-vfat,\
	$(MODULES_DIR)/kernel/fs/vfat/vfat.o \
	$(MODULES_DIR)/kernel/fs/fat/fat.o \
,CONFIG_VFAT_FS,,30,fat vfat))

$(eval $(call KMOD_template,FS_XFS,fs-xfs,\
	$(MODULES_DIR)/kernel/fs/xfs/*.o \
,CONFIG_XFS_FS,,30,xfs))


# Multimedia

$(eval $(call KMOD_template,PWC,pwc,\
	$(MODULES_DIR)/kernel/drivers/usb/pwc.o \
,CONFIG_USB_PWC,kmod-videodev,63,pwc))

$(eval $(call KMOD_template,SOUNDCORE,soundcore,\
	$(MODULES_DIR)/kernel/drivers/sound/soundcore.o \
,CONFIG_SOUND,,30,soundcore))

$(eval $(call KMOD_template,VIDEODEV,videodev,\
	$(MODULES_DIR)/kernel/drivers/media/video/videodev.o \
,CONFIG_VIDEO_DEV,,62,videodev))


# Network devices

$(eval $(call KMOD_template,NET_AIRO,net-airo,\
	$(MODULES_DIR)/kernel/drivers/net/wireless/airo.o \
,CONFIG_AIRO,,10,airo))

$(eval $(call KMOD_template,NET_HERMES,net-hermes,\
	$(MODULES_DIR)/kernel/drivers/net/wireless/hermes.o \
	$(MODULES_DIR)/kernel/drivers/net/wireless/orinoco.o \
,CONFIG_HERMES,,10,hermes orinoco))

$(eval $(call KMOD_template,NET_HERMES_PCI,net-hermes-pci,\
	$(MODULES_DIR)/kernel/drivers/net/wireless/orinoco_pci.o \
,CONFIG_PCI_HERMES,kmod-net-hermes,11,orinoco_pci))

$(eval $(call KMOD_template,NET_HERMES_PCI,net-hermes-plx,\
	$(MODULES_DIR)/kernel/drivers/net/wireless/orinoco_plx.o \
,CONFIG_PLX_HERMES,kmod-net-hermes,11,orinoco_plx))

$(eval $(call KMOD_template,NET_PRISM54,net-prism54,\
	$(MODULES_DIR)/kernel/drivers/net/wireless/prism54/prism54.o \
,CONFIG_PRISM54,,10,prism54))


# PCMCIA/CardBus

$(eval $(call KMOD_template,PCMCIA_CORE,pcmcia-core,\
	$(MODULES_DIR)/kernel/drivers/pcmcia/pcmcia_core.o \
	$(MODULES_DIR)/kernel/drivers/pcmcia/yenta_socket.o \
	$(MODULES_DIR)/kernel/drivers/pcmcia/ds.o \
,CONFIG_PCMCIA,,50,pcmcia_core yenta_socket ds))

$(eval $(call KMOD_template,PCMCIA_SERIAL,pcmcia-serial,\
	$(MODULES_DIR)/kernel/drivers/char/pcmcia/serial_cs.o \
,CONFIG_PCMCIA_SERIAL_CS,kmod-pcmcia-core,51,serial_cs))


# USB

$(eval $(call KMOD_template,USB,usb-core,\
	$(MODULES_DIR)/kernel/drivers/usb/usbcore.o \
,CONFIG_USB,,50,usbcore))

$(eval $(call KMOD_template,USB_OHCI,usb-ohci,\
	$(MODULES_DIR)/kernel/drivers/usb/host/usb-ohci.o \
,CONFIG_USB_OHCI,kmod-usb-core,60,usb-ohci))

$(eval $(call KMOD_template,USB_UHCI,usb-uhci,\
	$(MODULES_DIR)/kernel/drivers/usb/host/uhci.o \
,CONFIG_USB_UHCI_ALT,kmod-usb-core,60,uhci))

$(eval $(call KMOD_template,USB2,usb2,\
	$(MODULES_DIR)/kernel/drivers/usb/host/ehci-hcd.o \
,CONFIG_USB_EHCI_HCD,kmod-usb-core,60,ehci-hcd))

$(eval $(call KMOD_template,USB_ACM,usb-acm,\
	$(MODULES_DIR)/kernel/drivers/usb/acm.o \
,CONFIG_USB_ACM))

$(eval $(call KMOD_template,USB_AUDIO,usb-audio,\
	$(MODULES_DIR)/kernel/drivers/usb/audio.o \
,CONFIG_USB_AUDIO,kmod-soundcore kmod-usb-core,61,audio))

$(eval $(call KMOD_template,USB_PRINTER,usb-printer,\
	$(MODULES_DIR)/kernel/drivers/usb/printer.o \
,CONFIG_USB_PRINTER,kmod-usb-core,60,printer))

$(eval $(call KMOD_template,USB_SERIAL,usb-serial,\
	$(MODULES_DIR)/kernel/drivers/usb/serial/usbserial.o \
,CONFIG_USB_SERIAL,kmod-usb-core,60,usbserial))

$(eval $(call KMOD_template,USB_SERIAL_BELKIN,usb-serial-belkin,\
	$(MODULES_DIR)/kernel/drivers/usb/serial/belkin_sa.o \
,CONFIG_USB_SERIAL_BELKIN,kmod-usb-serial,61,belkin_sa))

$(eval $(call KMOD_template,USB_SERIAL_FTDI,usb-serial-ftdi,\
	$(MODULES_DIR)/kernel/drivers/usb/serial/ftdi_sio.o \
,CONFIG_USB_SERIAL_FTDI_SIO,kmod-usb-serial,61,ftdi_sio))

$(eval $(call KMOD_template,USB_SERIAL_MCT_U232,usb-serial-mct-u232,\
	$(MODULES_DIR)/kernel/drivers/usb/serial/mct_u232.o \
,CONFIG_USB_SERIAL_MCT_U232,kmod-usb-serial,61,mct_u232))

$(eval $(call KMOD_template,USB_SERIAL_PL2303,usb-serial-pl2303,\
	$(MODULES_DIR)/kernel/drivers/usb/serial/pl2303.o \
,CONFIG_USB_SERIAL_PL2303,kmod-usb-serial,61,pl2303))

$(eval $(call KMOD_template,USB_SERIAL_VISOR,usb-serial-visor,\
	$(MODULES_DIR)/kernel/drivers/usb/serial/visor.o \
,CONFIG_USB_SERIAL_VISOR,kmod-usb-serial,61,visor))

$(eval $(call KMOD_template,USB_STORAGE,usb-storage,\
	$(MODULES_DIR)/kernel/drivers/scsi/*.o \
	$(MODULES_DIR)/kernel/drivers/usb/storage/*.o \
,CONFIG_USB_STORAGE,kmod-usb-core,60,scsi_mod sd_mod usb-storage))


# Misc. devices

$(eval $(call KMOD_template,AX25,ax25,\
	$(MODULES_DIR)/kernel/net/ax25/ax25.o \
	$(MODULES_DIR)/kernel/drivers/net/hamradio/mkiss.o \
,CONFIG_AX25,,90,ax25 mkiss))

$(eval $(call KMOD_template,BLUETOOTH,bluetooth,\
	$(MODULES_DIR)/kernel/net/bluetooth/*.o \
	$(MODULES_DIR)/kernel/net/bluetooth/rfcomm/*.o \
	$(MODULES_DIR)/kernel/drivers/bluetooth/*.o \
,CONFIG_BLUEZ))

$(eval $(call KMOD_template,SOFTDOG,softdog,\
	$(MODULES_DIR)/kernel/drivers/char/softdog.o \
,CONFIG_SOFT_WATCHDOG,,95,softdog))



