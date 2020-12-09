################################################################################
#
# alpine-keys
#
################################################################################

ALPINE_KEYS_VERSION = 2.4-r1
ALPINE_KEYS_SITE = https://nl.alpinelinux.org/alpine/latest-stable/main/x86_64
ALPINE_KEYS_SOURCE = alpine-keys-$(ALPINE_KEYS_VERSION).apk
ALPINE_KEYS_LICENSE = GPL-2.0
ALPINE_KEYS_STRIP_COMPONENTS = 0
INFLATE.apk ?= $(ZCAT)

ifeq ($(BR2_arm)$(BR2_ARM_CPU_HAS_FPU),yy)
ALPINE_KEYS_RSA_PUB= alpine-devel@lists.alpinelinux.org-524d27bb.rsa.pub \
		     alpine-devel@lists.alpinelinux.org-616a9724.rsa.pub
endif # BR2_arm BR2_ARM_CPU_HAS_FPU
ifeq ($(BR2_ARM_CPU_ARMV7A),y)
ALPINE_KEYS_RSA_PUB = alpine-devel@lists.alpinelinux.org-524d27bb.rsa.pub \
		      alpine-devel@lists.alpinelinux.org-616adfeb.rsa.pub
endif # BR2_ARM_CPU_ARMV7A
ifeq ($(BR2_aarch64),y)
ALPINE_KEYS_RSA_PUB = alpine-devel@lists.alpinelinux.org-58199dcc.rsa.pub \
		      alpine-devel@lists.alpinelinux.org-616ae350.rsa.pub
endif # BR2_aarch64
ifeq ($(BR2_powerpc64le),y)
ALPINE_KEYS_RSA_PUB = alpine-devel@lists.alpinelinux.org-58cbb476.rsa.pub \
		      alpine-devel@lists.alpinelinux.org-616abc23.rsa.pub
endif # BR2_powerpc64le
ifeq ($(BR2_mips64),y)
ALPINE_KEYS_RSA_PUB = alpine-devel@lists.alpinelinux.org-5e69ca50.rsa.pub
endif # BR2_mips64
ifeq ($(BR2_riscv)$(BR2_RISCV_64)$(BR2_RISCV_ABI_LP64D),yyy)
ALPINE_KEYS_RSA_PUB= alpine-devel@lists.alpinelinux.org-60ac2099.rsa.pub \
		     alpine-devel@lists.alpinelinux.org-616db30d.rsa.pub
endif # BR2_riscv
ifeq ($(BR2_s390x),y)
ALPINE_KEYS_RSA_PUB = alpine-devel@lists.alpinelinux.org-58e4f17d.rsa.pub \
		      alpine-devel@lists.alpinelinux.org-616ac3bc.rsa.pub
endif # BR2_s390x
ifeq ($(BR2_i386),y)
ALPINE_KEYS_RSA_PUB = alpine-devel@lists.alpinelinux.org-5243ef4b.rsa.pub \
		      alpine-devel@lists.alpinelinux.org-61666e3f.rsa.pub \
		      alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub
endif # BR2_i386
ifeq ($(BR2_x86_64),y)
ALPINE_KEYS_RSA_PUB = alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub \
		      alpine-devel@lists.alpinelinux.org-5261cecb.rsa.pub \
		      alpine-devel@lists.alpinelinux.org-6165ee59.rsa.pub
endif # BR2_x86_64

define HOST_ALPINE_KEYS_INSTALL_CMDS
	$(foreach key,$(ALPINE_KEYS_RSA_PUB),\
		$(INSTALL) -D -m 0644 $(@D)/usr/share/apk/keys/$(key) $(HOST_DIR)/etc/apk/keys/$(key); \
	)
endef

$(eval $(host-generic-package))
