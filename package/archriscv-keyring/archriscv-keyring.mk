################################################################################
#
# archriscv-keyring
#
################################################################################

ARCHRISCV_KEYRING_VERSION = 20231222-1
ARCHRISCV_KEYRING_SITE = https://archriscv.felixc.at/repo/core
ARCHRISCV_KEYRING_SOURCE = archlinux-keyring-$(ARCHRISCV_KEYRING_VERSION)-any.pkg.tar.zst
ARCHRISCV_KEYRING_STRIP_COMPONENTS = 0
ARCHRISCV_KEYRING_LICENSE = GPL-2.0

define HOST_ARCHRISCV_KEYRING_INSTALL_CMDS
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archlinux.gpg $(HOST_DIR)/usr/share/pacman/keyrings/archlinux.gpg
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archlinux-trusted $(HOST_DIR)/usr/share/pacman/keyrings/archlinux-trusted
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archlinux-revoked $(HOST_DIR)/usr/share/pacman/keyrings/archlinux-revoked
endef

$(eval $(host-generic-package))
