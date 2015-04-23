#!/bin/sh
#
# Copyright (C) 2012 Embecosm Limited
# Copyright (C) 2013-2015 Synopsys Inc.
#
# Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
#
# This file is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.
#
# As a special exception to the GNU General Public License, if you
# distribute this file as part of a program that contains a
# configuration script generated by Autoconf, you may include it under
# the same distribution terms that you use for the rest of that program.

# A wrapper for the GCC symlink-tree script, to build a symlink tree of all
# the component directories.

# Usage:

#   symlink-all.sh <unisrc> <component1> <component2> ...

# The <unisrc> directory is assumed to exist. symlink-tree is run in that
# directory for each top level directory in each <componentn> directory.

# We assume that the global environment variable ${ARC_GNU} is set, and that
# the component directories  direct subdirs of it. We also assume that the
# symlink-tree script can be found in ${ARC_GNU}/gcc.

# With a unified binutils-gdb repository, we need to make sure that we pull
# the common components from the correct repository. We achieve this by
# ignoring the gdb and sim directories when the component is binutils.


# Change to the unisrc directory
unisrc=$1
shift
cd ${unisrc}

echo "Symlink-all" ${unisrc}

# Symlink each tree
for component in $*
do
    case $component in
	binutils)
	    ignore="gdb sim"
	    ;;

	*)
	    ignore=""
	    ;;
    esac

    if ! ${ARC_GNU}/gcc/symlink-tree ${ARC_GNU}/${component} "${ignore}"
    then
	exit 1
    fi
done

exit 0

# vim: noexpandtab sts=4 ts=8: