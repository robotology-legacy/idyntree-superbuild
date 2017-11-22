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

option(IDYNTREE_USES_MATLAB    "Enable compilation of software that depends on Matlab" FALSE)
option(IDYNTREE_USES_LUA       "Enable compilation of software that depends on Lua"    FALSE)
option(IDYNTREE_USES_PYTHON    "Enable compilation of software that depends on Python" FALSE)
option(IDYNTREE_USES_OCTAVE    "Enable compilation of software that depends on Octave" FALSE)
option(IDYNTREE_USES_YARP      "Enable compilation of software that depends on YARP"    FALSE)
option(IDYNTREE_USES_ICUB_MAIN "Enable compilation of software that depends on icub-main" FALSE)
option(IDYNTREE_USES_IRRLICHT  "Enable compilation of software that depends on irrlicht" FALSE)

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
set(YCM_TAG abb0a980c7079a6bdf5155bb53795b53c38b424d)
# Workaround disabling hash warning until we fix https://github.com/robotology/codyco-superbuild/issues/162
set(YCM_SKIP_HASH_CHECK TRUE)
include(YCMBootstrap)

include(FindOrBuildPackage)
include(YCMEPHelper)

if(MSVC) 
    find_or_build_package(Eigen3)
    find_or_build_package(TinyXML)
else()
    find_package(Eigen3 3.2 REQUIRED)
endif()

if(${IDYNTREE_USES_YARP})
    find_or_build_package(YARP)
endif()
if(${IDYNTREE_USES_ICUB_MAIN})
    find_or_build_package(ICUB)
endif()

find_or_build_package(iDynTree)


set_package_properties(Git PROPERTIES TYPE RUNTIME)
set_package_properties(Subversion PROPERTIES TYPE RUNTIME)
set_package_properties(PkgConfig PROPERTIES TYPE RUNTIME)
set_package_properties(Doxygen PROPERTIES TYPE RUNTIME)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
