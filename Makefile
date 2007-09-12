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

PACKAGE= procmail-lib
DESTDIR =

.PHONY: all install clean distclean

all:
	@echo "There is nothing to make. See INSTALL."

clean:
	make -C lib	     clean
	make -C lib-stebbens clean
	make -C doc	     clean

distclean: clean

install:
	make -C lib	     install
	make -C lib-stebbens install
	make -C doc	     install

# Rule: deb-nmu -- Non-Debian maintainer packages (NMUs). Do not sign archives.
deb-nmu:
	dpkg-buildpackage -uc -us -rfakeroot

# Rule: deb-debuild -- Build *.deb with debuild(1)
deb-debuild:
	debuild --lintian --linda -rfakeroot

# Rule: deb-publish-local - Copy *.deb to localhost repository with dput(1)
deb-publish-local:
	cd ..; file=$$(ls -t $(PACKAGE)*.changes | head -1); \
	echo Publishing $$file; \
	dput --force localhost $$file
	@echo "Reminder: run debarchiver -so"

deb-publish-public-html:
	cp ../$(PACKAGE)*_* $(HOME)/public_html/tmp/debian

# End of file
