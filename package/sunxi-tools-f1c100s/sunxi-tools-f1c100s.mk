################################################################################
#
# sunxi-tools
#
################################################################################

SUNXI_TOOLS_F1C100S_SITE = https://github.com/Icenowy/sunxi-tools/archive/refs/heads
SUNXI_TOOLS_F1C100S_SOURCE = f1c100s-spiflash.tar.gz
SUNXI_TOOLS_F1C100S_LICENSE = GPL-2.0+
SUNXI_TOOLS_F1C100S_LICENSE_FILES = LICENSE.md
HOST_SUNXI_TOOLS_F1C100S_DEPENDENCIES = host-libusb host-pkgconf
HOST_SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_HOST_SUNXI_TOOLS_F1C100S_FEL) += sunxi-fel
FEX2BIN = $(HOST_DIR)/bin/fex2bin

SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_FEXC) += sunxi-fexc
SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_BOOTINFO) += sunxi-bootinfo
SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_FEL) += sunxi-fel
SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_NAND_PART) += sunxi-nand-part
SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_PIO) += sunxi-pio
SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_MEMINFO) += sunxi-meminfo
SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_PHOENIX_INFO) += phoenix_info
SUNXI_TOOLS_F1C100S_TARGETS_$(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_NAND_IMAGE_BUILDER) += \
	sunxi-nand-image-builder

ifeq ($(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_FEXC),y)
SUNXI_TOOLS_F1C100S_FEXC_LINKS += fex2bin bin2fex
endif

ifeq ($(BR2_PACKAGE_SUNXI_TOOLS_F1C100S_FEL),y)
SUNXI_TOOLS_F1C100S_DEPENDENCIES += libusb host-pkgconf zlib
endif

ifeq ($(BR2_PACKAGE_HOST_SUNXI_TOOLS_F1C100S_FEL),y)
HOST_SUNXI_TOOLS_F1C100S_DEPENDENCIES += host-zlib
endif

define HOST_SUNXI_TOOLS_F1C100S_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) CROSS_COMPILE="" CC="$(HOSTCC)" \
		PREFIX=$(HOST_DIR) EXTRA_CFLAGS="$(HOST_CFLAGS)" \
		LDFLAGS="$(HOST_LDFLAGS)" -C $(@D) $(HOST_SUNXI_TOOLS_F1C100S_TARGETS_y)
endef

define HOST_SUNXI_TOOLS_F1C100S_INSTALL_CMDS
	$(foreach t,$(HOST_SUNXI_TOOLS_F1C100S_TARGETS_y), \
		$(INSTALL) -D -m 0755 $(@D)/$(t) $(HOST_DIR)/bin/$(t)
	)
endef

define SUNXI_TOOLS_F1C100S_BUILD_CMDS
	$(foreach t,$(SUNXI_TOOLS_F1C100S_TARGETS_y), \
		$(TARGET_MAKE_ENV) $(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
			CC="$(TARGET_CC)" PREFIX=/usr \
			EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
			LDFLAGS="$(TARGET_LDFLAGS)" -C $(@D) $(t)
	)
endef

define SUNXI_TOOLS_F1C100S_INSTALL_TARGET_CMDS
	$(foreach t,$(SUNXI_TOOLS_F1C100S_TARGETS_y), \
		$(INSTALL) -D -m 0755 $(@D)/$(t) $(TARGET_DIR)/usr/bin/$(t)
	)
	$(foreach t,$(SUNXI_TOOLS_F1C100S_FEXC_LINKS), \
		ln -nfs sunxi-fexc $(TARGET_DIR)/usr/bin/$(t)
	)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
