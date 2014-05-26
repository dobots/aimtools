#!/bin/make

# Author: Anne C. van Rossum
# Date: Mar. 15, 2013

program=aiminfo
targetdir=$(DESTDIR)/usr/bin

all:
	@echo "[#] No compilation necessary (just bash scripts)"

# We only install (need to be sudo)
install: | $(targetdir)
	@echo install $(program) $(targetdir)
	@install $(program) $(targetdir)

$(targetdir):
	mkdir -p $(targetdir)

