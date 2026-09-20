import copy
import json
import subprocess
import unittest
from unittest.mock import patch
from tool.release_checks import (
    REQUIRED_JOBS, needs_deep_tests, select_scope, successful_shas, validate_gate,
)


class ReleaseChecksTest(unittest.TestCase):
    def test_ui_and_documentation_only_can_reuse_successful_core(self):
        self.assertFalse(needs_deep_tests(["lib/views/theme.dart", "arb/intl_en.arb", "README.md"]))

    def test_toolchains_dependencies_submodules_and_build_scripts_require_depth(self):
        for path in ("core/Clash.Meta", "core/main.go", "pubspec.lock", "pubspec.yaml",
                     "setup.dart", "plugins/setup/setup_hooks/lib/src/go.dart",
                     "services/helper/Cargo.lock", ".github/workflows/build.yaml",
                     "android/gradle/libs.versions.toml", "tool/release_checks.py"):
            with self.subTest(path=path):
                self.assertTrue(needs_deep_tests([path]))

    def test_version_only_changes_do_not_trigger_deep_dependency_tests(self):
        before = "version: 0.8.97+2026091521\ndependencies: {dio: 5.8.0}\n"
        after = before.replace("0.8.97+2026091521", "0.8.98+2026092011")
        self.assertFalse(needs_deep_tests(["pubspec.yaml", "lib/views/theme.dart"], before, after))
        self.assertTrue(needs_deep_tests(["pubspec.yaml"], before, after.replace("5.8.0", "5.11.0")))
        self.assertTrue(needs_deep_tests(["pubspec.yaml"]))

    def test_failed_manual_and_current_runs_are_not_baselines(self):
        good = {"id": 1, "head_sha": "a" * 40, "event": "push", "conclusion": "success"}
        runs = [dict(good, conclusion="failure"), dict(good, event="workflow_dispatch"),
                dict(good, id=2), dict(good, head_sha="invalid"), good]
        self.assertEqual(list(successful_shas(runs, 2)), ["a" * 40])

    @patch("tool.release_checks.subprocess.run", side_effect=OSError("API unavailable"))
    def test_unavailable_baseline_requires_deep_checks(self, _):
        self.assertEqual(select_scope("fixture/repo", "b" * 40, 2), (True, ""))

    def test_nonancestor_success_is_ignored_before_comparing_current_lineage(self):
        first, ancestor, head = "a" * 40, "b" * 40, "c" * 40
        runs = [{"id": n, "head_sha": sha, "event": "push", "conclusion": "success"}
                for n, sha in [(1, first), (2, ancestor)]]
        def command(args, **kwargs):
            if args[0] == "gh":
                return subprocess.CompletedProcess(args, 0, json.dumps({"workflow_runs": runs}))
            if args[1] == "merge-base":
                return subprocess.CompletedProcess(args, int(args[-2] == first), b"")
            if args[1] == "diff":
                self.assertEqual(args[-2:], [ancestor, head])
                return subprocess.CompletedProcess(args, 0, b"lib/views/theme.dart\0")
            return subprocess.CompletedProcess(args, 0, b"")
        with patch("tool.release_checks.subprocess.run", side_effect=command):
            self.assertEqual(select_scope("fixture/repo", head, 3), (False, ancestor))

    @patch("tool.release_checks.subprocess.run", side_effect=subprocess.TimeoutExpired("gh", 30))
    def test_api_timeout_requires_depth_instead_of_waiting_for_the_job_timeout(self, _):
        self.assertEqual(select_scope("fixture/repo", "b" * 40, 2), (True, ""))

    def passing(self, deep="true"):
        needs = {name: {"result": "success"} for name in REQUIRED_JOBS}
        needs["version"]["outputs"] = {"deep_tests": deep}
        needs["deep-tests"] = {"result": "success"}
        return needs

    def test_required_checks_cannot_be_skipped_cancelled_or_failed(self):
        for name in (*REQUIRED_JOBS, "deep-tests"):
            for result in ("skipped", "cancelled", "failure"):
                with self.subTest(name=name, result=result):
                    needs = self.passing()
                    needs[name]["result"] = result
                    with self.assertRaises(ValueError):
                        validate_gate(needs)

    def test_depth_skip_is_only_accepted_with_explicit_verified_false(self):
        validate_gate(self.passing())
        needs = self.passing("false")
        needs["deep-tests"]["result"] = "skipped"
        validate_gate(needs)
        for value in (None, "", "true"):
            invalid = copy.deepcopy(needs)
            invalid["version"]["outputs"]["deep_tests"] = value
            with self.assertRaises(ValueError):
                validate_gate(invalid)
