# The skeleton packages provide their libc; installing the one compiled by
# buildroot breaks the userland.
#
# Sadly, the exernal.mk cannot override these variables as it is included after
# the packages.mk of the buildroot tree. The local.mk is the only alternative
# for now as it included before.
#
# If the variable BR2_PACKAGE_OVERRIDE_FILE is overridden by the .config or
# through the command-line, the target is screwed up.
#
# FIXME: Find another viable alternative!
GLIBC_INSTALL_TARGET = NO
MUSL_INSTALL_TARGET = NO
UCLIBC_INSTALL_TARGET = NO
