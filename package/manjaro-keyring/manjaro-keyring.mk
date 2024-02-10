################################################################################
#
# manjaro-keyring
#
################################################################################

MANJARO_KEYRING_VERSION = e79dce9f7cf111cfe987c6e91c69062c418377cd
MANJARO_KEYRING_SITE = https://gitlab.manjaro.org/packages/core/manjaro-keyring/-/archive/$(MANJARO_KEYRING_VERSION)
MANJARO_KEYRING_SOURCE = manjaro-keyring-$(MANJARO_KEYRING_VERSION).tar.gz
MANJARO_KEYRING_LICENSE = GPL-2.0

define HOST_MANJARO_KEYRING_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
