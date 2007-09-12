#	Copyright (C)  Jari Aalto
#	Keywords:      Makefile, procmail
#
#	This program is free software; you can redistribute it and/or
#	modify it under the terms of the GNU General Public License as
#	published by the Free Software Foundation; either version 2 of the
#	License, or (at your option) any later version

ifneq (,)
This makefile requires GNU Make.
endif

include ../common.mk

NAME		= lib-jaalto
EXDIR		= $(EXAMPLEDIR)/$(NAME)/examples
DDIR		= $(DOCDIR)/$(NAME)

INSTALL_EXAMPLE_OBJS = examples/*.procmailrc
INSTALL_OBJS	     = index.html html/*.html source/*.txt
INSTALL_LOG_DOC	     = source/ChangeLog
INSTALL_LOG_LIB	     = ../lib/ChangeLog

all:
	@echo "There is nothing to make."

clean:

distclean:

install-examples:
	$(INSTALL_BIN) -d $(EXDIR)
	$(INSTALL_DATA) $(INSTALL_EXAMPLE_OBJS) $(EXDIR)

install-doc:
	$(INSTALL_BIN) -d $(DDIR)
	$(INSTALL_DATA) $(INSTALL_OBJS) $(DDIR)
	$(INSTALL_DATA) $(INSTALL_LOG_DOC) $(DDIR)/ChangeLog-of-doc
	$(INSTALL_DATA) $(INSTALL_LOG_LIB) $(DDIR)/ChangeLog-of-lib

install: install-doc install-examples

# End of file
