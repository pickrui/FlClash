"""Choose release test scope and enforce the final publication gate."""
import argparse
import json
import os
import re
import subprocess

# Deep checks only run Go: nothing outside the core module, its submodule and
# the scripts the deep workflow calls can change their outcome.
DEEP_PREFIXES = ("core/",)
DEEP_FILES = {
    ".gitmodules", ".github/workflows/go-deep-tests.yaml", "tool/go_build_tags.env",
    "tool/check_form_dependencies.py", "tool/check_mieru_dependencies.py",
    "tool/check_quic_dependencies.py", "tool/release_checks.py",
}
REQUIRED_JOBS = (
    "version", "test", "go-test", "android-core-test", "android-test",
    "windows-helper-test",
)


def needs_deep_tests(paths):
    return any(path in DEEP_FILES or path.startswith(DEEP_PREFIXES) for path in paths)


def successful_shas(runs, current_run):
    for run in runs:
        sha = run.get("head_sha", "")
        if (str(run.get("id")) != str(current_run)
                and run.get("conclusion") == "success"
                and run.get("event") == "push"
                and re.fullmatch(r"[0-9a-f]{40}", sha)):
            yield sha


def git(*args):
    return subprocess.run(["git", *args], check=True, capture_output=True, timeout=30).stdout


def select_scope(repository, head, run_id):
    try:
        response = subprocess.run(
            ["gh", "api", f"repos/{repository}/actions/workflows/build.yaml/runs"
             "?status=success&event=push&per_page=100"],
            check=True, capture_output=True, text=True, timeout=30,
        )
        runs = json.loads(response.stdout)["workflow_runs"]
        for baseline in successful_shas(runs, run_id):
            try:
                git("cat-file", "-e", f"{baseline}^{{commit}}")
            except subprocess.CalledProcessError:
                git("fetch", "--no-tags", "origin", baseline)
            if subprocess.run(
                ["git", "merge-base", "--is-ancestor", baseline, head],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=30,
            ).returncode != 0:
                continue
            paths = git("diff", "--no-renames", "--name-only", "-z", baseline, head)
            changed = [p for p in paths.decode().split("\0") if p]
            return needs_deep_tests(changed), baseline
    except (OSError, ValueError, KeyError, subprocess.CalledProcessError, subprocess.TimeoutExpired):
        print("Could not verify a successful ancestor; requiring deep tests")
    return True, ""


def validate_gate(needs):
    failures = [name for name in REQUIRED_JOBS
                if needs.get(name, {}).get("result") != "success"]
    deep = needs.get("version", {}).get("outputs", {}).get("deep_tests")
    result = needs.get("deep-tests", {}).get("result")
    if deep not in ("true", "false") or not (
        result == "success" or deep == "false" and result == "skipped"
    ):
        failures.append("deep-tests")
    if failures:
        raise ValueError("Release checks did not pass: " + ", ".join(failures))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=("scope", "gate"))
    args = parser.parse_args()
    if args.mode == "gate":
        validate_gate(json.loads(os.environ["NEEDS_JSON"]))
        print("All required release checks passed")
        return
    deep, baseline = select_scope(
        os.environ["GITHUB_REPOSITORY"], os.environ["GITHUB_SHA"],
        os.environ["GITHUB_RUN_ID"],
    )
    with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as output:
        output.write(f"deep_tests={str(deep).lower()}\nbaseline={baseline}\n")
    print(f"Deep tests: {deep}; successful ancestor: {baseline or 'none'}")


if __name__ == "__main__":
    main()
