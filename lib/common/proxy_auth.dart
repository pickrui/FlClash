import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:fl_clash/models/config.dart';

typedef ProxyAuthenticationState = ({
  int port,
  AuthenticationProps authentication,
});

AuthenticationProps enableProxyAuthentication(AuthenticationProps value) {
  final random = Random.secure();
  String secret(int count) => List.generate(
    count,
    (_) =>
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'[random
            .nextInt(62)],
  ).join();
  return value.copyWith(
    enable: true,
    username: AuthenticationProps.validUsername(value.username)
        ? value.username
        : secret(8),
    password: AuthenticationProps.validPassword(value.password)
        ? value.password
        : secret(20),
  );
}

bool needsVpnRestartForAuthentication({
  required bool android,
  required bool running,
  required VpnProps vpn,
  required bool before,
  required bool after,
}) => android && running && vpn.enable && vpn.systemProxy && before != after;

/// Keep credentials out of proxy address strings and origin headers. Dart's
/// HttpClient caches proxy passwords, so rotate the client when credentials
/// change; a mihomo 403 cannot trigger HttpClient's 407 credential refresh.
class ProxyAuthenticatedHttpClient implements HttpClient {
  final HttpClient Function() _create;
  final SecurityContext? _securityContext;
  bool Function(X509Certificate, String, int)? _badCertificateCallback;
  Function(String)? _keyLog;
  Future<ConnectionTask<Socket>> Function(Uri, String?, int?)?
  _connectionFactory;
  final ProxyAuthenticationState? Function() _read;
  final _settings = <String, void Function(HttpClient)>{};
  final _clients = <HttpClient>[];
  final _connectors = <HttpClient>{};
  String Function(Uri)? _findProxy;
  HttpClient? _current;
  ProxyAuthenticationState? _authentication;
  bool _closed = false;

  ProxyAuthenticatedHttpClient({
    required this._create,
    required this._read,
    this._securityContext,
  });

  static HttpClient wrap(
    HttpClient first,
    ProxyAuthenticationState? Function() read,
  ) {
    if (first is ProxyAuthenticatedHttpClient) return first;
    HttpClient? initial = first;
    return ProxyAuthenticatedHttpClient(
      create: () {
        final client = initial;
        initial = null;
        return client ?? HttpClient();
      },
      read: read,
    );
  }

  HttpClient get _client {
    if (_closed) throw StateError('HttpClient is closed');
    final next = _read();
    if (_current == null || next != _authentication) {
      final auth = next?.authentication;
      if (auth?.enable == true) {
        auth!.credentials; // Validate before retiring the working client.
        if (next!.port <= 0 || next.port > 65535) {
          throw const FormatException('Invalid local proxy port');
        }
      }
      final client = _createRaw();
      for (final entry in _settings.entries) {
        if (auth?.enable != true || !entry.key.startsWith('proxy:')) {
          entry.value(client);
        }
      }
      if (auth?.enable == true) _installTunnel(client, next!);
      _current?.close(); // Let requests already in flight finish.
      _current = client;
      _authentication = next;
      _clients.add(client);
    }
    return _current!;
  }

  void _set(String key, void Function(HttpClient) configure) {
    if (_closed) throw StateError('HttpClient is closed');
    _settings[key] = configure;
    if (_current case final client?) {
      if (_authentication?.authentication.enable != true ||
          !key.startsWith('proxy:')) {
        configure(client);
      }
      if (_authentication?.authentication.enable == true) {
        _installTunnel(client, _authentication!);
      }
    }
  }

  HttpClient _createRaw() {
    final client = _create();
    if (client is! ProxyAuthenticatedHttpClient) return client;
    final raw = client._createRaw();
    client.close();
    return raw;
  }

