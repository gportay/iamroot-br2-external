################################################################################
#
# archlinuxriscv-keyring
#
################################################################################

ARCHLINUXRISCV_KEYRING_VERSION = 20240208-1
ARCHLINUXRISCV_KEYRING_SITE = https://archriscv.felixc.at/repo/core
ARCHLINUXRISCV_KEYRING_SOURCE = archlinux-keyring-$(ARCHLINUXRISCV_KEYRING_VERSION)-any.pkg.tar.zst
ARCHLINUXRISCV_KEYRING_STRIP_COMPONENTS = 0
ARCHLINUXRISCV_KEYRING_LICENSE = GPL-2.0

define HOST_ARCHLINUXRISCV_KEYRING_INSTALL_CMDS
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archlinux.gpg $(HOST_DIR)/usr/share/pacman/keyrings/archlinux.gpg
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archlinux-trusted $(HOST_DIR)/usr/share/pacman/keyrings/archlinux-trusted
	$(INSTALL) -D -m0644 $(@D)/usr/share/pacman/keyrings/archlinux-revoked $(HOST_DIR)/usr/share/pacman/keyrings/archlinux-revoked
endef

$(eval $(host-generic-package))
