#!/bin/bash

#######################################################################################################################
# Configuration
#######################################################################################################################

# Installation paths, the bin path is to store the application itself, the share path to store 
# additional details such as helper python files, icons, translations. The config path to store 
# configuration details, such as starting at booting.

AIM_CONFIG_PATH=/etc/aim
AIM_CONFIG_FILE=/etc/aim/config.sh

#######################################################################################################################
# Tweaks and general configuration details
#######################################################################################################################

source $AIM_CONFIG_FILE
source $AIM_CONFIG_COLOR

#######################################################################################################################
# Implementation
#######################################################################################################################

reg_check() {
	local modulename=$1
	local __resultvar=$2
	local MODULE_FULLNAME=
	while read LINE; do
		MODULE_I=`echo "$LINE" | cut -d'=' -f 1`
		M_I_STRIPPED=${MODULE_I//[[:space:]]}
#		echo $M_I_STRIPPED
		if [[ "$M_I_STRIPPED" == "$modulename" ]]; then
#			echo "$modulename found. Run it"
			MODULE_FULLNAME=`echo "$LINE" | cut -d'=' -f 2`
#			SUCCESS=true
			break
		fi
	done < "${AIM_REGISTRY}"
	
	if [[ "$__resultvar" ]]; then
		eval $__resultvar="'$MODULE_FULLNAME'"
	else
		echo "$MODULE_FULLNAME"
	fi
}
