import 'dart:convert';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String _decodeBase64(String value) {
  final normalized = base64.normalize(value.trim());
  return utf8.decode(base64.decode(normalized));
}

String _decodeBase64Url(String value) {
  final normalized = base64Url.normalize(value.trim());
  return utf8.decode(base64Url.decode(normalized));
}

String _tryDecodeBase64(String value) {
  final decoded = _decodeComponent(value);
  try {
    return _decodeBase64(decoded);
  } catch (_) {
    try {
      return _decodeBase64Url(decoded);
    } catch (_) {
      return decoded;
    }
  }
}

String _decodeComponent(String value) {
  try {
    return Uri.decodeComponent(value);
  } catch (_) {
    return value;
  }
}

int? _parsePort(Object? port) {
  if (port == null) {
    return null;
  }
  final value = port is int ? port : int.tryParse(port.toString());
  if (value == null || value <= 0 || value > 65535) {
    return null;
  }
  return value;
}

int? _uriPort(Uri uri) {
  return uri.hasPort ? uri.port : null;
}

bool _parseBoolOrPresence(String? value) {
  final normalized = value?.trim().toLowerCase();
  if (normalized == null || normalized.isEmpty) {
    return true;
  }
  return normalized == '1' ||
      normalized == 'true' ||
      normalized == 'yes' ||
      normalized == 'on';
}

int? _parseInt(String? value) {
  return value == null ? null : int.tryParse(value.trim());
}

List<String> _splitValues(String value) {
  return value
      .split(',')
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList();
}

String _fallbackName(Uri uri, String scheme) {
  final fragment = _decodeComponent(uri.fragment).trim();
  if (fragment.isNotEmpty) {
    return fragment;
  }
  final host = uri.host.isNotEmpty ? uri.host : scheme;
  final port = uri.hasPort ? ':${uri.port}' : '';
  return '$host$port';
}

void _putIfNotEmpty(Map<String, Object?> proxy, String key, Object? value) {
  if (value == null) {
    return;
  }
  if (value is String && value.isEmpty) {
    return;
  }
  if (value is Iterable && value.isEmpty) {
    return;
  }
  proxy[key] = value;
}

String _defaultProxyName(Uri uri, String label, int port) {
  final fragment = _decodeComponent(uri.fragment).trim();
  if (fragment.isNotEmpty) {
    return fragment;
  }
  return '$label ${uri.host}:$port';
}

int _portOrDefault(Uri uri, int defaultPort) {
  return _parsePort(_uriPort(uri)) ?? defaultPort;
}

List<String> _splitAuth(String auth) {
  final index = auth.indexOf(':');
  if (index == -1) {
    return [auth];
  }
  return [auth.substring(0, index), auth.substring(index + 1)];
}

void _putQueryValue(
  Map<String, Object?> proxy,
  Map<String, String> query,
  String key,
) {
  _putIfNotEmpty(proxy, key, query[key]);
}

void _putQueryInt(
  Map<String, Object?> proxy,
  Map<String, String> query,
  String key,
) {
  final value = _parseInt(query[key]);
  if (value != null) {
    proxy[key] = value;
  }
}

void _putQueryBool(
  Map<String, Object?> proxy,
  Map<String, String> query,
  String key,
) {
  if (query.containsKey(key)) {
    proxy[key] = _parseBoolOrPresence(query[key]);
  }
}

void _putQueryList(
  Map<String, Object?> proxy,
  Map<String, String> query,
  String key,
) {
  final value = query[key];
  if (value == null) {
    return;
  }
  final values = _splitValues(value);
  if (values.isNotEmpty) {
    proxy[key] = values;
  }
}

void _putFirstQueryValue(
  Map<String, Object?> proxy,
  Map<String, String> query,
  String targetKey,
  List<String> keys,
) {
  for (final key in keys) {
    final value = query[key];
    if (value?.isNotEmpty == true) {
      proxy[targetKey] = value;
      return;
    }
  }
}

void _putFirstQueryBool(
  Map<String, Object?> proxy,
  Map<String, String> query,
  String targetKey,
  List<String> keys,
) {
  for (final key in keys) {
    if (query.containsKey(key)) {
      proxy[targetKey] = _parseBoolOrPresence(query[key]);
      return;
    }
  }
}

String _stripScheme(String raw, String scheme) {
  final prefix = '$scheme://';
  if (!raw.toLowerCase().startsWith(prefix)) {
    throw FormatException('Invalid $scheme URI');
  }
  return raw.substring(prefix.length);
}

String _decodeBase64OrOriginal(String value) {
  final decoded = _tryDecodeBase64(value);
  return decoded.isEmpty ? value : decoded;
}

String _normalizeSsrServer(String value) {
  return value
      .replaceFirst(RegExp(r'^\['), '')
      .replaceFirst(RegExp(r'\]$'), '');
}

String _decodeSsrQueryValue(Map<String, String> query, String key) {
  final value = query[key];
  if (value == null || value.isEmpty) {
    return '';
  }
  return _decodeBase64OrOriginal(value).replaceAll(RegExp(r'\s'), '');
}

