import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/common/proxy_auth.dart';
import 'tls_connection.dart';

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

class TlsCertificateFailure implements Exception {
  TlsCertificateFailure(X509Certificate certificate, String host, int port)
    : origin = Uri(scheme: 'https', host: host.toLowerCase(), port: port),
      fingerprint = sha256.convert(certificate.der).toString();

  final Uri origin;
  final String fingerprint;

  bool matches(X509Certificate certificate, String host, int port) =>
      origin.host == host.toLowerCase() &&
      origin.port == port &&
      fingerprint == sha256.convert(certificate.der).toString();

  @override
  String toString() => 'CERTIFICATE_VERIFY_FAILED';
}

class _TlsGrant {
  _TlsGrant(this.failure);

  final TlsCertificateFailure failure;
  final releases = <void Function()>{};
  bool active = true;

  void revoke() {
    active = false;
    for (final release in releases.toList()) {
      release();
    }
    releases.clear();
  }
}

class FlClashTemporaryTls {
  const FlClashTemporaryTls._();

  static final _zoneKey = Object();
  static _TlsGrant? get _grant {
    final grant = Zone.current[_zoneKey] as _TlsGrant?;
    return grant?.active == true ? grant : null;
  }

  static bool get allowBadCertificate => _grant != null;

  static TlsCertificateFailure? failureFor(Object error) {
    if (error is TlsCertificateFailure) return error;
    if (error is DioException && error.error != null) {
      return failureFor(error.error!);
    }
    return null;
  }

  static Future<T> runWithBadCertificateAllowed<T>(
    TlsCertificateFailure failure,
    Future<T> Function() action,
  ) async {
    final grant = _TlsGrant(failure);
    try {
      return await runZoned(action, zoneValues: {_zoneKey: grant});
    } finally {
      grant.revoke();
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

HttpClientAdapter createFlClashHttpClientAdapter({
  required String Function(Uri uri) findProxy,
  bool Function()? allowBadCertificate,
  bool allowCertificateRetry = false,
  String? Function()? userAgent,
  HostResolver? resolver,
}) {
  IOHttpClientAdapter create(
    bool Function(X509Certificate, String, int) onBadCertificate,
  ) => _FlClashHttpClientAdapter(
    createHttpClient: () {
      final client = ProxyAuthenticatedHttpClient.wrap(
        HttpClient(),
        FlClashHttpOverrides.readProxyAuthentication,
      );
      client.badCertificateCallback = onBadCertificate;
      if (resolver != null) {
        client.connectionFactory = (uri, proxyHost, proxyPort) =>
            connectWithResolver(
              uri,
              proxyHost,
              proxyPort,
              resolver: resolver,
              onBadCertificate: onBadCertificate,
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
  return allowCertificateRetry
      ? _CertificateRetryAdapter(create)
      : create((_, _, _) => allowBadCertificate?.call() ?? false);
}

class _CertificateRetryAdapter implements HttpClientAdapter {
  _CertificateRetryAdapter(this._create);

  final IOHttpClientAdapter Function(
    bool Function(X509Certificate, String, int),
  )
  _create;
  final _active = <HttpClientAdapter, void Function()>{};
  bool _closed = false;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (_closed) throw StateError('Certificate retry adapter is closed');
    final grant = FlClashTemporaryTls._grant;
    TlsCertificateFailure? failure;
    final adapter = _create((certificate, host, port) {
      if (grant?.active == true &&
          grant!.failure.matches(certificate, host, port)) {
        return true;
      }
      failure = TlsCertificateFailure(certificate, host, port);
      return false;
    });
    var released = false;
    StreamSubscription<void>? cancellation;
    void release() {
      if (released) return;
      released = true;
      final subscription = cancellation;
      if (subscription != null) unawaited(subscription.cancel());
      _active.remove(adapter);
      grant?.releases.remove(release);
      adapter.close(force: true);
    }

    _active[adapter] = release;
    grant?.releases.add(release);
    cancellation = cancelFuture?.asStream().listen((_) => release());
    try {
      final response = await adapter.fetch(
        options,
        requestStream,
        cancelFuture,
      );
      if (released) {
        await response.stream.listen(null).cancel();
        throw DioException.requestCancelled(
          requestOptions: options,
          reason: 'Certificate retry canceled',
        );
      }
      final stream = response.stream;
      response.stream = () async* {
        try {
          yield* stream;
        } finally {
          release();
        }
      }();
      return response;
    } catch (error) {
      release();
      if (failure != null &&
          FlClashTemporaryTls.isCertificateVerifyFailed(error)) {
        throw DioException.badCertificate(
          requestOptions: options,
          error: failure,
        );
      }
      rethrow;
    }
  }

  @override
  void close({bool force = false}) {
    if (_closed) return;
    _closed = true;
    for (final entry in _active.entries.toList()) {
      if (force) {
        entry.value();
      } else {
        entry.key.close();
      }
    }
  }
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
  bool Function(X509Certificate, String, int)? onBadCertificate,
}) async {
  if (proxyHost != null) {
    // Never fall through to a direct connection for a proxied request.
    return Socket.startConnect(proxyHost, proxyPort!);
  }
  final secure = uri.isScheme('https');
  final port = uri.hasPort ? uri.port : (secure ? 443 : 80);
  final addresses = await resolver.resolve(uri.host);
  ConnectionTask<Socket>? pending;
  Socket? activeSocket;
  var canceled = false;
  Future<Socket> connect() async {
    Object? lastError;
    StackTrace? lastStackTrace;
    for (final address in addresses) {
      if (canceled) throw const SocketException('Connection attempt cancelled');
      try {
        final task = pending = await (secure
            ? startTlsConnection(
                address,
                port,
                host: uri.host,
                onBadCertificate: (certificate) =>
                    onBadCertificate?.call(certificate, uri.host, port) ??
                    false,
              )
            : Socket.startConnect(address, port));
        if (canceled) {
          task.cancel();
          throw const SocketException('Connection attempt cancelled');
        }
        final socket = activeSocket = await task.socket;
        if (canceled) {
          socket.destroy();
          throw const SocketException('Connection attempt cancelled');
        }
        resolver.confirm(uri.host, address);
        return socket;
      } catch (error, stackTrace) {
        activeSocket?.destroy();
        activeSocket = null;
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
    // A completed TCP task no longer owns its socket. Keep ownership through
    // the TLS handshake so cancellation also releases that connection.
    activeSocket?.destroy();
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

  static Set<String> splitRoutes(String findProxyResult) =>
      findProxyResult.split(';').map((route) => route.trim()).toSet();

  static String Function(Uri) pinnedRoute(String route) =>
      (uri) => _isLocalHost(uri.host) ? 'DIRECT' : route;

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
    client.findProxy = handleResourceFindProxy;
    return client;
  }
}
