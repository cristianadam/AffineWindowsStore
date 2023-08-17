# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(affine LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets OpenGL)

qt_standard_project_setup()

qt_add_executable(affine
    main.cpp
    xform.cpp xform.h
    arthurstyle.cpp arthurstyle.h
    arthurwidgets.cpp arthurwidgets.h
    hoverpoints.cpp hoverpoints.h
    fbopaintdevice.cpp fbopaintdevice.h
)

set_target_properties(affine PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(affine PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::OpenGL
)

# Resources:
set(shared_resource_files
    images/button_normal_cap_left.png
    images/button_normal_cap_right.png
    images/button_normal_stretch.png
    images/button_pressed_cap_left.png
    images/button_pressed_cap_right.png
    images/button_pressed_stretch.png
    images/frame_bottom.png
    images/frame_bottomleft.png
    images/frame_bottomright.png
    images/frame_left.png
    images/frame_right.png
    images/frame_top.png
    images/frame_topleft.png
    images/frame_topright.png
    images/groupframe_bottom_left.png
    images/groupframe_bottom_right.png
    images/groupframe_bottom_stretch.png
    images/groupframe_left_stretch.png
    images/groupframe_right_stretch.png
    images/groupframe_top_stretch.png
    images/groupframe_topleft.png
    images/groupframe_topright.png
    images/line_dash_dot.png
    images/line_dash_dot_dot.png
    images/line_dashed.png
    images/line_dotted.png
    images/line_solid.png
    images/radiobutton-on.png
    images/radiobutton_off.png
    images/radiobutton_on.png
    images/slider_bar.png
    images/slider_thumb_on.png
    images/title_cap_left.png
    images/title_cap_right.png
    images/title_stretch.png
)

qt_add_resources(affine "shared"
    PREFIX
        "/res"
    FILES
        ${shared_resource_files}
)

set(affine_resource_files
    bg1.jpg
    xform.cpp
    xform.html
)

qt_add_resources(affine "affine"
    PREFIX
        "/res/affine"
    FILES
        ${affine_resource_files}
)

include(GNUInstallDirs)
install(TARGETS affine
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_app_script(
    TARGET affine
    OUTPUT_SCRIPT deploy_script
    NO_COMPILER_RUNTIME
    NO_TRANSLATIONS
    NO_UNSUPPORTED_PLATFORM_ERROR
)
install(SCRIPT ${deploy_script})
include(InstallRequiredSystemLibraries)

# Set some values for the AppxManifest.xml
set(APPX_PACKAGE_GUID "9801A16D-FCD7-48FD-A132-2ED185569A20")
set(APPX_PACKAGE_PUBLISHER "CN=qt-project.org")
set(APPX_PACKAGE_VERSION "1.0.0.0")
set(APPX_PACKAGE_ARCHITECTURE "x64")
set(APPX_PACKAGE_PUBLISHER_DISPLAY_NAME "qt-project.org")
set(APPX_PACKAGE_SHORT_NAME "affine")
set(APPX_PACKAGE_DESCRIPTION "Affine Transformations Qt Example")
set(APPX_PACKAGE_PFX_SIGNATURE_KEY "affine_TemporaryKey.pfx")
set(APPX_PACKAGE_EXECUTABLE ${CMAKE_INSTALL_BINDIR}/affine.exe)
set(APPX_PACKAGE_NAME affine.appx)

configure_file(AppxManifest.xml.in ${CMAKE_CURRENT_BINARY_DIR}/AppxManifest.xml)
install(
  FILES ${CMAKE_CURRENT_BINARY_DIR}/AppxManifest.xml
  DESTINATION ${CMAKE_INSTALL_PREFIX}
)
install(DIRECTORY Assets DESTINATION ${CMAKE_INSTALL_PREFIX})

if (NOT EXISTS ${CMAKE_SOURCE_DIR}/${APPX_PACKAGE_PFX_SIGNATURE_KEY})
  message(FATAL_ERROR
    "Make sure to either point to the right certificate pfx file "
    "or run make-self-signed-certificate.cmd to create a self signed certificate.\n"
    "make-self-signed-certificate.cmd needs to be run from a Visual C++ configured shell.\n"
    "install-self-signed-certificate.cmd needs to be run as Administrator.")
endif()

# Execute makeappx and signtool
install(CODE "
  file(REMOVE ${CMAKE_BINARY_DIR}/${APPX_PACKAGE_NAME})
  execute_process(
    COMMAND makeappx pack /d ${CMAKE_INSTALL_PREFIX}\ /p ${CMAKE_BINARY_DIR}/${APPX_PACKAGE_NAME})
  execute_process(
    COMMAND signtool sign /a /v /fd SHA256 /f ${CMAKE_SOURCE_DIR}/${APPX_PACKAGE_PFX_SIGNATURE_KEY} ${CMAKE_BINARY_DIR}/${APPX_PACKAGE_NAME})
")
