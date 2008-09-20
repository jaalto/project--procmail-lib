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
#	Visit <http://www.gnu.org/copyleft/gpl.html>

ifneq (,)
This makefile requires GNU Make.
endif

include ../common.mk

INSTALL		= install
INSTALL_BIN	= $(INSTALL) -m 755
INSTALL_DATA	= $(INSTALL) -m 644

BASEDIR		= $(DOCDIR)/lib-aalto
EXDIR		= $(BASEDIR)/examples

INSTALL_EXAMPLE_OBJS = examples/*.procmailrc
INSTALL_LOG_DOC	     = ChangeLog
INSTALL_LOG_LIB	     = ../lib/ChangeLog

all: doc

install-examples:
	$(INSTALL_BIN) -d $(EXDIR)
	$(INSTALL_DATA) $(INSTALL_EXAMPLE_OBJS) $(EXDIR)

install-doc:
	$(INSTALL_BIN) -d $(BASEDIR) $(BASEDIR)/manual $(BASEDIR)/article
	$(INSTALL_DATA) *.html $(BASEDIR)
	$(INSTALL_DATA) manual/*.html $(BASEDIR)/manual
	$(INSTALL_DATA) article/*.html $(BASEDIR)/article
	$(INSTALL_DATA) $(INSTALL_LOG_DOC) $(BASEDIR)/ChangeLog.doc
	$(INSTALL_DATA) $(INSTALL_LOG_LIB) $(BASEDIR)/ChangeLog.lib

# Rule: install - install documentation
install: install-doc install-examples

# Rule: clean - delete temporary files
clean:
	rm  -f *[~#] *.tmp

# Rule: www - copy web pages to ../../<project>-www
www: html
	name=$$(basename $$(cd .. && pwd)); \
	to=../../$$name-www; \
	echo "Copying to $$to"; \
	find . -type f -name "*.html" | \
	rsync $${test:+"--dry-run"} \
	  --files-from=- \
	  --update \
	  --progress \
	  --verbose \
	  -r \
	  . \
	  $$to/

manual: manual/index.txt
	perl -S t2html.pl --Auto-detect --Out --print-url $<

article: article/index.txt
	perl -S t2html.pl --Auto-detect --Out --print-url $<

html: manual article

# Rule: doc - Generate or update documentation
doc: html

.PHONY: all doc html www

# End of file