  // Dart can also put cached Proxy-Authorization on the HTTPS origin request
  // after CONNECT (including redirects). Give credentials only to a temporary
  // CONNECT client. The main client carries origin traffic on the detached
  // socket and never receives those credentials. dart:io validates TLS with the
  // caller's security context and certificate policy.
  void _installTunnel(HttpClient client, ProxyAuthenticationState state) {
    client.findProxy = (_) => 'DIRECT';
    client.connectionFactory = (uri, _, _) async {
      var canceled = false;
      HttpClient? connector;
      ConnectionTask<Socket>? directTask;
      Socket? connected;
      Future<Socket> connect() async {
        final routes = (_findProxy?.call(uri) ?? 'DIRECT').split(';');
        Object? lastError;
        for (final candidate in routes) {
          if (canceled || _closed) {
            throw const HttpException('Connection canceled');
          }
          final route = candidate.trim();
          try {
            if (route == 'DIRECT') {
              directTask =
                  await (_connectionFactory?.call(uri, null, null) ??
                      Socket.startConnect(uri.host, uri.port));
              if (canceled || _closed) directTask!.cancel();
              connected = await directTask!.socket;
            } else if (route.startsWith('PROXY ')) {
              connector = _createRaw();
              _connectors.add(connector!);
              for (final entry in _settings.entries) {
                if (!entry.key.startsWith('site:') &&
                    entry.key != 'authenticate') {
                  entry.value(connector!);
                }
              }
              Socket? tunnelSocket;
              connector!.connectionFactory =
                  (target, proxyHost, proxyPort) async {
                    final factory = _connectionFactory;
                    directTask =
                        await (factory?.call(target, proxyHost, proxyPort) ??
                            Socket.startConnect(
                              proxyHost ?? target.host,
                              proxyPort ?? target.port,
                            ));
                    return ConnectionTask.fromSocket(
                      directTask!.socket.then((socket) {
                        tunnelSocket = socket;
                        return socket;
                      }),
                      directTask!.cancel,
                    );
                  };
              for (final host in ['localhost', '127.0.0.1', '::1']) {
                connector!.addProxyCredentials(
                  host,
                  state.port,
                  '',
                  HttpClientBasicCredentials(
                    state.authentication.username,
                    state.authentication.password,
                  ),
                );
              }
              connector!.findProxy = (_) => route;
              final request = await connector!.openUrl(
                'CONNECT',
                Uri(scheme: 'http', host: uri.host, port: uri.port),
              );
              request.followRedirects = false;
              final response = await request.close();
              if (response.statusCode != HttpStatus.ok) {
                throw HttpException(
                  'Proxy CONNECT failed (${response.statusCode})',
                );
              }
              final detached = await response.detachSocket();
              // HttpClient's DetachedSocket wrapper cannot be upgraded by
              // SecureSocket.secure. Retain the native socket from our factory;
              // detachSocket has already released the HTTP parser's ownership.
              connected = uri.scheme == 'https' ? tunnelSocket! : detached;
            } else {
              throw const HttpException('Unsupported proxy configuration');
            }
            if (canceled || _closed) {
              connected?.destroy();
              throw const HttpException('Connection canceled');
            }
            if (uri.scheme == 'https' && connected is! SecureSocket) {
              final certificateCallback = _badCertificateCallback;
              connected = await SecureSocket.secure(
                connected!,
                host: uri.host,
                context: _securityContext,
                keyLog: _keyLog,
                onBadCertificate: (certificate) =>
                    certificateCallback?.call(
                      certificate,
                      uri.host,
                      uri.port,
                    ) ??
                    false,
              );
            }
            return connected!;
          } on SocketException catch (error) {
            connected?.destroy();
            lastError = error;
          } on TimeoutException catch (error) {
            connected?.destroy();
            lastError = error;
          } catch (_) {
            connected?.destroy();
            rethrow;
          } finally {
            connector?.close(force: true);
            _connectors.remove(connector);
            connector = null;
          }
        }
        throw lastError ?? const HttpException('No proxy route available');
      }

      return ConnectionTask.fromSocket(connect(), () {
        canceled = true;
        directTask?.cancel();
        connector?.close(force: true);
        connected?.destroy();
      });
    };
  }

