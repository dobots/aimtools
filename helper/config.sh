#!/bin/bash

# Author: Anne C. van Rossum
# License: GNU LGPLv3 
# Date: Jun. 17, 2012

AIM_VERSION="0.3"
REQUIRED_RUR_VERSION="0.3"

# Installation paths.
# The bin path is to store the application itself.
# the share path to store additional details such as helper python files, icons, translations.
# The config path to store configuration details, such as starting at booting.
RUR_BIN_PATH=/usr/bin
RUR_SHARE_PATH=/usr/share/rur
RUR_TEMPLATE_PATH=$RUR_SHARE_PATH/templates
RUR_BACKENDS_PATH=$RUR_SHARE_PATH/backends
RUR_CONFIG_PATH=/etc/rur

AIM_BIN_PATH=/usr/bin
AIM_SHARE_PATH=/usr/share/aim
AIM_TEMPLATE_PATH=$AIM_SHARE_PATH/templates
AIM_CONFIG_PATH=/etc/aim
AIM_CROSSCOMPILECONF_PATH=$AIM_SHARE_PATH/crosscompileconf

# Working paths
RUR_DATA_PATH=$HOME/.rur/data
RUR_REGISTRY_PATH=$RUR_DATA_PATH/registry

# Configuration files
RUR_CONFIG_FILE_BACKENDS=${RUR_CONFIG_PATH}/backends.conf
RUR_CONFIG_FILE_BACKENDS_CMAKE=${RUR_CONFIG_PATH}/backends.cmake

AIM_CONFIG_COLOR=$AIM_CONFIG_PATH/color.sh
AIM_CONFIG_SANITY=$AIM_CONFIG_PATH/sanity.sh
AIM_CONFIG_REGISTRY_CHECK=$AIM_CONFIG_PATH/registry_check.sh

# Data(base) files
AIM_REGISTRY=${RUR_DATA_PATH}/aim_registry.txt

# Update paths by prepending it with DESTDIR so installation via the Ubuntu PPA works properly. This
# causes a duplicate "//" when $DESTDIR is empty, which is no problem at all, it just doesn't look so
# nice.
# Added an if-statement. Does this not work?
if [ -n "$DESTDIR" ]; then
	RUR_SHARE_PATH="$DESTDIR/$RUR_SHARE_PATH"
	RUR_TEMPLATE_PATH="$DESTDIR/$RUR_TEMPLATE_PATH"
	RUR_BACKENDS_PATH="$DESTDIR/$RUR_BACKENDS_PATH"
	RUR_CONFIG_PATH="$DESTDIR/$RUR_CONFIG_PATH"

	AIM_BIN_PATH="$DESTDIR/$AIM_BIN_PATH"
	AIM_SHARE_PATH="$DESTDIR/$AIM_SHARE_PATH"
	AIM_TEMPLATE_PATH="$DESTDIR/$AIM_TEMPLATE_PATH"
	AIM_CONFIG_PATH="$DESTDIR/$AIM_CONFIG_PATH"
	AIM_CROSSCOMPILECONF_PATH="$DESTDIR/$AIM_CROSSCOMPILECONF_PATH"
fi


