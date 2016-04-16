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

# Add iDynTree options on the dependencies to use also to the iDynTree-superbuild
option(IDYNTREE_SUPERBUILD_USES_KDL "Compile iDynTree superbuild with KDL dependency" TRUE)
option(IDYNTREE_SUPERBUILD_USES_YARP "Compile iDynTree superbuild with YARP dependency" TRUE)
option(IDYNTREE_SUPERBUILD_USES_ICUB_MAIN  "Compiled iDynTree superbuild with icub-main dependencies (for iKin and skinDynLib helper functions and tools)" TRUE)
option(IDYNTREE_SUPERBUILD_USES_MATLAB "Compile iDynTree superbuild with Matlab dependency" FALSE)
option(IDYNTREE_SUPERBUILD_USES_PYTHON "Compile iDynTree superbuild with Python dependency" FALSE)
option(IDYNTREE_SUPERBUILD_USES_LUA "Compile iDynTree superbuild with Lua dependency" FALSE)



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
set(YCM_TAG aae056b0f51d106fe746b964966ca816faa925ab)
include(YCMBootstrap)

include(FindOrBuildPackage)
include(YCMEPHelper)

# Get Eigen from the superbuild only on Windows
if(MSVC)
    find_or_build_package(Eigen3)
else()
    find_package(Eigen3 3.2 REQUIRED)
endif()

find_or_build_package(iDynTree)

set_package_properties(Git PROPERTIES TYPE RUNTIME)
set_package_properties(Subversion PROPERTIES TYPE RUNTIME)
set_package_properties(PkgConfig PROPERTIES TYPE RUNTIME)
set_package_properties(Doxygen PROPERTIES TYPE RUNTIME)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
