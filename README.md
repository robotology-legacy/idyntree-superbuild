# iDynTree-superbuild [![Build Status](https://travis-ci.org/robotology/idyntree-superbuild.svg?branch=master)](https://travis-ci.org/robotology/idyntree-superbuild)
Superbuild helper repository for installing dependencies for all the components of the iDynTree library. 


Table of Contents
=================
  * [Installation](#installation)
    * [Linux](#linux)
    * [macOS](#macos)
    * [Windows](#windows)
  * [Update](#update)


Installation
============

We provide different instructions on how to install iDynTree throught the iDynTree-superbuild, depending on your operating system:
* [**Windows**](#windows): use the superbuild with Microsoft Visual Studio
* [**macOS**](#macos): use the superbuild with Xcode or GNU make
* [**Linux**](#linux): use the superbuild with make 

## Windows
The `idyntree-superbuild` is not supported anymore on Windows, please check the [`robotology-superbuild`](https://github.com/robotology/robotology-superbuild)
with the `ROBOTOLOGY_ENABLE_DYNAMICS` option enabled for an easy way of compiling and installing iDynTree on Windows.

## macOS

### System Dependencies 
To install Eigen and CMake, it is possible to use [Homebrew](http://brew.sh/):
```
brew install eigen cmake boost tinyxml
```

### Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain 
```
Finally it is possible to install iDynTree and its dependencies using the superbuild:
```bash
git clone https://github.com/robotology/idyntree-superbuild.git
cd idyntree-superbuild
mkdir build
cd build
```
To use GNU Makefile generators:
```bash
cmake ../
make
```
To use Xcode project generators
```bash
cmake ../ -G Xcode
xcodebuild -configuration Release
```

### Configure your environment
After building the superbuild, all binaries are installed in `idyntree-superbuild/build/install/bin` and all libraries in `idyntree-superbuild/build/install/lib`.

To use this binaries you should update the `PATH` environment variables.

An easy way is to add these lines to the `.bashrc` or `.bash_profile` file in your home directory:
```bash
IDYNTREE_SUPERBUILD_ROOT=/directory/where/you/downloaded/idyntree-superbuild
export PATH=$PATH:$IDYNTREE_SUPERBUILD_ROOT/build/install/bin
export YARP_DATA_DIRS=$YARP_DATA_DIRS:$IDYNTREE_SUPERBUILD_ROOT/build/install/share/yarp:$IDYNTREE_SUPERBUILD_ROOT/build/install/share/iCub
```

To use the updated `.bashrc` in your terminal you should run the following command:
```bash
user@host:~$ source ~/.bashrc
```
or for the `.bash_profile` file
```bash
user@host:~$ source ~/.bash_profile
```
or simply open a new terminal.

## Linux 
### System Dependencies 
On Debian based systems (as Ubuntu) you can install CMake and Eigen (and other dependencies necessary for the codyco-superbuild) using `apt-get`:
```
sudo apt-get install libeigen3-dev cmake cmake-curses-gui libboost-system-dev libboost-thread-dev libtinyxml-dev libace-dev libgsl0-dev libcv-dev libhighgui-dev libcvaux-dev libode-dev liblua5.1-dev lua5.1 swig
```

The packages provided in the official distro repositories work out of the box for **Ubuntu 16.04**.
If you need support for any other Linux distribution, please open an issue.

If you want to compile iDynTree with support for the `IDYNTREE_USES_KDL` CMake option, for example for use with [`FloBaRoID`](https://github.com/kjyv/FloBaRoID),
you will also need to install the following dependencies:
~~~
sudo apt install liburdfdom-dev liborocos-kdl-dev
~~~

Update
======
For updating the idyntree-superbuild repository it is possible to just fetch the last changes using the usual
git command:
~~~
git pull
~~~
However, for running the equivalent of `git pull` on all the repositories managed by
the idyntree-superbuild, you have to execute in your build system the appropriate target.
To do this, make sure to be in the `build` directory of the `idyntree-superbuild` and execute:
~~~
make update-all
~~~
using make on Linux or macOS or
~~~
cmake --build . --target UPDATE_ALL
~~~
using Visual Studio on Windows or 
~~~
cmake --build . --target ALL_UPDATE
~~~
using Xcode on macOS.

