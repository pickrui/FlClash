import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'bounded_http_client_adapter.dart';
import 'http.dart';
import 'http_read_race.dart';

const maxIconDownloadBytes = 8 * 1024 * 1024;

bool isSvgIconUrl(String url) =>
    Uri.tryParse(url)?.path.toLowerCase().endsWith('.svg') ?? false;

/// Keeps cache validation headers while selecting a complete, usable image.
class IconFileService extends FileService {
  IconFileService({
    Iterable<String> Function(Uri)? resolveRoutes,
    HttpClientAdapter Function(String)? createAdapter,
    this.timeout = const Duration(seconds: 30),
    this.maxBytes = maxIconDownloadBytes,
  }) : _resolveRoutes = resolveRoutes ?? _defaultRoutes,
       _createAdapter = createAdapter ?? _defaultAdapter;

  final Iterable<String> Function(Uri) _resolveRoutes;
  final HttpClientAdapter Function(String) _createAdapter;
  final Duration timeout;
  final int maxBytes;

  static Iterable<String> _defaultRoutes(Uri uri) =>
      FlClashHttpOverrides.handleResourceFindProxy(
        uri,
      ).split(';').map((route) => route.trim()).toSet();

  static HttpClientAdapter _defaultAdapter(String route) =>
      createFlClashHttpClientAdapter(
        findProxy: (uri) =>
            uri.host == 'localhost' ||
                (InternetAddress.tryParse(uri.host)?.isLoopback ?? false)
            ? 'DIRECT'
            : route,
        allowBadCertificate: () => FlClashTemporaryTls.allowBadCertificate,
      );

  @override
  Future<FileServiceResponse> get(String url, {Map<String, String>? headers}) {
    final uri = Uri.parse(url);
    final isPublic =
        uri.userInfo.isEmpty &&
        !uri.hasQuery &&
        (headers?.keys.every(
              (key) => const {
                'if-none-match',
                'if-modified-since',
                'accept',
                'user-agent',
              }.contains(key.toLowerCase()),
            ) ??
            true);
    return raceHttpReads<FileServiceResponse>(
      _resolveRoutes(uri).toSet().map(
        (route) =>
            (token) => _read(uri, headers, route, token),
      ),
      timeout: timeout,
      isTerminalError: isPublic ? isTerminalPublicHttpReadError : null,
    );
  }

  Future<FileServiceResponse> _read(
    Uri uri,
    Map<String, String>? headers,
    String route,
    CancelToken token,
  ) async {
    final client =
        Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
            ),
          )
          ..httpClientAdapter = BoundedHttpClientAdapter(
            _createAdapter(route),
            maxBytes: maxBytes,
          );
    try {
      final origin = uri.replace(userInfo: '');
      final requestHeaders = Map<String, String>.from(headers ?? const {});
      if (uri.userInfo.isNotEmpty &&
          !requestHeaders.keys.any(
            (key) => key.toLowerCase() == HttpHeaders.authorizationHeader,
          )) {
        requestHeaders[HttpHeaders.authorizationHeader] =
            'Basic ${base64Encode(utf8.encode(Uri.decodeComponent(uri.userInfo)))}';
      }
      var target = origin;
      for (var redirects = 0; ; redirects++) {
        final response = await client.getUri<Uint8List>(
          target,
          cancelToken: token,
          options: Options(
            headers: requestHeaders,
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) => status != null && status < 400,
          ),
        );
        final status = response.statusCode!;
        if (const {301, 302, 303, 307, 308}.contains(status)) {
          final location = response.headers.value(HttpHeaders.locationHeader);
          if (redirects >= 5 || location == null || location.isEmpty) {
            throw const FormatException('Invalid image redirect');
          }
          final next = target.resolve(location);
          if (!const {'http', 'https'}.contains(next.scheme) ||
              next.userInfo.isNotEmpty) {
            throw const FormatException('Invalid image redirect');
          }
          if (next.scheme != origin.scheme ||
              next.host != origin.host ||
              next.port != origin.port) {
            requestHeaders.removeWhere(
              (key, _) => const {
                HttpHeaders.authorizationHeader,
                HttpHeaders.proxyAuthorizationHeader,
                HttpHeaders.cookieHeader,
              }.contains(key.toLowerCase()),
            );
          }
          target = next;
          continue;
        }
        final bytes = response.data ?? Uint8List(0);
        final conditional = requestHeaders.keys.any(
          (key) => const {
            HttpHeaders.ifNoneMatchHeader,
            HttpHeaders.ifModifiedSinceHeader,
          }.contains(key.toLowerCase()),
        );
        if (status == HttpStatus.notModified && conditional) {
          // CacheManager keeps the existing file and refreshes its metadata.
        } else if (status == HttpStatus.ok) {
          await validateIconBytes(bytes, svg: isSvgIconUrl(uri.toString()));
        } else {
          throw const FormatException('Invalid image response');
        }
        final error = token.cancelError;
        if (error != null) throw error;
        return HttpGetResponse(
          http.StreamedResponse(
            Stream.value(bytes),
            status,
            contentLength: bytes.length,
            headers: response.headers.map.map(
              (key, values) => MapEntry(key.toLowerCase(), values.join(',')),
            ),
          ),
        );
      }
    } finally {
      client.close(force: true);
    }
  }
}

Future<void> validateIconBytes(Uint8List bytes, {required bool svg}) async {
  if (bytes.isEmpty) throw const FormatException('Empty image');
  if (svg) {
    final source = utf8.decode(bytes);
    if (!RegExp(r'<svg(?:\s|>)', caseSensitive: false).hasMatch(source)) {
      throw const FormatException('Invalid SVG image');
    }
    final picture = await vg.loadPicture(SvgStringLoader(source), null);
    picture.picture.dispose();
    return;
  }
  final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
  ui.ImageDescriptor? descriptor;
  ui.Codec? codec;
  try {
    descriptor = await ui.ImageDescriptor.encoded(buffer);
    if (descriptor.width <= 0 ||
        descriptor.height <= 0 ||
        descriptor.width * descriptor.height > 32 * 1024 * 1024) {
      throw const FormatException('Image dimensions exceed limit');
    }
    codec = await descriptor.instantiateCodec(
      targetWidth: descriptor.width > 256 ? 256 : null,
    );
    final frame = await codec.getNextFrame();
    frame.image.dispose();
  } finally {
    codec?.dispose();
    descriptor?.dispose();
    buffer.dispose();
  }
}
