# Add all targets to the build-tree export set
export(TARGETS tessellate project_options project_warnings FILE "${PROJECT_BINARY_DIR}/tessellateTargets.cmake")

# Export the package for use from the build-tree
# (this registers the build-tree with a global CMake-registry)
export(PACKAGE tessellate)

# Create the tessellateConfig.cmake and tessellateConfigVersion.cmake files
file(RELATIVE_PATH REL_INCLUDE_DIR "${INSTALL_CMAKE_DIR}" "${INSTALL_INCLUDE_DIR}")
# ... for the build tree
set(CONF_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}" "${PROJECT_BINARY_DIR}")
configure_file(cmake/tessellateConfig.cmake.in "${PROJECT_BINARY_DIR}/tessellateConfig.cmake" @ONLY)
# ... for the install tree
set(CONF_INCLUDE_DIRS "\${TESSELLATE_CMAKE_DIR}/${REL_INCLUDE_DIR}")
configure_file(cmake/tessellateConfig.cmake.in "${PROJECT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/tessellateConfig.cmake" @ONLY)
# ... for both
configure_file(cmake/tessellateConfigVersion.cmake.in "${PROJECT_BINARY_DIR}/tessellateConfigVersion.cmake" @ONLY)

# Install the tessellateConfig.cmake and tessellateConfigVersion.cmake
install(FILES
        "${PROJECT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/tessellateConfig.cmake"
        "${PROJECT_BINARY_DIR}/tessellateConfigVersion.cmake"
        DESTINATION
        "${INSTALL_CMAKE_DIR}" COMPONENT dev)

install(DIRECTORY include/ DESTINATION ${INSTALL_INCLUDE_DIR})

# Install the export set for use with the install-tree
install(EXPORT tessellateTargets
        DESTINATION "${INSTALL_CMAKE_DIR}"
        COMPONENT dev)

