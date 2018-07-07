# 
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
ifeq ($(DUMP),1)
  KERNEL:=<KERNEL>
  BOARD:=<BOARD>
  LINUX_VERSION:=<LINUX_VERSION>
else

  include $(TOPDIR)/.kernel.mk
  include $(INCLUDE_DIR)/target.mk

  # check to see if .kernel.mk matches target.mk
  ifeq ($(CONFIG_BOARD)-$(CONFIG_KERNEL),$(BOARD)-$(KERNEL))
     LINUX_VERSION:=$(CONFIG_LINUX_VERSION)
     LINUX_RELEASE:=$(CONFIG_LINUX_RELEASE)
     LINUX_KARCH:=$(CONFIG_LINUX_KARCH)
  else
  # oops, old .kernel.config; rebuild it (hiding the misleading errors this produces)
    $(warning rebuilding .kernel.mk)
    $(TOPDIR)/.kernel.mk: FORCE
	@$(MAKE) -C $(TOPDIR)/target/linux/$(BOARD)-$(KERNEL) $@ &>/dev/null
  endif

  ifeq ($(KERNEL),2.6)
    LINUX_KMOD_SUFFIX=ko
  else
    LINUX_KMOD_SUFFIX=o
  endif

  KERNELNAME=
  ifneq (,$(findstring x86,$(BOARD)))
    KERNELNAME="bzImage"
  endif
  ifneq (,$(findstring ppc,$(BOARD)))
    KERNELNAME="uImage"
  endif

  ifneq (,$(findstring uml,$(BOARD)))
    LINUX_KARCH:=um
    KERNEL_CC:=$(HOSTCC)
    KERNEL_CROSS:=
  else
    KERNEL_CC:=$(TARGET_CC)
    KERNEL_CROSS:=$(TARGET_CROSS)
  endif

  KERNEL_BUILD_DIR:=$(BUILD_DIR)/linux-$(KERNEL)-$(BOARD)
  LINUX_DIR := $(KERNEL_BUILD_DIR)/linux-$(LINUX_VERSION)

  MODULES_SUBDIR:=lib/modules/$(LINUX_VERSION)
  MODULES_DIR := $(KERNEL_BUILD_DIR)/modules/$(MODULES_SUBDIR)
  TARGET_MODULES_DIR := $(LINUX_TARGET_DIR)/$(MODULES_SUBDIR)
  KMOD_BUILD_DIR := $(KERNEL_BUILD_DIR)/linux-modules

  LINUX_KERNEL:=$(KERNEL_BUILD_DIR)/vmlinux
endif

# FIXME: remove this crap
define KMOD_template
ifeq ($$(strip $(4)),)
KDEPEND_$(1):=m
else
KDEPEND_$(1):=$($(4))
endif

IDEPEND_$(1):=kernel ($(LINUX_VERSION)-$(BOARD)-$(LINUX_RELEASE)) $(foreach pkg,$(5),", $(pkg)")

PKG_$(1) := $(PACKAGE_DIR)/kmod-$(2)_$(LINUX_VERSION)-$(BOARD)-$(LINUX_RELEASE)_$(ARCH).ipk
I_$(1) := $(KMOD_BUILD_DIR)/ipkg/$(2)

ifeq ($$(KDEPEND_$(1)),m)
ifneq ($$(CONFIG_PACKAGE_KMOD_$(1)),)
TARGETS += $$(PKG_$(1))
endif
ifeq ($$(CONFIG_PACKAGE_KMOD_$(1)),y)
INSTALL_TARGETS += $$(PKG_$(1))
endif
endif

$$(PKG_$(1)): $(LINUX_DIR)/.modules_done
	rm -rf $$(I_$(1))
	$(SCRIPT_DIR)/make-ipkg-dir.sh $$(I_$(1)) ../control/kmod-$(2).control $(LINUX_VERSION)-$(BOARD)-$(LINUX_RELEASE) $(ARCH)
	echo "Depends: $$(IDEPEND_$(1))" >> $$(I_$(1))/CONTROL/control
ifneq ($(strip $(3)),)
	mkdir -p $$(I_$(1))/lib/modules/$(LINUX_VERSION)
	$(CP) $(3) $$(I_$(1))/lib/modules/$(LINUX_VERSION)
endif
ifneq ($(6),)
	mkdir -p $$(I_$(1))/etc/modules.d
	for module in $(7); do \
		echo $$$$module >> $$(I_$(1))/etc/modules.d/$(6)-$(2); \
	done
	echo "#!/bin/sh" >> $$(I_$(1))/CONTROL/postinst
	echo "[ -z \"\$$$$IPKG_INSTROOT\" ] || exit" >> $$(I_$(1))/CONTROL/postinst
	echo ". /etc/functions.sh" >> $$(I_$(1))/CONTROL/postinst
	echo "load_modules /etc/modules.d/$(6)-$(2)" >> $$(I_$(1))/CONTROL/postinst
	chmod 0755 $$(I_$(1))/CONTROL/postinst
endif
	$(8)
	$(IPKG_BUILD) $$(I_$(1)) $(PACKAGE_DIR)
endef

