import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/common/proxy_auth.dart';

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
  HostResolver? resolver,
}) {
  return _FlClashHttpClientAdapter(
    createHttpClient: () {
      final client = ProxyAuthenticatedHttpClient.wrap(
        HttpClient(),
        FlClashHttpOverrides.readProxyAuthentication,
      );
      client.badCertificateCallback = (_, _, _) =>
          allowBadCertificate?.call() ?? false;
      if (resolver != null) {
        client.connectionFactory = (uri, proxyHost, proxyPort) =>
            connectWithResolver(
              uri,
              proxyHost,
              proxyPort,
              resolver: resolver,
              allowBadCertificate: allowBadCertificate,
            );
      }
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

/// Opens the connection over an address [resolver] chose. A direct HTTPS
/// request is secured here, because a client with a connection factory hands
/// the socket to the request untouched; the handshake still names the URL's
/// host, so the certificate is checked against the domain and not the address.
/// Proxied requests keep Dart's own path: it opens the tunnel and secures it.
Future<ConnectionTask<Socket>> connectWithResolver(
  Uri uri,
  String? proxyHost,
  int? proxyPort, {
  required HostResolver resolver,
  bool Function()? allowBadCertificate,
}) async {
  if (proxyHost != null) {
    // Never fall through to a direct connection for a proxied request.
    return Socket.startConnect(proxyHost, proxyPort!);
  }
  final secure = uri.isScheme('https');
  final port = uri.hasPort ? uri.port : (secure ? 443 : 80);
  final addresses = await resolver.resolve(uri.host);
  ConnectionTask<Socket>? pending;
  var canceled = false;
  Future<Socket> connect() async {
    Object? lastError;
    StackTrace? lastStackTrace;
    for (final address in addresses) {
      if (canceled) throw const SocketException('Connection attempt cancelled');
      try {
        final task = pending = await Socket.startConnect(address, port);
        final socket = await task.socket;
        if (canceled) {
          socket.destroy();
          throw const SocketException('Connection attempt cancelled');
        }
        final connected = secure
            ? await SecureSocket.secure(
                socket,
                host: uri.host,
                onBadCertificate: (_) => allowBadCertificate?.call() ?? false,
              )
            : socket;
        resolver.confirm(uri.host, address);
        return connected;
      } catch (error, stackTrace) {
        if (canceled) rethrow;
        lastError = error;
        lastStackTrace = stackTrace;
      }
    }
    if (lastError != null) {
      Error.throwWithStackTrace(lastError, lastStackTrace!);
    }
    throw SocketException('No address for \'${uri.host}\'');
  }

  return ConnectionTask.fromSocket<Socket>(connect(), () {
    canceled = true;
    pending?.cancel();
  });
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
  static ProxyAuthenticationState? readProxyAuthentication() {
    if (!appController.isAttach || !appController.isProxyActive) return null;
    final config = appController.config;
    return (
      port: config.patchClashConfig.mixedPort,
      authentication: config.networkProps.authentication,
    );
  }

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
    final isStart = appController.isProxyActive;
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
      isCoreRunning: appController.isProxyActive,
      port: port,
    );
  }

  // Resource clients can change route only while opening a connection.
  // HttpClient performs this fallback before sending the request body.
  static String handleResourceFindProxy(Uri url) {
    if (_isLocalHost(url.host) || !appController.isAttach) return 'DIRECT';
    if (Secrets.isApiDomain(url.host)) return handleCloudApiFindProxy(url);
    return resolveResourceProxy(
      isCoreRunning: appController.isProxyActive,
      port: appController.config.patchClashConfig.mixedPort,
    );
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = ProxyAuthenticatedHttpClient(
      create: () => super.createHttpClient(context),
      read: readProxyAuthentication,
      securityContext: context,
    );
    client.connectionTimeout = const Duration(seconds: 10);
    client.badCertificateCallback = (_, _, _) =>
        FlClashTemporaryTls.allowBadCertificate;
    client.findProxy = handleResourceFindProxy;
    return client;
  }
}
