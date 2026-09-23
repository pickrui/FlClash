import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/http.dart';
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
    10049: 'Network address is unavailable',
    10048: 'Network address or port is already in use',
    10052: 'Connection reset',
    10053: 'Connection aborted',
    10024: 'Insufficient system network resources',
    10055: 'Insufficient system network resources',
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
      expect(
        CloudApiException.clean(error),
        'Direct: Connection closed before the TLS handshake completed',
      );
      expect(CloudApiException.isCertificateVerifyFailed(error), isFalse);
    },
  );

  for (final entry in {
    'certificate has expired': 'Certificate has expired',
    'CERT_HAS_EXPIRED': 'Certificate has expired',
    'certificate is not yet valid': 'Certificate is not yet valid',
    'CERT_NOT_YET_VALID': 'Certificate is not yet valid',
    'certificate revoked': 'Certificate has been revoked',
    'CERT_REVOKED': 'Certificate has been revoked',
    'hostname mismatch': 'Certificate does not match the requested domain',
    'IP address mismatch': 'Certificate does not match the requested domain',
    'HOSTNAME_MISMATCH': 'Certificate does not match the requested domain',
    'unable to get local issuer certificate':
        'Certificate chain is not trusted',
    'unable to verify the first certificate':
        'Certificate chain is not trusted',
    'self signed certificate in certificate chain':
        'Certificate chain is not trusted',
    'self-signed certificate': 'Certificate chain is not trusted',
    'certificate not trusted': 'Certificate chain is not trusted',
    'unspecified verification error': 'Certificate Verification Failed',
  }.entries) {
    test(
      'certificate diagnostic classifies ${entry.key} without raw details',
      () {
        final cause = HandshakeException(
          'CERTIFICATE_VERIFY_FAILED: ${entry.key}; private-api.example secret-token',
        );
        final error = _networkError(cause, type: DioExceptionType.unknown);
        expect(CloudApiException.clean(error), 'Direct: ${entry.value}');
        expect(CloudApiException.clean(cause), entry.value);
        expect(
          CloudApiException.clean(Exception(cause.toString())),
          entry.value,
        );
        final wrapped = CloudApiException(
          CloudApiException.clean(error),
          cause: error,
        );
        expect(CloudApiException.certificateMessage(wrapped), entry.value);
      },
    );
  }

  for (final entry in {
    DioExceptionType.cancel: 'Request canceled',
    DioExceptionType.connectionTimeout: 'Connection timed out',
    DioExceptionType.badResponse:
        'Service is temporarily unavailable (HTTP 503)',
  }.entries) {
    test('${entry.key} cannot be reclassified by certificate text', () {
      final error = DioException(
        requestOptions: _options(),
        type: entry.key,
        message: 'CERTIFICATE_VERIFY_FAILED: certificate has expired',
        response: entry.key == DioExceptionType.badResponse
            ? Response(requestOptions: _options(), statusCode: 503)
            : null,
      );
      expect(CloudApiException.clean(error), 'Direct: ${entry.value}');
      expect(CloudApiException.isCertificateVerifyFailed(error), isFalse);
    });
  }

  test('untyped Dio metadata cannot invent a certificate failure', () {
    final error = DioException(
      requestOptions: _options(),
      message: 'CERTIFICATE_VERIFY_FAILED: certificate has expired',
    );
    expect(CloudApiException.clean(error), 'Direct: Unknown network error');
    expect(CloudApiException.isCertificateVerifyFailed(error), isFalse);
  });

  test('request metadata cannot decide the certificate failure category', () {
    final error = DioException.badCertificate(
      requestOptions: RequestOptions(
        path: 'https://api.test/certificate has expired',
      ),
    );
    expect(
      CloudApiException.certificateReason(error),
      TlsCertificateFailureReason.unknown,
    );
  });

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

  for (final entry in {
    400: 'Server rejected the request as invalid',
    403: 'Access forbidden',
    404: 'Requested API or resource was not found',
    405: 'Request method is not allowed',
    408: 'Server timed out receiving the request',
    413: 'Request exceeds the server size limit',
    429: 'Too many requests; try again later',
    500: 'Internal server error',
    502: 'Gateway received an invalid upstream response',
    503: 'Service is temporarily unavailable',
    504: 'Gateway timed out waiting for the upstream server',
    511: 'This network requires sign-in before access',
  }.entries) {
    test(
      'HTTP ${entry.key} retains its meaning and hides response contents',
      () {
        final options = _options();
        final error = DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: options,
            statusCode: entry.key,
            data: 'secret-token private-api.example',
          ),
        );
        expect(
          CloudApiException.clean(error),
          'Direct: ${entry.value} (HTTP ${entry.key})',
        );
        expect(CloudApiException.isUnauthorized(error), isFalse);
      },
    );
  }

  for (final entry in {
    'WRONG_VERSION_NUMBER': 'Incompatible TLS protocol or invalid TLS response',
    'tlsv1 alert protocol version':
        'Incompatible TLS protocol or invalid TLS response',
    'UNSUPPORTED_PROTOCOL': 'Incompatible TLS protocol or invalid TLS response',
    'NO_SHARED_CIPHER': 'TLS cryptographic algorithm negotiation failed',
    'no suitable signature algorithm':
        'TLS cryptographic algorithm negotiation failed',
    'UNEXPECTED_EOF_WHILE_READING':
        'Connection closed before the TLS handshake completed',
    'sslv3 alert handshake failure': 'TLS handshake failed',
  }.entries) {
    test('TLS ${entry.key} stays separate from certificate errors', () {
      final error = _networkError(
        HandshakeException('${entry.key} private-api.example secret-token'),
        type: DioExceptionType.unknown,
      );
      expect(CloudApiException.clean(error), 'Direct: ${entry.value}');
      expect(CloudApiException.isCertificateVerifyFailed(error), isFalse);
      expect(CloudApiException.certificateFailure(error), isNull);
    });
  }

  for (final entry in {
    'Connection closed before full header was received':
        'Connection closed before the full response was received',
    'Connection closed before full body was received':
        'Connection closed before the full response was received',
    'Connection closed while receiving data':
        'Connection closed before the full response was received',
    'Invalid response line private-api.example secret-token':
        'Invalid server response',
    'Invalid header field name, with secret-token': 'Invalid server response',
  }.entries) {
    test('HTTP transport distinguishes ${entry.key}', () {
      final error = HttpException(
        entry.key,
        uri: Uri.parse('https://private-api.example?token=secret-token'),
      );
      expect(CloudApiException.clean(error), entry.value);
      expect(
        CloudApiException.clean(_networkError(error)),
        'Direct: ${entry.value}',
      );
    });
  }

  for (final entry in {
    'Redirect loop detected': 'Server redirects form a loop',
    'Redirect limit exceeded': 'Too many server redirects',
    'Server response has no Location header for redirect':
        'Server redirect is invalid',
  }.entries) {
    test('redirect errors distinguish ${entry.key}', () {
      final error = RedirectException(entry.key, const []);
      expect(CloudApiException.clean(error), entry.value);
      expect(
        CloudApiException.clean(_networkError(error)),
        'Direct: ${entry.value}',
      );
    });
  }

  test(
    'response size limits stay distinct from invalid data and retain no body',
    () {
      const oversized = FormatException('HTTP response exceeds size limit');
      const invalid = FormatException(
        'Unexpected private-api.example',
        'secret-token',
      );
      expect(
        CloudApiException.clean(oversized),
        'Server response exceeds the allowed size',
      );
      expect(
        CloudApiException.clean(_networkError(oversized)),
        'Direct: Server response exceeds the allowed size',
      );
      expect(CloudApiException.clean(invalid), 'Invalid server response');
    },
  );

  test('unknown HTTP status stays numeric', () {
    final error = DioException.badResponse(
      statusCode: 418,
      requestOptions: _options(),
      response: Response(requestOptions: _options(), statusCode: 418),
    );
    expect(CloudApiException.clean(error), 'Direct: Server returned HTTP 418');
  });

  for (final entry in {
    'Software caused connection abort': 'Connection aborted',
    "Can't assign requested address": 'Network address is unavailable',
    'Address already in use': 'Network address or port is already in use',
    'Too many open files': 'Insufficient system network resources',
    'No buffer space available': 'Insufficient system network resources',
  }.entries) {
    test(
      'socket text classifies ${entry.key} without guessing platform errno',
      () {
        final error = SocketException(
          entry.key,
          osError: const OSError('private-api.example secret-token', 9999),
        );
        expect(
          CloudApiException.clean(error),
          '${entry.value} (System error 9999)',
        );
      },
    );
  }

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

  test('a 403 without a known reason reports denial and keeps its status', () {
    expect(
      CloudApiException.clean(_forbidden()),
      'Direct: Access forbidden (HTTP 403)',
    );
    expect(
      CloudApiException.clean(_forbidden(reason: 'something_else')),
      'Direct: Access forbidden (HTTP 403)',
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
