#!/bin/bash

# busybox
#
# Replacement for busybox command which calls the program from the host.
#
# (c) 2020 Gaël PORTAY <gael.portay@gmail.com>, LGPL

set -e

busybox() {
	local interpreter

	LD_LIBRARY_PATH= \
	LD_PRELOAD= \
	interpreter="$(file -L "$FAKECHROOT_BASE_ORIG$FAKECHROOT_CMD_ORIG" | sed -n 's/^.*, interpreter \([^,]*\), .*$/\1/p')"
	if [[ ! "$interpreter" ]]
	then
		return 127
	fi

	FAKECHROOT_BASE= \
	LD_PRELOAD= \
	"$FAKECHROOT_BASE_ORIG$interpreter" "$FAKECHROOT_BASE_ORIG$FAKECHROOT_CMD_ORIG" "$@"
}

argv=("$@")
while [[ $# -ne 0 ]]
do
	if [[ "$func" ]]
	then
		break
	elif [[ "$1" == "--install" ]]
	then
		install=1
	elif [[ "$install" ]] && [[ "$1" == "-s" ]]
	then
		s=1
	elif [[ "$install" ]] && [[ ! "$directory" ]]
	then
		directory="$1"
	elif [[ "$install" ]] && [[ "$directory" ]]
	then
		echo "$1: Too many argument" >&2
		exit 1
	else
		func="$1"
		break
	fi
	shift
done
set -- "${argv[@]}"

if [[ ! "$install" ]] || [[ ! "$s" ]]
then
	LD_LIBRARY_PATH= \
	busybox "$@"
	exit 0
fi

# TODO: Absolute symlinks must be local to the chroot'ed environment.
#       Disabling creation of /bin/busybox symlinks lets the host access to
#       binaries.
s=
mapfile -t applets < <(busybox --list-full)
for applet in "${applets[@]}"
do
	if [[ ! "$s" ]]
	then
		rm -f "$FAKECHROOT_BASE_ORIG/$applet"
		cp "$FAKECHROOT_BASE_ORIG/bin/busybox" "$FAKECHROOT_BASE_ORIG/$applet"
	else
		ln -sf /bin/busybox "$FAKECHROOT_BASE_ORIG/$applet"
	fi
done
