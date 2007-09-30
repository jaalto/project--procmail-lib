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

include ../common.mk

EXDIR		= $(EXAMPLEDIR)/examples
DDIR		= $(DOCDIR)

INSTALL_EXAMPLE_OBJS = examples/*.procmailrc
INSTALL_OBJS	     = index.html html/*.html source/*.txt
INSTALL_LOG_DOC	     = source/ChangeLog
INSTALL_LOG_LIB	     = ../lib/ChangeLog

all:
	@echo "There is nothing to build."

clean:

distclean:

install-examples:
	$(INSTALL_BIN) -d $(EXDIR)
	$(INSTALL_DATA) $(INSTALL_EXAMPLE_OBJS) $(EXDIR)

install-doc:
	$(INSTALL_BIN) -d $(DDIR)
	$(INSTALL_DATA) $(INSTALL_OBJS) $(DDIR)
	$(INSTALL_DATA) $(INSTALL_LOG_DOC) $(DDIR)/ChangeLog.doc
	$(INSTALL_DATA) $(INSTALL_LOG_LIB) $(DDIR)/ChangeLog.lib

install: install-doc install-examples

# End of file
