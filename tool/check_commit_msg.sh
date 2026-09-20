#!/usr/bin/env bash

set -euo pipefail

message_file="${1:?commit message file is required}"

# The subject and the body have to be cut from the same text, or they overlap:
# `git commit --cleanup=verbatim` and hook-written templates leave blank lines
# above the subject, and a body taken as "everything from line two" then
# contains the subject itself.
cleaned="$(grep -v '^#' "$message_file" | sed '/[^[:space:]]/,$!d' || true)"

subject="$(head -n 1 <<<"$cleaned")"

if [[ -z "$subject" ]]; then
  echo 'Commit message is empty.' >&2
  exit 1
fi

if [[ "$subject" =~ ^(Merge|Revert)[[:space:]] ]]; then
  exit 0
fi

if [[ "$subject" =~ ^(fixup|squash)! ]]; then
  exit 0
fi

types='feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert'

if [[ ! "$subject" =~ ^($types)(\([a-z0-9,./_-]+\))?!?:[[:space:]].+ ]]; then
  cat >&2 <<MESSAGE
Commit subject does not follow Conventional Commits:

  $subject

Expected: <type>[(scope)][!]: <description>
Types:    ${types//|/, }
Examples:
  fix(core): keep the tunnel routes out of the way of a restart
  feat(store): quote purchases before submitting them
  fix(ci)!: drop the legacy artifact layout
MESSAGE
  exit 1
fi

if [[ ${#subject} -gt 100 ]]; then
  echo "Commit subject is ${#subject} characters; keep it within 100." >&2
  exit 1
fi

description="${subject#*: }"

first_word="${description%% *}"
first_word="${first_word%%[^[:alnum:]]*}"

if [[ "$first_word" =~ ^[A-Z][a-z]+$ ]]; then
  echo "Commit description should start in lower case: $description" >&2
  echo 'Identifiers and acronyms keep their own casing, for example AppBar or DNS.' >&2
  exit 1
fi

if [[ "$description" =~ \.$ ]]; then
  echo "Commit description should not end with a period: $description" >&2
  exit 1
fi

body="$(tail -n +2 <<<"$cleaned")"

agents='anthropic|claude|codex|copilot|cursor|devin|gemini|openai|\[bot\]'

if grep -qiE "($agents)" <<<"$cleaned"; then
  cat >&2 <<'MESSAGE'
Do not mention a coding agent in the commit message.

The history records what changed and why, not which tool typed it: no
Co-authored-by, no generated-with footer, no tool name in the body.
MESSAGE
  exit 1
fi

if [[ "$subject" =~ ^($types)(\([a-z0-9,./_-]+\))?!: ]] &&
  ! grep -qE '^BREAKING[ -]CHANGE:' <<<"$body"; then
  cat >&2 <<'MESSAGE'
A breaking commit needs a BREAKING CHANGE footer describing what breaks:

  feat(backup)!: new archive layout

  BREAKING CHANGE: Archives from 0.8.95 and earlier need re-import
MESSAGE
  exit 1
fi
