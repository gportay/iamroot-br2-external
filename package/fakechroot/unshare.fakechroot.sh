#!/bin/sh

# unshare
#
# Replacement for unshare command which calls program directly.
#
# (c) 2020 Gaël PORTAY <gael.portay@gmail.com>, LGPL

SHELL="${SHELL:-/bin/sh}"
while [ $# -gt 0 ]; do
    case "$1" in
        -*)
            ;;
        --)
            shift
            break
            ;;
        *)
            break
            ;;
    esac
    shift
done

FAKECHROOT_CMD_ORIG= \
exec "${@:-$SHELL}"
