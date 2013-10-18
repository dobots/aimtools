/**
 * @file TemplateModuleExt.h
 * @brief TemplateModule extension
 *
 * This file is created at "Your Company". It is open-source software and part of "Specific Software Project". This 
 * software is published under the GNU Lesser General Public license (LGPL).
 *
 * Copyright © 2013 Your Name <your@email>
 *
 * @author	Your Name
 * @date	Current date
 * @company	Your Company
 * @project	Specific Software Project
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

