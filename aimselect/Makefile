#!/bin/make

# Author: Anne C. van Rossum
# Date: Jun. 04, 2013

program=aimselect
targetdir=$(DESTDIR)/usr/bin

all:
	@echo "[#] No compilation necessary (just bash scripts)"

# We only install (need to be sudo)
install: | $(targetdir)
	@install $(program) $(targetdir)

$(targetdir):
	mkdir -p $(targetdir)

