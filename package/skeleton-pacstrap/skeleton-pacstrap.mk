################################################################################
#
# skeleton-pacstrap
#
################################################################################

SKELETON_PACSTRAP_INSTALL_STAGING = YES

SKELETON_PACSTRAP_DEPENDENCIES = host-arch-install-scripts host-iamroot host-pacman host-pacman-mirrorlist

ifeq ($(BR2_PACKAGE_HOST_ARCHLINUX_KEYRING),y)
SKELETON_PACSTRAP_DEPENDENCIES += host-archlinux-keyring
SKELETON_PACSTRAP_KEYRINGS += archlinux
endif
ifeq ($(BR2_PACKAGE_HOST_ARCHLINUX32_KEYRING),y)
SKELETON_PACSTRAP_DEPENDENCIES += host-archlinux32-keyring
SKELETON_PACSTRAP_KEYRINGS += archlinux32
endif
ifeq ($(BR2_PACKAGE_HOST_ARCHLINUXARM_KEYRING),y)
SKELETON_PACSTRAP_DEPENDENCIES += host-archlinuxarm-keyring
SKELETON_PACSTRAP_KEYRINGS += archlinuxarm
endif
ifeq ($(BR2_PACKAGE_HOST_ARCHPOWER_KEYRING),y)
SKELETON_PACSTRAP_DEPENDENCIES += host-archpower-keyring
SKELETON_PACSTRAP_KEYRINGS += archpower
endif
ifeq ($(BR2_PACKAGE_HOST_ARCHRISCV_KEYRING),y)
SKELETON_PACSTRAP_DEPENDENCIES += host-archriscv-keyring
SKELETON_PACSTRAP_KEYRINGS += archlinux
endif
ifeq ($(BR2_PACKAGE_HOST_MANJARO_KEYRING),y)
SKELETON_PACSTRAP_DEPENDENCIES += host-manjaro-keyring
SKELETON_PACSTRAP_KEYRINGS += manjaro
endif

SKELETON_PACSTRAP_PACKAGES = $(call qstrip,$(BR2_PACKAGE_SKELETON_PACSTRAP_PACKAGES))
ifeq ($(SKELETON_PACSTRAP_PACKAGES),)
SKELETON_PACSTRAP_PACKAGES = base
endif

SKELETON_PACSTRAP_ARCH = $(call qstrip,$(BR2_ARCH))
SKELETON_PACSTRAP_ENV += IAMROOT_DEFLIB=/lib:/usr/lib

SKELETON_PACSTRAP_CONFIGURATION = $(call qstrip,$(BR2_PACKAGE_SKELETON_PACSTRAP_CONFIGURATION))
ifeq ($(SKELETON_PACSTRAP_CONFIGURATION),)
SKELETON_PACSTRAP_CONFIGURATION = $(SKELETON_PACSTRAP_PKGDIR)/pacman.conf
endif

SKELETON_PACSTRAP_ARCH = $(call qstrip,$(BR2_ARCH))
SKELETON_PACSTRAP_ENV += IAMROOT_DEFLIB=/lib:/usr/lib
SKELETON_PACSTRAP_ENV += IAMROOT_DEFLIB_AARCH64_LINUX_AARCH64_1=/lib:/usr/lib
SKELETON_PACSTRAP_ENV += IAMROOT_DEFLIB_POWERPC64LE_2=/lib:/usr/lib
SKELETON_PACSTRAP_ENV += IAMROOT_DEFLIB_POWERPC64_2=/lib:/usr/lib
SKELETON_PACSTRAP_ENV += IAMROOT_DEFLIB_RISCV64_LINUX_RISCV64_LP64D_1=/lib:/usr/lib

define SKELETON_PACSTRAP_BUILD_CMDS
	rm -Rf $(@D)/rootfs/
	mkdir -p $(@D)/rootfs/
	if [ -n "$(SKELETON_PACSTRAP_CONFIGURATION)" ]; then \
		$(INSTALL) -D -m 0644 $(SKELETON_PACSTRAP_CONFIGURATION) $(HOST_DIR)/etc/pacman.conf; \
	else \
		$(INSTALL) -D -m 0644 $(SKELETON_PACSTRAP_PKGDIR)/pacman.conf $(@D)/pacman.conf; \
		$(SED) '/Include = mirrorlist/s,= mirrorlist,= $(@D)/mirrorlist,' $(@D)/pacman.conf; \
		$(INSTALL) -D -m 0644 $(HOST_DIR)/etc/pacman.d/mirrorlist $(@D)/mirrorlist; \
		$(SED) '/#Server = /s,^#,,' $(@D)/mirrorlist; \
	fi
	PATH=$(BR_PATH) ish -c "pacman-key --init"
	if [ "$(SKELETON_PACSTRAP_KEYRINGS)" ]; then \
		PATH=$(BR_PATH) ish -c "pacman-key --populate $(SKELETON_PACSTRAP_KEYRINGS)"; \
	fi
	( cd $(@D) && $(TARGET_MAKE_ENV) $(SKELETON_PACSTRAP_ENV) ish -c "pacstrap -GMC $(HOST_DIR)/etc/pacman.conf $(@D)/rootfs $(SKELETON_PACSTRAP_PACKAGES) --arch $(ARCH) --dbpath $(@D)/rootfs/var/lib/pacman" )
endef

define SKELETON_PACSTRAP_INSTALL_TARGET_CMDS
	$(call SYSTEM_RSYNC,$(@D)/rootfs,$(TARGET_DIR))
endef

# For the staging dir, we install nothing, but we need the /lib and /usr/lib
# appropriately setup.
define SKELETON_PACSTRAP_INSTALL_STAGING_CMDS
	$(call SYSTEM_BIN_SBIN_LIB_DIRS,$(STAGING_DIR))
	$(call SYSTEM_USR_SYMLINKS_OR_DIRS,$(STAGING_DIR))
	$(call SYSTEM_LIB_SYMLINK,$(STAGING_DIR))
endef

$(eval $(generic-package))
