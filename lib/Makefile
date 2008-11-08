#!/usr/bin/make -f
#
#	Copyright (C) 1997-2008 Jari Aalto
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

include ../common.mk

INSTALL_OBJS = *.rc

all:
	@echo "There is nothing to make. See INSTALL"

install-procmail:
	# Rule install-procmail - install procmail files
	$(INSTALL_BIN) -d $(SHAREDIR)
	$(INSTALL_DATA) $(INSTALL_OBJS) $(SHAREDIR)

install: install-procmail

.PHONY: install-procmail

# End of file
