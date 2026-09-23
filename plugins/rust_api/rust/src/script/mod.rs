mod console;

use crate::api::script::{ScriptEvaluation, ScriptLog};
use rquickjs::{CatchResultExt, Context, Function, Runtime, Value};
use std::cell::RefCell;
use std::rc::Rc;
use std::time::{Duration, Instant};

const TIMEOUT: Duration = Duration::from_secs(10);
const MEMORY_LIMIT: usize = 256 * 1024 * 1024;
const INPUT_LIMIT: usize = 32 * 1024 * 1024;

pub fn evaluate(script: &str, config: &str) -> ScriptEvaluation {
    evaluate_with_limits(script, config, TIMEOUT, MEMORY_LIMIT)
}

fn evaluate_with_limits(
    script: &str,
    config: &str,
    timeout: Duration,
    memory: usize,
) -> ScriptEvaluation {
    let logs = Rc::new(RefCell::new(Vec::<ScriptLog>::new()));
    let result = run(script, config, timeout, memory, logs.clone());
    let logs = std::mem::take(&mut *logs.borrow_mut());
    match result {
        Ok(config) => ScriptEvaluation {
            config: Some(config),
            error: None,
            logs,
        },
        Err(error) => ScriptEvaluation {
            config: None,
            error: Some(error),
            logs,
        },
    }
}

fn run(
    script: &str,
    config: &str,
    timeout: Duration,
    memory: usize,
    logs: Rc<RefCell<Vec<ScriptLog>>>,
) -> Result<String, String> {
    if script.len() > INPUT_LIMIT || config.len() > INPUT_LIMIT {
        return Err("script or profile exceeds the 32 MiB input limit".into());
    }
    let runtime = Runtime::new().map_err(|e| e.to_string())?;
    runtime.set_memory_limit(memory);
    let deadline = Instant::now() + timeout;
    runtime.set_interrupt_handler(Some(Box::new(move || Instant::now() >= deadline)));
    let context = Context::full(&runtime).map_err(|e| e.to_string())?;
    let result = context.with(|ctx| {
        console::install(&ctx, logs).catch(&ctx).map_err(describe)?;
        ctx.eval::<Value, _>(script.as_bytes())
            .catch(&ctx)
            .map_err(describe)?;
        // Lexical bindings such as `const main = ...` are not global properties.
        let entry: Function = ctx.eval(b"main").catch(&ctx).map_err(describe)?;
        let parsed: Value = ctx.json_parse(config).catch(&ctx).map_err(describe)?;
        let result: Value = entry.call((parsed,)).catch(&ctx).map_err(describe)?;
        let result = match result.as_promise() {
            Some(promise) => loop {
                // Check between jobs as well as inside JS: an endless chain of
                // individually short microtasks must also respect the deadline.
                if Instant::now() >= deadline {
                    return Err("script execution timed out".into());
                }
                if let Some(result) = promise.result::<Value>() {
                    break result.catch(&ctx).map_err(describe)?;
                }
                if !ctx.execute_pending_job() {
                    return Err("main() returned a Promise that did not settle".into());
                }
            },
            None => result,
        };
        if result.is_undefined() || result.is_null() {
            return Ok(config.to_owned());
        }
        if !result.is_object() || result.is_array() || result.is_function() {
            return Err("script did not return a configuration object".into());
        }
        let json = ctx
            .json_stringify(result)
            .catch(&ctx)
            .map_err(describe)?
            .ok_or_else(|| "script result is not JSON".to_owned())?;
        let json = json.to_string().map_err(|e| e.to_string())?;
        if json.len() > INPUT_LIMIT {
            return Err("script result exceeds the 32 MiB output limit".into());
        }
        Ok(json)
    });
    if Instant::now() >= deadline {
        Err("script execution timed out".into())
    } else {
        result
    }
}

