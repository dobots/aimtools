#!/bin/make

# Author: Anne C. van Rossum
# Date: Jun. 04, 2013

program=aimcross

aim_share_path:=/usr/share/aim
aim_crosscompileconf_path:=$(aim_share_path)/crosscompileconf

aim_crosscompileconf_path:=$(DESTDIR)/$(aim_crosscompileconf_path)
targetdir:=$(DESTDIR)/usr/bin

all:
	@echo "[#] No compilation necessary (just bash scripts)"

# We only install (need to be sudo)
install: | $(targetdir)
	@echo install $(program) $(targetdir)
	@install $(program) $(targetdir)
	@echo cp conf/* $(aim_crosscompileconf_path)
	@cp conf/* $(aim_crosscompileconf_path)

$(targetdir):
	mkdir -p $(targetdir)

