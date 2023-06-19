#!/bin/bash
#
#  SPDX-License-Identifier: GPL-2.0+
#
#  This file is part of linux-distros-br2-external.
#
#  linux-distros-br2-external is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2.0 of the License, or (at your
#  option) any later version.

set -e

config_isset() {
	grep -Eq "^$1=" "$BR2_CONFIG"
}

config_string() {
	sed -n "/^$1/s,.*=\"\(.*\)\",\1,p" "$BR2_CONFIG"
}

sed -e '\:/dev/root / auto :d' -i "$TARGET_DIR"/etc/fstab
if config_isset "BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW"
then
	echo "/dev/root / auto rw 0 1" >>"$TARGET_DIR"/etc/fstab
else
	echo "/dev/root / auto ro 0 1" >>"$TARGET_DIR/etc/fstab"
fi

if config_isset "BR2_TARGET_ENABLE_ROOT_LOGIN"
then
	passwd="$(config_string "BR2_TARGET_GENERIC_ROOT_PASSWD")"
	if [[ "$passwd" =~ ^\$\$[156]\$\$.* ]]
	then
		# WARNING! WARNING!
		# The password appears as-is in the .config file, and may appear
		# in the build log! Avoid using a valuable password if either
		# the .config file or the build log may be distributed, or at
		# the very least use a strong cryptographic hash for your
		# password!
		passwd="${passwd//\$\$/\$}"
	fi
	if [[ "$passwd" ]] && [[ ! "$passwd" =~ ^\$[156]\$.* ]]
	then
		method="$(config_string "BR2_TARGET_GENERIC_PASSWD_METHOD")"
		passwd="$(mkpasswd -m "${method:-md5}" "$passwd")"
	fi

	sed -e "s,^root:[^:]*:,root:$passwd:," -i "$TARGET_DIR/etc/shadow"
fi

hostname="$(config_string "BR2_TARGET_GENERIC_HOSTNAME")"
if [[ "$hostname" ]]
then
	hostnames=("$hostname")
	IFS=. read -a domains <<<"$hostname"
	if [[ "${#domains[*]}" -gt 1 ]]
	then
		hostnames+=("${domains[0]}")
	fi
	echo "$hostname" >"$TARGET_DIR/etc/hostname"
	sed -e "\$a \127.0.1.1\t${hostnames[*]}" \
	    -e '/^127.0.1.1/d' \
	    -i "$TARGET_DIR/etc/hosts"
fi

issue="$(config_string "BR2_TARGET_GENERIC_ISSUE")"
if [[ "$issue" ]]
then
	echo -e "$issue" >"$TARGET_DIR/etc/issue"
fi
