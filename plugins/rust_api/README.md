# rust_api

Desktop IPC, the QuickJS script runtime and global hotkeys, exposed through Flutter Rust Bridge 2.13

`hook/build.dart` compiles and bundles the library with Native Assets. `rust/rust-toolchain.toml` pins Rust and supported targets. Android bindgen uses the NDK libclang; macOS keeps deployment target 12.0

From this directory, regenerate bindings with `flutter_rust_bridge_codegen generate` using version 2.13.0. Validate with `cargo test --locked --manifest-path rust/Cargo.toml`

The application unit-test jobs set `hooks.user_defines.rust_api.build_assets` to false and explicitly build a fixture library. Packaging requires both native hooks to be enabled; `setup.dart` remains the release entry point
