import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:proxy/proxy_platform_interface.dart';

enum DiagnosticProxyState { matching, disabled, different, automatic, unknown }

class DiagnosticSystemState {
  final DiagnosticProxyState proxy;
  final bool? tunRoute;
  const DiagnosticSystemState({
    this.proxy = DiagnosticProxyState.unknown,
    this.tunRoute,
  });
}

// The native proxy plugin reads WinINet flags. PowerShell only reads a route;
// no configuration values are interpolated into this command or the report.
const windowsNetworkDiagnosticScript = r'''
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
$result = @{}
try {
  $route = @(Find-NetRoute -RemoteIPAddress '1.1.1.1' -ErrorAction Stop)[0]
  $result.routeInterface = [string]$route.InterfaceAlias
} catch { }
$result | ConvertTo-Json -Compress
''';

typedef DiagnosticCommandRunner =
    Future<String> Function(
      String executable,
      List<String> arguments,
      CancelToken cancellation,
    );

class NetworkDiagnosticPlatform {
  final String platform;
  final DiagnosticCommandRunner runCommand;
  final Future<Map<String, dynamic>?> Function() readWindowsProxy;
  NetworkDiagnosticPlatform({
    String? platform,
    DiagnosticCommandRunner? runCommand,
    Future<Map<String, dynamic>?> Function()? readWindowsProxy,
  }) : platform = platform ?? Platform.operatingSystem,
       runCommand = runCommand ?? runDiagnosticCommand,
       readWindowsProxy =
           readWindowsProxy ?? ProxyPlatform.instance.getProxySettings;

  Future<DiagnosticSystemState> inspect(
    int port,
    String? tunDevice,
    CancelToken token,
  ) async {
    try {
      if (platform == 'windows') {
        var data = <String, dynamic>{};
        try {
          data =
              await readWindowsProxy().timeout(const Duration(seconds: 2)) ??
              data;
        } catch (_) {}
        if (tunDevice != null && tunDevice.isNotEmpty && !token.isCancelled) {
          try {
            final root = Platform.environment['SystemRoot'] ?? r'C:\Windows';
            final raw = await runCommand(
              '$root\\System32\\WindowsPowerShell\\v1.0\\powershell.exe',
              [
                '-NoLogo',
                '-NoProfile',
                '-NonInteractive',
                '-Command',
                windowsNetworkDiagnosticScript,
              ],
              token,
            );
            final route = jsonDecode(raw);
            if (route is Map) {
              data = {...data, 'routeInterface': route['routeInterface']};
            }
          } catch (_) {}
        }
        return parseWindowsDiagnosticState(data, port, tunDevice);
      }
      if (platform == 'macos') {
        // Failure to inspect the route must not discard valid proxy evidence.
        final proxy = await runCommand('/usr/sbin/scutil', ['--proxy'], token);
        String? route;
        if (tunDevice != null && tunDevice.isNotEmpty && !token.isCancelled) {
          try {
            route = await runCommand('/sbin/route', [
              '-n',
              'get',
              '1.1.1.1',
            ], token);
          } catch (_) {}
        }
        return parseMacosDiagnosticState(proxy, route, port, tunDevice);
      }
    } catch (_) {}
    return const DiagnosticSystemState();
  }
}

bool _matchesProxy(String address, int port) {
  final uri = Uri.tryParse('http://${address.trim()}');
  if (uri == null ||
      uri.userInfo.isNotEmpty ||
      uri.port != port ||
      uri.path.isNotEmpty ||
      uri.hasQuery ||
      uri.hasFragment) {
    return false;
  }
  return uri.host.toLowerCase() == 'localhost' ||
      (InternetAddress.tryParse(uri.host)?.isLoopback ?? false);
}

DiagnosticSystemState parseWindowsDiagnosticState(
  Map<String, dynamic> data,
  int port,
  String? tunDevice,
) {
  var proxy = DiagnosticProxyState.unknown;
  final flags = data['flags'];
  // PROXY_TYPE_AUTO_PROXY_URL (4) and PROXY_TYPE_AUTO_DETECT (8). Saved
  // addresses alone do not prove an enabled PAC/WPAD or manual proxy.
  if (flags is! int || flags < 0) {
    proxy = DiagnosticProxyState.unknown;
  } else if ((flags & 12) != 0) {
    proxy = DiagnosticProxyState.automatic;
  } else if ((flags & 2) == 0) {
    proxy = DiagnosticProxyState.disabled;
  } else if (data['proxyServer'] is String) {
    final server = (data['proxyServer'] as String).trim();
    final entries = <String, String>{};
    for (final entry in server.split(';')) {
      final separator = entry.indexOf('=');
      if (separator > 0) {
        entries[entry.substring(0, separator).trim().toLowerCase()] = entry
            .substring(separator + 1)
            .trim();
      }
    }
    final matches = entries.isEmpty
        ? _matchesProxy(server, port)
        : _matchesProxy(entries['http'] ?? '', port) &&
              _matchesProxy(entries['https'] ?? '', port);
    proxy = matches
        ? DiagnosticProxyState.matching
        : DiagnosticProxyState.different;
  }
  final route = data['routeInterface'];
  return DiagnosticSystemState(
    proxy: proxy,
    tunRoute:
        tunDevice == null ||
            tunDevice.isEmpty ||
            route is! String ||
            route.isEmpty
        ? null
        : route.toLowerCase() == tunDevice.toLowerCase(),
  );
}

