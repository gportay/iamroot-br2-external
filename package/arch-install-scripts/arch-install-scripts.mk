################################################################################
#
# arch-install-scripts
#
################################################################################

ARCH_INSTALL_SCRIPTS_VERSION = 24
ARCH_INSTALL_SCRIPTS_SITE = $(call github,archlinux,arch-install-scripts,v$(ARCH_INSTALL_SCRIPTS_VERSION))
ARCH_INSTALL_SCRIPTS_LICENSE = GPL2
ARCH_INSTALL_SCRIPTS_LICENSE_FILES = COPYING

define HOST_ARCH_INSTALL_SCRIPTS_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
