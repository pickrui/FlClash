import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<RequestOptions> requests;
  late int closed;

  setUp(() {
    requests = [];
    closed = 0;
  });

  Request client(ResponseBody Function(RequestOptions) reply) {
    final request = Request(
      readRoutes: (_) => ['DIRECT'],
      publicGitHubAdapter: () => _Adapter((options) {
        requests.add(options);
        expect(options.headers.containsKey('Authorization'), isFalse);
        expect(options.uri.hasQuery, isFalse);
        return reply(options);
      }, () => closed++),
    );
    addTearDown(() => request.dio.close(force: true));
    return request;
  }

  ResponseBody release(String tag, String body) => ResponseBody.fromString(
    jsonEncode({'tag_name': tag, 'body': body}),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  ResponseBody changelog(String body) => ResponseBody.fromString(body, 200);
  ResponseBody unavailable() => ResponseBody.fromString('unavailable', 503);

  test('release notes use the offered tag for both public sources', () async {
    final request = client(
      (options) => options.uri.host == 'api.github.com'
          ? release('v0.8.98', '- Offered release')
          : changelog('## v0.8.98\n- Changelog fallback'),
    );
    expect(await request.fetchReleaseNotes('v0.8.98'), '- Offered release');
    expect(
      requests.map((r) => r.uri.path),
      unorderedEquals([
        '/repos/pickrui/FlClash/releases/tags/v0.8.98',
        '/pickrui/FlClash/v0.8.98/CHANGELOG.md',
      ]),
    );
    expect(closed, 2);
  });

  test(
    'failed release lookup falls back to the same version changelog',
    () async {
      final request = client(
        (options) => options.uri.host == 'api.github.com'
            ? unavailable()
            : changelog(
                '## v0.8.99\n- Future change\n## v0.8.98\n- Offered change',
              ),
      );
      expect(await request.fetchReleaseNotes('0.8.98'), '- Offered change');
      expect(closed, 2);
    },
  );

  test(
    'mismatched release metadata cannot substitute another version',
    () async {
      final request = client(
        (options) => options.uri.host == 'api.github.com'
            ? release('v0.8.99', '- Wrong release')
            : changelog('## v0.8.98\n- Correct release'),
      );
      expect(await request.fetchReleaseNotes('v0.8.98'), '- Correct release');
    },
  );

  test(
    'unavailable requested notes never become the latest release notes',
    () async {
      final request = client(
        (options) => options.uri.host == 'api.github.com'
            ? release('v0.8.99', '- Wrong release')
            : changelog('## v0.8.99\n- Future release'),
      );
      expect(await request.fetchReleaseNotes('v0.8.98'), isNull);
    },
  );

  test('an earlier network failure does not cache an empty result', () async {
    var offline = true;
    final request = client((options) {
      if (offline) return unavailable();
      return options.uri.host == 'api.github.com'
          ? release('v0.8.98', '- Recovered notes')
          : changelog('## v0.8.98\n- Recovered notes');
    });
    expect(await request.fetchReleaseNotes('v0.8.98'), isNull);
    offline = false;
    expect(await request.fetchReleaseNotes('v0.8.98'), '- Recovered notes');
    expect(requests, hasLength(4));
    expect(closed, 4);
  });

  test('legacy build-only updates can resolve the latest release', () async {
    final request = client(
      (options) => options.uri.host == 'api.github.com'
          ? release('v0.8.98', '- Latest release')
          : changelog('## v0.8.99\n- Unreleased change'),
    );
    expect(await request.fetchReleaseNotes(null), '- Latest release');
    expect(
      requests.map((r) => r.uri.path),
      unorderedEquals([
        '/repos/pickrui/FlClash/releases/latest',
        '/pickrui/FlClash/main/CHANGELOG.md',
      ]),
    );
  });

  test('invalid tags cannot change the fixed public endpoint paths', () async {
    final request = client((_) => throw StateError('unexpected request'));
    expect(await request.fetchReleaseNotes('../main?token=secret'), isNull);
    expect(requests, isEmpty);
  });
}

class _Adapter implements HttpClientAdapter {
  _Adapter(this.reply, this.onClose);
  final ResponseBody Function(RequestOptions) reply;
  final void Function() onClose;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => reply(options);

  @override
  void close({bool force = false}) => onClose();
}
