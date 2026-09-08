import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';

String resolveCloudApiProxy({required bool isCoreRunning, required int port}) {
  if (!isCoreRunning || port <= 0 || port > 65535) {
    return 'DIRECT';
  }
  return 'DIRECT; PROXY localhost:$port';
}

String resolveResourceProxy({required bool isCoreRunning, required int port}) {
  if (!isCoreRunning || port <= 0 || port > 65535) return 'DIRECT';
  return 'PROXY localhost:$port; DIRECT';
}

class FlClashTemporaryTls {
  const FlClashTemporaryTls._();

  static int _badCertificateDepth = 0;

  static bool get allowBadCertificate => _badCertificateDepth > 0;

  static Future<T> runWithBadCertificateAllowed<T>(
    Future<T> Function() action,
  ) async {
    _badCertificateDepth++;
    try {
      return await action();
    } finally {
      _badCertificateDepth--;
    }
  }

  static bool isCertificateVerifyFailed(Object error) {
    if (error is DioException &&
        error.type == DioExceptionType.badCertificate) {
      return true;
    }
    final message = error.toString().toLowerCase();
    return message.contains('certificate_verify_failed') ||
        message.contains('certificate verify failed') ||
        message.contains('bad certificate') ||
        message.contains('invalid certificate') ||
        message.contains('unable to get local issuer certificate');
  }
}

IOHttpClientAdapter createFlClashHttpClientAdapter({
  required String Function(Uri uri) findProxy,
  bool Function()? allowBadCertificate,
  String? Function()? userAgent,
}) {
  return _FlClashHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient();
      client.badCertificateCallback = (_, _, _) =>
          allowBadCertificate?.call() ?? false;
      client.findProxy = (uri) {
        final ua = userAgent?.call();
        if (ua != null && ua.isNotEmpty) {
          client.userAgent = ua;
        }
        return findProxy(uri);
      };
      return client;
    },
  );
}

class _FlClashHttpClientAdapter extends IOHttpClientAdapter {
  _FlClashHttpClientAdapter({required super.createHttpClient});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    // Dart stores HTTPS proxy tunnels in the origin's idle connection pool.
    // Reusing one after choosing DIRECT can silently keep the previous exit.
    return super.fetch(
      options.copyWith(persistentConnection: false),
      requestStream,
      cancelFuture,
    );
  }
}

class FlClashHttpOverrides extends HttpOverrides {
  static bool _isLocalHost(String host) {
    final normalizedHost = host.trim().toLowerCase();
    return normalizedHost == localhost ||
        normalizedHost == 'localhost' ||
        (InternetAddress.tryParse(normalizedHost)?.isLoopback ?? false);
  }

  static String handleFindProxy(Uri url) {
    if (_isLocalHost(url.host) || Secrets.isApiDomain(url.host)) {
      return 'DIRECT';
    }
    final port = appController.config.patchClashConfig.mixedPort;
    final isStart = appController.isStart;
    final displayUrl = Uri(
      scheme: url.scheme,
      host: url.host,
      port: url.hasPort ? url.port : null,
      path: url.path,
    );
    commonPrint.log('find $displayUrl proxy:$isStart');
    if (!isStart) return 'DIRECT';
    return 'PROXY localhost:$port';
  }

  static String handleCloudApiFindProxy(Uri url) {
    if (_isLocalHost(url.host) || !appController.isAttach) {
      return 'DIRECT';
    }
    final port = appController.config.patchClashConfig.mixedPort;
    return resolveCloudApiProxy(
      isCoreRunning: appController.isStart,
      port: port,
    );
  }

  // Resource clients can change route only while opening a connection.
  // HttpClient performs this fallback before sending the request body.
  static String handleResourceFindProxy(Uri url) {
    if (_isLocalHost(url.host) || !appController.isAttach) return 'DIRECT';
    if (Secrets.isApiDomain(url.host)) return handleCloudApiFindProxy(url);
    return resolveResourceProxy(
      isCoreRunning: appController.isStart,
      port: appController.config.patchClashConfig.mixedPort,
    );
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.connectionTimeout = const Duration(seconds: 10);
    client.badCertificateCallback = (_, _, _) =>
        FlClashTemporaryTls.allowBadCertificate;
    client.findProxy = handleResourceFindProxy;
    return client;
  }
}
