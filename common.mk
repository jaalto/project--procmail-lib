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

PROJECT		= procmail-lib
DESTDIR		=

prefix		= /usr/local
exec_prefix	= $(prefix)
doc_prefix	= $(prefix)/share/doc
data_prefix	= $(prefix)/share

man_prefix	= $(prefix)/man

ifeq ($(prefix),/usr)
  man_prefix	= $(prefix)/share/man
endif

INSTALL		= install
INSTALL_BIN	= $(INSTALL) -m 755
INSTALL_DATA	= $(INSTALL) -m 644

BINDIR		= $(DESTDIR)$(exec_prefix)/bin
DATADIR		= $(DESTDIR)$(data_prefix)/$(PROJECT)
DOCDIR		= $(DESTDIR)$(doc_prefix)/$(PROJECT)
MANDIR		= $(DESTDIR)$(man_prefix)

MAN1DIR		= $(MANDIR)/man1
MAN5DIR		= $(MANDIR)/man5
MAN8DIR		= $(MANDIR)/man8

clean:
	-rm -f *[~#] .[~#]* *.tmp

distclean: clean

# End of file
