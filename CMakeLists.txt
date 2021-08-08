cmake_minimum_required(VERSION 3.15)

project(tessellate LANGUAGES CXX VERSION 0.0.1)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

add_library(project_options INTERFACE)
add_library(project_warnings INTERFACE)

include(cmake/SetUp.cmake)

option(ENABLE_PCH "Enable Precompiled Headers" ON)
option(ENABLE_EXAMPLES "Enable Examples" OFF)
option(BUILD_SHARED_LIBS "Enable compilation of shared libraries" OFF)
option(ENABLE_TESTING "Enable Test Builds" OFF)

include(cmake/Conan.cmake)
run_conan()

add_library(tessellate INTERFACE)
target_include_directories(tessellate
        INTERFACE
        $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include/tessellate>)

install(TARGETS tessellate project_options project_warnings
        EXPORT tessellateTargets
        RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT bin
        LIBRARY DESTINATION "${INSTALL_LIB_DIR}" COMPONENT shlib
        PUBLIC_HEADER DESTINATION "${INSTALL_INCLUDE_DIR}"
        COMPONENT dev)

if (ENABLE_PCH)
    list(APPEND public_headers fold)

    foreach (header ${public_headers})
        list(APPEND headers "include/tessellate/${header}.hpp")
    endforeach ()

    target_precompile_headers(tessellate INTERFACE ${headers})
endif ()

if (ENABLE_EXAMPLES)
    add_subdirectory(examples)
endif ()

if (ENABLE_TESTING)
    enable_testing()
    add_subdirectory(test)
endif ()

option(ENABLE_UNITY "Enable Unity builds of projects" OFF)
if (ENABLE_UNITY)
    # Add for any project you want to apply unity builds for
    set_target_properties(intro PROPERTIES UNITY_BUILD ON)
endif ()

include(cmake/ExportLibrary.cmake)

