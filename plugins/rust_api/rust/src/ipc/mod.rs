#[cfg(not(target_os = "android"))]
mod desktop;
#[cfg(not(target_os = "android"))]
pub use desktop::{restart_ipc_server, send_ipc_message, stop_ipc_server};

#[cfg(target_os = "android")]
mod android {
    use crate::frb_generated::StreamSink;
    use flutter_rust_bridge::for_generated::SseCodec;

    pub fn restart_ipc_server(_: String, _: StreamSink<Vec<u8>, SseCodec>) -> Result<(), String> {
        Err("Desktop IPC is unavailable on Android".into())
    }
    pub fn send_ipc_message(_: Vec<u8>) -> Result<(), String> {
        Err("Desktop IPC is unavailable on Android".into())
    }
    pub fn stop_ipc_server() -> Result<(), String> {
        Ok(())
    }
}
#[cfg(target_os = "android")]
pub use android::{restart_ipc_server, send_ipc_message, stop_ipc_server};
