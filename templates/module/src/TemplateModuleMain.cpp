/**
 * @file TemplateModuleMain.cpp
 * @brief Entry function for TemplateModule
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
 
#include <TemplateModuleExt.h>

#include <stdlib.h>
#include <iostream>

using namespace rur;
using namespace std;

/**
 * Every module is a separate binary and hence has its own main method. It is recommended
 * to have a version of your code running without any middleware wrappers, so preferably
 * have this file and the TemplateModule header and code in a separate "aim" directory.
 */
int main(int argc, char *argv[])  {
	TemplateModuleExt *m = new TemplateModuleExt();

	if (argc < 2) {
		std::cout << "Use an identifier as argument for this instance" << endl;
		return EXIT_FAILURE;
	}
	std::string identifier = argv[1];
	m->Init(identifier);

	do {
		m->Tick();
	} while (!m->Stop()); 

	delete m;

	return EXIT_SUCCESS;
}
