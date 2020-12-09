################################################################################
#
# alpine-keys
#
################################################################################

ALPINE_KEYS_VERSION = 2.4-r1
ALPINE_KEYS_SITE = https://nl.alpinelinux.org/alpine/latest-stable/main/$(ARCH)
ALPINE_KEYS_SOURCE = alpine-keys-$(ALPINE_KEYS_VERSION).apk
ALPINE_KEYS_LICENSE = GPL-2.0
ALPINE_KEYS_STRIP_COMPONENTS = 0
INFLATE.apk ?= $(ZCAT)

define HOST_ALPINE_KEYS_INSTALL_CMDS
	$(INSTALL) -d $(HOST_DIR)/etc/apk/keys
	$(INSTALL) -m 0644 $(@D)/etc/apk/keys/*.rsa.pub $(HOST_DIR)/etc/apk/keys/
	$(INSTALL) -d $(HOST_DIR)/share/apk/keys
	$(INSTALL) -m 0644 $(@D)/usr/share/apk/keys/*.rsa.pub $(HOST_DIR)/share/apk/keys/
endef

$(eval $(host-generic-package))
