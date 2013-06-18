<!-- Uses markdown syntax for neat display at github -->

# AIM Tools
AIM stands for Artificial Intelligence Modules ([AIM website](http://dobots.github.io/aim-bzr/)).

## What does it do?
The AIM tools are meant for management of separate modules that each have AI functionality. They can be compared with the utilities that are provided with ROS, such as roscreate-pkg etc (of which we were not aware at the time), or with nodejs, such as npm (of which we were neither aware). The tools work together with [rur-builder](https://github.com/mrquincle/rur-builder), a (python) backend for omniidl. 

The current AIM tools have been in operational mode for a long time with [YARP](http://eris.liralab.it/yarp/). The newest useful addition has been Node.js, which allows us to deploy the modules using the npm (node package manager) system.

The goal of the AIM tools is to allow programmers to do rapid prototyping for multiple platforms and connecting them by multiple means without being bothered by the middleware specifics. We want you to be able to run a module on your smartphone, connect it to a server that you happen to have, and go from there to your raspberry PI and your television set. We do want to build an ecosystem where many AI modules are working together and do want to allow you to run our software on your own servers. Monetizing this ecosystem will be via the website [dodedodo.com](http://www.dodedodo.com/) that will allow you to find other modules and function as a hub to download binaries from, it will not be the place though which all application traffic has to pass, but just a sophisticated name service.

## Is it good?
The maturity of this software can be improved. However, it has been used already in quite some different scenarios. One of them is to connect to the servers of an Almende spinoff in sensor data cloud services ([Sense Observation Systems](http://sense-os.nl)), another use case has been the [Surveyor](http://www.surveyor.com/SRV_info.html) robots, a third on the unmanned aerial vehicles of [FireSwarm](http://www.fireswarm.nl).

## What are the alternatives?
There are no known alternatives. Most modular approaches tie the user to a certain middleware.

## How to install?
The AIM tools work together with the [rur-builder](https://github.com/mrquincle/rur-builder). To install:

<img src="https://raw.github.com/dobots/aimtools/master/docs/logos/ubuntu.png" alt="Ubuntu" style="width: 16px;"/> 
Install OmniIDL via apt-get 

```bash
sudo apt-get install omniidl
```
<img src="https://raw.github.com/dobots/aimtools/master/docs/logos/mac_os.png" alt="Mac OS X" style="width: 16px;"/> 
Or install OmniIDL via homebrew

```bash
brew install omniorb
```

Set the installation path, on Linux systems this is most often `/opt`, but it is up to you, let us say you want to use `~/setup`:
```bash
set SETUP_PATH=~/setup # directory where you prefer to install from
```

Install rur-builder, by cloning, and running make:

```bash
cd $SETUP_PATH
git clone https://github.com/dobots/rur-builder.git
cd rur-builder
make 
sudo make install
```

The rur-builder is now installed in `/usr/bin` and the backends in `/usr/share/rur`. 

To install the aimtools, this is similar:

```bash
cd $SETUP_PATH
git clone https://github.com/dobots/aimtools.git
cd aimtools
make
sudo make install
```

Multiple aim* binaries are now installed in `/usr/bin`, such as `aimcreate-pkg`

Now, define the environmental variable `AIM_WORKSPACE`, this will become a collection of repositories with AI modules, collected from multiple github repositories.

```bash
export AIM_WORKSPACE=$HOME/aim_workspace
echo $AIM_WORKSPACE >> ~/.bashrc # in case you use bash (check with e.g. `sh --version`).
```

<img src="https://raw.github.com/dobots/aimtools/master/docs/logos/mac_os.png" alt="Mac OS X" style="width: 16px;"/> 
Restart your terminal to reload these new binaries to the PATHs environment variable.

And now you are ready to get actual AI modules:

```bash
aimget robotics https://github.com/mrquincle/aim_modules
aimget navigation https://github.com/vliedel/aim_modules
```

This will allow you to run all the modules defined in these repositories. Build one if you like to:

```bash
cd $AIM_WORKSPACE/robotics
aimmake FindRobotModule
```

Optionally, you can now remove the files in `$SETUP_PATH`, however, if you quickly want to upgrade to newer versions, you might better of leaving them there. Anyway, to remove them:

```bash
cd $SETUP_PATH
rm -r rur-builder
rm -r aimtools
```

## How to create your own module?

How to create your own module is not part of the installation process. Go for that to the [AIM website](http://dobots.github.io/aim-bzr/). However, to lift a little bit of the curtain, in the end you will need to write your functionality in C++ in a function called `Tick()` using channels to communicate with other modules:

```cpp
void WriteToFileModule::Tick() {
	double input = *readInput();
	ofstream myfile(cliParam->filename.c_str(), ios::app);
	myfile << input << '\n';
	myfile.close();
}
```

## And what about the other middlewares?

You can also use your module in a completely different middleware, for example YARP. Such middleware is optionally. 

<img src="https://raw.github.com/dobots/aimtools/master/docs/logos/ubuntu.png" alt="Ubuntu" style="width: 16px;"/> To install:

```bash
sudo add-apt-repository ppa:yarpers/yarp
sudo apt-get update # optionally: apt-cache search yarp
apt-get install libyarp yarp-bin yarp-view
```

## Where can I read more?
* [Wikipedia (YARP)](http://en.wikipedia.org/wiki/YARP)
* [AIM website](http://dobots.github.com/aim-bzr/) 

## Copyrights
The copyrights (2012) belong to:

- Author: Anne van Rossum
- Author: Scott Guo
- Almende B.V., http://www.almende.com and DO bots B.V., http://www.dobots.nl
- Rotterdam, The Netherlands
