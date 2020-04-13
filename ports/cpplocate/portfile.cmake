include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cginternals/cpplocate
    REF v2.2.0
    SHA512 b5ea01ef03cd736ed867893d7ae499caaacf62881a206682b3444193e8e164bd69a361aac7c0ac323a656b8d608952cd6e0694f10d064befefe996069811cd9d
    PATCHES system-install.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DOPTION_BUILD_TESTS=OFF
        -DOPTION_BUILD_GPU_TESTS=OFF
        -DGIT_REV=0
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/cpplocate/cmake/cpplocate)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

file(WRITE ${CURRENT_PACKAGES_DIR}/share/cpplocate/cpplocate-config.cmake "include(CMakeFindDependencyMacro)
include(\${CMAKE_CURRENT_LIST_DIR}/cpplocate-export.cmake)
")

# Handle copyright
file(RENAME ${CURRENT_PACKAGES_DIR}/share/cpplocate/LICENSE ${CURRENT_PACKAGES_DIR}/share/cpplocate/copyright)

vcpkg_copy_pdbs()
