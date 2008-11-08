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
#	General Public License for more details at
#	Visit <http://www.gnu.org/copyleft/gpl.html>.

ifneq (,)
This makefile requires GNU Make.
endif

include ../common.mk

NAME		     = lib-stebbens

BASEDIR		     = $(DOCDIR)/$(NAME)
EXDIR		     = $(BASEDIR)/examples

BIN		     = proclint
INSTALL_OBJS	     = $(BIN)
INSTALL_PM_OBJS	     = `ls *.rc | grep -v example`
INSTALL_EXAMPLE_OBJS = prefile-example.rc procmailrc-example
INSTALL_DOC_OBJS     = 0*README* Copyright \
		       GNU-LICENSE *.html *tutorial* *.info
all: man

man:
	$(MAKE) -f pod2man.mk BIN=$(BIN) makeman

install-doc:
	# Rule install-doc - install documentation
	$(INSTALL_BIN) -d $(BASEDIR)
	$(INSTALL_DATA) $(INSTALL_DOC_OBJS) $(BASEDIR)

install-examples:
	# Rule install-examples - install examples
	$(INSTALL_BIN) -d $(EXDIR)
	$(INSTALL_BIN) -D $(INSTALL_EXAMPLE_OBJS) $(EXDIR)

install-procmail:
	# Rule install-procmail - install procmail files
	$(INSTALL_BIN) -d $(SHAREDIR)
	$(INSTALL_DATA)	$(INSTALL_PM_OBJS) $(SHAREDIR)

install-man:
	# Rule install-man - install manual page
	$(INSTALL_BIN) -D $(BIN).1 $(MANDIR1)/$(BIN).1

install-bin:
	$(INSTALL_BIN) -D $(BIN) $(BINDIR)/$(BIN)

install: all install-bin install-man install-procmail \
	 install-examples install-doc

.PHONY: man clean \
	install-bin install-man install-procmail install-examples install-doc

# End of file
