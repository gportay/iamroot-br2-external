# Hacked makefile for buildroot
#
# Copyright (C) 2020 by Gaël PORTAY <gael.portay@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#

# Do not pollute target
GLIBC_INSTALL_TARGET = NO
MUSL_INSTALL_TARGET = NO
UCLIBC_INSTALL_TARGET = NO
SKELETON_INSTALL_TARGET = NO
SKELETON_INIT_COMMON_INSTALL_TARGET = NO
SKELETON_INIT_NONE_INSTALL_TARGET = NO
SKELETON_INIT_OPENRC_INSTLAL_TARGET = NO
SKELETON_INIT_SYSTEMD_INSTALL_TARGET = NO
SKELETON_INIT_SYSV_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_ARM_AARCH64_BE_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_ARM_AARCH64_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_ARM_ARM_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_BOOTLIN_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_CODESCAPE_IMG_MIPS_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_CODESCAPE_MTI_MIPS_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_CODESOURCERY_AARCH64_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_CODESOURCERY_ARM_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_CODESOURCERY_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_CODESOURCERY_MIPS_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_CUSTOM_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_LINARO_AARCH64_BE_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_LINARO_AARCH64_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_LINARO_ARM_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_LINARO_ARMEB_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_INSTALL_TARGET = NO
TOOLCHAIN_EXTERNAL_INSTALL_TARGET = NO

include Makefile

ifndef ZSTDCAT
ZSTDCAT = zstdcat
INFLATE.zst = $(ZSTDCAT)
endif

target-finalize:;
	@$(call MESSAGE,"Finalizing target directory hacked!")

	$(foreach d, $(call qstrip,$(BR2_ROOTFS_OVERLAY)), \
		@$(call MESSAGE,"Copying overlay $(d)")$(sep) \
		$(Q)$(call SYSTEM_RSYNC,$(d),$(TARGET_DIR))$(sep))

	$(Q)$(if $(TARGET_DIR_FILES_LISTS), \
		cat $(TARGET_DIR_FILES_LISTS)) > $(BUILD_DIR)/packages-file-list.txt
	$(Q)$(if $(HOST_DIR_FILES_LISTS), \
		cat $(HOST_DIR_FILES_LISTS)) > $(BUILD_DIR)/packages-file-list-host.txt
	$(Q)$(if $(STAGING_DIR_FILES_LISTS), \
		cat $(STAGING_DIR_FILES_LISTS)) > $(BUILD_DIR)/packages-file-list-staging.txt

	$(foreach s, $(call qstrip,$(BR2_ROOTFS_POST_BUILD_SCRIPT)), \
		@$(call MESSAGE,"Executing post-build script $(s)")$(sep) \
		$(Q)$(EXTRA_ENV) $(s) $(TARGET_DIR) $(call qstrip,$(BR2_ROOTFS_POST_SCRIPT_ARGS))$(sep))