  @override
  Future<HttpClientRequest> open(
    String method,
    String host,
    int port,
    String path,
  ) => _client.open(method, host, port, path);
  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) =>
      _client.openUrl(method, url);
  @override
  Future<HttpClientRequest> get(String host, int port, String path) =>
      open('GET', host, port, path);
  @override
  Future<HttpClientRequest> getUrl(Uri url) => openUrl('GET', url);
  @override
  Future<HttpClientRequest> post(String host, int port, String path) =>
      open('POST', host, port, path);
  @override
  Future<HttpClientRequest> postUrl(Uri url) => openUrl('POST', url);
  @override
  Future<HttpClientRequest> put(String host, int port, String path) =>
      open('PUT', host, port, path);
  @override
  Future<HttpClientRequest> putUrl(Uri url) => openUrl('PUT', url);
  @override
  Future<HttpClientRequest> delete(String host, int port, String path) =>
      open('DELETE', host, port, path);
  @override
  Future<HttpClientRequest> deleteUrl(Uri url) => openUrl('DELETE', url);
  @override
  Future<HttpClientRequest> patch(String host, int port, String path) =>
      open('PATCH', host, port, path);
  @override
  Future<HttpClientRequest> patchUrl(Uri url) => openUrl('PATCH', url);
  @override
  Future<HttpClientRequest> head(String host, int port, String path) =>
      open('HEAD', host, port, path);
  @override
  Future<HttpClientRequest> headUrl(Uri url) => openUrl('HEAD', url);
  @override
  Duration get idleTimeout => _client.idleTimeout;
  @override
  set idleTimeout(Duration value) =>
      _set('idleTimeout', (client) => client.idleTimeout = value);
  @override
  Duration? get connectionTimeout => _client.connectionTimeout;
  @override
  set connectionTimeout(Duration? value) =>
      _set('connectionTimeout', (client) => client.connectionTimeout = value);
  @override
  int? get maxConnectionsPerHost => _client.maxConnectionsPerHost;
  @override
  set maxConnectionsPerHost(int? value) => _set(
    'maxConnectionsPerHost',
    (client) => client.maxConnectionsPerHost = value,
  );
  @override
  bool get autoUncompress => _client.autoUncompress;
  @override
  set autoUncompress(bool value) =>
      _set('autoUncompress', (client) => client.autoUncompress = value);
  @override
  String? get userAgent => _client.userAgent;
  @override
  set userAgent(String? value) =>
      _set('userAgent', (client) => client.userAgent = value);
  @override
  set authenticate(Future<bool> Function(Uri, String, String?)? value) =>
      _set('authenticate', (client) => client.authenticate = value);
  @override
  set connectionFactory(
    Future<ConnectionTask<Socket>> Function(Uri, String?, int?)? value,
  ) {
    _connectionFactory = value;
    _set('connectionFactory', (client) => client.connectionFactory = value);
  }

  @override
  set findProxy(String Function(Uri)? value) {
    _findProxy = value;
    _set('findProxy', (client) => client.findProxy = value);
  }

  @override
  set authenticateProxy(
    Future<bool> Function(String, int, String, String?)? value,
  ) => _set('authenticateProxy', (client) => client.authenticateProxy = value);
  @override
  set badCertificateCallback(
    bool Function(X509Certificate, String, int)? value,
  ) {
    _badCertificateCallback = value;
    _set(
      'badCertificateCallback',
      (client) => client.badCertificateCallback = value,
    );
  }

  @override
  set keyLog(Function(String)? value) {
    _keyLog = value;
    _set('keyLog', (client) => client.keyLog = value);
  }

  @override
  void addCredentials(
    Uri url,
    String realm,
    HttpClientCredentials credentials,
  ) => _set(
    'site:$url:$realm',
    (client) => client.addCredentials(url, realm, credentials),
  );
  @override
  void addProxyCredentials(
    String host,
    int port,
    String realm,
    HttpClientCredentials credentials,
  ) => _set(
    'proxy:$host:$port:$realm',
    (client) => client.addProxyCredentials(host, port, realm, credentials),
  );
  @override
  void close({bool force = false}) {
    _closed = true;
    for (final connector in _connectors) {
      connector.close(force: force);
    }
    _connectors.clear();
    for (final client in _clients) {
      client.close(force: force);
    }
    _clients.clear();
    _current = null;
    _authentication = null;
    _settings.clear();
  }
}
