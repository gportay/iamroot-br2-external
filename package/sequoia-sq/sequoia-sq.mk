################################################################################
#
# sequoia-sq
#
################################################################################

SEQUOIA_SQ_VERSION = 0.33.0
SEQUOIA_SQ_SITE = https://gitlab.com/sequoia-pgp/sequoia-sq/-/archive/v$(SEQUOIA_SQ_VERSION)
SEQUOIA_SQ_LICENSE = GPL-2.0
SEQUOIA_SQ_LICENSE_FILES = LICENSE.txt
HOST_SEQUOIA_SQ_DEPENDENCIES = host-nettle host-openssl host-pkgconf

$(eval $(host-cargo-package))