List<String> _splitSsrMain(String value) {
  final parts = value.split(':');
  if (parts.length < 6) {
    throw const FormatException('Invalid ssr URI');
  }
  final password = parts.removeLast();
  final obfs = parts.removeLast();
  final cipher = parts.removeLast();
  final protocol = parts.removeLast();
  final port = parts.removeLast();
  final server = parts.join(':');
  return [server, port, protocol, cipher, obfs, password];
}

String _stripAddressPrefix(String value) {
  return value
      .trim()
      .replaceFirst(RegExp(r'/\d+$'), '')
      .replaceFirst(RegExp(r'^\['), '')
      .replaceFirst(RegExp(r'\]$'), '');
}

bool _isIpv4(String value) {
  final parts = value.split('.');
  if (parts.length != 4) {
    return false;
  }
  return parts.every((part) {
    final value = int.tryParse(part);
    return value != null && value >= 0 && value <= 255;
  });
}

Map<String, Object?> _parseSimpleProxy(
  Uri uri,
  String scheme, {
  required String type,
  int? defaultPort,
}) {
  final port = _parsePort(_uriPort(uri));
  final server = uri.host;
  if (server.isEmpty || (port == null && defaultPort == null)) {
    throw FormatException('Invalid $scheme URI');
  }
  final proxy = <String, Object?>{
    'name': _fallbackName(uri, scheme),
    'type': type,
    'server': server,
    'port': port ?? defaultPort,
  };
  final userInfo = uri.userInfo;
  if (userInfo.isNotEmpty) {
    final decoded = _tryDecodeBase64(_decodeComponent(userInfo));
    final parts = decoded.split(':');
    proxy['username'] = parts.first;
    if (parts.length > 1) {
      proxy['password'] = parts.sublist(1).join(':');
    }
  }
  proxy['skip-cert-verify'] = true;
  if (scheme == 'https') {
    proxy['tls'] = true;
  }
  return proxy;
}

String _stripShadowsocksLegacyBody(String raw) {
  final body = _stripScheme(raw, 'ss');
  final fragmentIndex = body.indexOf('#');
  final queryIndex = body.indexOf('?');
  final endIndexes = [
    if (fragmentIndex >= 0) fragmentIndex,
    if (queryIndex >= 0) queryIndex,
  ];
  final endIndex = endIndexes.isEmpty
      ? body.length
      : endIndexes.reduce(
          (value, element) => value < element ? value : element,
        );
  return body.substring(0, endIndex);
}

Map<String, Object?> _parseShadowsocks(String raw, Uri uri) {
  var nextUri = uri;
  if (!nextUri.hasPort && nextUri.host.isNotEmpty && nextUri.userInfo.isEmpty) {
    final query = uri.hasQuery ? '?${uri.query}' : '';
    nextUri = Uri.parse(
      'ss://${_tryDecodeBase64(_stripShadowsocksLegacyBody(raw))}$query',
    );
  }
  final port = _parsePort(_uriPort(nextUri));
  if (nextUri.host.isEmpty || port == null) {
    throw const FormatException('Invalid ss URI');
  }
  var method = _decodeComponent(nextUri.userInfo);
  String? password;
  if (method.contains(':')) {
    final parts = method.split(':');
    method = parts.first;
    password = parts.sublist(1).join(':');
  } else {
    final decoded = _tryDecodeBase64(method);
    final parts = decoded.split(':');
    if (parts.length >= 2) {
      method = parts.first;
      password = parts.sublist(1).join(':');
    }
  }
  if (method.isEmpty || password?.isNotEmpty != true) {
    throw const FormatException('Invalid ss URI');
  }
  final query = nextUri.queryParameters;
  final proxy = <String, Object?>{
    'name': _fallbackName(uri, 'ss'),
    'type': 'ss',
    'server': nextUri.host,
    'port': port,
    'cipher': method,
    'password': password,
    'udp': true,
  };
  if (query['udp-over-tcp'] == 'true' || query['uot'] == '1') {
    proxy['udp-over-tcp'] = true;
  }
  final plugin = query['plugin'] ?? '';
  if (plugin.contains(';')) {
    final pluginInfo = Uri.splitQueryString(
      'pluginName=${plugin.replaceAll(';', '&')}',
    );
    final pluginName = pluginInfo['pluginName'] ?? '';
    if (pluginName.contains('obfs')) {
      proxy['plugin'] = 'obfs';
      proxy['plugin-opts'] = {
        'mode': pluginInfo['obfs'],
        'host': pluginInfo['obfs-host'],
      };
    } else if (pluginName.contains('v2ray-plugin')) {
      proxy['plugin'] = 'v2ray-plugin';
      proxy['plugin-opts'] = {
        'mode': pluginInfo['mode'],
        'host': pluginInfo['host'],
        'path': pluginInfo['path'],
        'tls': plugin.contains('tls'),
      };
    }
  }
  return proxy;
}

Map<String, Object?> _buildTransportOptions(
  Map<String, Object?> proxy,
  String network,
  Map<String, String> query, {
  String? path,
  String? host,
}) {
  proxy['network'] = network;
  switch (network) {
    case 'ws':
    case 'httpupgrade':
      final headers = <String, Object?>{};
      _putIfNotEmpty(headers, 'Host', host ?? query['host']);
      proxy['ws-opts'] = {
        'path': path ?? query['path'] ?? '/',
        if (headers.isNotEmpty) 'headers': headers,
      };
    case 'h2':
    case 'http':
      final headers = <String, Object?>{};
      final hosts = _splitValues(host ?? query['host'] ?? '');
      if (hosts.isNotEmpty) {
        headers['Host'] = hosts;
      }
      proxy[network == 'h2' ? 'h2-opts' : 'http-opts'] = {
        'path': _splitValues(path ?? query['path'] ?? '/'),
        if (headers.isNotEmpty) 'headers': headers,
      };
    case 'grpc':
      proxy['grpc-opts'] = {
        'grpc-service-name': query['serviceName'] ?? path ?? '',
      };
  }
  return proxy;
}

