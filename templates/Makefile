#!/bin/make

# Author: Anne C. van Rossum
# Date: Jun. 18, 2013

targetdir=$(DESTDIR)/usr/share/rur/templates

all:
	@echo "[#] No compilation necessary (just bash scripts)"

# We only install (need to be sudo)
install: | $(targetdir)
	@echo "Tip: run uninstall to remove previous templates"
	@echo cp -r module/* $(targetdir)
	@cp -r module/* $(targetdir)

UNINSTALL_TIME=$(shell date +%Y-%m-%d)

uninstall:
	@echo "We will not really recursively remove in sudo user mode, we move the folder to /tmp, delete it there"
	@mkdir -p /tmp
	@mv $(targetdir) "/tmp/aim_templates [$(UNINSTALL_TIME)]"
	@ls /tmp | grep aim_templates

$(targetdir):
	mkdir -p $(targetdir)

