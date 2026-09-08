import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/core/controller.dart' show ConfigValidationException;
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'bounded_http_client_adapter.dart';
import 'http_read_race.dart';

class AppUpdateInfo {
  const AppUpdateInfo({this.releaseNotes});

  final String? releaseNotes;
}

final _releaseVersionPattern = RegExp(
  r'^v?(\d+(?:\.\d+)+(?:[-+][\w.-]+)?)$',
  caseSensitive: false,
);
final _releasePlaceholderPattern = RegExp(
  r'^(?:(?:feat|chore)(?:\([^)]*\))?:\s*)?(?:release|follow upstream)\s+v?\d+(?:\.\d+)+(?:[-+][\w.-]+)?$',
  caseSensitive: false,
);
final _releaseHeadingPattern = RegExp(
  r'^##\s+(v?\d+(?:\.\d+)+(?:[-+][\w.-]+)?)\s*$',
  caseSensitive: false,
);

String? normalizeReleaseTagName(String? value) {
  if (value == null) return null;
  final match = _releaseVersionPattern.firstMatch(value.trim());
  return match == null ? null : 'v${match.group(1)}';
}

String? releaseTagNameFromVersionData(Object? versionData) {
  if (versionData is String) {
    return normalizeReleaseTagName(versionData.split('+').first);
  }
  if (versionData is! Map<String, dynamic>) return null;
  for (final key in [
    'tag_name',
    'tagName',
    'version_name',
    'versionName',
    'version',
  ]) {
    final value = versionData[key];
    if (value is! String) continue;
    final tagName = normalizeReleaseTagName(value.split('+').first);
    if (tagName != null) return tagName;
  }
  return null;
}

String? latestReleaseTagNameFromChangelog(String source) {
  for (final line in source.replaceAll('\r\n', '\n').split('\n')) {
    final match = _releaseHeadingPattern.firstMatch(line.trim());
    if (match != null) return normalizeReleaseTagName(match.group(1));
  }
  return null;
}

String? normalizeReleaseNotes(String? source) {
  if (source == null) return null;
  final normalized = <String>[];
  var pendingEmptyLine = false;
  for (final rawLine in source.replaceAll('\r\n', '\n').split('\n')) {
    var line = rawLine.trimRight();
    final releaseLine = line
        .trim()
        .replaceFirst(RegExp(r'^#{1,6}\s+'), '')
        .replaceFirst(RegExp(r'^-\s+'), '');
    if (_releaseVersionPattern.hasMatch(releaseLine) ||
        _releasePlaceholderPattern.hasMatch(releaseLine)) {
      continue;
    }
    line = line.replaceFirst(RegExp(r'^#{1,6}\s+'), '');
    line = line.replaceAllMapped(
      RegExp(r'\[([^\]]+)]\([^)]+\)'),
      (match) => match.group(1)!,
    );
    line = line.replaceAll('**', '').replaceAll('`', '');
    final isEmpty = line.trim().isEmpty;
    if (isEmpty) {
      pendingEmptyLine = normalized.isNotEmpty;
      continue;
    }
    if (pendingEmptyLine &&
        !(normalized.last.trimLeft().startsWith('- ') &&
            line.trimLeft().startsWith('- '))) {
      normalized.add('');
    }
    normalized.add(line);
    pendingEmptyLine = false;
  }
  final result = normalized.join('\n').trim();
  return result.isEmpty ? null : result;
}

String? extractCurrentReleaseNotes(String? source, String tagName) {
  if (source == null) return null;
  final versionNotes = extractReleaseNotesFromChangelog(source, tagName);
  if (versionNotes != null) return versionNotes;
  if (RegExp(r'^##\s+', multiLine: true).hasMatch(source)) return null;
  return normalizeReleaseNotes(source);
}

String? extractEmbeddedReleaseNotes(Object? versionData, String tagName) {
  if (versionData is! Map<String, dynamic>) return null;
  for (final key in ['changelog', 'release_notes', 'releaseNotes']) {
    final notes = versionData[key];
    if (notes is String) {
      final normalized = extractCurrentReleaseNotes(
        notes,
        latestReleaseTagNameFromChangelog(notes) ?? tagName,
      );
      if (normalized != null) return normalized;
    }
  }
  return null;
}

