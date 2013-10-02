#!/bin/make

# Author: Anne C. van Rossum
# Date: Oct. 02, 2013

program=aimbrowse
targetdir=$(DESTDIR)/usr/bin

all:
	@echo "[#] No compilation necessary (just bash scripts)"

# We only install (need to be sudo)
install: | $(targetdir)
	@echo install $(program) $(targetdir)
	@install $(program) $(targetdir)

$(targetdir):
	mkdir -p $(targetdir)

