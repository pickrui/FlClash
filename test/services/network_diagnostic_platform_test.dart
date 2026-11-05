import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_clash/services/network_diagnostic_platform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DiagnosticSystemState windows(Map<String, Object?> data) =>
      parseWindowsDiagnosticState(data, 7890, 'FlClash');
  test('Windows accepts combined or per-protocol loopback proxies', () {
    for (final server in [
      '127.0.0.1:7890',
      '[::1]:7890',
      'http=localhost:7890;https=127.0.0.1:7890;socks=localhost:9999',
    ]) {
      expect(
        windows({'flags': 2, 'proxyServer': server}).proxy,
        DiagnosticProxyState.matching,
      );
    }
  });
  test(
    'Windows detects disabled mismatched incomplete and automatic proxy',
    () {
      expect(windows({'flags': 1}).proxy, DiagnosticProxyState.disabled);
      expect(windows({'flags': 6}).proxy, DiagnosticProxyState.automatic);
      for (final server in [
        '127.0.0.1:7891',
        '192.0.2.1:7890',
        'http=localhost:7890',
        'http=localhost:7890;https=localhost:7891',
        'user@localhost:7890',
        'localhost:7890/unexpected',
      ]) {
        expect(
          windows({'flags': 2, 'proxyServer': server}).proxy,
          DiagnosticProxyState.different,
          reason: server,
        );
      }
      expect(windows({}).proxy, DiagnosticProxyState.unknown);
    },
  );
  test('Windows uses PAC/WPAD enable flags instead of saved URLs', () {
    for (final flags in [4, 8, 6, 10, 14]) {
      expect(
        windows({'flags': flags, 'proxyServer': '127.0.0.1:7890'}).proxy,
        DiagnosticProxyState.automatic,
      );
    }
    expect(
      windows({
        'flags': 2,
        'proxyServer': '127.0.0.1:7890',
        'autoConfig': true,
      }).proxy,
      DiagnosticProxyState.matching,
    );
    expect(
      windows({'flags': 1, 'proxyServer': '127.0.0.1:7890'}).proxy,
      DiagnosticProxyState.disabled,
    );
  });
  test('Windows route failure cannot erase native proxy evidence', () async {
    final platform = NetworkDiagnosticPlatform(
      platform: 'windows',
      readWindowsProxy: () async => {
        'flags': 2,
        'proxyServer': '127.0.0.1:7890',
      },
      runCommand: (_, _, _) async => throw StateError('blocked'),
    );
    final result = await platform.inspect(7890, 'FlClash', CancelToken());
    expect(result.proxy, DiagnosticProxyState.matching);
    expect(result.tunRoute, isNull);
  });
  test('Windows native failure still allows route inspection', () async {
    final platform = NetworkDiagnosticPlatform(
      platform: 'windows',
      readWindowsProxy: () async => throw StateError('old plugin'),
      runCommand: (_, _, _) async => '{"routeInterface":"FlClash"}',
    );
    final result = await platform.inspect(7890, 'FlClash', CancelToken());
    expect(result.proxy, DiagnosticProxyState.unknown);
    expect(result.tunRoute, isTrue);
  });
  test('Windows avoids starting PowerShell when TUN is disabled', () async {
    final platform = NetworkDiagnosticPlatform(
      platform: 'windows',
      readWindowsProxy: () async => {
        'flags': 2,
        'proxyServer': '127.0.0.1:7890',
      },
      runCommand: (_, _, _) async => throw TestFailure('unexpected command'),
    );
    expect(
      (await platform.inspect(7890, null, CancelToken())).proxy,
      DiagnosticProxyState.matching,
    );
  });
  test('Windows route must match the actual core interface', () {
    expect(windows({'routeInterface': 'flclash'}).tunRoute, isTrue);
    expect(windows({'routeInterface': 'Other VPN'}).tunRoute, isFalse);
    expect(windows({'routeInterface': ''}).tunRoute, isNull);
    expect(windows({}).tunRoute, isNull);
  });
  test('macOS ignores other scoped proxies and matches exact utun route', () {
    const proxy = '''<dictionary> {
  HTTPEnable : 1
  HTTPProxy : 127.0.0.1
  HTTPPort : 7890
  HTTPSEnable : 1
  HTTPSProxy : ::1
  HTTPSPort : 7890
  __SCOPED__ : <dictionary> {
    en0 : <dictionary> {
      HTTPPort : 9999
      ProxyAutoConfigEnable : 1
    }
  }
}''';
    expect(
      parseMacosDiagnosticState(
        proxy,
        ' interface: utun4\n',
        7890,
        'utun4',
      ).proxy,
      DiagnosticProxyState.matching,
    );
    expect(
      parseMacosDiagnosticState(
        proxy,
        ' interface: utun4\n',
        7890,
        'utun4',
      ).tunRoute,
      isTrue,
    );
    expect(
      parseMacosDiagnosticState(
        proxy,
        ' interface: utun3\n',
        7890,
        'utun4',
      ).tunRoute,
      isFalse,
    );
    expect(
      parseMacosDiagnosticState(proxy, null, 7890, 'utun4').tunRoute,
      isNull,
    );
  });
  test('macOS PAC is uncertain and missing output is unknown', () {
    expect(
      parseMacosDiagnosticState(
        '<dictionary> {\n ProxyAutoConfigEnable : 1\n}',
        null,
        7890,
        null,
      ).proxy,
      DiagnosticProxyState.automatic,
    );
    expect(
      parseMacosDiagnosticState('<dictionary> {\n}', null, 7890, null).proxy,
      DiagnosticProxyState.disabled,
    );
    expect(
      parseMacosDiagnosticState('permission denied', null, 7890, null).proxy,
      DiagnosticProxyState.unknown,
    );
  });
  test('unavailable Windows command produces unknown, not healthy', () async {
    final platform = NetworkDiagnosticPlatform(
      platform: 'windows',
      readWindowsProxy: () async => null,
      runCommand: (_, _, _) async {
        throw const ProcessException('powershell', [], 'blocked by policy');
      },
    );
    final result = await platform.inspect(7890, 'FlClash', CancelToken());
    expect(result.proxy, DiagnosticProxyState.unknown);
    expect(result.tunRoute, isNull);
  });
  test(
    'malformed command output is unknown without leaking raw text',
    () async {
      final platform = NetworkDiagnosticPlatform(
        platform: 'windows',
        readWindowsProxy: () async => null,
        runCommand: (_, _, _) async => 'private-host: secret',
      );
      final result = await platform.inspect(7890, 'FlClash', CancelToken());
      expect(result.proxy, DiagnosticProxyState.unknown);
    },
  );
  test(
    'macOS route failure preserves proxy evidence and uses fixed commands',
    () async {
      final calls = <String>[];
      final platform = NetworkDiagnosticPlatform(
        platform: 'macos',
        runCommand: (exe, args, _) async {
          calls.add('$exe ${args.join(' ')}');
          if (exe == '/sbin/route') throw StateError('unavailable');
          return '<dictionary> {\n HTTPEnable : 0\n}';
        },
      );
      final result = await platform.inspect(
        7890,
        'utun4; unsafe',
        CancelToken(),
      );
      expect(result.proxy, DiagnosticProxyState.disabled);
      expect(result.tunRoute, isNull);
      expect(calls, ['/usr/sbin/scutil --proxy', '/sbin/route -n get 1.1.1.1']);
    },
  );
  test(
    'command runner captures stdout and rejects failures and oversized output',
    () async {
      expect(
        await runDiagnosticCommand('/bin/sh', [
          '-c',
          'printf fixture',
        ], CancelToken()),
        'fixture',
      );
      await expectLater(
        runDiagnosticCommand('/bin/sh', [
          '-c',
          'printf private-error >&2; exit 1',
        ], CancelToken()),
        throwsStateError,
      );
      await expectLater(
        runDiagnosticCommand('/usr/bin/head', [
          '-c',
          '70000',
          '/dev/zero',
        ], CancelToken()),
        throwsStateError,
      );
    },
    skip: Platform.isWindows,
  );
  test('canceled command never starts', () async {
    final token = CancelToken()..cancel();
    await expectLater(
      runDiagnosticCommand('/missing-fixture-executable', [], token),
      throwsStateError,
    );
  });
}
