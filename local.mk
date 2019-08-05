# PowerPC64 big endian by default uses the elfv1 ABI, and PowerPC64 little
# endian by default uses the elfv2 ABI. However, Arch POWER has decided to use
# the elfv2 ABI for both, so we force the ABI for PowerPC64 big endian when the
# selected C library is glibc.
ifeq ($(BR2_TOOLCHAIN_USES_GLIBC)$(BR2_powerpc64),yy)
ifeq ($(BR2_PACKAGE_SKELETON_PACSTRAP_ARCHPOWER_POWERPC64_CONFIGURATION_FILE),y)
HOST_GCC_COMMON_CONF_OPTS += --with-abi=elfv2
endif
endif

ifndef ZSTDCAT
ZSTDCAT = zstdcat
INFLATE.zst = $(ZSTDCAT)
endif
