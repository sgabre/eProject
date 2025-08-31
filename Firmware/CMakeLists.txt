#/TestHarness/Firmware/CMakeLists.txt


#add_subdirectory(Shell)
add_subdirectory(Module)

if(NOT CMAKE_BUILD_TYPE STREQUAL UnitTesting)
    # Include the Version.cmake file
    include(${CMAKE_SOURCE_DIR}/.cmake/Version/git.cmake)
    
    # Now you can use the version information
    message(STATUS "CMAKE_PROJECT_NAME: ${CMAKE_PROJECT_NAME}")
    message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
    message(STATUS "MAJOR_VERSION: ${PROJECT_VERSION_MAJOR}")
    message(STATUS "MINOR_VERSION: ${PROJECT_VERSION_MINOR}")
    message(STATUS "PATCH_VERSION: ${PROJECT_VERSION_PATCH}")
    message(STATUS "Git Revision: ${BUILD_GIT_REVISION}")
    message(STATUS "Build Date: ${BUILD_DATE}")
    message(STATUS "Install Prefix: ${CMAKE_INSTALL_PREFIX}")
    
    
    # Now, configure the Version.h.in file to create Version.h with actual values
    configure_file(${CMAKE_SOURCE_DIR}/.cmake/Version/Version.h.in ${CMAKE_CURRENT_BINARY_DIR}/Applications/Version.h)
    
    include_directories(${CMAKE_CURRENT_BINARY_DIR}/Applications)

    add_subdirectory(Applications)
endif()