String? extractReleaseNotesFromReleaseBody(String? body, String tagName) {
  if (body == null) return null;
  var end = body.length;
  for (final marker in [
    '<div align=center>',
    '<div align="center">',
    '**Download based on your OS:**',
    '**List of all changes:**',
  ]) {
    final index = body.indexOf(marker);
    if (index >= 0 && index < end) end = index;
  }
  final notes = body.substring(0, end);
  return extractCurrentReleaseNotes(notes, tagName);
}

String? extractReleaseNotesFromChangelog(String source, String tagName) {
  final lines = source.replaceAll('\r\n', '\n').split('\n');
  final normalizedTagName = normalizeReleaseTagName(tagName);
  if (normalizedTagName == null) return null;
  final start = lines.indexWhere((line) {
    final match = _releaseHeadingPattern.firstMatch(line.trim());
    return match != null &&
        normalizeReleaseTagName(match.group(1)) == normalizedTagName;
  });
  if (start < 0) return null;
  var end = lines.length;
  for (var index = start + 1; index < lines.length; index++) {
    if (lines[index].trimLeft().startsWith('## ')) {
      end = index;
      break;
    }
  }
  return normalizeReleaseNotes(lines.sublist(start + 1, end).join('\n'));
}

class Request {
  late final Dio dio;
  final List<String> Function(Uri uri)? _readRoutes;
  final bool Function(String host) _isApiDomain;
  final Duration _readTimeout;
  static const _maxReadBytes = 64 * 1024 * 1024;
  final _apiOptions = BaseOptions(
    headers: {'User-Agent': browserUa},
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  );
  final _resourceOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  Request({
    List<String> Function(Uri uri)? readRoutes,
    bool Function(String host)? isApiDomain,
    Duration readTimeout = const Duration(seconds: 30),
  }) : _readRoutes = readRoutes,
       _isApiDomain = isApiDomain ?? Secrets.isApiDomain,
       _readTimeout = readTimeout {
    // IP detection must report the selected exit, even if that exit fails.
    dio = Dio(
      BaseOptions(
        headers: {'User-Agent': browserUa},
        connectTimeout: const Duration(seconds: 10),
      ),
    );
    dio.httpClientAdapter = createFlClashHttpClientAdapter(
      findProxy: FlClashHttpOverrides.handleFindProxy,
      allowBadCertificate: () => FlClashTemporaryTls.allowBadCertificate,
    );
  }

  Map<String, String> get _flclashIdentityHeaders {
    final packageInfo = globalState.packageInfo;
    final headers = <String, String>{};
    if (packageInfo.buildNumber.isNotEmpty) {
      headers['X-Flclash-Build'] = packageInfo.buildNumber;
    }
    return headers;
  }

  ({Uri? authOrigin, Map<String, dynamic>? headers, String url})
  _resolveBasicAuth(String url, Map<String, dynamic>? headers) {
    final uri = Uri.tryParse(url);
    if (uri == null ||
        uri.userInfo.isEmpty ||
        (!uri.isScheme('http') && !uri.isScheme('https'))) {
      return (authOrigin: null, headers: headers, url: url);
    }

    final requestUrl = uri.replace(userInfo: '').toString();
    final requestHeaders = Map<String, dynamic>.from(headers ?? const {});
    if (!requestHeaders.containsKey(HttpHeaders.authorizationHeader) &&
        !requestHeaders.containsKey('Authorization')) {
      requestHeaders[HttpHeaders.authorizationHeader] =
          'Basic ${base64Encode(utf8.encode(Uri.decodeComponent(uri.userInfo)))}';
    }
    return (
      authOrigin: Uri.tryParse(requestUrl),
      headers: requestHeaders,
      url: requestUrl,
    );
  }

  Options _getOptionsForUrl(
    Options options,
    Uri? authOrigin,
    String requestUrl,
  ) {
    if (authOrigin == null) {
      return options;
    }
    final uri = Uri.tryParse(requestUrl);
    if (uri != null &&
        uri.scheme == authOrigin.scheme &&
        uri.host == authOrigin.host &&
        uri.port == authOrigin.port) {
      return options;
    }
    final headers = Map<String, dynamic>.from(options.headers ?? const {});
    headers.remove(HttpHeaders.authorizationHeader);
    headers.remove('Authorization');
    return options.copyWith(headers: headers);
  }

