################################################################################
#
# pacman
#
################################################################################

PACMAN_VERSION = 6.0.1
PACMAN_SITE = https://sources.archlinux.org/other/pacman/
PACMAN_SOURCE = pacman-$(PACMAN_VERSION).tar.xz
PACMAN_LICENSE = GPL-2.0
PACMAN_LICENSE_FILES = COPYING

HOST_PACMAN_DEPENDENCIES = host-libarchive host-libcurl
HOST_PACMAN_CONF_OPTS = -Dldconfig=/usr/bin/ldconfig

$(eval $(host-meson-package))
