#!/bin/make

# Author: Anne C. van Rossum
# Date: Jun. 18, 2013

templatedir=$(DESTDIR)/usr/share/rur/templates
configdir=$(DESTDIR)/etc/rur

all:
	@echo "[#] No compilation necessary (just bash scripts)"

# We only install (need to be sudo)
install: | $(templatedir) $(configdir)
	@echo "Tip: run uninstall to remove previous templates"
	@echo cp -r module/* $(templatedir)
	@cp -r module/* $(templatedir)
	@echo cp -r config/* $(configdir)
	@cp -r config/* $(configdir)

UNINSTALL_TIME=$(shell date +%Y-%m-%d)

uninstall:
	@echo "We will not really recursively remove in sudo user mode, we move the folder to /tmp, delete it there"
	@mkdir -p /tmp
	@mv $(templatedir) "/tmp/aim_templates [$(UNINSTALL_TIME)]"
	@mv $(configdir) "/tmp/aim_config [$(UNINSTALL_TIME)]"
	@ls /tmp | grep aim

$(templatedir):
	mkdir -p $(templatedir)

$(configdir):
	mkdir -p $(configdir)

