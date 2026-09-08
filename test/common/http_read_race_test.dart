import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/http_read_race.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('both routes start before either response completes', () async {
    final reads = [Completer<String>(), Completer<String>()];
    final tokens = <CancelToken>[];
    final pending = raceHttpReads<String>([
      for (final read in reads)
        (token) {
          tokens.add(token);
          return read.future;
        },
    ], timeout: const Duration(seconds: 1));
    expect(tokens, hasLength(2));
    reads.last.complete('proxy');
    expect(await pending, 'proxy');
    expect(tokens.every((token) => token.isCancelled), isTrue);
    // A response that ignores cancellation cannot replace the winner.
    reads.first.complete('late direct');
    await pumpEventQueue();
  });

  test('invalid or failed candidates leave the other route running', () async {
    final valid = Completer<String>();
    final invalid = Completer<String>();
    final pending = raceHttpReads<String>([
      (_) => invalid.future,
      (_) => valid.future,
    ], timeout: const Duration(seconds: 1));
    var completed = false;
    unawaited(pending.then((_) => completed = true));
    invalid.completeError(const FormatException('invalid data'));
    await pumpEventQueue();
    expect(completed, isFalse);
    valid.complete('validated data');
    expect(await pending, 'validated data');
  });

  test(
    'external cancellation stops both routes without waiting for timeout',
    () async {
      final parent = CancelToken();
      final tokens = <CancelToken>[];
      final pending = raceHttpReads<String>(
        [
          for (var i = 0; i < 2; i++)
            (token) {
              tokens.add(token);
              return Completer<String>().future;
            },
        ],
        timeout: const Duration(minutes: 1),
        cancelToken: parent,
      );
      final failure = expectLater(pending, throwsA(isA<DioException>()));
      parent.cancel('user cancelled');
      await failure;
      expect(tokens.every((token) => token.isCancelled), isTrue);
    },
  );

  test('already cancelled and expired reads send no requests', () async {
    var calls = 0;
    Future<String> read(CancelToken _) async {
      calls++;
      return 'unexpected';
    }

    await expectLater(
      raceHttpReads(
        [read],
        timeout: const Duration(seconds: 1),
        cancelToken: CancelToken()..cancel(),
      ),
      throwsA(isA<DioException>()),
    );
    await expectLater(
      raceHttpReads([read], timeout: Duration.zero),
      throwsA(isA<TimeoutException>()),
    );
    expect(calls, 0);
  });

  for (final status in [401, 403]) {
    test('HTTP $status cancels the other candidate immediately', () async {
      final options = RequestOptions(path: '/read');
      final denied = Completer<String>();
      final tokens = <CancelToken>[];
      final pending = raceHttpReads<String>([
        (token) {
          tokens.add(token);
          return denied.future;
        },
        (token) {
          tokens.add(token);
          return Completer<String>().future;
        },
      ], timeout: const Duration(seconds: 1));
      final failure = expectLater(
        pending,
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'status',
            status,
          ),
        ),
      );
      denied.completeError(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: options, statusCode: status),
        ),
      );
      await failure;
      expect(tokens.every((token) => token.isCancelled), isTrue);
    });
  }

  test(
    'a truncated response cannot prevent the other complete read from winning',
    () async {
      final origin = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      final sockets = <Socket>[];
      addTearDown(() async {
        for (final socket in sockets) {
          socket.destroy();
        }
        await origin.close();
      });
      origin.listen((socket) {
        sockets.add(socket);
        var sent = false;
        socket.listen((_) async {
          if (sent) return;
          sent = true;
          socket.write(
            'HTTP/1.1 200 OK\r\nContent-Length: 100\r\nConnection: close\r\n\r\npartial',
          );
          await socket.flush();
          await socket.close();
        });
      });
      final client = Dio();
      addTearDown(() => client.close(force: true));
      final broken = Completer<void>();
      DioException? failure;
      final result = await raceHttpReads<String>([
        (token) async {
          try {
            final response = await client.get<String>(
              'http://127.0.0.1:${origin.port}/read',
              cancelToken: token,
            );
            return response.data!;
          } on DioException catch (error) {
            failure = error;
            rethrow;
          } finally {
            broken.complete();
          }
        },
        (_) async {
          await broken.future;
          return 'complete';
        },
      ], timeout: const Duration(seconds: 1));
      expect(failure?.error, isA<HttpException>());
      expect(result, 'complete');
    },
  );
}
