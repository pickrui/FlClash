# flutter_js only ships a prebuilt x64 quickjs_c_bridge.dll, so on Windows arm64
# loading it fails with "%1 is not a valid Win32 application" (error code 193)
# and the script override feature is unusable. Build the bridge from the pinned
# quickjs-c-bridge sources instead so it always matches the target architecture.
# This directory is added last, which makes the install rule below run after the
# plugin's and replace the prebuilt DLL in the bundle.
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
target_include_directories(flclash_quickjs PUBLIC "${QUICKJS_SRC_DIR}")
target_include_directories(flclash_quickjs PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_compile_definitions(flclash_quickjs PRIVATE "CONFIG_VERSION=\"${QUICKJS_VERSION}\"")
target_compile_options(flclash_quickjs PRIVATE "$<$<C_COMPILER_ID:MSVC>:/utf-8>")

# quickjs.c stores libm addresses in a static table, but /O2 turns them into
# intrinsics without constant addresses (C2099). Limit /Oi- to that source.
set_property(SOURCE "${QUICKJS_SRC_DIR}/quickjs/quickjs.c"
  APPEND PROPERTY COMPILE_OPTIONS
  "$<$<C_COMPILER_ID:MSVC>:/Oi->"
)

# Both sources use the POSIX alloca name, which MSVC does not expose on arm64.
set_property(SOURCE
  "${QUICKJS_SRC_DIR}/quickjs/quickjs.c"
  "${QUICKJS_SRC_DIR}/quickjs/libregexp.c"
  APPEND PROPERTY COMPILE_OPTIONS
  "$<$<C_COMPILER_ID:MSVC>:/FImsvc_compat.h>"
)

add_library(quickjs_c_bridge SHARED
  "${QUICKJS_SRC_DIR}/libfastdev_quickjs_runtime.cpp"
)
target_compile_features(quickjs_c_bridge PRIVATE cxx_std_17)
target_compile_options(quickjs_c_bridge PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")
target_link_libraries(quickjs_c_bridge PRIVATE flclash_quickjs)

install(FILES "$<TARGET_FILE:quickjs_c_bridge>"
  DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
  COMPONENT Runtime)
