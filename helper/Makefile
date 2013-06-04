#!/bin/make

# Author: Anne C. van Rossum
# Date: Jun. 04, 2013

aim_config_path=/etc/aim
targetdir=$(DESTDIR)/$(aim_config_path)

all:
	@echo "[#] No compilation necessary (just bash scripts)"

# We only install (need to be sudo)
install: | $(targetdir)
	@echo cp *.sh $(targetdir)
	@cp *.sh $(targetdir)

$(targetdir):
	mkdir -p $(targetdir)

