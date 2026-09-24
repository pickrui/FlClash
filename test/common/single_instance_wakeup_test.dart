import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/lock.dart';
import 'package:test/test.dart';

void main() {
  late Directory directory;
  late File endpoint;
  late ServerSocket server;
  late Completer<void> wakeup;
  late int shows;

  Future<void> show() async {
    shows++;
    if (!wakeup.isCompleted) wakeup.complete();
  }

  Future<ServerSocket> listen() => SingleInstanceWakeup.listen(
    endpoint: endpoint,
    onWakeup: show,
    requestTimeout: const Duration(milliseconds: 300),
  );

  Future<String> request() async {
    final data = jsonDecode(await endpoint.readAsString()) as Map;
    return 'FlClash.wakeup.v1 ${data['token']}\n';
  }

  Future<void> waitForClose(Socket socket) async {
    try {
      await socket.drain<void>().timeout(const Duration(seconds: 2));
    } on SocketException {
      // Windows can reset a connection rejected with unread probe data.
    } finally {
      socket.destroy();
    }
  }

  Future<void> send(List<int> bytes) async {
    final socket = await Socket.connect(
      InternetAddress.loopbackIPv4,
      server.port,
    );
    final closed = waitForClose(socket);
    socket.add(bytes);
    await socket.flush();
    await closed;
  }

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('flclash_wakeup_test_');
    endpoint = File('${directory.path}/FlClash.wakeup');
    wakeup = Completer<void>();
    shows = 0;
    server = await listen();
  });

  tearDown(() async {
    await server.close();
    await directory.delete(recursive: true);
  });

  test(
    'an idle TCP probe times out without showing the hidden window',
    () async {
      final socket = await Socket.connect(
        InternetAddress.loopbackIPv4,
        server.port,
      );
      await waitForClose(socket);

      expect(shows, 0);
    },
  );

  test('a connect-and-disconnect probe does not show the window', () async {
    final socket = await Socket.connect(
      InternetAddress.loopbackIPv4,
      server.port,
    );
    final closed = waitForClose(socket);
    await socket.close();
    await closed;

    expect(shows, 0);
  });

  test('an ordinary HTTP probe does not show the window', () async {
    await send(utf8.encode('GET / HTTP/1.1\r\nHost: localhost\r\n\r\n'));

    expect(shows, 0);
  });

  test(
    'a wrong token is rejected and a later legitimate launch works',
    () async {
      final valid = await request();
      const offset = 'FlClash.wakeup.v1 '.length;
      final wrong = valid.replaceRange(
        offset,
        offset + 1,
        valid[offset] == 'A' ? 'B' : 'A',
      );
      await send(utf8.encode(wrong));
      expect(shows, 0);

      await SingleInstanceWakeup.notify(endpoint);
      await wakeup.future.timeout(const Duration(seconds: 2));
      expect(shows, 1);
    },
  );

  test(
    'pending probes are bounded and release capacity on disconnect',
    () async {
      await server.close();
      server = await SingleInstanceWakeup.listen(
        endpoint: endpoint,
        onWakeup: show,
        requestTimeout: const Duration(seconds: 5),
      );
      final probes = <Socket>[];
      final closed = <Future<void>>[];
      try {
        for (var i = 0; i < 16; i++) {
          final socket = await Socket.connect(
            InternetAddress.loopbackIPv4,
            server.port,
          );
          probes.add(socket);
          closed.add(waitForClose(socket));
        }
        final overflow = await Socket.connect(
          InternetAddress.loopbackIPv4,
          server.port,
        );
        await waitForClose(overflow).timeout(const Duration(seconds: 1));
        expect(shows, 0);
      } finally {
        for (final socket in probes) {
          await socket.close();
        }
        await Future.wait(closed);
      }
      await SingleInstanceWakeup.notify(endpoint);
      await wakeup.future.timeout(const Duration(seconds: 2));
      expect(shows, 1);
    },
  );

  test('a legitimate second launch shows the window once', () async {
    await SingleInstanceWakeup.notify(endpoint);
    await wakeup.future.timeout(const Duration(seconds: 2));

    expect(shows, 1);
  });

  test('a complete request can arrive in multiple TCP packets', () async {
    final bytes = utf8.encode(await request());
    final socket = await Socket.connect(
      InternetAddress.loopbackIPv4,
      server.port,
    );
    final closed = waitForClose(socket);
    for (final part in [bytes.sublist(0, 10), bytes.sublist(10)]) {
      socket.add(part);
      await socket.flush();
      await pumpEventQueue();
    }
    await closed;
    await wakeup.future.timeout(const Duration(seconds: 2));

    expect(shows, 1);
  });

  test('an incomplete request expires without showing the window', () async {
    final valid = await request();
    await send(utf8.encode(valid.substring(0, valid.length - 1)));

    expect(shows, 0);
  });

  test('an oversized request does not show the window', () async {
    await send(List.filled(4096, 65));

    expect(shows, 0);
  });

  test(
    'a token from an earlier server cannot wake the current window',
    () async {
      final oldRequest = await request();
      await server.close();
      server = await listen();
      expect(await request(), isNot(oldRequest));

      await send(utf8.encode(oldRequest));
      expect(shows, 0);
      await SingleInstanceWakeup.notify(endpoint);
      await wakeup.future.timeout(const Duration(seconds: 2));
      expect(shows, 1);
    },
  );

  test(
    'legacy and invalid endpoints never contact an unrelated port',
    () async {
      final unrelated = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      var connections = 0;
      unrelated.listen((socket) {
        connections++;
        socket.destroy();
      });
      try {
        for (final data in [
          unrelated.port,
          {'version': 2, 'port': unrelated.port, 'token': 'A' * 43 + '='},
          {'version': 1, 'port': unrelated.port, 'token': 'invalid'},
          {'version': 1, 'port': 0, 'token': 'A' * 43 + '='},
        ]) {
          await endpoint.writeAsString(jsonEncode(data));
          await SingleInstanceWakeup.notify(endpoint);
        }
        await pumpEventQueue();
        expect(connections, 0);
        expect(shows, 0);
      } finally {
        await unrelated.close();
      }
    },
  );
}
