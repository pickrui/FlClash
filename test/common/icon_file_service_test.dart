import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/icon_file_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('an HTML response cannot beat a complete valid image', () async {
    final available = Completer<void>();
    final started = <String>[];
    final adapters = <_Adapter>[];
    final service = IconFileService(
      resolveRoutes: (_) => ['direct', 'proxy'],
      createAdapter: (route) {
        final adapter = _Adapter((_) async {
          started.add(route);
          if (started.length == 2) available.complete();
          if (route == 'direct') {
            return ResponseBody.fromString('<html>blocked</html>', 200);
          }
          await available.future;
          return ResponseBody.fromBytes(
            _png,
            200,
            headers: {
              'content-type': ['image/png'],
            },
          );
        });
        adapters.add(adapter);
        return adapter;
      },
    );
    final response = await service.get('https://icons.invalid/node.png');
    expect(started, ['direct', 'proxy']);
    expect(await response.content.expand((chunk) => chunk).toList(), _png);
    expect(adapters.every((adapter) => adapter.closed), true);
  });

  for (final scenario in [
    (
      url: 'https://icons.invalid/icon.png',
      headers: <String, String>{},
      denied: false,
    ),
    (
      url: 'https://user:secret@icons.invalid/icon.png',
      headers: <String, String>{},
      denied: true,
    ),
    (
      url: 'https://icons.invalid/icon.png?token=secret',
      headers: <String, String>{},
      denied: true,
    ),
    (
      url: 'https://icons.invalid/icon.png',
      headers: {'Authorization': 'Bearer fixture'},
      denied: true,
    ),
  ]) {
    test(
      'public CDN 403 policy preserves credentials for ${scenario.url}',
      () async {
        final release = Completer<void>();
        final service = IconFileService(
          resolveRoutes: (_) => ['direct', 'proxy'],
          createAdapter: (route) => _Adapter((_) async {
            if (route == 'direct') return ResponseBody.fromBytes([], 403);
            await release.future;
            return ResponseBody.fromBytes(_png, 200);
          }),
        );
        final pending = service.get(scenario.url, headers: scenario.headers);
        final assertion = expectLater(
          pending,
          scenario.denied
              ? throwsA(
                  isA<DioException>().having(
                    (e) => e.response?.statusCode,
                    'status',
                    403,
                  ),
                )
              : completes,
        );
        await pumpEventQueue();
        release.complete();
        await assertion;
        if (!scenario.denied) {
          expect(
            await (await pending).content.expand((chunk) => chunk).toList(),
            _png,
          );
        }
      },
    );
  }

  test(
    'conditional 304 keeps ETag and cache lifetime without replacing bytes',
    () async {
      final service = IconFileService(
        resolveRoutes: (_) => ['direct'],
        createAdapter: (_) => _Adapter((options) async {
          expect(options.headers['If-None-Match'], 'v1');
          return ResponseBody.fromBytes(
            [],
            304,
            headers: {
              'etag': ['v1'],
              'cache-control': ['max-age=600'],
            },
          );
        }),
      );
      final now = DateTime.now();
      final response = await service.get(
        'https://icons.invalid/node.png',
        headers: {'If-None-Match': 'v1'},
      );
      expect(response.statusCode, 304);
      expect(response.eTag, 'v1');
      expect(
        response.validTill.difference(now).inSeconds,
        inInclusiveRange(599, 601),
      );
      expect(await response.content.expand((chunk) => chunk).toList(), isEmpty);
    },
  );

  test('an unsolicited 304 cannot win over an image', () async {
    final response = await IconFileService(
      resolveRoutes: (_) => ['direct', 'proxy'],
      createAdapter: (route) => _Adapter(
        (_) async => route == 'direct'
            ? ResponseBody.fromBytes([], 304)
            : ResponseBody.fromBytes(_png, 200),
      ),
    ).get('https://icons.invalid/node.png');
    expect(response.statusCode, 200);
    expect(await response.content.expand((chunk) => chunk).toList(), _png);
  });

  test(
    'oversized candidates fail locally while the other image can win',
    () async {
      final response = await IconFileService(
        maxBytes: _png.length,
        resolveRoutes: (_) => ['direct', 'proxy'],
        createAdapter: (route) => _Adapter(
          (_) async => ResponseBody.fromBytes(
            route == 'direct' ? Uint8List(_png.length + 1) : _png,
            200,
          ),
        ),
      ).get('https://icons.invalid/node.png');
      expect(await response.content.expand((chunk) => chunk).toList(), _png);
    },
  );

  test('cross-origin redirects remove authorization and cookies', () async {
    final requests = <RequestOptions>[];
    final response =
        await IconFileService(
          resolveRoutes: (_) => ['direct'],
          createAdapter: (_) => _Adapter((options) async {
            requests.add(options);
            if (options.uri.host == 'icons.invalid') {
              return ResponseBody.fromString(
                'redirect',
                302,
                headers: {
                  'location': ['https://cdn.invalid/icon.png'],
                },
              );
            }
            return ResponseBody.fromBytes(_png, 200);
          }),
        ).get(
          'https://alice:local-test@icons.invalid/icon.png',
          headers: {'Cookie': 'session=test'},
        );
    expect(response.statusCode, 200);
    expect(requests.first.uri.userInfo, isEmpty);
    expect(requests.first.headers['authorization'], startsWith('Basic '));
    expect(requests.first.headers['Cookie'], 'session=test');
    expect(
      requests.last.headers.keys.map((key) => key.toLowerCase()),
      isNot(contains('authorization')),
    );
    expect(
      requests.last.headers.keys.map((key) => key.toLowerCase()),
      isNot(contains('cookie')),
    );
  });

  test('deadline cancels a hanging image and closes its client', () async {
    var cancelled = false;
    final stream = StreamController<Uint8List>(
      onCancel: () => cancelled = true,
    );
    late _Adapter adapter;
    final service = IconFileService(
      timeout: const Duration(milliseconds: 20),
      resolveRoutes: (_) => ['direct'],
      createAdapter: (_) =>
          adapter = _Adapter((_) async => ResponseBody(stream.stream, 200)),
    );
    await expectLater(
      service.get('https://icons.invalid/node.png'),
      throwsA(isA<TimeoutException>()),
    );
    await Future<void>.delayed(Duration.zero);
    expect(cancelled, true);
    expect(adapter.closed, true);
  });

  test('signed SVG URLs keep SVG validation and rendering', () async {
    const url = 'https://icons.invalid/node.SVG?token=local-test';
    expect(isSvgIconUrl(url), true);
    final svg = utf8.encode(
      '<svg xmlns="http://www.w3.org/2000/svg" width="10" height="10"><rect width="10" height="10"/></svg>',
    );
    final response = await IconFileService(
      resolveRoutes: (_) => ['direct'],
      createAdapter: (_) =>
          _Adapter((_) async => ResponseBody.fromBytes(svg, 200)),
    ).get(url);
    expect(await response.content.expand((chunk) => chunk).toList(), svg);
  });

  test('SVG candidates must contain a parseable SVG', () async {
    await expectLater(
      validateIconBytes(
        Uint8List.fromList(utf8.encode('<html>blocked</html>')),
        svg: true,
      ),
      throwsFormatException,
    );
    await validateIconBytes(
      Uint8List.fromList(
        utf8.encode(
          '<svg xmlns="http://www.w3.org/2000/svg" width="10" height="10"><rect width="10" height="10"/></svg>',
        ),
      ),
      svg: true,
    );
  });
}

final _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR4nGP4z8DwHwAFAAH/iZk9HQAAAABJRU5ErkJggg==',
);

class _Adapter implements HttpClientAdapter {
  _Adapter(this.respond);
  final Future<ResponseBody> Function(RequestOptions) respond;
  var closed = false;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => respond(options);
  @override
  void close({bool force = false}) => closed = true;
}
