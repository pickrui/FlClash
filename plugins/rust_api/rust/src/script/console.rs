use crate::api::script::ScriptLog;
use rquickjs::convert::Coerced;
use rquickjs::function::Rest;
use rquickjs::{CatchResultExt, Ctx, Function, Object, Result, Value};
use std::cell::RefCell;
use std::rc::Rc;

const MAX_LINES: usize = 256;
const MAX_LINE_BYTES: usize = 4096;
const MAX_BYTES: usize = 128 * 1024;

pub fn install(ctx: &Ctx<'_>, logs: Rc<RefCell<Vec<ScriptLog>>>) -> Result<()> {
    let console = Object::new(ctx.clone())?;
    let bytes = Rc::new(RefCell::new(0usize));
    for level in ["log", "info", "warn", "error", "debug", "trace"] {
        let logs = logs.clone();
        let bytes = bytes.clone();
        let print = Function::new(ctx.clone(), move |ctx, args| {
            write(level, ctx, args, &logs, &bytes)
        })?;
        console.set(level, print)?;
    }
    ctx.globals().set("console", console)
}

fn write<'js>(
    level: &str,
    ctx: Ctx<'js>,
    args: Rest<Value<'js>>,
    logs: &RefCell<Vec<ScriptLog>>,
    bytes: &RefCell<usize>,
) {
    // Never stream unbounded native logs or enqueue one Dart event per call.
    if logs.borrow().len() >= MAX_LINES || *bytes.borrow() >= MAX_BYTES {
        return;
    }
    let limit = MAX_LINE_BYTES.min(MAX_BYTES - *bytes.borrow());
    let mut line = String::new();
    for value in args.iter() {
        if !line.is_empty() {
            line.push(' ');
        }
        let text = format(&ctx, value);
        let mut end = text.len().min(limit.saturating_sub(line.len()));
        while !text.is_char_boundary(end) {
            end -= 1;
        }
        line.push_str(&text[..end]);
        if line.len() >= limit {
            break;
        }
    }
    // toJSON can itself call console. Recheck the shared budget after formatting.
    if logs.borrow().len() >= MAX_LINES || *bytes.borrow() >= MAX_BYTES {
        return;
    }
    let mut end = line.len().min(MAX_BYTES - *bytes.borrow());
    while !line.is_char_boundary(end) {
        end -= 1;
    }
    line.truncate(end);
    *bytes.borrow_mut() += line.len();
    logs.borrow_mut().push(ScriptLog {
        level: level.into(),
        output: line,
    });
}

fn format<'js>(ctx: &Ctx<'js>, value: &Value<'js>) -> String {
    if let Some(text) = value.as_string() {
        return text.to_string().unwrap_or_default();
    }
    // Clear any stringify or ToString exception (cycles, a throwing toJSON or
    // toString, symbols), so console formatting cannot poison the evaluation.
    if value.is_object() {
        if let Ok(Some(json)) = ctx.json_stringify(value.clone()).catch(ctx) {
            return json.to_string().unwrap_or_default();
        }
    }
    match value.get::<Coerced<String>>().catch(ctx) {
        Ok(text) => text.0,
        Err(_) => value.type_name().to_owned(),
    }
}
