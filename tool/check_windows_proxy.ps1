$ErrorActionPreference = "Stop"
$repoPath = Split-Path -Parent $PSScriptRoot
$testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("flclash-proxy-test-" + [guid]::NewGuid())

function Invoke-Checked {
    param([string]$Command, [string[]]$Arguments)
    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Command failed with exit code $LASTEXITCODE"
    }
}

try {
    Invoke-Checked flutter @("create", "--no-pub", "--platforms=windows", "--project-name=proxy_test_host", $testRoot)
    $pluginPath = (Join-Path $repoPath "plugins/proxy").Replace("\", "/").Replace("'", "''")
    @"
name: proxy_test_host
publish_to: none
version: 1.0.0+1
environment:
  sdk: '>=3.8.0 <4.0.0'
dependencies:
  flutter:
    sdk: flutter
  proxy:
    path: '$pluginPath'
flutter:
  uses-material-design: true
"@ | Set-Content -Encoding utf8 (Join-Path $testRoot "pubspec.yaml")
    # The generated counter app can require a newer Dart language version than
    # the plugin host. Only a minimal entry point is needed for native tests.
    @"
import 'package:flutter/widgets.dart';

void main() => runApp(const SizedBox.shrink());
"@ | Set-Content -Encoding utf8 (Join-Path $testRoot "lib/main.dart")
    Push-Location $testRoot
    try {
        Invoke-Checked flutter @("pub", "get")
        Invoke-Checked flutter @("build", "windows", "--debug")
        Invoke-Checked cmake @("-S", "windows", "-B", "build/windows/x64", "-Dinclude_proxy_tests=ON")
        Invoke-Checked cmake @("--build", "build/windows/x64", "--config", "Debug", "--target", "proxy_test")
        Invoke-Checked ctest @("--test-dir", "build/windows/x64/plugins/proxy", "-C", "Debug", "--output-on-failure", "--no-tests=error")
    } finally {
        Pop-Location
    }
} finally {
    if (Test-Path $testRoot) {
        Remove-Item -Recurse -Force $testRoot
    }
}