Map<String, Object?> _parseVMess(String raw) {
  final body = raw.substring(raw.indexOf('://') + 3);
  try {
    final values = Map<String, Object?>.from(json.decode(_decodeBase64(body)));
    final network = (values['net'] as String?)?.toLowerCase();
    final proxy = <String, Object?>{
      'name': (values['ps'] as String?)?.trim().isNotEmpty == true
          ? values['ps']
          : 'vmess',
      'type': 'vmess',
      'server': values['add'],
      'port': int.tryParse('${values['port']}') ?? values['port'],
      'uuid': values['id'],
      'alterId': int.tryParse('${values['aid'] ?? 0}') ?? 0,
      'udp': true,
      'xudp': true,
      'tls': '${values['tls'] ?? ''}'.toLowerCase().endsWith('tls'),
      'skip-cert-verify': false,
      'cipher': (values['scy'] as String?)?.isNotEmpty == true
          ? values['scy']
          : 'auto',
    };
    _putIfNotEmpty(proxy, 'servername', values['sni']);
    final alpn = values['alpn'];
    if (alpn is String && alpn.isNotEmpty) {
      proxy['alpn'] = _splitValues(alpn);
    }
    if (network != null && network.isNotEmpty) {
      final normalizedNetwork = values['type'] == 'http'
          ? 'http'
          : network == 'http'
          ? 'h2'
          : network;
      _buildTransportOptions(
        proxy,
        normalizedNetwork,
        const {},
        path: values['path'] as String?,
        host: values['host'] as String?,
      );
    }
    return proxy;
  } catch (_) {
    final uri = Uri.parse(raw);
    final query = uri.queryParameters;
    final proxy = <String, Object?>{
      'name': _fallbackName(uri, 'vmess'),
      'type': 'vmess',
      'server': uri.host,
      'port': _parsePort(_uriPort(uri)),
      'uuid': uri.userInfo,
      'alterId': 0,
      'cipher': query['encryption']?.isNotEmpty == true
          ? query['encryption']
          : 'auto',
      'udp': true,
      'tls': query['security'] == 'tls' || query['security'] == 'reality',
    };
    _putIfNotEmpty(proxy, 'servername', query['sni']);
    _putIfNotEmpty(proxy, 'client-fingerprint', query['fp']);
    final network = (query['type'] ?? '').toLowerCase();
    if (network.isNotEmpty) {
      _buildTransportOptions(proxy, network, query);
    }
    return proxy;
  }
}

Map<String, Object?> _parseVless(Uri uri) {
  final query = uri.queryParameters;
  final proxy = <String, Object?>{
    'name': _fallbackName(uri, 'vless'),
    'type': 'vless',
    'server': uri.host,
    'port': _parsePort(_uriPort(uri)),
    'uuid': uri.userInfo,
    'udp': true,
    'tls': query['security'] == 'tls' || query['security'] == 'reality',
  };
  _putIfNotEmpty(proxy, 'flow', query['flow']);
  _putIfNotEmpty(proxy, 'encryption', query['encryption']);
  _putIfNotEmpty(proxy, 'servername', query['sni']);
  _putIfNotEmpty(proxy, 'client-fingerprint', query['fp']);
  if (query['security'] == 'reality') {
    proxy['reality-opts'] = {
      'public-key': query['pbk'],
      'short-id': query['sid'],
    };
  }
  final network = (query['type'] ?? '').toLowerCase();
  if (network.isNotEmpty) {
    _buildTransportOptions(proxy, network, query);
  }
  _putFirstQueryBool(proxy, query, 'skip-cert-verify', [
    'allowInsecure',
    'insecure',
  ]);
  return proxy;
}

Map<String, Object?> _parseTrojan(Uri uri) {
  final query = uri.queryParameters;
  final proxy = <String, Object?>{
    'name': _fallbackName(uri, 'trojan'),
    'type': 'trojan',
    'server': uri.host,
    'port': _parsePort(_uriPort(uri)),
    'password': _decodeComponent(uri.userInfo),
    'udp': true,
  };
  _putFirstQueryBool(proxy, query, 'skip-cert-verify', [
    'allowInsecure',
    'insecure',
  ]);
  _putIfNotEmpty(proxy, 'sni', query['sni']);
  _putIfNotEmpty(proxy, 'client-fingerprint', query['fp'] ?? 'chrome');
  if (query['alpn']?.isNotEmpty == true) {
    proxy['alpn'] = _splitValues(query['alpn']!);
  }
  final network = (query['type'] ?? '').toLowerCase();
  if (network.isNotEmpty) {
    _buildTransportOptions(proxy, network, query);
  }
  return proxy;
}

