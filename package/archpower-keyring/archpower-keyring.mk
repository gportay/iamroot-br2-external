################################################################################
#
# archpower-keyring
#
################################################################################

ARCHPOWER_KEYRING_VERSION = 20220105-1
ARCHPOWER_KEYRING_SITE = https://repo.archlinuxpower.org/base/any
ARCHPOWER_KEYRING_SOURCE = archpower-keyring-$(ARCHPOWER_KEYRING_VERSION)-any.pkg.tar.zst
ARCHPOWER_KEYRING_STRIP_COMPONENTS = 0
ARCHPOWER_KEYRING_LICENSE = GPL-2.0

define HOST_ARCHPOWER_KEYRING_INSTALL_CMDS
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archpower.gpg $(HOST_DIR)/usr/share/pacman/keyrings/archpower.gpg
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archpower-trusted $(HOST_DIR)/usr/share/pacman/keyrings/archpower-trusted
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archpower-revoked $(HOST_DIR)/usr/share/pacman/keyrings/archpower-revoked
endef

$(eval $(host-generic-package))