  Future<Response<T>> _getWithRedirect<T>(
    String url, {
    required Options options,
    bool isApiRequest = false,
    FutureOr<void> Function(Response<T> response)? validate,
  }) async {
    final clientOptions = isApiRequest ? _apiOptions : _resourceOptions;
    final uri = Uri.parse(url);
    final paths =
        _readRoutes?.call(uri).toSet() ??
        (isApiRequest
                ? FlClashHttpOverrides.handleCloudApiFindProxy(uri)
                : FlClashHttpOverrides.handleResourceFindProxy(uri))
            .split(';')
            .map((path) => path.trim())
            .toSet();
    return raceHttpReads<Response<T>>(
      paths.map(
        (path) => (token) async {
          final routed = Dio(clientOptions.copyWith());
          routed.httpClientAdapter = BoundedHttpClientAdapter(
            createFlClashHttpClientAdapter(
              findProxy: (target) =>
                  target.host.toLowerCase() == 'localhost' ||
                      (InternetAddress.tryParse(target.host)?.isLoopback ??
                          false)
                  ? 'DIRECT'
                  : path,
              allowBadCertificate: () =>
                  FlClashTemporaryTls.allowBadCertificate,
              userAgent: isApiRequest
                  ? null
                  : () => appController.isAttach ? appController.ua : null,
            ),
            maxBytes: _maxReadBytes,
          );
          try {
            final response = await _getWithRedirectOnRoute<T>(
              url,
              options: options,
              client: routed,
              cancelToken: token,
            );
            if (token.isCancelled) throw token.cancelError!;
            await validate?.call(response);
            if (token.isCancelled) throw token.cancelError!;
            return response;
          } finally {
            routed.close(force: true);
          }
        },
      ),
      timeout: _readTimeout,
    );
  }

  Future<Response<T>> _getWithRedirectOnRoute<T>(
    String url, {
    required Options options,
    required Dio client,
    required CancelToken cancelToken,
  }) async {
    final request = _resolveBasicAuth(url, options.headers);
    final opts = options.copyWith(
      followRedirects: false,
      headers: request.headers,
      validateStatus: (status) => status != null && status < 400,
    );

    var requestUrl = request.url;
    var response = await client.get<T>(
      requestUrl,
      options: opts,
      cancelToken: cancelToken,
    );
    int redirectCount = 0;
    while ([
          HttpStatus.movedTemporarily,
          HttpStatus.movedPermanently,
          HttpStatus.seeOther,
          HttpStatus.temporaryRedirect,
          HttpStatus.permanentRedirect,
        ].contains(response.statusCode) &&
        redirectCount < 5) {
      final location = response.headers.value(HttpHeaders.locationHeader);
      if (location == null || location.isEmpty) break;
      final redirectUrl = Uri.parse(requestUrl).resolve(location).toString();
      response = await client.get<T>(
        redirectUrl,
        cancelToken: cancelToken,
        options: _getOptionsForUrl(opts, request.authOrigin, redirectUrl),
      );
      requestUrl = redirectUrl;
      redirectCount++;
    }

    final status = response.statusCode;
    if (status == null || status < 200 || status >= 300) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
    return response;
  }

  Future<Response<Uint8List>> getFileResponseForUrl(
    String url, {
    FutureOr<void> Function(Uint8List bytes)? validate,
  }) async {
    final uri = Uri.tryParse(url);
    final isApiDomain = uri != null && _isApiDomain(uri.host);
    try {
      return await _getWithRedirect<Uint8List>(
        url,
        isApiRequest: isApiDomain,
        validate: (response) async {
          final bytes = response.data;
          if (bytes == null || bytes.isEmpty) {
            throw const FormatException('Subscription response is empty');
          }
          await validate?.call(bytes);
        },
        options: Options(
          headers: _flclashIdentityHeaders,
          responseType: ResponseType.bytes,
        ),
      );
    } catch (e) {
      commonPrint.log(
        isApiDomain
            ? 'oixCloud profile request failed: ${e is DioException ? e.type.name : e.runtimeType}'
            : 'Profile request failed: ${e is DioException ? '${e.type.name}, HTTP ${e.response?.statusCode ?? 0}' : e.runtimeType}',
      );
      if (e is ConfigValidationException) rethrow;
      if (e is DioException) {
        if (FlClashTemporaryTls.isCertificateVerifyFailed(e)) {
          rethrow;
        }
        if (e.response?.statusCode == HttpStatus.unauthorized) {
          throw 'Unauthorized';
        }
        if (isApiDomain) {
          throw appLocalizations.networkException;
        }
        if (e.type == DioExceptionType.unknown) {
          throw appLocalizations.unknownNetworkError;
        } else if (e.type == DioExceptionType.badResponse) {
          throw appLocalizations.networkException;
        }
        rethrow;
      }
      throw appLocalizations.unknownNetworkError;
    }
  }

