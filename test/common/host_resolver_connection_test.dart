import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/host_resolver.dart';
import 'package:fl_clash/common/http.dart';
import 'package:flutter_test/flutter_test.dart';

/// A resolver that serves the query and answers with no address, which is what
/// a tunnel's DNS does while the core is down.
Future<List<InternetAddress>> _deadResolver(
  String host, {
  InternetAddressType type = InternetAddressType.any,
}) async => throw SocketException(
  "Failed host lookup: '$host'",
  osError: const OSError('No address associated with hostname', 7),
);

void main() {
  late HttpServer server;
  late Uri origin;
  var requests = <String?>[];

  setUp(() async {
    requests = [];
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    origin = Uri.parse('http://api.test:${server.port}/check');
    server.listen((request) async {
      requests.add(request.headers.value(HttpHeaders.hostHeader));
      request.response.write('ok');
      await request.response.close();
    });
  });

  tearDown(() => server.close(force: true));

  Dio dioWith(HostResolver resolver) => Dio()
    ..httpClientAdapter = createFlClashHttpClientAdapter(
      findProxy: (_) => 'DIRECT',
      resolver: resolver,
    );

  test('a remembered address carries the request when DNS is dead', () async {
    final resolver = HostResolver(lookup: _deadResolver);
    resolver.confirm('api.test', InternetAddress.loopbackIPv4);

    final response = await dioWith(resolver).getUri<String>(origin);

    expect(response.statusCode, 200);
    expect(response.data, 'ok');
    // The request still names the domain, so the server sees the real host.
    expect(requests, ['api.test:${server.port}']);
  });

  test('a working lookup is remembered for the next outage', () async {
    var answers = 1;
    final resolver = HostResolver(
      lookup: (host, {type = InternetAddressType.any}) async => answers-- > 0
          ? [InternetAddress.loopbackIPv4]
          : throw const SocketException(
              'Failed host lookup',
              osError: OSError('No address associated with hostname', 7),
            ),
    );
    final dio = dioWith(resolver);

    expect((await dio.getUri<String>(origin)).data, 'ok');
    // The resolver has gone silent by now; the confirmed address remains.
    expect((await dio.getUri<String>(origin)).data, 'ok');
    expect(requests, hasLength(2));
  });

  test(
    'an outage with nothing remembered still reports the DNS error',
    () async {
      final dio = dioWith(HostResolver(lookup: _deadResolver));
      await expectLater(
        dio.getUri<String>(origin),
        throwsA(
          isA<DioException>().having(
            (error) => (error.error as SocketException?)?.osError?.errorCode,
            'errorCode',
            7,
          ),
        ),
      );
      expect(requests, isEmpty);
    },
  );

  test('a proxied request is left to Dart and never resolved here', () async {
    final resolver = HostResolver(lookup: _deadResolver);
    final task = await connectWithResolver(
      Uri.parse('http://api.test/check'),
      InternetAddress.loopbackIPv4.address,
      server.port,
      resolver: resolver,
    );
    final socket = await task.socket;
    addTearDown(() => socket.destroy());
    expect(socket.remotePort, server.port);
  });
}
