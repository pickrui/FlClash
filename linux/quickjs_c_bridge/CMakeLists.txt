# flutter_js only ships a prebuilt x86-64 libquickjs_c_bridge_plugin.so, and its
# own install rule targets a stale prefix that the bundle wipe later removes, so
# the script override feature is broken on Linux (hard failure on arm64). Build
# the bridge from the pinned quickjs-c-bridge sources instead. This directory is
# added last so the install rule below runs after the bundle wipe.
enable_language(C)

set(QUICKJS_SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../third_party/quickjs-c-bridge/cxx")

if(NOT EXISTS "${QUICKJS_SRC_DIR}/libfastdev_quickjs_runtime.cpp")
  message(FATAL_ERROR
    "quickjs-c-bridge sources are missing. Run: git submodule update --init --recursive")
endif()

file(STRINGS "${QUICKJS_SRC_DIR}/quickjs/VERSION" QUICKJS_VERSION)

add_library(flclash_quickjs STATIC
  "${QUICKJS_SRC_DIR}/quickjs/cutils.c"
  "${QUICKJS_SRC_DIR}/quickjs/libregexp.c"
  "${QUICKJS_SRC_DIR}/quickjs/libunicode.c"
  "${QUICKJS_SRC_DIR}/quickjs/quickjs.c"
)
set_target_properties(flclash_quickjs PROPERTIES
  POSITION_INDEPENDENT_CODE ON
  C_VISIBILITY_PRESET hidden)
target_include_directories(flclash_quickjs PUBLIC "${QUICKJS_SRC_DIR}")
target_compile_definitions(flclash_quickjs PRIVATE "CONFIG_VERSION=\"${QUICKJS_VERSION}\"")
# quickjs 2021-03-27 returns pointers as integers in a few places, which GCC 14+
# and recent Clang reject by default.
target_compile_options(flclash_quickjs PRIVATE -Wno-int-conversion)
target_link_libraries(flclash_quickjs PUBLIC m)

add_library(quickjs_c_bridge_plugin SHARED
  "${QUICKJS_SRC_DIR}/libfastdev_quickjs_runtime.cpp"
)
set_target_properties(quickjs_c_bridge_plugin PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_features(quickjs_c_bridge_plugin PRIVATE cxx_std_17)
target_link_libraries(quickjs_c_bridge_plugin PRIVATE flclash_quickjs)

install(FILES "$<TARGET_FILE:quickjs_c_bridge_plugin>"
  DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
  COMPONENT Runtime)
