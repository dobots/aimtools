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

* <img src="https://raw.github.com/dobots/aimtools/master/docs/ubuntu.png" alt="Ubuntu" style="width: 16px;"/> Install OmniIDL via apt-get: `sudo apt-get install omniidl`
* [MAC OS X] Install OmniORB via homebrew: `brew install omniorb`
* Install rur-builder: cd to your projects directory, or just `cd ~`, `cd ~/setup`, or whereever you prefer to install from
* Clone the rur-builder repository: `git clone https://github.com/dobots/rur-builder.git`
* Make the rur-builder: `cd rur-builder`, `make` and `sudo make install`, the rur-builder is now installed in `/usr/bin` and the backends in `/usr/share/rur`
* Optionally: remove the local rur-builder repository: `rm -rf ~/rur-builder` (or your other used directory)
* Go back to your preferred install location: `cd ~`, or `cd ~/setup`
* Install AIMTools: `git clone https://github.com/dobots/aimtools.git`
* Make AIMTools: `cd aimtools`, `make` and `sudo make install`, different aim* binaries are now installed in `/usr/bin`, such as `aimcreate-pkg`
* Optionally: remove the local AIMTools repository: `rm -rf ~/aimtools` (or your other used directory)
* [MAC OS X] Restart your terminal to reload this new binaries to the PATHs environment variable.
* Define the environmental variable AIM\_WORKSPACE, for example: `export AIM_WORKSPACE=$HOME/aim_workspace` (this will become a collection of repositories of AI modules)
* Add this environmental variable to your `~/.bashrc`, `~/.localrc`, or other user shell configuration file
* Get an example repository with code for robots: `aimget robotics https://github.com/mrquincle/aim_modules`
* Go to it and build one: `cd $AIM_WORKSPACE/robotics`, and for example `aimmake FindRobotModule` (note the convention to end with 'Module')

## How to create your own module

You can create your own module(s). The following shows it for a module in Node:

* Go the aim workspace: `cd $AIM_WORKSPACE`
* Create your own AI modules repository (say you plan to create software for the Kinect): `aiminit kinect` 
* Go there: `cd kinect`
* Create your own module (lets call it Cusum): `aimcreate-pkg CusumModule` (note again the convention to end with 'Module')
* [MAC OS X] Optionally: remove old template files in it: `rm -ir *-e; rm -ir ./*/*-e` 
* Set it up to build for Node.js: `aimselect CusumModule nodejs`
* Build it for Node: `aimmake CusumModule`
* Optionally: Modify `aim-config/nodejs/binding.gyp` to your dependencies and compiler flags
* Optionally: Modify `aim-config/nodejs/package.json` for Node dependencies and add a module description
* Optionally: Modify `CusumModuleNode.cc` to your needs. Probably won't need any modifications.
* Build it again if you change things: `aimmake CusumModule`
* Install gyp (globally) to link with node: `npm install -g node-gyp`
* Install all dependencies and build sources locally with: `cd CusumModule` and `npm install`

## And what about the other middlewares?

You can also use your module in a completely different middleware, for example YARP. Such middleware is optionally. 

* [Ubuntu] sudo add-apt-repository ppa:yarpers/yarp
* [Ubuntu] sudo apt-get update
* [Ubuntu] sudo apt-cache search yarp
* [Ubuntu] sudo apt-get install libyarp yarp-bin # and perhaps yarp-view

## Example
Now you will have a module created for you. You should be able to run "make" directly in it. This will use the default .idl file and generate the proper "YourModule.h" header file in the "aim" directory.

Suppose this is the parameter you want to send over the commandline to the module, then you add this to the YourModule.idl file:

```cpp
struct Param {
	string filename;
};
```

Subsequently in your YourModuleMain.cpp file you will need to set it:

```cpp
int main(int argc, char *argv[])  {
	YourModule *m = new YourModule();
	Param * param = m->GetParam();
	...
	param->filename = argv[2]; // let's say it's the second argument
	...
}
```

Then, for an incoming channel, you write this in the YourModule.idl file:

```cpp
interface WriteToFileModule {
	void Input(in long data);
};
```

This will automatically generate a "/data" channel for you in the case YARP is chosen as backend (more specifically, it will be /yourmodule{id}/data). The only thing you will need to do now is to write functional code that uses the channels in the stub file YourModule.cpp, for example:

```cpp
void WriteToFileModule::Tick() {
	double input = *readInput();
	ofstream myfile(cliParam->filename.c_str(), ios::app);
	myfile << input << '\n';
	myfile.close();
}
```

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