Map<String, Object?> _parseHysteria(Uri uri) {
  final query = uri.queryParameters;
  final proxy = <String, Object?>{
    'name': _fallbackName(uri, 'hysteria'),
    'type': 'hysteria',
    'server': uri.host,
    'port': _parsePort(_uriPort(uri)),
    'sni': query['peer'] ?? query['sni'],
    'obfs': query['obfs'],
    'auth-str': query['auth'],
    'protocol': query['protocol'],
    'up': query['up'] ?? query['upmbps'],
    'down': query['down'] ?? query['downmbps'],
  };
  _putFirstQueryBool(proxy, query, 'skip-cert-verify', ['insecure']);
  if (query['alpn']?.isNotEmpty == true) {
    proxy['alpn'] = _splitValues(query['alpn']!);
  }
  return proxy;
}

Map<String, Object?> _parseHysteria2(Uri uri) {
  final query = uri.queryParameters;
  final proxy = <String, Object?>{
    'name': _fallbackName(uri, 'hysteria2'),
    'type': 'hysteria2',
    'server': uri.host,
    'port': _parsePort(_uriPort(uri)) ?? 443,
    'password': _decodeComponent(uri.userInfo),
    'obfs': query['obfs'],
    'obfs-password': query['obfs-password'],
    'sni': query['sni'],
    'fingerprint': query['pinSHA256'],
    'up': query['up'],
    'down': query['down'],
  };
  _putFirstQueryBool(proxy, query, 'skip-cert-verify', ['insecure']);
  if (query['alpn']?.isNotEmpty == true) {
    proxy['alpn'] = _splitValues(query['alpn']!);
  }
  return proxy;
}

Map<String, Object?> _parseSSR(String raw) {
  final body = _stripScheme(raw, 'ssr');
  final decoded = _decodeBase64OrOriginal(body);
  final configParts = decoded.split('/?');
  final params = _splitSsrMain(configParts.first);
  final server = _normalizeSsrServer(params[0]);
  final port = _parsePort(params[1]);
  if (server.isEmpty || port == null) {
    throw const FormatException('Invalid ssr URI');
  }
  final query = configParts.length > 1
      ? Uri.splitQueryString(configParts[1])
      : const <String, String>{};
  final name = query['remarks']?.isNotEmpty == true
      ? _decodeBase64OrOriginal(query['remarks']!).trim()
      : server;
  final proxy = <String, Object?>{
    'name': name,
    'type': 'ssr',
    'server': server,
    'port': port,
    'protocol': params[2],
    'cipher': params[3],
    'obfs': params[4],
    'password': _decodeBase64OrOriginal(params[5]),
  };
  _putIfNotEmpty(
    proxy,
    'protocol-param',
    _decodeSsrQueryValue(query, 'protoparam'),
  );
  _putIfNotEmpty(proxy, 'obfs-param', _decodeSsrQueryValue(query, 'obfsparam'));
  return proxy;
}

Map<String, Object?> _parseAnyTLS(Uri uri) {
  final query = uri.queryParameters;
  final port = _portOrDefault(uri, 443);
  final proxy = <String, Object?>{
    'name': _defaultProxyName(uri, 'AnyTLS', port),
    'type': 'anytls',
    'server': uri.host,
    'port': port,
    'udp': true,
  };
  final auth = _decodeComponent(uri.userInfo);
  if (auth.isNotEmpty) {
    final authParts = _splitAuth(auth);
    proxy['password'] = authParts.length > 1 ? authParts[1] : authParts.first;
  }
  _putQueryValue(proxy, query, 'sni');
  _putQueryList(proxy, query, 'alpn');
  _putFirstQueryValue(proxy, query, 'fingerprint', ['fingerprint', 'hpkp']);
  _putFirstQueryValue(proxy, query, 'client-fingerprint', [
    'client-fingerprint',
    'fp',
  ]);
  _putFirstQueryBool(proxy, query, 'skip-cert-verify', [
    'skip-cert-verify',
    'insecure',
  ]);
  _putQueryBool(proxy, query, 'udp');
  _putQueryInt(proxy, query, 'idle-session-check-interval');
  _putQueryInt(proxy, query, 'idle-session-timeout');
  _putQueryInt(proxy, query, 'min-idle-session');
  return proxy;
}

Map<String, Object?> _parseTUIC(Uri uri) {
  final query = uri.queryParameters;
  final port = _portOrDefault(uri, 443);
  final authParts = _splitAuth(_decodeComponent(uri.userInfo));
  if (authParts.length < 2 ||
      authParts.first.isEmpty ||
      authParts.last.isEmpty) {
    throw const FormatException('Invalid tuic URI');
  }
  final proxy = <String, Object?>{
    'name': _defaultProxyName(uri, 'TUIC', port),
    'type': 'tuic',
    'server': uri.host,
    'port': port,
    'uuid': authParts.first,
    'password': authParts.last,
  };
  _putQueryValue(proxy, query, 'token');
  _putQueryValue(proxy, query, 'ip');
  _putQueryInt(proxy, query, 'heartbeat-interval');
  _putQueryList(proxy, query, 'alpn');
  _putQueryBool(proxy, query, 'disable-sni');
  _putQueryBool(proxy, query, 'reduce-rtt');
  _putQueryInt(proxy, query, 'request-timeout');
  _putQueryValue(proxy, query, 'udp-relay-mode');
  _putQueryValue(proxy, query, 'congestion-controller');
  _putQueryInt(proxy, query, 'max-udp-relay-packet-size');
  _putQueryBool(proxy, query, 'fast-open');
  _putFirstQueryBool(proxy, query, 'skip-cert-verify', [
    'skip-cert-verify',
    'allow-insecure',
  ]);
  _putQueryInt(proxy, query, 'max-open-streams');
  _putQueryValue(proxy, query, 'sni');
  return proxy;
}