fn describe(error: rquickjs::CaughtError<'_>) -> String {
    match error {
        rquickjs::CaughtError::Exception(exception) => {
            let message = exception.message().unwrap_or_else(|| exception.to_string());
            match exception.stack() {
                Some(stack) if !stack.trim().is_empty() => format!("{message}\n{}", stack.trim()),
                _ => message,
            }
        }
        other => other.to_string(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn evaluate(script: &str, config: &str) -> Result<String, String> {
        let result = super::evaluate(script, config);
        result.error.map_or_else(|| Ok(result.config.unwrap()), Err)
    }
    fn evaluate_within(script: &str, config: &str, timeout: Duration) -> Result<String, String> {
        let result = evaluate_with_limits(script, config, timeout, MEMORY_LIMIT);
        result.error.map_or_else(|| Ok(result.config.unwrap()), Err)
    }

    use serde_json::{json, Value as Json};

    fn run(script: &str, config: Json) -> Result<Json, String> {
        evaluate(script, &config.to_string()).map(|out| serde_json::from_str(&out).unwrap())
    }

    #[test]
    fn returns_the_object_main_produced() {
        let result = run(
            "function main(config) { config.mode = 'global'; return config }",
            json!({ "mode": "rule" }),
        )
        .unwrap();

        assert_eq!(result, json!({ "mode": "global" }));
    }

    #[test]
    fn accepts_a_lexically_declared_arrow_function_entry() {
        let result = run(
            "const main = (config) => { return config; }",
            json!({ "mode": "rule" }),
        )
        .unwrap();

        assert_eq!(result, json!({ "mode": "rule" }));
    }

    #[test]
    fn keeps_the_profile_when_main_returns_nothing() {
        let result = run("function main(config) {}", json!({ "mode": "rule" })).unwrap();

        assert_eq!(result, json!({ "mode": "rule" }));
    }

    #[test]
    fn resolves_a_promise_main_returns() {
        let result = run(
            "async function main(config) { config.mode = 'global'; return config }",
            json!({ "mode": "rule" }),
        )
        .unwrap();

        assert_eq!(result, json!({ "mode": "global" }));
    }

    #[test]
    fn reports_the_rejection_of_a_promise_main_returns() {
        let error = run(
            "async function main() { throw new Error('bad profile') }",
            json!({}),
        )
        .unwrap_err();

        assert!(error.contains("bad profile"), "{error}");
    }

    #[test]
    fn reports_a_promise_that_never_settles() {
        let error = run(
            "function main() { return new Promise(() => {}) }",
            json!({}),
        )
        .unwrap_err();

        assert!(error.contains("did not settle"), "{error}");
    }

    #[test]
    fn reports_a_missing_entry_point() {
        let error = run("const value = 1", json!({})).unwrap_err();

        assert!(error.contains("main"), "{error}");
    }

    #[test]
    fn reports_the_message_and_stack_of_a_thrown_error() {
        let error = run(
            "function main() { throw new Error('bad profile') }",
            json!({}),
        )
        .unwrap_err();

        assert!(error.contains("bad profile"), "{error}");
        assert!(error.contains("main"), "{error}");
    }

    #[test]
    fn reports_a_syntax_error_with_its_location() {
        let error = run("function main( {", json!({})).unwrap_err();

        assert!(error.contains(":1:"), "{error}");
    }

    #[test]
    fn stops_a_script_that_never_finishes() {
        let started = Instant::now();
        let error = evaluate_within(
            "function main() { while (true) {} }",
            "{}",
            Duration::from_millis(100),
        )
        .unwrap_err();

        assert!(!error.is_empty());
        assert!(started.elapsed() < Duration::from_secs(5));
    }

    #[test]
    fn console_calls_do_not_stop_a_script() {
        let result = run(
            "function main(config) { console.log('a', 1); console.error({}); return config }",
            json!({ "mode": "rule" }),
        )
        .unwrap();

        assert_eq!(result, json!({ "mode": "rule" }));
    }

    #[test]
    fn supports_the_language_features_profile_scripts_use() {
        let script = r#"
            const regions = new Map([['HK', '🇭🇰']]);
            function main(config) {
              const names = [...new Set(config.proxies.map((proxy) => proxy.name))];
              const flag = regions.get('HK') ?? '';
              return {
                ...config,
                names: names.map((name) => `${flag} ${name}`.trim()),
                first: config.proxies?.[0]?.name ?? null,
                entries: Object.fromEntries(names.map((name, index) => [name, index])),
              };
            }
        "#;

        let result = run(
            script,
            json!({ "proxies": [{ "name": "a" }, { "name": "b" }, { "name": "a" }] }),
        )
        .unwrap();

        assert_eq!(result["names"], json!(["🇭🇰 a", "🇭🇰 b"]));
        assert_eq!(result["first"], json!("a"));
        assert_eq!(result["entries"], json!({ "a": 0, "b": 1 }));
    }

    fn overwrite_fixture() -> Json {
        let script = include_str!("../../tests/fixtures/profile_script.js");
        let config = include_str!("../../tests/fixtures/profile_config.json");

        serde_json::from_str(&evaluate(script, config).unwrap()).unwrap()
    }

    #[test]
    fn runs_a_profile_overwrite_end_to_end() {
        let result = overwrite_fixture();
        let proxies = result["proxies"].as_array().unwrap();
        let groups = result["proxy-groups"].as_array().unwrap();
        let rules = result["rules"].as_array().unwrap();

        assert_eq!(proxies.len(), 10);
        assert_eq!(groups.len(), 17);
        assert_eq!(rules.len(), 12);
        assert_eq!(rules.last().unwrap(), &json!("MATCH,手动选择"));
    }

    #[test]
    fn the_overwrite_renames_nodes_and_rewrites_the_chains_through_them() {
        let result = overwrite_fixture();
        let proxies = result["proxies"].as_array().unwrap();
        let named = |name: &str| {
            proxies
                .iter()
                .find(|proxy| proxy["name"] == json!(name))
                .unwrap_or_else(|| panic!("{name} is missing"))
        };

        assert!(proxies
            .iter()
            .all(|proxy| proxy["name"] != json!("官网 https://example.com")));
        assert_eq!(named("🇬🇧 英国 01")["dialer-proxy"], json!("🇭🇰 香港 01"));
        assert_eq!(named("🏳️ 其他 02")["dialer-proxy"], json!(null));
        assert_eq!(named("🇭🇰 香港 02 | 2x")["server"], json!("hk2.example.com"));
    }

    #[test]
    fn the_overwrite_merges_dns_instead_of_replacing_it() {
        let dns = overwrite_fixture()["dns"].clone();

        assert_eq!(dns["enhanced-mode"], json!("fake-ip"));
        assert_eq!(dns["nameserver"], json!(["223.5.5.5", "119.29.29.29"]));
        assert_eq!(
            dns["nameserver-policy"]["+.example.com"],
            json!("223.5.5.5")
        );
        assert_eq!(dns["nameserver-policy"]["+.internal"], json!("system://"));
    }
    #[test]
    fn stops_top_level_loops_and_endless_microtasks() {
        for script in [
            "while (true) {}",
            "function main() { return new Promise(() => { function step() { Promise.resolve().then(step) } step() }) }",
            "function main() { return { toJSON() { while (true) {} } } }",
        ] {
            let started = Instant::now();
            let result = evaluate_with_limits(script, "{}", Duration::from_millis(50), MEMORY_LIMIT);
            assert_eq!(result.error.as_deref(), Some("script execution timed out"));
            assert!(started.elapsed() < Duration::from_secs(5));
        }
    }

    #[test]
    fn enforces_heap_limit_and_recovers_in_a_fresh_runtime() {
        let result = evaluate_with_limits(
            "function main() { const values = []; while(true) values.push(new Array(10000).fill('x')); }",
            "{}", Duration::from_secs(2), 2 * 1024 * 1024,
        );
        assert!(result.error.is_some());
        assert!(!result.error.unwrap().contains("timed out"));
        assert_eq!(
            run("function main(c) { return c }", json!({"ok": true})).unwrap(),
            json!({"ok": true})
        );
    }

    #[test]
    fn rejects_non_object_results_and_preserves_null_config() {
        for value in [
            "42",
            "true",
            "'text'",
            "[]",
            "() => {}",
            "{toJSON: () => 42}",
        ] {
            let result = super::evaluate(&format!("function main() {{ return {value} }}"), "{}");
            // A custom toJSON may change the type: Dart validates the decoded value too.
            if value.starts_with("{toJSON") {
                assert_eq!(result.config.as_deref(), Some("42"));
            } else {
                assert!(result.error.is_some(), "{value}");
            }
        }
        assert_eq!(
            run("function main(c) { c.x = 2; return null }", json!({"x": 1})).unwrap(),
            json!({"x": 1})
        );
    }

    #[test]
    fn preserves_console_on_failure_and_bounds_utf8_log_floods() {
        let result = super::evaluate(
            "function main() { console.warn('before', {x: 1}); throw new Error('failed') }",
            "{}",
        );
        assert!(result.error.unwrap().contains("failed"));
        assert_eq!(result.logs.len(), 1);
        assert_eq!(result.logs[0].level, "warn");
        assert_eq!(result.logs[0].output, "before {\"x\":1}");
        let result = super::evaluate("function main(c) { for (let i = 0; i < 10000; i++) console.log('中文'.repeat(2000)); return c }", "{}");
        assert!(result.error.is_none());
        assert!(result.logs.len() <= 256);
        assert!(
            result
                .logs
                .iter()
                .map(|log| log.output.len())
                .sum::<usize>()
                <= 128 * 1024
        );
        assert!(result.logs.iter().all(|log| log.output.len() <= 4096));
    }

    #[test]
    fn formats_console_values_json_cannot_represent() {
        let result = super::evaluate(
            "function main(c) { const cycle = {}; cycle.self = cycle; console.log(undefined, c.missing, NaN, function f() {}, 1n); console.log(Symbol('s'), cycle, null, {a: [1]}); return c }",
            "{}",
        );
        assert_eq!(result.error, None);
        assert_eq!(result.config.as_deref(), Some("{}"));
        let outputs: Vec<_> = result.logs.iter().map(|log| log.output.as_str()).collect();
        assert_eq!(
            outputs,
            [
                "undefined undefined NaN function f() {} 1",
                "symbol [object Object] null {\"a\":[1]}",
            ]
        );
    }

    #[test]
    fn isolates_global_state_and_console_formatting_errors() {
        run("globalThis.leak = 1; function main(c) { const cycle = {}; cycle.self = cycle; console.log(cycle); return c }", json!({})).unwrap();
        let result = run(
            "function main() { return {isolated: typeof leak === 'undefined'} }",
            json!({}),
        )
        .unwrap();
        assert_eq!(result, json!({"isolated": true}));
    }
    #[test]
    fn recursive_console_formatting_cannot_exceed_the_log_budget() {
        let result = super::evaluate("function main(c) { console.log({toJSON() { for (let i = 0; i < 1000; i++) console.log('x'.repeat(4096)); return 'outer'; }}); return c }", "{}");
        assert!(result.error.is_none());
        assert!(result.logs.len() <= 256);
        assert!(
            result
                .logs
                .iter()
                .map(|log| log.output.len())
                .sum::<usize>()
                <= 128 * 1024
        );
    }
}
