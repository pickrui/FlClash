import 'dart:async';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:webdav_client/webdav_client.dart';

import 'bounded_http_client_adapter.dart';
import 'http_read_race.dart';

bool isSafeDavFileName(String value) {
  if (value.isEmpty || value == '.' || value == '..' || value.length > 255) {
    return false;
  }
  return !value.contains(RegExp(r'[/\\?#\x00-\x1f\x7f]'));
}

class DAVClient {
  late final Client client;
  final Completer<bool> pingCompleter = Completer();
  final DAVProps _dav;
  final Iterable<String> Function(Uri) _resolveRoutes;
  final HttpClientAdapter Function(String)? _createAdapter;
  final Duration readTimeout;

  DAVClient(
    DAVProps dav, {
    Iterable<String> Function(Uri)? resolveRoutes,
    HttpClientAdapter Function(String)? createAdapter,
    this.readTimeout = const Duration(seconds: 60),
  }) : _dav = dav,
       _resolveRoutes = resolveRoutes ?? _defaultRoutes,
       _createAdapter = createAdapter {
    if (!isSafeDavFileName(dav.fileName)) {
      throw const FormatException('invalid WebDAV backup file name');
    }
    final uri = Uri.tryParse(dav.uri);
    if (uri == null ||
        !const {'http', 'https'}.contains(uri.scheme) ||
        uri.host.isEmpty) {
      throw const FormatException('invalid WebDAV URL');
    }
    client = _newClient();
    pingCompleter.complete(_ping());
  }

  static Iterable<String> _defaultRoutes(Uri uri) =>
      FlClashHttpOverrides.handleResourceFindProxy(
        uri,
      ).split(';').map((route) => route.trim()).toSet();

  Client _newClient({String? route}) {
    final result = newClient(
      _dav.uri,
      user: _dav.user,
      password: _dav.password,
    );
    final origin = Uri.parse(_dav.uri);
    result.c.options.persistentConnection = false;
    result.setHeaders({'accept-charset': 'utf-8', 'Content-Type': 'text/xml'});
    result.setConnectTimeout(8000);
    result.setSendTimeout(60000);
    result.setReceiveTimeout(60000);
    final adapter = route != null && _createAdapter != null
        ? _createAdapter(route)
        : createFlClashHttpClientAdapter(
            findProxy: route == null
                ? FlClashHttpOverrides.handleResourceFindProxy
                : (uri) =>
                      uri.host == 'localhost' ||
                          (io.InternetAddress.tryParse(uri.host)?.isLoopback ??
                              false)
                      ? 'DIRECT'
                      : route,
            allowBadCertificate: () => FlClashTemporaryTls.allowBadCertificate,
          );
    result.c.httpClientAdapter = route == null
        ? adapter
        : BoundedHttpClientAdapter(adapter, maxBytes: maxBackupArchiveBytes);
    var requests = 0;
    result.c.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final target = options.uri;
          if (target.scheme != origin.scheme ||
              target.host != origin.host ||
              target.port != origin.port ||
              (route != null && ++requests > 16)) {
            handler.reject(
              DioException(
                requestOptions: options,
                error: const FormatException('Invalid WebDAV redirect'),
              ),
            );
            return;
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          // A write must never be replayed after a redirect response.
          if (route == null &&
              (response.statusCode ?? 0) >= 300 &&
              (response.statusCode ?? 0) < 400) {
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                type: DioExceptionType.badResponse,
              ),
            );
            return;
          }
          handler.next(response);
        },
      ),
    );
    return result;
  }

  Future<T> _raceRead<T>(
    Future<T> Function(Client client, CancelToken token) read,
  ) => raceHttpReads<T>(
    _resolveRoutes(Uri.parse(_dav.uri)).toSet().map(
      (route) => (token) async {
        final routed = _newClient(route: route);
        try {
          return await read(routed, token);
        } finally {
          routed.c.close(force: true);
        }
      },
    ),
    timeout: readTimeout,
  );

  Future<bool> _ping() async {
    try {
      return await _raceRead((client, token) async {
        await client.ping(token);
        return true;
      });
    } catch (_) {
      return false;
    }
  }

  String get fileName => _dav.fileName;

  String get root => '/$appName';

  String get backupFile => '$root/$fileName';

  Future<bool> backup(String localFilePath) async {
    await client.mkdir(root);
    final temporaryRemotePath = '$backupFile.upload-${utils.id}';
    try {
      await client.writeFromFile(localFilePath, temporaryRemotePath);
      await client.rename(temporaryRemotePath, backupFile, true);
    } catch (_) {
      try {
        await client.remove(temporaryRemotePath);
      } catch (_) {}
      rethrow;
    }
    return true;
  }

  Future<String> restore() async {
    final candidates = <String>{};
    String? winner;
    try {
      winner = await _raceRead<String>((client, token) async {
        String? candidate;
        var valid = false;
        try {
          final bytes = await client.read(backupFile, cancelToken: token);
          final error = token.cancelError;
          if (error != null) throw error;
          if (bytes.isEmpty || bytes.length > maxBackupArchiveBytes) {
            throw const FormatException('invalid backup archive size');
          }
          candidate = await appPath.tempFilePath;
          final pathError = token.cancelError;
          if (pathError != null) throw pathError;
          await io.File(candidate).writeAsBytes(bytes, flush: true);
          await validateBackupArchiveDirectory(
            candidate,
            '$candidate.restore',
            verifyPayload: true,
          );
          final completionError = token.cancelError;
          if (completionError != null) throw completionError;
          valid = true;
          candidates.add(candidate);
          return candidate;
        } finally {
          if (!valid && candidate != null) {
            await io.File(candidate).safeDelete();
          }
        }
      });
      return winner;
    } finally {
      // Each branch owns its file; a late loser cannot remove the winner.
      for (final candidate in candidates.toList()) {
        if (candidate != winner) await io.File(candidate).safeDelete();
      }
    }
  }
}
