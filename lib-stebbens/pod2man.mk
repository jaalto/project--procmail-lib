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
#	Visit <http://www.gnu.org/copyleft/gpl.html>

BIN		= package
PODCENTER	= $$(date "+%Y-%m-%d")
MANSECT		= 1
MANDEST		= $(MANSRC)

MANPOD		= $(MANSRC)$(BIN).$(MANSECT).pod
MANPAGE		= $(MANDEST)$(BIN).$(MANSECT)

makeman: $(MANPAGE)

$(MANPAGE): $(MANPOD)
	which pod2man && \
	pod2man --center="$(PODCENTER)" \
		--name="$(BIN)" \
		--section="$(MANSECT)" \
		$(MANPOD) \
	| sed 's,[Pp]erl v[0-9.]\+,$(BIN),' \
	> $(MANPAGE) && \
	rm -f pod*.tmp

# End of of Makefile part
