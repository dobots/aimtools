#!/bin/make 

#######################################################################################################################

# Author: A.C. van Rossum
# Date: Jun. 17, 2013
# License: LGPL v.3
# Company: Distributed Organisms B.V.

# Thanks to http://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
# and many people on stackoverflow asking questions and giving answers

#######################################################################################################################

# Compile everything, but start with "helper" and "template"
SUBDIRS=helper templates aimconnect aimcopy aimcreate-pkg aimcross aimget aimlist aimlogin aimmake aimports \
	aimregister aimrun aimselect aimstop aimupdate

#######################################################################################################################

# Of course you can have a for-loop in a Makefile, however, such a loop is a SHELL loop. This means, that an error will
# not be automatically propagate back to this Makefile and it will continue building the other folders. It can be hard 
# to see errors in that way. Manually catching the error does not respect "make -k". Moreover, with a for-loop the make 
# cannot be executed in parallel. Hence, we clone the array of abovefor the install target.

INSTALL_SUBDIRS=$(addsuffix .install,$(SUBDIRS))

#######################################################################################################################

subdirs: $(SUBDIRS)

install-subdirs: $(INSTALL_SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

$(INSTALL_SUBDIRS): %.install:
	$(MAKE) -C $* install	

#######################################################################################################################

# Here you see the normal targets you would expect, these would be the only ones we would export to the command-line if
# that was an option in Makefiles.

all: subdirs

install: install-subdirs

clean:
	@echo "Not implemented to clean targets yet"

uninstall:
	@echo "Not implemented to uninstall targets (use your default package manager or checkinstall)"

#######################################################################################################################

.PHONY: subdirs $(SUBDIRS) all install-subdirs $(INSTALL_SUBDIRS) install clean

