################################################################################
#
# iamroot
#
################################################################################

IAMROOT_VERSION = 22
IAMROOT_SITE = $(call github,gportay,iamroot,v$(IAMROOT_VERSION))
IAMROOT_LICENSE = LGPL-2.1+, and MIT (contains sources from musl)
IAMROOT_LICENSE_FILES = LICENSE COPYRIGHT.musl

HOST_IAMROOT_DEPENDENCIES += toolchain

HOST_IAMROOT_MAKE_ENV += PREFIX=$(HOST_DIR)

# Host machines:
#  - ARM 64-bit
#  - Intel x86 64-bit
HOST_IAMROOT_HOST_TOOLCHAIN_MACHINE = $(shell $(HOSTCC) -dumpmachine)
HOST_IAMROOT_HOST_TOOLCHAIN_USES_GLIBC = $(if $(findstring gnu,$(HOST_IAMROOT_HOST_TOOLCHAIN_MACHINE)),y,)
HOST_IAMROOT_HOST_TOOLCHAIN_USES_MUSL = $(if $(findstring musl,$(HOST_IAMROOT_HOST_TOOLCHAIN_MACHINE)),y,)

ifeq ($(HOSTARCH),aarch64)
ifeq ($(HOST_IAMROOT_HOST_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_HOST_LIB = libiamroot-linux-aarch64.so.1
endif # glibc

ifeq ($(HOST_IAMROOT_HOST_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_HOST_LIB = libiamroot-musl-aarch64.so.1
endif # musl
endif # aarch64

ifeq ($(HOSTARCH),x86_64)
ifeq ($(HOST_IAMROOT_HOST_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_HOST_LIB = libiamroot-linux-x86-64.so.2
endif # glibc

ifeq ($(HOST_IAMROOT_HOST_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_HOST_LIB = libiamroot-musl-x86_64.so.1
endif # musl
endif # x86_64

ifeq ($(HOST_IAMROOT_HOST_LIB),)
$(error The host toolchain is not supported. Report this failure to the package developer)
endif

# Target machines:
#  - ARM 32-bit, ARM 64-bit and ARM 64-bit big endian
#  - MIPS little endian and MIPS 64-bit little endian
#  - PowerPC 64-bit and PowerPC 64-bit little endian
#  - RISC-V 64-bit
#  - IBM System z 64-bit
#  - Intel x86 32-bit and 64-bit
ifeq ($(BR2_arm),y)
ifeq ($(BR2_ARM_EABI),y)
IAMROOT_ARCH = arm
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-linux.so.3
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-arm.so.1
endif # musl
endif # BR2_ARM_EABI

ifeq ($(BR2_ARM_EABIHF),y)
IAMROOT_ARCH = armhf
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-linux-armhf.so.3
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-armhf.so.1
endif # musl
endif # BR2_ARM_EABIHF
endif # BR2_arm

ifeq ($(BR2_aarch64),y)
IAMROOT_ARCH = aarch64
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-linux-aarch64.so.1
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-aarch64.so.1
endif # musl
endif # BR2_aarch64

ifeq ($(BR2_aarch64_be),y)
IAMROOT_ARCH = aarch64_be
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-linux-aarch64_be.so.1
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-aarch64_be.so.1
endif # musl
endif # BR2_aarch64_be

ifeq ($(BR2_mips),y)
IAMROOT_ARCH = mips
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot.so.1
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-mips.so.1
endif # musl
endif # BR2_mips

ifeq ($(BR2_mipsel),y)
IAMROOT_ARCH = mipsle
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot.so.1
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-mipsel.so.1
endif # musl
endif # BR2_mipsel

ifeq ($(BR2_mips64),y)
IAMROOT_ARCH = mips64
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot.so.1
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-mips64.so.1
endif # musl
endif # BR2_mips64

ifeq ($(BR2_mips64el),y)
IAMROOT_ARCH = mips64le
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot.so.1
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-mips64el.so.1
endif # musl
endif # BR2_mips64el

ifeq ($(BR2_powerpc64),y)
IAMROOT_ARCH = powerpc64
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot.so.2
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-powerpc64.so.1
endif # musl
endif # BR2_powerpc64

ifeq ($(BR2_powerpc64le),y)
IAMROOT_ARCH = powerpc64le
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot.so.2
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-powerpc64le.so.1
endif # musl
endif # BR2_powerpc64le

ifeq ($(BR2_RISCV_64),y)
IAMROOT_ARCH = riscv64
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
ifeq ($(BR2_RISCV_ABI_LP64D),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-linux-riscv64-lp64d.so.1
else
HOST_IAMROOT_TARGET_LIB = libiamroot-linux-riscv64.so.1
endif # BR2_RISCV_ABI_LP64D
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-riscv64.so.1
endif # musl
endif # BR2_RISCV_64

ifeq ($(BR2_s390x),y)
IAMROOT_ARCH = s390x
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot.so.1
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-s390x.so.1
endif # musl
endif # BR2_s390x

ifeq ($(BR2_i386),y)
IAMROOT_ARCH = i686
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-linux.so.2
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-i386.so.1
endif # musl
endif # BR2_i386

ifeq ($(BR2_x86_64),y)
IAMROOT_ARCH = x86_64
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-linux-x86-64.so.2
endif # glibc

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
HOST_IAMROOT_TARGET_LIB = libiamroot-musl-x86_64.so.1
endif # musl
endif # BR2_x86_64

ifeq ($(HOST_IAMROOT_TARGET_LIB),)
$(error The toolchain is not supported. Report this failure to the package developer)
endif

ifeq ($(BR2_i386),y)
IAMROOT_TARGET_CFLAGS = -fno-stack-protector
endif # BR2_i386

define HOST_IAMROOT_BUILD_CMDS
	mkdir -p $(@D)/host
	ln -sf ../ido $(@D)/host/
	ln -sf ../ish $(@D)/host/
	ln -sf ../exec.sh $(@D)/host/
	ln -sf ../Makefile $(@D)/host/
	$(HOST_MAKE_ENV) $(HOST_IAMROOT_MAKE_ENV) $(MAKE) -C $(@D)/host VPATH=$(@D) CC="$(HOSTCC)" NVERBOSE=0
	mkdir -p $(@D)/target
	ln -sf ../ido $(@D)/host/
	ln -sf ../ish $(@D)/target/
	ln -sf ../exec.sh $(@D)/target/
	ln -sf ../Makefile $(@D)/target/
	$(TARGET_MAKE_ENV) $(HOST_IAMROOT_MAKE_ENV) $(MAKE) -C $(@D)/target VPATH=$(@D) CC="$(TARGET_CC)" CFLAGS="$(IAMROOT_TARGET_CFLAGS)" NVERBOSE=0
endef

define HOST_IAMROOT_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(HOST_IAMROOT_MAKE_ENV) $(MAKE) -C $(@D)/host VPATH=$(@D) install-bin
	$(HOST_MAKE_ENV) $(HOST_IAMROOT_MAKE_ENV) $(MAKE) -C $(@D)/host VPATH=$(@D) install-lib
	$(INSTALL) -D -m 0755 $(@D)/host/libiamroot.so $(HOST_DIR)/lib/iamroot/$(HOSTARCH)/$(HOST_IAMROOT_HOST_LIB)
	$(INSTALL) -D -m 0755 $(@D)/target/libiamroot.so $(HOST_DIR)/lib/iamroot/$(IAMROOT_ARCH)/$(HOST_IAMROOT_TARGET_LIB)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