bool _matchesMacosProxy(Map<String, String> values, String protocol, int port) {
  final host = values['${protocol}Proxy'];
  final actualPort = int.tryParse(values['${protocol}Port'] ?? '');
  if (host == null || actualPort != port) return false;
  return host.toLowerCase() == 'localhost' ||
      (InternetAddress.tryParse(host)?.isLoopback ?? false);
}

DiagnosticSystemState parseMacosDiagnosticState(
  String raw,
  String? route,
  int port,
  String? tunDevice,
) {
  final values = <String, String>{};
  var depth = 0;
  for (final line in raw.split('\n')) {
    // Scoped and supplemental dictionaries may describe a different interface.
    if (depth == 1) {
      final match = RegExp(r'^\s*(\w+)\s*:\s*([^<{]+)\s*$').firstMatch(line);
      if (match != null) values[match[1]!] = match[2]!.trim();
    }
    depth += '{'.allMatches(line).length - '}'.allMatches(line).length;
  }
  final DiagnosticProxyState proxy;
  if (values['ProxyAutoConfigEnable'] == '1' ||
      values['ProxyAutoDiscoveryEnable'] == '1') {
    proxy = DiagnosticProxyState.automatic;
  } else if (values['HTTPEnable'] == '1' || values['HTTPSEnable'] == '1') {
    final matches =
        values['HTTPEnable'] == '1' &&
        values['HTTPSEnable'] == '1' &&
        _matchesMacosProxy(values, 'HTTP', port) &&
        _matchesMacosProxy(values, 'HTTPS', port);
    proxy = matches
        ? DiagnosticProxyState.matching
        : DiagnosticProxyState.different;
  } else {
    proxy = raw.contains('<dictionary>')
        ? DiagnosticProxyState.disabled
        : DiagnosticProxyState.unknown;
  }
  final interface = route == null
      ? null
      : RegExp(
          r'^\s*interface:\s*(\S+)\s*$',
          multiLine: true,
        ).firstMatch(route)?[1];
  return DiagnosticSystemState(
    proxy: proxy,
    tunRoute: tunDevice == null || tunDevice.isEmpty || interface == null
        ? null
        : interface == tunDevice,
  );
}

Future<String> runDiagnosticCommand(
  String executable,
  List<String> arguments,
  CancelToken cancellation,
) async {
  if (cancellation.isCancelled) throw StateError('Diagnostic canceled');
  final process = await Process.start(executable, arguments, runInShell: false);
  final canceled = cancellation.whenCancel.asStream().listen(
    (_) => process.kill(),
  );
  var timedOut = false;
  final deadline = Timer(const Duration(seconds: 4), () {
    timedOut = true;
    process.kill();
  });
  final output = BytesBuilder(copy: false);
  var exceeded = false;
  var total = 0;
  void consume(List<int> chunk, bool capture) {
    total += chunk.length;
    if (total > 64 * 1024) {
      exceeded = true;
      process.kill();
      return;
    }
    if (capture) output.add(chunk);
  }

  final stdout = process.stdout.listen((chunk) => consume(chunk, true));
  final stderr = process.stderr.listen((chunk) => consume(chunk, false));
  final stdoutDone = stdout.asFuture<void>();
  final stderrDone = stderr.asFuture<void>();
  try {
    final code = await process.exitCode.timeout(const Duration(seconds: 5));
    await Future.wait([
      stdoutDone,
      stderrDone,
    ]).timeout(const Duration(seconds: 1));
    if (code != 0 || exceeded || timedOut || cancellation.isCancelled) {
      throw StateError('Diagnostic command unavailable');
    }
    return utf8
        .decode(output.takeBytes(), allowMalformed: true)
        .replaceFirst('\ufeff', '');
  } finally {
    deadline.cancel();
    process.kill();
    await canceled.cancel();
    await stdout.cancel();
    await stderr.cancel();
  }
}
