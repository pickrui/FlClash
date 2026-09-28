import unittest
from tool.release_checks import REQUIRED_JOBS, validate_gate


class ReleaseChecksTest(unittest.TestCase):
    def passing(self):
        return {name: {"result": "success"} for name in REQUIRED_JOBS}

    def test_accepts_successful_required_checks(self):
        validate_gate(self.passing())

    def test_required_checks_cannot_be_skipped_cancelled_or_failed(self):
        for name in REQUIRED_JOBS:
            for result in ("skipped", "cancelled", "failure"):
                with self.subTest(name=name, result=result):
                    needs = self.passing()
                    needs[name]["result"] = result
                    with self.assertRaises(ValueError):
                        validate_gate(needs)

    def test_missing_required_check_cannot_pass(self):
        for name in REQUIRED_JOBS:
            with self.subTest(name=name):
                needs = self.passing()
                del needs[name]
                with self.assertRaises(ValueError):
                    validate_gate(needs)
