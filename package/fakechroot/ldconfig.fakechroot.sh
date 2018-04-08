#!/bin/sh

# ldconfig
#
# Replacement for ldconfig command which calls the program from the chroot'ed
# environment with the option -r $FAKECHROOT_BASE_ORIG"
#
# (c) 2020 Gaël PORTAY <gael.portay@gmail.com>, LGPL

exec "$FAKECHROOT_BASE_ORIG/usr/bin/ldconfig" -r "$FAKECHROOT_BASE_ORIG"
