cmake_minimum_required(VERSION 2.8.11)
project(iDynTree-superbuild NONE)

## we have to enable C because it is currently used
## by CMake to describe packages (in Config*.cmake files)
enable_language(C)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(IDYNTREE-SUPERBUILD_MAJOR_VERSION 0)
set(IDYNTREE-SUPERBUILD_MINOR_VERSION 2)
set(IDYNTREE-SUPERBUILD_PATCH_VERSION 0)
set(IDYNTREE-SUPERBUILD_VERSION ${IDYNTREE-SUPERBUILD_MAJOR_VERSION}.${IDYNTREE-SUPERBUILD_MINOR_VERSION}.${IDYNTREE-SUPERBUILD_PATCH_VERSION})

include(CTest)
include(FeatureSummary)

set(YCM_USE_CMAKE_PROPOSED TRUE CACHE BOOL "Use files including unmerged cmake patches")

#Compilation options
option(USE_SYSTEM_TINYXML "Use system TinyXML instead of superbuild one" FALSE)

# Optionally load a file named ProjectsTags
# for overwriting the desired branch/tag/commit
# of the included subprojects of the superbuild
# Useful for having superbuild "branches"
include(ProjectsTags OPTIONAL)

#Set CMake policies
if(NOT CMAKE_VERSION VERSION_LESS 3.0)
    cmake_policy(SET CMP0045 OLD)
endif()

# Bootstrap YCM
include(YCMBootstrap)

include(FindOrBuildPackage)
include(YCMEPHelper)

# Require Boost here to simplify debug for now
# (BuildBoost.cmake requires CMake 3.0, but the 
#  theory is that you need it only on Windows)
# Note that while is possible to specify header-only
# Boost libraries as components in BuildBoost.cmake,
# this is not possible in FindBoost.cmake . For this 
# reason we first search for Boost and only if we can't
# find it in the system we call find_or_build_package
# with the required components.
if(MSVC) 
	find_package(Boost)
	if(NOT ${Boost_FOUND})
		# install Boost from superbuild only on Windows 
		# This Boost dependencies are required by urdfdom
		find_or_build_package(Boost COMPONENTS smart_ptr algorithm lexical_cast function)
	endif()

	find_or_build_package(Eigen3)
	
else()
    find_package(Eigen3 3.2 REQUIRED)
endif()

find_or_build_package(YARP 2.3.63.2)
find_or_build_package(ICUB)
find_or_build_package(iDynTree)


set_package_properties(Git PROPERTIES TYPE RUNTIME)
set_package_properties(Subversion PROPERTIES TYPE RUNTIME)
set_package_properties(PkgConfig PROPERTIES TYPE RUNTIME)
set_package_properties(Doxygen PROPERTIES TYPE RUNTIME)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
