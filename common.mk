#	Copyright (C)  Jari Aalto
#	Keywords:      Makefile, procmail
#
#	This program is free software; you can redistribute it and/or
#	modify it under the terms of the GNU General Public License as
#	published by the Free Software Foundation; either version 2 of the
#	License, or (at your option) any later version
#
#	This is file is included by all Makefiles

PROJECT		= procmail-lib
DESTDIR		=
prefix		= /usr/local
exec_prefix	= $(prefix)
doc_prefix	= $(prefix)/doc
man_prefix	= $(prefix)/share
data_prefix	= $(prefix)/share

INSTALL		= install
INSTALL_BIN	= $(INSTALL) -m 755
INSTALL_DATA	= $(INSTALL) -m 644

BINDIR		= $(DESTDIR)$(exec_prefix)/bin
MANDIR		= $(DESTDIR)$(man_prefix)/man/man1
DATADIR		= $(DESTDIR)$(data_prefix)/$(PROJECT)

DOCDIR		= $(DESTDIR)$(doc_prefix)/$(PROJECT)
EXAMPLEDIR	= $(DOCDIR)

# End of file
