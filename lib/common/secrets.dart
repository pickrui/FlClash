import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

bool containsCloudInformation(String value, Iterable<String> hosts) {
  final normalized = value.toLowerCase();
  if (normalized.contains('oixcloud') ||
      normalized.contains('[dns-auth]') ||
      normalized.contains('cloudapi')) {
    return true;
  }
  for (final host in hosts) {
    final domain = host.trim().toLowerCase().replaceFirst(RegExp(r'\.$'), '');
    if (domain.isEmpty) continue;
    if (RegExp(
      '(^|[^a-z0-9_.-])(?:[a-z0-9_-]+\\.)*${RegExp.escape(domain)}\\.?(\$|[^a-z0-9_.-])',
      caseSensitive: false,
    ).hasMatch(value)) {
      return true;
    }
  }
  return false;
}

String redactHostnames(String value, Iterable<String> hosts) {
  var redacted = value;
  final normalizedHosts = hosts
      .map((host) => host.trim().toLowerCase())
      .where((host) => host.isNotEmpty)
      .toSet();
  for (final host in normalizedHosts) {
    redacted = redacted.replaceAll(
      RegExp(
        '(?:https?://)?${RegExp.escape(host)}(?::\\d+)?(?:/[^\\s,;)]*)?',
        caseSensitive: false,
      ),
      '[oixCloud API]',
    );
  }
  return redacted;
}

class Secrets {
  const Secrets._();

  static final String profileKey = _deob(
    const String.fromEnvironment('PROFILE_KEY'),
  );

  static final String baseDomain = _deob(
    const String.fromEnvironment('BASE_DOMAIN'),
  );
  static final String spareDomain = _deob(
    const String.fromEnvironment('SPARE_DOMAIN'),
  );
  static final String apiDomain = _deob(
    const String.fromEnvironment('API_DOMAIN'),
  );
  static final String spareApiDomain = _deob(
    const String.fromEnvironment('SPARE_API_DOMAIN'),
  );

  static final String flClashAppSecret = _deob(
    const String.fromEnvironment('FLCLASH_APP_SECRET'),
  );

  static String get primarySiteDomain => baseDomain.trim();

  static String get spareSiteDomain => spareDomain.trim();

  static List<String> get cloudDomains => {
    baseDomain.trim().toLowerCase(),
    spareDomain.trim().toLowerCase(),
    apiDomain.trim().toLowerCase(),
    spareApiDomain.trim().toLowerCase(),
  }.where((domain) => domain.isNotEmpty).toList();

  static bool shouldSuppressOutput(String value) =>
      containsCloudInformation(value, cloudDomains);

  static String get primaryApiDomain => _requireDomain(apiDomain, 'API_DOMAIN');

  static String get fallbackApiDomain =>
      _requireDomain(spareApiDomain, 'SPARE_API_DOMAIN');

  static List<String> get apiDomains => {
    primaryApiDomain.toLowerCase(),
    fallbackApiDomain.toLowerCase(),
  }.toList();

  static bool isApiDomain(String host) {
    return apiDomains.contains(host.trim().toLowerCase());
  }

  static String redactApiDomains(String value) {
    return redactHostnames(value, {
      apiDomain.trim().toLowerCase(),
      spareApiDomain.trim().toLowerCase(),
    });
  }

  static String _requireDomain(String value, String name) {
    final domain = value.trim();
    if (domain.isEmpty) {
      throw StateError('$name must be configured');
    }
    return domain;
  }

  // Compile-time secrets are injected obfuscated (v2) by setup.dart for release
  // builds and restored here at runtime; plain values (dev --dart-define-from-file)
  // pass through unchanged. Keystream = SHA256-CTR(master, nonce) with a
  // runtime-derived master, matching core/secrets.go and setup.dart.
  static const String _v2Prefix = 'v2:';

  static String _deob(String value) {
    if (!value.startsWith(_v2Prefix)) {
      return value;
    }
    // normalize restores '=' padding in case it was stripped by argument
    // parsing along the build pipeline.
    final raw = base64.decode(
      base64.normalize(value.substring(_v2Prefix.length)),
    );
    if (raw.length < 8) {
      return value;
    }
    final nonce = raw.sublist(0, 8);
    final cipher = raw.sublist(8);
    final ks = _keystream(nonce, cipher.length);
    final out = Uint8List(cipher.length);
    for (var i = 0; i < cipher.length; i++) {
      out[i] = cipher[i] ^ ks[i];
    }
    return utf8.decode(out);
  }

  static Uint8List _obfMaster() {
    const a = [
      0x5a,
      0x1c,
      0xe7,
      0x93,
      0x2f,
      0xb8,
      0x04,
      0xd6,
      0x69,
      0xa1,
      0x3e,
      0xcf,
      0x72,
      0x8d,
      0x15,
      0xba,
    ];
    const b = [
      0xc4,
      0x37,
      0x9e,
      0x08,
      0x51,
      0xed,
      0x2a,
      0x7f,
      0xd3,
      0x60,
      0x1b,
      0x86,
      0xf9,
      0x42,
      0xad,
      0x0e,
    ];
    return Uint8List.fromList(
      sha256.convert(<int>[
        ...a,
        ...b,
        ...utf8.encode('oix-obf-v2-flclash'),
      ]).bytes,
    );
  }

  static Uint8List _keystream(List<int> nonce, int count) {
    final master = _obfMaster();
    final out = <int>[];
    var counter = 0;
    while (out.length < count) {
      out.addAll(
        sha256.convert(<int>[
          ...master,
          ...nonce,
          (counter >> 24) & 0xff,
          (counter >> 16) & 0xff,
          (counter >> 8) & 0xff,
          counter & 0xff,
        ]).bytes,
      );
      counter++;
    }
    return Uint8List.fromList(out.sublist(0, count));
  }
}
