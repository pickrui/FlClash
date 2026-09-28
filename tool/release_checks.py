"""Enforce the publication gate for the release workflow."""
import argparse
import json
import os

REQUIRED_JOBS = (
    "version", "test", "go-test", "android-core-test", "android-test",
    "windows-helper-test",
)


def validate_gate(needs):
    failures = [name for name in REQUIRED_JOBS
                if needs.get(name, {}).get("result") != "success"]
    if failures:
        raise ValueError("Release checks did not pass: " + ", ".join(failures))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=("gate",))
    parser.parse_args()
    validate_gate(json.loads(os.environ["NEEDS_JSON"]))
    print("All required release checks passed")


if __name__ == "__main__":
    main()
