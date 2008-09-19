#!/usr/bin/make -f
#
#	Copyright (C) 1997-2009 Jari Aalto
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

NAME		     = lib-stebbens
EXDIR		     = $(EXAMPLEDIR)/$(NAME)/examples

INSTALL_OBJS	     = proclint
INSTALL_PM_OBJS	     = `ls *.rc | grep -v example`
INSTALL_EXAMPLE_OBJS = prefile-example.rc procmailrc-example
INSTALL_DOC_OBJS     = README README.txt Copyright \
		       GNU-LICENSE *.html *tutorial* *.info
all:
	@echo "There is nothing to make. See INSTALL."

clean:
	-rm -f *[~#] .[~#]*

distclean: clean

install-doc:
	$(INSTALL_BIN) -d $(DOCDIR)/$(NAME)
	$(INSTALL_DATA) $(INSTALL_DOC_OBJS) $(DOCDIR)/$(NAME)

install-examples:
	$(INSTALL_BIN) -d $(EXDIR)
	$(INSTALL_BIN)	  $(INSTALL_EXAMPLE_OBJS) $(EXDIR)

install-procmail:
	$(INSTALL_BIN) -d $(DATADIR)
	$(INSTALL_BIN)	  $(INSTALL_PM_OBJS) $(DATADIR)

install-bin:
	$(INSTALL_BIN) -d $(BINDIR)
	$(INSTALL_BIN)	  $(INSTALL_OBJS) $(BINDIR)

install: install-bin install-procmail install-examples install-doc

.PHONY: install-bin install-procmail install-examples install-doc

# End of file
