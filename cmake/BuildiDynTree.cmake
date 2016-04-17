# iDynTree
include(YCMEPHelper)
include(FindOrBuildPackage)

set(iDynTreeDependsList Eigen3)

if(IDYNTREE_SUPERBUILD_USES_YARP)
    find_or_build_package(YARP QUIET)
    list(APPEND iDynTreeDependsList YARP)
endif()

if(IDYNTREE_SUPERBUILD_USES_ICUB)
    find_or_build_package(ICUB QUIET)
    list(APPEND iDynTreeDependsList ICUB)
endif()

# orocos_kdl and package kdl_codyco use export(PACKAGE <pkg>) that
# installs some files in ~/.cmake/packages/<pkg> that are used by cmake
# to locate the build directory for some packages.
# This messes up with the superbuild, because CMake will find the build
# directory, and therefore will not rebuild the package.
# Therefore we disable the package registry using
# NO_CMAKE_PACKAGE_REGISTRY
if(IDYNTREE_SUPERBUILD_USES_KDL)
    find_or_build_package(orocos_kdl QUIET NO_CMAKE_PACKAGE_REGISTRY)
    list(APPEND iDynTreeDependsList orocos_kdl)
endif()

# In Windows for simplyfing the build iDynTree uses custom internal version of TinyXML and urdfdom
if( NOT MSVC )
    find_or_build_package(TinyXML QUIET)
    list(APPEND iDynTreeDepensList TinyXML)
    # urdfdom is used only by KDL-based parsers
    if(IDYNTREE_SUPERBUILD_USES_KDL)
        find_or_build_package(urdfdom_headers QUIET)
        list(APPEND iDynTreeDependsList urdfdom_headers)
        find_or_build_package(urdfdom QUIET)
        list(APPEND iDynTreeDependsList urdfdom)
    endif()
endif()

ycm_ep_helper(iDynTree TYPE GIT
                       STYLE GITHUB
                       REPOSITORY robotology/idyntree.git
                       TAG master
                       COMPONENT libraries
                       CMAKE_ARGS -DIDYNTREE_USES_MATLAB:BOOL=${IDYNTREE_SUPERBUILD_USES_MATLAB}
                                  -DIDYNTREE_USES_PYTHON:BOOL=${IDYNTREE_SUPERBUILD_USES_PYTHON}
                                  -DIDYNTREE_USES_LUA:BOOL=${IDYNTREE_SUPERBUILD_USES_LUA}
                                  -DIDYNTREE_USES_KDL:BOOL=${IDYNTREE_SUPERBUILD_USES_KDL}
                                  -DIDYNTREE_USES_YARP:BOOL=${IDYNTREE_SUPERBUILD_USES_YARP}
                                  -DIDYNTREE_USES_ICUB_MAIN:BOOL=${IDYNTREE_SUPERBUILD_USES_ICUB_MAIN}
                       DEPENDS ${iDynTreeDependsList})
