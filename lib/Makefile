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

INSTALL_OBJS = *.rc

include ../common.mk

all:
	@echo "There is nothing to make. See INSTALL"

clean:
	-rm *[~#] .[~#]* 2> /dev/null

distclean: clean

install-procmail:
	$(INSTALL_BIN) -d $(DATADIR)
	$(INSTALL_BIN) $(INSTALL_OBJS) $(DATADIR)

install: install-procmail

# End of file
