#!/usr/bin/make -f
#
#	Copyright (C) 1997-2007 Jari Aalto
#
#	This program is free software; you can redistribute it and/or
#	modify it under the terms of the GNU General Public License as
#	published by the Free Software Foundation; either version 2 of the
#	License, or (at your option) any later version
#
#	This program is distributed in the hope that it will be useful, but
#	WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#	General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with program. If not, write to the
#	Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
#	Boston, MA 02110-1301, USA.
#
#	Visit <http://www.gnu.org/copyleft/gpl.html>

ifneq (,)
This makefile requires GNU Make.
endif

PACKAGE= procmail-lib
DESTDIR =

.PHONY: all install clean distclean

all:
	@echo "There is nothing to build. See INSTALL."

clean:
	make -C lib	     clean
	make -C doc	     clean

distclean: clean

install:
	make -C lib	     install
	make -C doc	     install

# End of file
