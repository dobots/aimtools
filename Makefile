#!/bin/make 

# Thanks to http://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
# Author: A.C. van Rossum
# Date: 2013
# License: LGPL v.3
# Company: Distributed Organisms B.V.

# Compile everything, but start with "helper"
SUBDIRS=helper templates aimconnect aimcopy aimcreate-pkg aimcross aimget aimlist aimlogin aimports \
	aimregister aimrun aimselect aimstop aimupdate

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

all: $(SUBDIRS)

install:
	for dir in $(SUBDIRS); do \
		$(MAKE) install -C $$dir; \
	done

clean:
	echo "Not implemented clean targets yet"

.PHONY: subdirs $(SUBDIRS)
