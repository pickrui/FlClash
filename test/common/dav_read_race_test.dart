import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/dav_client.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  late PathProviderPlatform originalPaths;
  final archive = ZipEncoder().encode(
    Archive()..addFile(ArchiveFile.string('config.json', '{"version":2}')),
  );

  setUpAll(() {
    directory = Directory.systemTemp.createTempSync('dav-race-');
    originalPaths = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _Paths(directory.path);
  });
  tearDown(() async {
    for (final file in directory.listSync()) {
      await file.delete(recursive: true);
    }
  });
  tearDownAll(() {
    PathProviderPlatform.instance = originalPaths;
    directory.deleteSync(recursive: true);
  });

  test(
    'authenticated reads race and only a validated ZIP is retained',
    () async {
      final requests = <(String, String)>[];
      final clients = <_Adapter>[];
      final dav = DAVClient(
        _props,
        resolveRoutes: (_) => ['direct', 'proxy'],
        createAdapter: (route) {
          final adapter = _Adapter((options) async {
            requests.add((route, options.method));
            if (options.headers['authorization'] == null) return _challenge();
            expect(options.headers['authorization'], startsWith('Basic '));
            return options.method == 'GET'
                ? ResponseBody.fromBytes(
                    route == 'direct' ? 'blocked'.codeUnits : archive,
                    200,
                  )
                : ResponseBody.fromBytes([], 200);
          });
          clients.add(adapter);
          return adapter;
        },
      );
      expect(await dav.pingCompleter.future, true);
      final path = await dav.restore();
      expect(await File(path).readAsBytes(), archive);
      expect(directory.listSync().map((file) => file.path), [path]);
      expect(
        requests
            .where((entry) => entry.$2 == 'GET')
            .map((entry) => entry.$1)
            .toSet(),
        {'direct', 'proxy'},
      );
      expect(requests.map((entry) => entry.$2), isNot(contains('MKCOL')));
      expect(clients.every((client) => client.closed), true);
    },
  );

  test(
    'a late loser cannot delete the winner or leave a partial archive',
    () async {
      final delayed = Completer<ResponseBody>();
      final bothReading = Completer<void>();
      var reads = 0;
      final dav = DAVClient(
        _props,
        resolveRoutes: (_) => ['direct', 'proxy'],
        createAdapter: (route) => _Adapter((options) async {
          if (options.method != 'GET') return ResponseBody.fromBytes([], 200);
          if (++reads == 2) bothReading.complete();
          if (route == 'proxy') return delayed.future;
          await bothReading.future;
          return ResponseBody.fromBytes(archive, 200);
        }),
      );
      expect(await dav.pingCompleter.future, true);
      final winner = await dav.restore();
      delayed.complete(ResponseBody.fromBytes(archive, 200));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(await File(winner).readAsBytes(), archive);
      expect(directory.listSync().map((file) => file.path), [winner]);
    },
  );

  test('a damaged ZIP payload cannot win with an intact directory', () async {
    final damaged = ZipEncoder().encode(
      Archive()..add(ArchiveFile.noCompress('file.txt', 4, [1, 2, 3, 4])),
    );
    final header = ByteData.sublistView(Uint8List.fromList(damaged));
    final payloadOffset =
        30 +
        header.getUint16(26, Endian.little) +
        header.getUint16(28, Endian.little);
    damaged[payloadOffset] ^= 0xff;
    final dav = DAVClient(
      _props,
      resolveRoutes: (_) => ['direct', 'proxy'],
      createAdapter: (route) => _Adapter((options) async {
        if (options.method != 'GET') return ResponseBody.fromBytes([], 200);
        if (route == 'proxy') {
          await Future<void>.delayed(const Duration(milliseconds: 50));
        }
        return ResponseBody.fromBytes(
          route == 'direct' ? damaged : archive,
          200,
        );
      }),
    );
    expect(await dav.pingCompleter.future, true);
    final winner = await dav.restore();
    expect(await File(winner).readAsBytes(), archive);
    expect(directory.listSync().map((file) => file.path), [winner]);
  });

  test(
    'cross-origin WebDAV redirects never send account credentials',
    () async {
      final hosts = <String>[];
      final dav = DAVClient(
        _props,
        resolveRoutes: (_) => ['direct'],
        createAdapter: (_) => _Adapter((options) async {
          hosts.add(options.uri.host);
          if (options.headers['authorization'] == null) return _challenge();
          if (options.method == 'GET') {
            return ResponseBody.fromBytes(
              [],
              302,
              headers: {
                'location': ['https://other.invalid/backup.zip'],
              },
            );
          }
          return ResponseBody.fromBytes([], 200);
        }),
      );
      expect(await dav.pingCompleter.future, true);
      await expectLater(dav.restore(), throwsA(isA<DioException>()));
      expect(hosts.toSet(), {'dav.invalid'});
      expect(directory.listSync(), isEmpty);
    },
  );

  test(
    'a rejected authentication challenge remains an authoritative error',
    () async {
      final dav = DAVClient(
        _props,
        resolveRoutes: (_) => ['direct', 'proxy'],
        createAdapter: (_) => _Adapter((_) async => _challenge()),
      );
      expect(await dav.pingCompleter.future, false);
      await expectLater(
        dav.restore(),
        throwsA(
          isA<DioException>().having(
            (error) => error.response?.statusCode,
            'status',
            401,
          ),
        ),
      );
      expect(directory.listSync(), isEmpty);
    },
  );

  test(
    'a stalled backup download times out and cancels both streams',
    () async {
      var cancelled = 0;
      final dav = DAVClient(
        _props,
        readTimeout: const Duration(milliseconds: 30),
        resolveRoutes: (_) => ['direct', 'proxy'],
        createAdapter: (_) => _Adapter((options) async {
          if (options.method != 'GET') return ResponseBody.fromBytes([], 200);
          return ResponseBody(
            StreamController<Uint8List>(onCancel: () => cancelled++).stream,
            200,
          );
        }),
      );
      expect(await dav.pingCompleter.future, true);
      await expectLater(dav.restore(), throwsA(isA<TimeoutException>()));
      await Future<void>.delayed(Duration.zero);
      expect(cancelled, 2);
      expect(directory.listSync(), isEmpty);
    },
  );

  test('backup writes execute once and do not enter the read race', () async {
    final dav = DAVClient(
      _props,
      resolveRoutes: (_) => ['direct', 'proxy'],
      createAdapter: (_) => _Adapter((options) async {
        expect(options.method, 'OPTIONS');
        return ResponseBody.fromBytes([], 200);
      }),
    );
    expect(await dav.pingCompleter.future, true);
    final writes = <String>[];
    dav.client.c.httpClientAdapter = _Adapter((options) async {
      writes.add(options.method);
      return ResponseBody.fromBytes(
        [],
        options.method == 'OPTIONS' ? 200 : 201,
      );
    });
    final file = File('${directory.path}/upload.zip');
    await file.writeAsBytes(archive);
    expect(await dav.backup(file.path), true);
    expect(writes.where((method) => method == 'PUT'), hasLength(1));
    expect(writes.where((method) => method == 'MOVE'), hasLength(1));
  });

  test('a redirect after PUT cannot replay the write', () async {
    final dav = DAVClient(
      _props,
      resolveRoutes: (_) => ['direct'],
      createAdapter: (_) =>
          _Adapter((_) async => ResponseBody.fromBytes([], 200)),
    );
    await dav.pingCompleter.future;
    var uploads = 0;
    dav.client.c.httpClientAdapter = _Adapter((options) async {
      if (options.method == 'PUT') {
        uploads++;
        return ResponseBody.fromBytes(
          [],
          302,
          headers: {
            'location': ['/other-upload.zip'],
          },
        );
      }
      return ResponseBody.fromBytes(
        [],
        options.method == 'OPTIONS' ? 200 : 201,
      );
    });
    final file = File('${directory.path}/upload.zip');
    await file.writeAsBytes(archive);
    await expectLater(dav.backup(file.path), throwsA(isA<DioException>()));
    expect(uploads, 1);
  });
}

const _props = DAVProps(
  uri: 'https://dav.invalid/dav',
  user: 'alice',
  password: 'local-test',
);

ResponseBody _challenge() => ResponseBody.fromString(
  'authenticate',
  401,
  headers: {
    'www-authenticate': ['Basic realm="test"'],
  },
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
  ) async {
    await requestStream?.drain<void>();
    return respond(options);
  }

  @override
  void close({bool force = false}) => closed = true;
}

class _Paths extends PathProviderPlatform {
  _Paths(this.path);
  final String path;
  @override
  Future<String?> getApplicationSupportPath() async => path;
  @override
  Future<String?> getApplicationCachePath() async => path;
  @override
  Future<String?> getTemporaryPath() async => path;
  @override
  Future<String?> getDownloadsPath() async => path;
}
