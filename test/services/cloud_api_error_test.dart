import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => AppLocalizations.load(const Locale('en')));

  for (final entry in {
    11001: 'DNS could not find this domain',
    11002: 'DNS lookup failed',
    11003: 'DNS lookup failed',
    11004:
        'DNS returned no address, possibly blocked or a broken system resolver',
    10061: 'Connection refused',
    10054: 'Connection reset',
    10060: 'Connection timed out',
    10051: 'Network unreachable',
    10065: 'Network unreachable',
    10013: 'Network access denied',
    10049: 'Connection failed',
  }.entries) {
    test('Windows socket error ${entry.key} has a safe diagnosis', () {
      final error = _networkError(
        SocketException(
          'sensitive hostname',
          osError: OSError(
            'localized system error with secret-token',
            entry.key,
          ),
          address: InternetAddress('192.0.2.1'),
          port: 443,
        ),
      );
      expect(
        CloudApiException.clean(error),
        'Direct: ${entry.value} (System error ${entry.key})',
      );
    });
  }

  for (final entry in {
    DioExceptionType.connectionTimeout: 'Connection timed out',
    DioExceptionType.sendTimeout: 'Sending the request timed out',
    DioExceptionType.receiveTimeout: 'Waiting for the response timed out',
    DioExceptionType.transformTimeout: 'Request timed out',
    DioExceptionType.cancel: 'Request canceled',
  }.entries) {
    test('${entry.key} retains its failure stage', () {
      expect(
        CloudApiException.clean(_networkError(null, type: entry.key)),
        'Direct: ${entry.value}',
      );
    });
  }

  test(
    'Dart host lookup errors remain recognizable without a Windows code',
    () {
      expect(
        CloudApiException.clean(
          _networkError(
            const SocketException(
              "Failed host lookup: 'private-api.example'",
              osError: OSError('Name or service not known', -2),
            ),
          ),
        ),
        'Direct: DNS could not find this domain',
      );
    },
  );

  // An empty answer means the name resolved to nothing, which points at
  // interference or a broken resolver rather than at the domain.
  for (final entry in {
    (7, 'No address associated with hostname'):
        'DNS returned no address, possibly blocked or a broken system '
        'resolver (System error 7)',
    (-5, 'No address associated with hostname'):
        'DNS returned no address, possibly blocked or a broken system resolver',
    (8, 'nodename nor servname provided, or not known'):
        'DNS could not find this domain (System error 8)',
    (-3, 'Temporary failure in name resolution'): 'DNS lookup failed',
  }.entries) {
    final (code, systemMessage) = entry.key;
    test('host lookup code $code is diagnosed on its own', () {
      expect(
        CloudApiException.clean(
          _networkError(
            SocketException(
              "Failed host lookup: 'private-api.example'",
              osError: OSError(systemMessage, code),
            ),
          ),
        ),
        'Direct: ${entry.value}',
      );
    });
  }

  test(
    'TLS interruption is distinct from certificate verification failure',
    () {
      final error = _networkError(
        const HandshakeException('Connection terminated during handshake'),
        type: DioExceptionType.unknown,
      );
      expect(CloudApiException.clean(error), 'Direct: TLS handshake failed');
      expect(CloudApiException.isCertificateVerifyFailed(error), isFalse);
    },
  );

  test(
    'localized certificate diagnostics preserve the original certificate cause',
    () async {
      await AppLocalizations.load(const Locale('zh', 'CN'));
      addTearDown(() => AppLocalizations.load(const Locale('en')));
      final error = _networkError(
        const HandshakeException(
          'CERTIFICATE_VERIFY_FAILED: private-api.example',
        ),
        type: DioExceptionType.unknown,
      );
      final wrapped = CloudApiException(
        CloudApiException.clean(error),
        cause: error,
      );
      expect(CloudApiException.clean(wrapped), contains('证书'));
      expect(CloudApiException.clean(wrapped), isNot(contains('private-api')));
      expect(CloudApiException.isCertificateVerifyFailed(wrapped), isTrue);
    },
  );

  test('proxy CONNECT errors disclose only their status', () {
    for (final text in [
      'Proxy CONNECT failed (407)',
      'Proxy failed to establish tunnel (407 Authentication Required)',
    ]) {
      final error = _networkError(
        HttpException(
          text,
          uri: Uri.parse('https://private-api.example?token=secret-token'),
        ),
        route: 'PROXY localhost:7890',
        type: DioExceptionType.unknown,
      );
      expect(
        CloudApiException.clean(error),
        'Local proxy: Proxy authentication failed (HTTP 407)',
      );
      expect(CloudApiException.isUnauthorized(error), isFalse);
    }
  });

  test('a proxy 401 cannot invalidate the API account', () {
    final error = _networkError(
      const HttpException('Proxy CONNECT failed (401)'),
      type: DioExceptionType.unknown,
    );
    final wrapped = CloudApiException(
      CloudApiException.clean(error),
      cause: error,
    );
    expect(CloudApiException.clean(wrapped), contains('HTTP 401'));
    expect(CloudApiException.isUnauthorized(wrapped), isFalse);
  });

  test('HTTP errors show status without leaking the request or response', () {
    final options = _options();
    final error = DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: options,
        statusCode: 503,
        data: 'secret-token private-api.example',
      ),
    );
    expect(CloudApiException.clean(error), 'Direct: Server returned HTTP 503');
  });

  test(
    'invalid and unknown transport data cannot leak through generic messages',
    () {
      expect(
        CloudApiException.clean(
          _networkError(
            const FormatException('private-api.example secret-token'),
            type: DioExceptionType.unknown,
          ),
        ),
        'Direct: Invalid server response',
      );
      expect(
        CloudApiException.clean(
          _networkError(
            StateError('private-api.example secret-token'),
            type: DioExceptionType.unknown,
          ),
        ),
        'Direct: Unknown network error',
      );
    },
  );
  for (final entry in {
    'timestamp_expired':
        'The device clock is too far from the server. Turn on automatic date and time, then retry.',
    'signature_mismatch':
        'The server rejected this app’s signature. Reinstall the latest official build.',
    'server_unconfigured':
        'The server has no key configured for this app. Contact support.',
  }.entries) {
    test('a rejected managed config names ${entry.key}', () {
      expect(
        CloudApiException.clean(_forbidden(reason: entry.key)),
        'Direct: ${entry.value}',
      );
    });
  }

  test('a 403 without a known reason keeps the plain status', () {
    expect(
      CloudApiException.clean(_forbidden()),
      'Direct: Server returned HTTP 403',
    );
    expect(
      CloudApiException.clean(_forbidden(reason: 'something_else')),
      'Direct: Server returned HTTP 403',
    );
  });
}

RequestOptions _options({String route = 'DIRECT'}) => RequestOptions(
  baseUrl: 'https://private-api.example',
  path: '/api/v1/information',
  headers: {'Authorization': 'Bearer secret-token'},
  queryParameters: {'token': 'secret-token'},
  extra: {cloudReadRouteExtraKey: route},
);

DioException _networkError(
  Object? cause, {
  DioExceptionType type = DioExceptionType.connectionError,
  String route = 'DIRECT',
}) => DioException(
  requestOptions: _options(route: route),
  type: type,
  error: cause,
  message: 'private-api.example secret-token',
);

DioException _forbidden({String? reason}) => DioException(
  requestOptions: _options(),
  type: DioExceptionType.badResponse,
  response: Response(
    requestOptions: _options(),
    statusCode: HttpStatus.forbidden,
    headers: Headers.fromMap({
      if (reason != null) 'x-managed-auth-error': [reason],
    }),
  ),
);
