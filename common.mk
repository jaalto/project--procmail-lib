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

PACKAGE		= procmail-lib
DESTDIR		=

prefix		?= /usr/local
exec_prefix	?= $(prefix)
bindir		?= $(exec_prefix)/bin
sharedir	?= $(prefix)/share

ifeq ($(prefix),/usr)
    man_prefix	= $(prefix)/share
    mandir	?= $(man_prefix)/man
else
    man_prefix	?= $(prefix)
    mandir	?= $(prefix)/man
endif

BINDIR		?= $(DESTDIR)$(bindir)
DOCDIR		?= $(DESTDIR)$(sharedir)/doc/$(PACKAGE)
SHAREDIR	?= $(DESTDIR)$(prefix)/share/$(PACKAGE)
LIBDIR		?= $(DESTDIR)$(prefix)/lib/$(PACKAGE)
SBINDIR		?= $(DESTDIR)$(exec_prefix)/sbin
ETCDIR		?= $(DESTDIR)/etc/$(PACKAGE)

# 1 = regular, 5 = conf, 6 = games, 8 = daemons
MANDIR		?= $(DESTDIR)$(mandir)
MANDIR1		?= $(MANDIR)/man1
MANDIR5		?= $(MANDIR)/man5
MANDIR6		?= $(MANDIR)/man6
MANDIR8		?= $(MANDIR)/man8

INSTALL		?= install
INSTALL_BIN	?= $(INSTALL) -m 755
INSTALL_DATA	?= $(INSTALL) -m 644

distclean: clean

clean:
	-rm -f *[~#] .[~#]* *.tmp

# End of file