Map<String, Object?> _parseWireguard(Uri uri) {
  final query = uri.queryParameters;
  final port = _portOrDefault(uri, 443);
  final privateKey = _decodeComponent(uri.userInfo);
  if (privateKey.isEmpty) {
    throw const FormatException('Invalid wireguard URI');
  }
  final proxy = <String, Object?>{
    'name': _defaultProxyName(uri, 'WireGuard', port),
    'type': 'wireguard',
    'server': uri.host,
    'port': port,
    'private-key': privateKey,
    'udp': true,
  };
  final address = query['address'] ?? query['ip'];
  if (address?.isNotEmpty == true) {
    for (final item in address!.split(',')) {
      final ip = _stripAddressPrefix(item);
      if (_isIpv4(ip)) {
        proxy['ip'] = ip;
      } else if (ip.contains(':')) {
        proxy['ipv6'] = ip;
      }
    }
  }
  _putFirstQueryValue(proxy, query, 'public-key', ['publickey', 'public-key']);
  _putQueryList(proxy, query, 'allowed-ips');
  _putQueryValue(proxy, query, 'pre-shared-key');
  final reserved = query['reserved']
      ?.split(',')
      .map((item) => int.tryParse(item.trim()))
      .whereType<int>()
      .toList();
  if (reserved?.length == 3) {
    proxy['reserved'] = reserved;
  }
  _putQueryBool(proxy, query, 'udp');
  _putQueryInt(proxy, query, 'mtu');
  _putQueryBool(proxy, query, 'remote-dns-resolve');
  _putQueryList(proxy, query, 'dns');
  return proxy;
}

Map<String, Object?> parseProfileProxyUri(String value) {
  final raw = value.trim();
  if (raw.isEmpty) {
    throw const FormatException('URI is empty');
  }
  final uri = Uri.tryParse(raw);
  if (uri == null || uri.scheme.isEmpty) {
    throw const FormatException('Invalid URI');
  }
  final scheme = uri.scheme.toLowerCase();
  final proxy = normalizeProfileProxyMap(switch (scheme) {
    'ss' => _parseShadowsocks(raw, uri),
    'ssr' => _parseSSR(raw),
    'vmess' => _parseVMess(raw),
    'trojan' => _parseTrojan(uri),
    'vless' => _parseVless(uri),
    'anytls' => _parseAnyTLS(uri),
    'hysteria' || 'hy' => _parseHysteria(uri),
    'hysteria2' || 'hy2' => _parseHysteria2(uri),
    'tuic' => _parseTUIC(uri),
    'wireguard' || 'wg' => _parseWireguard(uri),
    'http' || 'https' => _parseSimpleProxy(uri, scheme, type: 'http'),
    'socks' || 'socks5' || 'socks5h' => _parseSimpleProxy(
      uri,
      scheme,
      type: 'socks5',
      defaultPort: 1080,
    ),
    _ => throw FormatException('Unsupported URI scheme: $scheme'),
  });
  _validateProfileProxy(proxy, scheme);
  return proxy;
}

void _validateProfileProxy(Map<String, Object?> proxy, String scheme) {
  final name = proxy['name'];
  final type = proxy['type'];
  if (name is! String ||
      name.trim().isEmpty ||
      type is! String ||
      type.trim().isEmpty) {
    throw const FormatException('Invalid proxy URI');
  }
  _requireString(proxy, 'server', scheme);
  _requirePort(proxy, scheme);
  switch (type) {
    case 'ss':
      _requireString(proxy, 'cipher', scheme);
      _requireString(proxy, 'password', scheme);
    case 'ssr':
      _requireString(proxy, 'cipher', scheme);
      _requireString(proxy, 'password', scheme);
      _requireString(proxy, 'protocol', scheme);
      _requireString(proxy, 'obfs', scheme);
    case 'vmess':
    case 'vless':
      _requireString(proxy, 'uuid', scheme);
    case 'tuic':
      _requireString(proxy, 'uuid', scheme);
      _requireString(proxy, 'password', scheme);
    case 'trojan':
    case 'anytls':
    case 'hysteria2':
      _requireString(proxy, 'password', scheme);
    case 'wireguard':
      _requireString(proxy, 'private-key', scheme);
      _requireString(proxy, 'public-key', scheme);
  }
}

void _requireString(Map<String, Object?> proxy, String key, String scheme) {
  final value = proxy[key];
  if (value is! String || value.trim().isEmpty) {
    throw FormatException('Invalid $scheme URI');
  }
}

void _requirePort(Map<String, Object?> proxy, String scheme) {
  final port = _parsePort(proxy['port']);
  if (port == null) {
    throw FormatException('Invalid $scheme URI');
  }
  proxy['port'] = port;
}

