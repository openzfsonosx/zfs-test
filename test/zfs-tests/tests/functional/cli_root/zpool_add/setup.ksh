#!/usr/bin/env ksh -p
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright 2009 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#

#
# Copyright (c) 2012 by Delphix. All rights reserved.
#

. $STF_SUITE/include/libtest.shlib
. $STF_SUITE/tests/functional/cli_root/zpool_add/zpool_add.kshlib

verify_runnable "global"

if [[ ( -z "$LINUX" && -z "$OSX" ) ]] && ! $(is_physical_device $DISKS) ; then
	log_unsupported "This directory cannot be run on raw files."
fi

if [[ -n $DISK ]]; then
	#
        # Use 'zpool create' to clean up the infomation in
        # in the given disk to avoid slice overlapping.
        #
	cleanup_devices $DISK

        partition_disk $SIZE $DISK 7

	[[ -n "$LINUX" ]] && start_disks="$DISK"
else
	for disk in `$ECHO $DISKSARRAY`; do
		cleanup_devices $disk
		partition_disk $SIZE $disk 7
	done

	 [[ -n "$LINUX" || -n "$OSX" ]] && start_disks="$DISK"
fi

if [[ -n "$OSX" && -n "$start_disks" ]]; then
    disk="" ; typeset -i i=0
    for dsk in $start_disks; do
    eval 'export DISK${i}="$dsk"'
    eval 'export DISK${i}b="$dsk"'
    [[ -z "$disk" ]] && disk=$dsk
    ((i += 1))
    done

cat <<EOF > $TMPFILE
export disk=$disk
export DISK0=$DISK0
export DISK0b=$DISK0b
export DISK1=$DISK1
export DISK1b=$DISK1b
export DISK2=$DISK2
export DISK2b=$DISK2b
export DEV_DSKDIR=""
EOF
fi

if [[ -n "$LINUX" && -n "$start_disks" ]]; then
	disk="" ; typeset -i i=0
	for dsk in $start_disks; do
		set -- $($KPARTX -asfv $dsk | head -n1)
		eval 'export DISK${i}="/dev/mapper/${8##*/}"'
		eval 'export DISK${i}b="$dsk"'
		[[ -z "$disk" ]] && disk=/dev/mapper/${8##*/}
		((i += 1))
	done

	cat <<EOF > $TMPFILE
export disk=$disk
export DISK0=$DISK0
export DISK0b=$DISK0b
export DISK1=$DISK1
export DISK1b=$DISK1b
export DISK2=$DISK2
export DISK2b=$DISK2b
export DEV_DSKDIR=""
EOF
fi

log_pass
