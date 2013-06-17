#!/bin/bash

# Author: Anne C. van Rossum
# License: GNU LGPLv3 
# Date: Jun. 17, 2012

# Installation paths
RUR_BIN_PATH=/usr/bin
RUR_SHARE_PATH=/usr/share/rur
RUR_TEMPLATE_PATH=$RUR_SHARE_PATH/templates
RUR_BACKENDS_PATH=$RUR_SHARE_PATH/backends
RUR_CONFIG_PATH=/etc/rur

AIM_CONFIG_PATH=/etc/aim

# Working paths
RUR_DATA_PATH=$HOME/.rur/data
RUR_REGISTRY_PATH=$RUR_DATA_PATH/registry

# Configuration files
RUR_CONFIG_FILE_BACKENDS=${RUR_CONFIG_PATH}/backends.conf
RUR_CONFIG_FILE_BACKENDS_CMAKE=${RUR_CONFIG_PATH}/backends.cmake

AIM_CONFIG_COLOR=$AIM_CONFIG_PATH/color.sh
AIM_CONFIG_SANITY=$AIM_CONFIG_PATH/sanity.sh

# Data(base) files
AIM_REGISTRY=${RUR_DATA_PATH}/aim_registry.txt

# Update paths by prepending it with DESTDIR so installation via the Ubuntu PPA works properly. This
# causes a duplicate "//" when $DESTDIR is empty, which is no problem at all, just does not look so
# nice.
if [ -n "$DESTDIR" ]; then
	RUR_SHARE_PATH="$DESTDIR/$RUR_SHARE_PATH"
	RUR_TEMPLATE_PATH="$DESTDIR/$RUR_TEMPLATE_PATH"
	RUR_BACKENDS_PATH="$DESTDIR/$RUR_BACKENDS_PATH"
	RUR_CONFIG_PATH="$DESTDIR/$RUR_CONFIG_PATH"

	AIM_CONFIG_PATH="$DESTDIR/$AIM_CONFIG_PATH"
fi


