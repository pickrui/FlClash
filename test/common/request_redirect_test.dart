import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Request request;

  setUp(() => request = Request());
  tearDown(() => request.dio.close(force: true));

  test('HTML redirects are followed before decoding version JSON', () async {
    final server = await _server((incoming) async {
      if (incoming.uri.path == '/version') {
        incoming.response.statusCode = HttpStatus.found;
        incoming.response.headers.set(HttpHeaders.locationHeader, './final');
        incoming.response.headers.contentType = ContentType.html;
        incoming.response.write('<a href="./final">redirect</a>');
      } else {
        incoming.response.headers.contentType = ContentType.json;
        incoming.response.write('{"ret":200,"data":"0.8.96+2026090801"}');
      }
      await incoming.response.close();
    });
    final response = await request.getTextResponseForUrl(
      'http://127.0.0.1:${server.port}/version',
    );
    expect(response.statusCode, HttpStatus.ok);
    expect(jsonDecode(response.data!)['ret'], 200);
  });

  for (final loop in [false, true]) {
    test(
      loop
          ? 'redirect loops stop after five hops and cannot become profile data'
          : 'redirects without Location cannot become profile data',
      () async {
        var calls = 0;
        final server = await _server((incoming) async {
          calls++;
          incoming.response.statusCode = HttpStatus.found;
          if (loop) {
            incoming.response.headers.set(HttpHeaders.locationHeader, '/loop');
          }
          incoming.response.write('redirect page, not a subscription');
          await incoming.response.close();
        });
        await expectLater(
          request.getTextResponseForUrl('http://127.0.0.1:${server.port}/loop'),
          throwsA(
            isA<DioException>()
                .having(
                  (error) => error.type,
                  'type',
                  DioExceptionType.badResponse,
                )
                .having((error) => error.response?.statusCode, 'status', 302),
          ),
        );
        expect(calls, loop ? 6 : 1);
      },
    );
  }

  test('Basic authorization stays on the original redirect origin', () async {
    final authorizations = <String?>[];
    final destination = await _server((incoming) async {
      authorizations.add(
        incoming.headers.value(HttpHeaders.authorizationHeader),
      );
      incoming.response.write('subscription');
      await incoming.response.close();
    });
    final origin = await _server((incoming) async {
      authorizations.add(
        incoming.headers.value(HttpHeaders.authorizationHeader),
      );
      incoming.response.statusCode = HttpStatus.found;
      incoming.response.headers.set(
        HttpHeaders.locationHeader,
        incoming.uri.path == '/first'
            ? '/second'
            : 'http://127.0.0.1:${destination.port}/final',
      );
      await incoming.response.close();
    });
    final response = await request.getTextResponseForUrl(
      'http://alice:local-test@127.0.0.1:${origin.port}/first',
    );
    expect(response.data, 'subscription');
    final basic = 'Basic ${base64Encode(utf8.encode('alice:local-test'))}';
    expect(authorizations, [basic, basic, null]);
  });
}

Future<HttpServer> _server(void Function(HttpRequest) onRequest) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  addTearDown(() => server.close(force: true));
  server.listen(onRequest);
  return server;
}
