cmake_minimum_required(VERSION 3.18)
project(libFoo VERSION 1.1.0 LANGUAGES C)

# Create the shared library
add_library(libFoo SHARED foo.c foo.h)

# Set library output name (without 'lib' prefix duplication)
set_target_properties(libFoo PROPERTIES
    OUTPUT_NAME Foo
    VERSION 1.1.0
    SOVERSION 1
)

# Check if linker supports --version-script
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/cmaketest.map
"{
  global:
    main;
  local:
    *;
};")

include(CheckLinkerFlag)
check_linker_flag(C "-Wl,--version-script=${CMAKE_CURRENT_BINARY_DIR}/cmaketest.map" HAVE_LD_VERSION_SCRIPT)
file(REMOVE ${CMAKE_CURRENT_BINARY_DIR}/cmaketest.map)

# Add version script if supported
if(HAVE_LD_VERSION_SCRIPT)
  target_link_options(libFoo PRIVATE "-Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/libFoo.map")
  set_target_properties(libFoo PROPERTIES
    LINK_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/libFoo.map)
endif()
