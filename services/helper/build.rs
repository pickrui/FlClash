fn main() {
    let core_sha256 = std::env::var("CORE_SHA256").unwrap_or_default();
    let default_name = if std::env::var("CARGO_CFG_TARGET_OS").as_deref() == Ok("windows") {
        "FlClashCore.exe"
    } else {
        "FlClashCore"
    };
    let core_name = std::env::var("CORE_NAME").unwrap_or_else(|_| default_name.to_string());
    println!("cargo:rustc-env=CORE_SHA256={}", core_sha256);
    println!("cargo:rustc-env=CORE_NAME={}", core_name);
    println!("cargo:rerun-if-env-changed=CORE_SHA256");
    println!("cargo:rerun-if-env-changed=CORE_NAME");
}
