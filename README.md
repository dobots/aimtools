<!-- Uses markdown syntax for neat display at github -->

# AIM Tools
AIM stands for Artificial Intelligence Modules ([AIM website](http://mrquincle.github.io/aim-bzr/)).

## What does it do?
The AIM tools are meant for management of separate modules that each have AI functionality. They can be compared with the utilities that are provided with ROS, such as roscreate-pkg etc (of which I was not aware), or with nodejs, such as npm (of which I was neither aware). The tools work together with [rur-builder](https://github.com/mrquincle/rur-builder), a (python) backend for omniidl.

The current AIM tools are tailored to [YARP](http://eris.liralab.it/yarp/) and generate code that makes it easy to work with YARP as middleware. However, nothing prevents further extensions to make it easier to wrap code as ROS modules or something else, even Java. It depends on the backends provided by the forementioned rur-builder.

## Is it good?
The maturity of this software can be improved. However, it has been used already in quite some different scenarios. One of them is to connect to the servers of an Almende spinoff in sensor data cloud services ([Sense Observation Systems](http://sense-os.nl)), another use case has been the [Surveyor](http://www.surveyor.com/SRV_info.html) robots.

## What are the alternatives?
There are no known alternatives. Most modular approaches tie the user to a certain middleware.

## How to install?
The AIM tools work together with the [rur-builder](https://github.com/mrquincle/rur-builder). To install:

* sudo apt-get install omniidl # the only dependency
* cd /opt # or e.g. $HOME/aim, wherever you like to install from
* git clone https://github.com/dobots/rur-builder.git
* git clone https://github.com/dobots/aimtools.git
* cd aimtools
* make; sudo make install # on the question fill in the proper rur-builder/backends directory
* cd "your workspace"
* aimcreate-pkg YourModule # convention: all AIM binaries end with "Module"

## Install AIM MODULES for Node.JS packages on Mac OS X

1. Install OmniORB via homebrew: `brew install omniorb`
2. Install Rur-builder: cd to your projects directory, or just `cd ~`
3. sudo git clone https://github.com/dobots/rur-builder.git
4. `cd rur-builder`
5. `sudo make install` --> The RUR-builder is now installed in `/usr/share/rur`
7. Optionally: remove the rur-builder repository: `rm -rf ~/rur-builder` (or your other used directory)
8. Install AIM-Tools: cd to your projects directory, or just `cd ~`
9. `git clone https://github.com/dobots/aimtools.git`
10. `cd aimtools`
11. `make all; sudo make install` --> AIMTools is now installed in `/usr/bin/aimcreate-pkg`
13. Optionally: remove aimtools: `cd ..` `rm -rf aimtools`
12. Restart your terminal to reload this new binary to the PATHs environments.
13. Install example AIM-modules: go to your project directory, or just `cd ~`
14. `git clone https://github.com/mrquincle/aim_modules.git`
15. `cd aim-modules`
17. Create your own module (lets call it Cusum): `aimcreate-pkg CusumModule` (note the convention to end with 'Module')
18. `cd CusumModule`
18. Optionally: remove old template files: `rm -i aim/*.*-e`
19. Add Node.JS as a build target: `echo "SET(BUILD_NODEJS on)" >> aim/local.cmake`
20. Create the Gyp information package (used to link with Node). `touch binding.gyp`. Open the file and use listing below (modify to your packagename)
21. Create a default implementation: `touch inc/CusumModuleNode.cc`. Fill with below default listing.
21. In the `CusumModule` directory, do make: `make`. Note: you will see an fatal error for "'node.h. file not found". This is no problem.
22. Install gyp to link with node: `npm install -g node-gyp`
23. Setup package with node: `node-gyp configure`
24. Build node package: `node-gyp build`


### Create NPM package
TODO

### Workflow
TODO: describe workflow, modify C(++) code, (re)build, npm republish

# TODO
Add package.json and .npmignore file to aimcreate templates, for fast npm-deployment

### Example `bindings.gyp` file
    {
      "targets": [
        {
          "target_name": "CusumModule",
          #"type": "executable",
          #"type": "<(library)",

          "include_dirs": [
            "/usr/include",
            "aim/inc"
          ],

          "dependencies":[
            # Other binding.gyp
          ],

          "cflags": [
            "-std=c++11",
            "-fPIC",
          ],

          "libraries": [
          ],

          "ldflags": [
            "-pthread",
          ],

          "sources": [
            "aim/inc/CusumModule.cpp",
            "src/CusumModuleExt.cpp",
            "aim/inc/CusumModuleNode.cc",
          ],
        }
      ]
    }


### Example CusumModuleNode.cc file
    #define BUILDING_NODE_EXTENSION
    #include <node.h>
    #include <CusumModuleExt.h>

    using namespace v8;
    using namespace rur;

    void RegisterModule(Handle<Object> exports) {
      CusumModuleExt::NodeRegister(exports);
    }

    NODE_MODULE(CusumModule, RegisterModule)

## How to install YARP?
The YARP middleware is optionally. To install on Ubuntu:

* sudo add-apt-repository ppa:yarpers/yarp
* sudo apt-get update
* sudo apt-cache search yarp
* sudo apt-get install libyarp yarp-bin # and perhaps yarp-view

## Example
Now you will have a module created for you. You should be able to run "make" directly in it. This will use the default .idl file and generate the proper "YourModule.h" header file in the "aim" directory.

Suppose this is the parameter you want to send over the commandline to the module, then you add this to the YourModule.idl file:

	struct Param {
		string filename;
	};

Subsequently in your YourModuleMain.cpp file you will need to set it:

	int main(int argc, char *argv[])  {
		YourModule *m = new YourModule();
		Param * param = m->GetParam();
		...
		param->filename = argv[2]; // let's say it's the second argument
		...
	}

Then, for an incoming channel, you write this in the YourModule.idl file:

	interface WriteToFileModule {
		void Input(in long data);
	};

This will automatically generate a "/data" channel for you in the case YARP is chosen as backend (more specifically, it will be /yourmodule{id}/data). The only thing you will need to do now is to write functional code that uses the channels in the stub file YourModule.cpp, for example:

	void WriteToFileModule::Tick() {
		double input = *readInput();
		ofstream myfile(cliParam->filename.c_str(), ios::app);
		myfile << input << '\n';
		myfile.close();
	}

As you can see the "Input" function in the YourModule.idl file has become something you can read from and which returns the proper type. All conversions necessary are done in the automatically generated header file (for example YARP does use Bottle's to communicate such datatypes, and you don't need to know anything about that using this framework).

Note: this example illustrates that a filestream is created and closed each "Tick()". To remedy this you should not add anything to the header file because that file should be automatically be regenerated as soon as you change the idl description of the module. Hence, the recommended method is to subclass YourModule to add state information to it. And you have subsequently to adjust the YourModuleMain.cpp file to call this subclass. If you have already an existing important class, this is also an easy way to integrate this middleware-agnostic layer. Just add also YourModule as a parent to that class.

## Workflow

The sequence of commands that you will need to execute is along the following lines:

* aimget -h # to see what this command is about, you'll learn you'll need an AIM_WORKSPACE environmental variable
* mkdir -p $HOME/myworkspace/aim
* export AIM_WORKSPACE=$HOME/myworkspace/aim
* aimget "mrquincle" https://github.com/mrquincle/aim_modules
* cd $AIM_WORKSPACE/mrquincle
* cd WriteModule && make # make force=1 will make all modules
* cd ..
* aimregister WriteModule
* aimrun WriteModule 0

Now you have gone full throttle through all the steps to get modules to in the end running them, to read more on the aim tools, and how to connect the modules, see the [AIM](http://mrquincle.github.com/aim-bzr/) website.

## Where can I read more?
* [Wikipedia (YARP)](http://en.wikipedia.org/wiki/YARP)

## Copyrights
The copyrights (2012) belong to:

- Author: Anne van Rossum
- Author: Scott Guo
- Almende B.V., http://www.almende.com and DO bots B.V., http://www.dobots.nl
- Rotterdam, The Netherlands
