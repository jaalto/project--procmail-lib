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
#	Visit <http://www.gnu.org/copyleft/gpl.html>

ifneq (,)
This makefile requires GNU Make.
endif

all:
	@echo "There is nothing to build. See file INSTALL."

clean:
	$(MAKE) -C lib	     clean
	$(MAKE) -C doc	     clean

realclean: clean

install:
	$(MAKE) -C lib		install
	$(MAKE) -C lib-stebbens install
	$(MAKE) -C doc		install

install-test:
	# Rule install-test - for Maintainer only
	rm -rf tmp
	make DESTDIR=`pwd`/tmp prefix=/. install
	@echo find -type f tmp

www:
	# Rule www - for Maintainer only
	$(MAKE) -C doc www

.PHONY: all clean distclean realclean install www

# End of file
