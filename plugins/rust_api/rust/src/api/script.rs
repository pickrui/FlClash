use flutter_rust_bridge::frb;

pub struct ScriptLog {
    pub level: String,
    pub output: String,
}

pub struct ScriptEvaluation {
    pub config: Option<String>,
    pub error: Option<String>,
    pub logs: Vec<ScriptLog>,
}

/// Run the profile transform on a Rust worker with a fresh, bounded JS runtime.
/// Return logs even when evaluation fails, so the script editor can show them.
#[frb]
pub fn evaluate_script(script: String, config: String) -> ScriptEvaluation {
    crate::script::evaluate(&script, &config)
}