  Future<Response<String>> getTextResponseForUrl(String url) async {
    return _getWithRedirect<String>(
      url,
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<AppUpdateInfo?> checkForUpdate() async {
    for (final domain in Secrets.apiDomains) {
      try {
        final response = await _getWithRedirect<String>(
          Uri.https(domain, '/api/v1/version/get', {
            't': DateTime.now().millisecondsSinceEpoch.toString(),
          }).toString(),
          isApiRequest: true,
          // Redirect pages may be HTML; decode only the final response as JSON.
          options: Options(responseType: ResponseType.plain),
          validate: (response) {
            final data = jsonDecode(response.data ?? '');
            if (data is! Map<String, dynamic> || data['ret'] != 200) {
              throw const FormatException('Invalid version response');
            }
            final value = data['data'];
            final version = value is Map<String, dynamic>
                ? value['version']
                : value;
            if (version is! String || version.trim().isEmpty) {
              throw const FormatException('Missing version');
            }
          },
        );
        if (response.statusCode != 200) continue;
        final data = jsonDecode(response.data ?? '');
        if (data is! Map<String, dynamic> || data['ret'] != 200) continue;

        final versionData = data['data'];
        final String? remoteVersion = versionData is Map<String, dynamic>
            ? versionData['version'] as String?
            : versionData as String?;

        if (remoteVersion == null) continue;

        final currentBuildNumber =
            int.tryParse(globalState.packageInfo.buildNumber) ?? 0;
        final remoteBuildNumber =
            int.tryParse(remoteVersion.split('+').last) ?? 0;

        final hasUpdate = remoteBuildNumber > currentBuildNumber;

        if (!hasUpdate) return null;

        final tagName =
            releaseTagNameFromVersionData(versionData) ??
            'v${globalState.packageInfo.version.trim()}';
        final releaseNotes =
            extractEmbeddedReleaseNotes(versionData, tagName) ??
            await _fetchReleaseNotes(tagName);
        return AppUpdateInfo(releaseNotes: releaseNotes);
      } catch (_) {
        commonPrint.log(
          'checkForUpdate failed for $domain',
          logLevel: LogLevel.warning,
        );
      }
    }
    throw Exception('checkForUpdate failed for all domains');
  }

  Future<String?> _fetchReleaseNotes(String tagName) async {
    final releaseFuture = _fetchLatestGitHubRelease();
    final changelogFuture = _fetchGitHubChangelog();
    final release = await releaseFuture;
    final changelog = await changelogFuture;
    final currentTagName =
        release?.tagName ??
        (changelog == null
            ? null
            : latestReleaseTagNameFromChangelog(changelog)) ??
        tagName;
    return extractReleaseNotesFromReleaseBody(release?.body, currentTagName) ??
        (changelog == null
            ? null
            : extractReleaseNotesFromChangelog(changelog, currentTagName));
  }

  // GitHub metadata and user subscriptions share the read-race policy.
  // Keep release lookups restricted to these fixed public endpoints.
  Future<Response<T>> _getPublicGitHub<T>(
    String url,
    ResponseType type, {
    required bool Function(T? data) validate,
  }) async {
    final uri = Uri.parse(url);
    if (uri.userInfo.isNotEmpty ||
        uri.hasQuery ||
        !const {
          'api.github.com',
          'raw.githubusercontent.com',
        }.contains(uri.host)) {
      throw ArgumentError('Expected a public GitHub release URL');
    }
    final routes = FlClashHttpOverrides.handleCloudApiFindProxy(
      uri,
    ).split(';').map((route) => route.trim()).toSet();
    final clients = <Dio>[];
    try {
      return await raceHttpReads<Response<T>>(
        routes.map(
          (route) => (token) async {
            final client = Dio(_apiOptions.copyWith());
            client.httpClientAdapter = BoundedHttpClientAdapter(
              createFlClashHttpClientAdapter(findProxy: (_) => route),
              maxBytes: _maxReadBytes,
            );
            clients.add(client);
            final response = await client.get<T>(
              url,
              cancelToken: token,
              options: Options(responseType: type),
            );
            if (!validate(response.data)) {
              throw const FormatException('Invalid public release data');
            }
            return response;
          },
        ),
        timeout: httpTimeoutDuration,
        isTerminalError: isTerminalPublicHttpReadError,
      );
    } finally {
      for (final client in clients) {
        client.close(force: true);
      }
    }
  }

  Future<({String? body, String tagName})?> _fetchLatestGitHubRelease() async {
    try {
      final response = await _getPublicGitHub<Map<String, dynamic>>(
        'https://api.github.com/repos/$releaseRepository/releases/latest',
        ResponseType.json,
        validate: (data) =>
            normalizeReleaseTagName(data?['tag_name'] as String?) != null,
      );
      final data = response.data;
      final tagName = normalizeReleaseTagName(data?['tag_name'] as String?);
      if (tagName == null) return null;
      return (body: data?['body'] as String?, tagName: tagName);
    } catch (error) {
      commonPrint.log(
        'fetch release notes failed: $error',
        logLevel: LogLevel.warning,
      );
      return null;
    }
  }

  Future<String?> _fetchGitHubChangelog() async {
    try {
      final response = await _getPublicGitHub<String>(
        'https://raw.githubusercontent.com/$releaseRepository/main/CHANGELOG.md',
        ResponseType.plain,
        validate: (data) =>
            data != null && latestReleaseTagNameFromChangelog(data) != null,
      );
      return response.data;
    } catch (error) {
      commonPrint.log(
        'fetch changelog failed: $error',
        logLevel: LogLevel.warning,
      );
      return null;
    }
  }

  final Map<String, IpInfo Function(Map<String, dynamic>)> _ipInfoSources = {
    'https://ipwho.is': IpInfo.fromIpWhoIsJson,
    'https://api.myip.com': IpInfo.fromMyIpJson,
    'https://ipapi.co/json': IpInfo.fromIpApiCoJson,
    'https://ident.me/json': IpInfo.fromIdentMeJson,
    'http://ip-api.com/json': IpInfo.fromIpAPIJson,
    'https://api.ip.sb/geoip': IpInfo.fromIpSbJson,
    'https://ipinfo.io/json': IpInfo.fromIpInfoIoJson,
  };

  Future<Result<IpInfo?>> checkIp({CancelToken? cancelToken}) async {
    final token = cancelToken ?? CancelToken();
    final result = Completer<Result<IpInfo?>>();
    var remaining = _ipInfoSources.length;
    final deadline = Timer(const Duration(seconds: 10), () {
      if (!result.isCompleted) result.complete(Result.success(null));
    });
    unawaited(
      token.whenCancel.then((_) {
        if (!result.isCompleted) result.complete(Result.error('cancelled'));
      }),
    );

    Future<void> checkSource(
      MapEntry<String, IpInfo Function(Map<String, dynamic>)> source,
    ) async {
      try {
        final response = await dio.get<Map<String, dynamic>>(
          source.key,
          cancelToken: token,
          options: Options(
            responseType: ResponseType.json,
            // A connection from the previous VPN route must not be reused.
            persistentConnection: false,
          ),
        );
        if (response.statusCode == HttpStatus.ok && response.data != null) {
          final info = source.value(response.data!);
          if (InternetAddress.tryParse(info.ip) != null &&
              RegExp(r'^[a-zA-Z]{2}$').hasMatch(info.countryCode) &&
              !result.isCompleted) {
            result.complete(Result.success(info));
          }
        }
      } catch (_) {
        // One failed or malformed source must not win the race.
      } finally {
        if (--remaining == 0 && !result.isCompleted) {
          result.complete(Result.success(null));
        }
      }
    }

    for (final source in _ipInfoSources.entries) {
      unawaited(checkSource(source));
    }
    try {
      return await result.future;
    } finally {
      deadline.cancel();
      token.cancel();
    }
  }
}

final request = Request();
