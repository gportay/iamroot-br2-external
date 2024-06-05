#!/usr/bin/env -S make -f
#
# Copyright 2024 Gaël PORTAY
#
# SPDX-License-Identifier: GPL-2.0-or-later
#

.PHONY: all
all: update-defconfig

.PHONY: update-defconfig
update-defconfig:
	$(foreach defconfig,$(wildcard configs/*_defconfig), \
		$(MAKE) -f Makefile O=$(CURDIR)/output-$@ $(notdir $(defconfig)) savedefconfig && \
	) \
	rm -Rf $(CURDIR)/output-$@ && \
	echo "completed!"

.PHONY: defconfigs
defconfigs:
	$(foreach defconfig,$(wildcard configs/*_defconfig), \
		defconfig=$(notdir $(defconfig)) && \
		$(MAKE) -f Makefile O=$(CURDIR)/output-$$defconfig $$defconfig && \
	) \
	echo "completed!"

.PHONY: toolchain
toolchain:
	$(foreach defconfig,$(wildcard configs/*_defconfig), \
		defconfig=$(notdir $(defconfig)) && \
		$(MAKE) -f Makefile O=$(CURDIR)/output-$$defconfig $$defconfig && \
		$(MAKE) -f Makefile O=$(CURDIR)/output-$$defconfig $@ && \
	) \
	echo "completed!"

.PHONY: test-pacman.conf
test-pacman.conf:
	$(foreach defconfig,$(wildcard configs/*_defconfig), \
		test -e package/skeleton-pacstrap/$(subst _defconfig,_pacman.conf,$(notdir $(defconfig))) && \
	) \
	echo "completed!"