bool hasDuplicateProfileProxyName(
  Iterable<ProfileProxy> profileProxies,
  ProfileProxy profileProxy,
) {
  final name = profileProxy.name;
  if (name.isEmpty) {
    return false;
  }
  return profileProxies.any((item) {
    return item.id != profileProxy.id && item.name == name;
  });
}

bool hasProfileProxyGroupNameConflict(
  Map rawConfig,
  ProfileProxy profileProxy,
) {
  final name = profileProxy.name;
  if (name.isEmpty) {
    return false;
  }
  return rawProxyGroupNames(rawConfig).contains(name);
}

bool hasProfileProxyCustomNameConflict(
  Profile profile,
  ProfileProxy profileProxy,
) {
  final name = profileProxy.name;
  return reservedOutboundNames.contains(name) ||
      profile.customProxyGroups.any((group) => group.name == name);
}

class ProfileProxyItem extends StatelessWidget {
  final bool isSelected;
  final bool isEditing;
  final ProfileProxy profileProxy;
  final VoidCallback onSelected;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggle;

  const ProfileProxyItem({
    super.key,
    required this.isSelected,
    required this.isEditing,
    required this.profileProxy,
    required this.onSelected,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        color: Colors.transparent,
        child: CommonCard(
          padding: EdgeInsets.zero,
          radius: 18,
          type: CommonCardType.filled,
          isSelected: isSelected,
          onPressed: onSelected,
          child: ListTile(
            minTileHeight: 32 + globalState.measure.bodyMediumHeight,
            minVerticalPadding: 12,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              profileProxy.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.toJetBrainsMono,
            ),
            subtitle: Text(
              profileProxy.type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant.opacity80,
              ),
            ),
            trailing: isEditing
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CommonCheckBox(
                      value: isSelected,
                      isCircle: true,
                      onChanged: (_) {
                        onSelected();
                      },
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(value: profileProxy.enable, onChanged: onToggle),
                      CommonPopupBox(
                        popup: CommonPopupMenu(
                          items: [
                            PopupMenuItemData(
                              icon: Icons.edit_outlined,
                              label: appLocalizations.edit,
                              onPressed: onEdit,
                            ),
                            PopupMenuItemData(
                              danger: true,
                              icon: Icons.delete_outline,
                              label: appLocalizations.delete,
                              onPressed: onDelete,
                            ),
                          ],
                        ),
                        targetBuilder: (open) {
                          return IconButton(
                            onPressed: () {
                              open();
                            },
                            icon: Icon(Icons.more_vert),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class ProfileProxyEditView extends StatefulWidget {
  final ProfileProxy? profileProxy;

  const ProfileProxyEditView({super.key, this.profileProxy});

  @override
  State<ProfileProxyEditView> createState() => _ProfileProxyEditViewState();
}

class _ProfileProxyEditViewState extends State<ProfileProxyEditView> {
  final _uriController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profileProxy = widget.profileProxy;
    _uriController.text = profileProxy?.uri ?? '';
    _uriController.addListener(_handleUriChanged);
  }

  @override
  void dispose() {
    _uriController.removeListener(_handleUriChanged);
    _uriController.dispose();
    super.dispose();
  }

  void _handleUriChanged() {
    setState(() {});
  }

  bool get _hasUri => _uriController.text.trim().isNotEmpty;

  void _handleSubmit() {
    try {
      final uri = _uriController.text.trim();
      final proxy = parseProfileProxyUri(uri);
      final nextProfileProxy =
          (widget.profileProxy ?? ProfileProxy.create(uri: uri, proxy: proxy))
              .copyWith(enable: true, uri: uri, proxy: proxy);
      Navigator.of(context).pop(nextProfileProxy);
    } catch (e) {
      context.showNotifier(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = _hasUri;
    return CommonScaffold(
      title: appLocalizations.proxyChainCustomNode,
      actions: [
        CommonMinIconButtonTheme(
          child: IconButton.filled(
            style:
                IconButton.styleFrom(
                  backgroundColor: canSubmit ? Colors.green : null,
                  foregroundColor: canSubmit ? Colors.white : null,
                ).copyWith(
                  mouseCursor: WidgetStatePropertyAll(
                    canSubmit
                        ? SystemMouseCursors.click
                        : SystemMouseCursors.basic,
                  ),
                ),
            onPressed: canSubmit ? _handleSubmit : null,
            icon: Icon(Icons.check),
          ),
        ),
        SizedBox(width: 8),
      ],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _uriController,
            minLines: 4,
            maxLines: 8,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'URI',
              helperText: appLocalizations.proxyChainUriNodeSupportedFormats,
              helperMaxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileProxiesContent extends ConsumerStatefulWidget {
  final int profileId;

  const ProfileProxiesContent({super.key, required this.profileId});

  @override
  ConsumerState<ProfileProxiesContent> createState() =>
      _ProfileProxiesContentState();
}

class _ProfileProxiesContentState extends ConsumerState<ProfileProxiesContent> {
  final _profileProxyKey = utils.id;

  Future<String?> _findRawReference(String name) {
    final profile = ref.read(profileProvider(widget.profileId));
    return appController.findRawProfileOutboundReference(
      widget.profileId,
      name,
      includeTopLevelRules: profile?.overwriteType != OverwriteType.custom,
    );
  }

  Set<int> _getSelectedProfileProxyIds() {
    return ref
        .read(selectedItemsProvider(_profileProxyKey))
        .whereType<int>()
        .toSet();
  }

  Future<void> _handleAddOrUpdateProfileProxy([
    ProfileProxy? profileProxy,
  ]) async {
    final res = await BaseNavigator.push<ProfileProxy>(
      context,
      ProfileProxyEditView(profileProxy: profileProxy),
    );
    if (res == null) {
      return;
    }
    if (!mounted) {
      return;
    }
    final profileProxies =
        ref.read(profileProvider(widget.profileId))?.profileProxies ?? [];
    if (hasDuplicateProfileProxyName(profileProxies, res)) {
      context.showNotifier(
        appLocalizations.existsTip(appLocalizations.proxies),
      );
      return;
    }
    final profile = ref.read(profileProvider(widget.profileId));
    if (profile != null && hasProfileProxyCustomNameConflict(profile, res)) {
      context.showNotifier(
        appLocalizations.existsTip(appLocalizations.proxies),
      );
      return;
    }
    try {
      final rawConfig = await appController.getRawProfileConfig(
        widget.profileId,
      );
      if (hasProfileProxyGroupNameConflict(rawConfig, res)) {
        if (mounted) {
          context.showNotifier(
            appLocalizations.proxyChainUnavailableNodeTip(res.name),
          );
        }
        return;
      }
    } catch (error) {
      if (mounted) {
        context.showNotifier(error.toString());
      }
      return;
    }
    if (!mounted) {
      return;
    }
    final previousName = profileProxy?.name;
    final nextName = res.name;
    if (previousName != null &&
        previousName.isNotEmpty &&
        nextName.isNotEmpty &&
        previousName != nextName) {
      final nextProxyChains = ref
          .read(profileProvider(widget.profileId))
          ?.proxyChains
          .copyAndRenameProxy(previousName, nextName);
      final conflictName = findProxyChainConflictName(nextProxyChains ?? []);
      if (conflictName != null) {
        context.showNotifier(
          appLocalizations.proxyChainConflictTip(conflictName),
        );
        return;
      }
      try {
        final rawReference = await _findRawReference(previousName);
        if (rawReference != null) {
          if (mounted) {
            context.showNotifier(
              appLocalizations.rawOutboundInUse(previousName, rawReference),
            );
          }
          return;
        }
      } catch (error) {
        if (mounted) {
          context.showNotifier(error.toString());
        }
        return;
      }
    }
    _putProfileProxy(res, previousName: profileProxy?.name);
    _applyProfileChanges();
  }

  void _putProfileProxy(ProfileProxy profileProxy, {String? previousName}) {
    ref.read(profilesProvider.notifier).updateProfile(widget.profileId, (
      state,
    ) {
      final nextProfileProxies = state.profileProxies.copyAndPut(profileProxy);
      final nextName = profileProxy.name;
      return state
          .copyWith(
            profileProxies: nextProfileProxies,
            proxyChains: state.proxyChains.copyAndRenameProxy(
              previousName,
              nextName,
            ),
          )
          .copyAndRenameOutboundReferences(previousName, nextName);
    });
  }

  void _applyProfileChanges() {
    appController.applyProfileDebounce(silence: true);
  }

  void _handleProfileProxySelected(int profileProxyId) {
    ref.read(selectedItemsProvider(_profileProxyKey).notifier).update((
      selectedProfileProxies,
    ) {
      final nextProfileProxies = Set<int>.from(selectedProfileProxies)
        ..addOrRemove(profileProxyId);
      return nextProfileProxies;
    });
  }

  void _handleSelectAllProfileProxies() {
    final ids =
        ref
            .read(profileProvider(widget.profileId))
            ?.profileProxies
            .map((item) => item.id)
            .toSet() ??
        {};
    ref.read(selectedItemsProvider(_profileProxyKey).notifier).update((
      selected,
    ) {
      return selected.containsAll(ids) ? {} : ids;
    });
  }

  Future<void> _handleDeleteProfileProxies([Set<int>? profileProxyIds]) async {
    final targetProfileProxyIds = profileProxyIds != null
        ? Set<int>.from(profileProxyIds)
        : _getSelectedProfileProxyIds();
    if (targetProfileProxyIds.isEmpty) {
      return;
    }
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: profileProxyIds == null
            ? appLocalizations.deleteMultipTip(appLocalizations.proxies)
            : appLocalizations.deleteTip(appLocalizations.proxyChainCustomNode),
      ),
    );
    if (res != true) {
      return;
    }
    if (!mounted) {
      return;
    }
    final currentProfile = ref.read(profileProvider(widget.profileId));
    final relatedNames =
        currentProfile?.profileProxies
            .where((item) => targetProfileProxyIds.contains(item.id))
            .map((item) => item.name)
            .toSet() ??
        {};
    for (final name in relatedNames) {
      try {
        final rawReference = await _findRawReference(name);
        if (rawReference != null) {
          if (mounted) {
            context.showNotifier(
              appLocalizations.rawOutboundInUse(name, rawReference),
            );
          }
          return;
        }
      } catch (error) {
        if (mounted) {
          context.showNotifier(error.toString());
        }
        return;
      }
    }
    if (!mounted) {
      return;
    }
    final referencedName = relatedNames.firstWhere(
      (name) =>
          currentProfile?.hasCustomOutboundReferences(
            name,
            includeProxyChains: false,
          ) ??
          false,
      orElse: () => '',
    );
    if (referencedName.isNotEmpty) {
      context.showNotifier(
        appLocalizations.customOutboundInUse(referencedName),
      );
      return;
    }
    final hasRelatedProxyChains =
        currentProfile?.proxyChains.any((chain) {
          return chain.proxies.any(relatedNames.contains);
        }) ??
        false;
    ref.read(profilesProvider.notifier).updateProfile(widget.profileId, (
      state,
    ) {
      final deletedNames = state.profileProxies
          .where((item) => targetProfileProxyIds.contains(item.id))
          .map((item) => item.name)
          .toSet();
      return state
          .copyWith(
            profileProxies: state.profileProxies
                .where((item) => !targetProfileProxyIds.contains(item.id))
                .toList(),
            proxyChains: state.proxyChains.copyAndRemoveProxies(deletedNames),
          )
          .copyAndRemoveOutboundCaches(deletedNames);
    });
    ref.read(selectedItemsProvider(_profileProxyKey).notifier).update((
      selectedProfileProxies,
    ) {
      return selectedProfileProxies
          .where((item) => !targetProfileProxyIds.contains(item))
          .toSet();
    });
    _applyProfileChanges();
    if (hasRelatedProxyChains) {
      context.showNotifier(appLocalizations.proxyChainRelatedChainsUpdated);
    }
  }

  Future<void> _handleProfileProxyToggle(
    ProfileProxy profileProxy,
    bool value,
  ) async {
    final profile = ref.read(profileProvider(widget.profileId));
    if (!value &&
        (profile?.hasCustomOutboundReferences(
              profileProxy.name,
              includeProxyChains: false,
            ) ??
            false)) {
      context.showNotifier(
        appLocalizations.customOutboundInUse(profileProxy.name),
      );
      return;
    }
    if (!value) {
      try {
        final rawReference = await _findRawReference(profileProxy.name);
        if (rawReference != null) {
          if (mounted) {
            context.showNotifier(
              appLocalizations.rawOutboundInUse(
                profileProxy.name,
                rawReference,
              ),
            );
          }
          return;
        }
      } catch (error) {
        if (mounted) {
          context.showNotifier(error.toString());
        }
        return;
      }
    }
    if (!mounted) {
      return;
    }
    final hasRelatedProxyChains =
        profile?.proxyChains.any(
          (chain) => chain.proxies.contains(profileProxy.name),
        ) ??
        false;
    ref.read(profilesProvider.notifier).updateProfile(widget.profileId, (
      state,
    ) {
      final nextProfileProxy = profileProxy.copyWith(enable: value);
      final nextProfileProxies = state.profileProxies.copyAndPut(
        nextProfileProxy,
      );
      if (value) {
        return state.copyWith(profileProxies: nextProfileProxies);
      }
      return state
          .copyWith(
            profileProxies: nextProfileProxies,
            proxyChains: state.proxyChains.copyAndDisableChainsUsingProxy(
              profileProxy.name,
            ),
          )
          .copyAndRemoveOutboundCaches({profileProxy.name});
    });
    _applyProfileChanges();
    if (!value && hasRelatedProxyChains) {
      context.showNotifier(appLocalizations.proxyChainRelatedChainsUpdated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProxies =
        ref.watch(profileProvider(widget.profileId))?.profileProxies ?? [];
    final selectedProfileProxies = ref.watch(
      selectedItemsProvider(_profileProxyKey),
    );
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: InfoHeader(
            info: Info(label: appLocalizations.proxyChainCustomNodes),
            actions: [
              if (selectedProfileProxies.isNotEmpty) ...[
                CommonMinIconButtonTheme(
                  child: IconButton.filledTonal(
                    onPressed: _handleDeleteProfileProxies,
                    icon: Icon(Icons.delete),
                  ),
                ),
                SizedBox(width: 8),
              ],
              CommonMinFilledButtonTheme(
                child: selectedProfileProxies.isNotEmpty
                    ? FilledButton(
                        onPressed: _handleSelectAllProfileProxies,
                        child: Text(appLocalizations.selectAll),
                      )
                    : FilledButton.icon(
                        onPressed: () {
                          _handleAddOrUpdateProfileProxy();
                        },
                        icon: Icon(Icons.add),
                        label: Text(appLocalizations.addProxyChainNode),
                      ),
              ),
            ],
          ),
        ),
        if (profileProxies.isNotEmpty) ...[
          SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverList.builder(
            itemCount: profileProxies.length,
            itemBuilder: (_, index) {
              final profileProxy = profileProxies[index];
              return ProfileProxyItem(
                isEditing: selectedProfileProxies.isNotEmpty,
                isSelected: selectedProfileProxies.contains(profileProxy.id),
                profileProxy: profileProxy,
                onSelected: () {
                  _handleProfileProxySelected(profileProxy.id);
                },
                onEdit: () {
                  _handleAddOrUpdateProfileProxy(profileProxy);
                },
                onDelete: () {
                  _handleDeleteProfileProxies({profileProxy.id});
                },
                onToggle: (value) {
                  _handleProfileProxyToggle(profileProxy, value);
                },
              );
            },
          ),
        ],
      ],
    );
  }
}
