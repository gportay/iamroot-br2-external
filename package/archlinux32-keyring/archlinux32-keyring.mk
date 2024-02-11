################################################################################
#
# archlinux32-keyring
#
################################################################################

ARCHLINUX32_KEYRING_VERSION = 20240131
ARCHLINUX32_KEYRING_SITE = https://sources.archlinux32.org/sources
ARCHLINUX32_KEYRING_SOURCE = archlinux32-keyring-v$(ARCHLINUX32_KEYRING_VERSION).tar.gz
ARCHLINUX32_KEYRING_LICENSE = GPL-2.0

define HOST_ARCHLINUX32_KEYRING_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
