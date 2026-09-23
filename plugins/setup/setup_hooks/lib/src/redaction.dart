final _encodedSecret = RegExp(r'v2:[A-Za-z0-9+/]+={0,2}');

final _linkerSecret = RegExp(
  r'(-X\s+main\.GlobalDNSAuth(?:PrivateKey|Domains)=)\S+',
);

final _namedSecret = RegExp(
  r'((?:PROFILE_KEY|BASE_DOMAIN|SPARE_DOMAIN|API_DOMAIN|SPARE_API_DOMAIN|'
  r'FLCLASH_APP_SECRET|FLCLASH_KEY|DNS_AUTH_PRIVATE_KEY|DNS_AUTH_DOMAINS)=)\S+',
);

final _dartDefines = RegExp(r'((?:--)?DartDefines=|DART_DEFINES\s*=\s*)\S+');

String redactBuildOutput(String value) => value
    .replaceAll(_encodedSecret, '<redacted>')
    .replaceAllMapped(_linkerSecret, (m) => '${m[1]}<redacted>')
    .replaceAllMapped(_namedSecret, (m) => '${m[1]}<redacted>')
    .replaceAllMapped(_dartDefines, (m) => '${m[1]}<redacted>');
