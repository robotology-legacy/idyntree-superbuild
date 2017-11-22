# iDynTree
include(YCMEPHelper)
include(FindOrBuildPackage)

set(iDynTree_DEPENDS)

if(${IDYNTREE_USES_YARP})
    find_or_build_package(YARP QUIET)
    list(APPEND iDynTree_DEPENDS YARP)
endif()
if(${IDYNTREE_USES_ICUB_MAIN})
    find_or_build_package(ICUB QUIET)
    list(APPEND iDynTree_DEPENDS ICUB)
endif()

if(MSVC) 
    find_or_build_package(Eigen3)
    find_or_build_package(TinyXML)
    list(APPEND iDynTree_DEPENDS Eigen3)
    list(APPEND iDynTree_DEPENDS TinyXML)
endif()

ycm_ep_helper(iDynTree TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/idyntree.git
              TAG master
              COMPONENT libraries
              CMAKE_ARGS -DIDYNTREE_USES_PYTHON:BOOL=${IDYNTREE_USES_PYTHON}
                         -DIDYNTREE_USES_LUA:BOOL=${IDYNTREE_USES_LUA}
                         -DIDYNTREE_USES_OCTAVE:BOOL=${IDYNTREE_USES_OCTAVE}
                         -DIDYNTREE_USES_MATLAB:BOOL=${IDYNTREE_USES_MATLAB}
                         -DIDYNTREE_USES_KDL:BOOL=OFF
                         -DIDYNTREE_USES_YARP:BOOL=${IDYNTREE_USES_YARP}
                         -DIDYNTREE_USES_ICUB_MAIN:BOOL=${IDYNTREE_USES_ICUB_MAIN}
                         -DIDYNTREE_USES_IRRLICHT:BOOL=${IDYNTREE_USES_IRRLICHT}
              DEPENDS ${iDynTree_DEPENDS})
