#
# @file binding.gyp
# @brief This file provides the configuration and building options for node-gyp
#
# This file is created at "${yourorganisation}". It is open-source software and part of "${yourproject}". 
# This software is published under the ${license} license (${license_abbreviation}).
#
# Copyright © ${year} ${yourname} <${youremail}>
#
# @author                    ${yourname}
# @date                      ${date}
# @organisation              ${yourorganisation}
# @project                   ${yourproject}
#
{
	"targets": [
		{
			"target_name": "TemplateModule",
			
			"include_dirs": [
				"../../inc",
				"../../aim-core/inc"
				
			],
			
			"dependencies":[
			],
			
			"cflags": [
			],
			
			"libraries": [
			],
			
			"ldflags": [
				"-pthread",
			],
			
			"sources":[
				"../../aim-core/src/TemplateModule.cpp",
				"TemplateModuleNode.cc",
				"../../src/TemplateModuleExt.cpp"
			],
		}
	]
}
