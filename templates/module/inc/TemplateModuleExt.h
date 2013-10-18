/**
 * @file TemplateModuleExt.h
 * @brief TemplateModule extension
 *
 * This file is created at "${yourorganisation}". It is open-source software and part of "${yourproject}". 
 * This software is published under the ${license} license (${license_abbreviation}).
 *
 * Copyright © ${year} ${yourname} <${youremail}>
 *
 * @author                   ${yourname}
 * @date                     ${date}
 * @organisation             ${yourorganisation}
 * @project                  ${yourproject}
 */

#include <TemplateModule.h>

namespace rur {

/**
 * Your Description of this module.
 */
class TemplateModuleExt: public TemplateModule {
public:
	//! The constructor
	TemplateModuleExt();

	//! The destructor
	virtual ~TemplateModuleExt();

	//! The tick function is the "heart" of your module, it reads and writes to the ports
	void Tick();

	//! As soon as Stop() returns "true", the TemplateModuleMain will stop the module
	bool Stop();
};

}

