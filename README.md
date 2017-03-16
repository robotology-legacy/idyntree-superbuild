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

### System Dependencies 
iDynTree and its dependencies are developed using the C/C++ language. For this reason, you should have Visual Studio installed on your computer to build it. You will also need some additional software, as listed afterwards. 
Some of this software can be easily installed using [Chocolatey](https://chocolatey.org), a tool to simplify software installation on Windows. 

#### Git 
Most of the CoDyCo software is hosted on Git repositories, so you will need Git to download them. 
You can download the Git installer at http://msysgit.github.io/ . 
##### Chocolatey 
If you have installed Chocolatey, you can install Git with the following command:
~~~
choco install git
~~~

####CMake
To install CMake you can use the official installer available at http://www.cmake.org/cmake/resources/software.html .
It is recommended to install the latest version of CMake. 
##### Chocolatey 
If you have installed Chocolatey, you can install CMake with the following command:
~~~
choco install cmake 
~~~

#### Eigen
Eigen can be automatically installed with the codyco-superbuild, so you don't have to install it manually. 

If you want to install Eigen manually, or you have already installed Eigen please check the following section.
##### Eigen Manual installation
You can install Eigen from source code available from the [Eigen official website](http://eigen.tuxfamily.org).
You can simply extract the Eigen source code in a directory, and then define the `EIGEN3_ROOT` environment variable to the path of the directory that contains the file `signature_of_eigen3_matrix_library` (it should be the first directory contained in the compressed file).

#### YARP
For installing the latest version of YARP software, please refer to [YARP official documentation](http://www.yarp.it/install_yarp_windows.html). If you do not plan to modify YARP, it should be sufficient to install the binaries of YARP.

#### ICUB
By default, the ICUB dependency of `iDynTree` has been disabled. To enable it back, set the `IDYNTREE_USES_ICUB_MAIN` CMake option and install ICUB following the instructions available
in [the official iCub documentation](http://wiki.icub.org/wiki/ICub_Software_Installation). If you do not plan to modify ICUB, it should be sufficient to install the binaries of ICUB.


### Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain 
```
After that you can clone the superbuild repository as any other git repository, and generate the Visual Studio solution using the CMake gui. Then you open the generated solution with Visual Studio and build the target `ALL_BUILD`. 
Visual Studio will then download, build and install in a local directory all the CoDyCo software and its dependencies.
If you prefer to work from the command line, you can also compile the `ALL_BUILD` target using the following command (if you are in the `iDynTree-superbuild/build` directory:
~~~
cmake --build . 
~~~

### Configure your environment
Currently the YCM superbuild does not support building a global install target, so all binaries are installed in `codyco-superbuild/build/install/bin` and all libraries in `codyco-superbuild/build/install/lib`.

To use this binaries and libraries, you should update the necessary environment variables.

Set the environment variable `IDYNTREE_SUPERBUILD_ROOT` so that it points to the  directory where you clone the codyco-superbuild repository.

To make the tools installed by iDynTree available from your command line, append `$IDYNTREE_SUPERBUILD_ROOT/build/install/bin` to your `PATH` enviromental variable. 

To make the iDynTree library available by other project to use, append the `$IDYNTREE_SUPERBUILD_ROOT/build` to your  `CMAKE_PREFIX_PATH` enviromental variable (or create it if it is not set). 

## macOS

### System Dependencies 
To install Eigen and CMake, it is possible to use [Homebrew](http://brew.sh/):
```
brew install eigen cmake boost tinyxml
```

For installing the latest version of YARP and ICUB software, please refer to [the official iCub documentation](http://wiki.icub.org/wiki/ICub_Software_Installation).

### Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain 
```
Finally it is possible to install iDynTree and its dependencies using the superbuild:
```bash
git clone https://github.com/robotology-playground/iDynTree-superbuild.git
cd iDynTree-superbuild
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
After building teh superbuild, all binaries are installed in `iDynTree-superbuild/build/install/bin` and all libraries in `iDynTree-superbuild/build/install/lib`.

To use this binaries you should update the `PATH` environment variables.

An easy way is to add these lines to the `.bashrc` or `.bash_profile` file in your home directory:
```bash
IDYNTREE_SUPERBUILD_ROOT=/directory/where/you/downloaded/iDynTree-superbuild
export PATH=$PATH:$IDYNTREE_SUPERBUILD_ROOT/build/install/bin
export YARP_DATA_DIRS=$YARP_DATA_DIRS:$IDYNTREE_SUPERBUILD_ROOT/build/install/share/codyco
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
sudo apt-get install libeigen3-dev cmake cmake-curses-gui libboost-system-dev libboost-thread-dev libtinyxml-dev libace-dev libgtkmm-2.4-dev libglademm-2.4-dev libgsl0-dev libcv-dev libhighgui-dev libcvaux-dev libode-dev liblua5.1-dev lua5.1 swig
```
The packages provided in the official distro repositories work out of the box for **Ubuntu 14.04** (`trusty`), **Ubuntu 13.10** (`saucy`) and **Debian 8** (`jessie`).
For older distros the included CMake and Eigen are too old, and is necessary to find a way to install them from an alternative
source:
* In **Debian 7** (`wheezy`) it is sufficient to [enable the `wheezy-backports` repository](http://backports.debian.org/Instructions/) to get recent versions of CMake and Eigen.
* In **Ubuntu 12.04** (`precise`) a [PPA is available to easily install CMake 2.8.12](https://launchpad.net/~robotology/+archive/ubuntu/ppa). To install a recent version of Eigen the easiest solution is [to get Eigen from source](http://eigen.tuxfamily.org/index.php?title=Main_Page#Download).

#### YARP and iCub software
For installing the latest version of YARP and ICUB software, please refer to [the official iCub documentation](http://wiki.icub.org/wiki/Linux:Installation_from_sources). Please note that at the moment 
the codyco-superbuild only supports YARP and ICUB installed from sources.

Update
======
For updating the codyco-superbuild repository it is possible to just fetch the last changes using the usual
git command:
~~~
git pull
~~~
However, for running the equivalent of `git pull` on all the repositories managed by
the codyco-superbuild, you have to execute in your build system the appropriate target.
To do this, make sure to be in the `build` directory of the `codyco-superbuild` and execute:
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

