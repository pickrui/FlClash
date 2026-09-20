import unittest
from tool.check_apk_version import verify_metadata


class ApkVersionTest(unittest.TestCase):
    def manifest(self, build, version="0.8.98", package="com.oixcloud.clash"):
        return f"package: name='{package}' versionCode='{build}' versionName='{version}' platformBuildVersionName='16'\n"

    def test_accepts_exact_shared_build_number(self):
        verify_metadata(self.manifest("2026092011"), "0.8.98", "2026092011")

    def test_rejects_every_flutter_abi_offset(self):
        for offset in (1000, 2000, 4000):
            with self.subTest(offset=offset), self.assertRaises(ValueError):
                verify_metadata(self.manifest(str(2026092011 + offset)), "0.8.98", "2026092011")

    def test_rejects_stale_version_missing_metadata_and_debug_flavor(self):
        for output in ("", self.manifest("2026092919"),
                       self.manifest("2026092011", version="0.8.97"),
                       self.manifest("2026092011", package="com.oixcloud.clash.dev")):
            with self.subTest(output=output), self.assertRaises(ValueError):
                verify_metadata(output, "0.8.98", "2026092011")
