################################################################################
#
# archlinux-keyring
#
################################################################################

ARCHLINUX_KEYRING_VERSION = 20240208
ARCHLINUX_KEYRING_SITE = https://gitlab.archlinux.org/archlinux/archlinux-keyring/-/archive/$(ARCHLINUX_KEYRING_VERSION)
ARCHLINUX_KEYRING_LICENSE = GPL-3.0+
HOST_ARCHLINUX_KEYRING_DEPENDENCIES = host-pkgconf host-python3 host-sequoia-sq

define HOST_ARCHLINUX_KEYRING_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=$(HOST_DIR) build
endef

define HOST_ARCHLINUX_KEYRING_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=$(HOST_DIR) SYSTEMD_SYSTEM_UNIT_DIR=$(HOST_DIR)/usr/lib/systemd/system install
endef

$(eval $(host-generic-package))
