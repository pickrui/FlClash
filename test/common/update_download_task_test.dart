import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/update_download.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppUpdateDownloadTask task;
  setUp(() => task = AppUpdateDownloadTask());
  tearDown(() => task.dispose());

  test(
    'one application task owns automatic and manual download requests',
    () async {
      final pending = Completer<File>();
      var downloads = 0;
      Future<File> download(CancelToken _, ProgressCallback _) {
        downloads++;
        return pending.future;
      }

      final first = task.start(download, url: 'https://fixture/update.exe');
      final second = task.start(download, url: 'https://fixture/update.exe');
      expect(second, same(first));
      expect(downloads, 1);
      expect(task.hasDownload, isTrue);
      pending.complete(File('/tmp/fixture-update.exe'));
      await first;
      expect(task.value.phase, AppUpdateDownloadPhase.ready);
      expect(task.value.showReadyNotice, isTrue);
      await task.start(download, url: 'https://fixture/update.exe');
      expect(downloads, 1);
      task.dismissNotice();
      expect(task.value.showReadyNotice, isFalse);
      expect(task.value.file, isNotNull);
    },
  );
  test('detaching a progress view keeps the transfer alive', () async {
    final pending = Completer<File>();
    late CancelToken token;
    final operation = task.start((value, _) {
      token = value;
      return pending.future;
    }, url: 'fixture');
    task.attachView();
    task.detachView();
    expect(token.isCancelled, isFalse);
    expect(task.hasForegroundView, isFalse);
    pending.complete(File('/tmp/fixture-update.exe'));
    await operation;
    expect(task.value.phase, AppUpdateDownloadPhase.ready);
  });
  test(
    'cancel cleans late output without overwriting a newer transfer',
    () async {
      final root = await Directory.systemTemp.createTemp('updater-task-test-');
      addTearDown(() => root.delete(recursive: true));
      final staging = await root.createTemp('flclash-update-');
      final oldFile = await File(
        '${staging.path}/update.exe',
      ).writeAsString('fixture');
      final pending = Completer<File>();
      late CancelToken oldToken;
      final first = task.start((value, _) {
        oldToken = value;
        return pending.future;
      }, url: 'old');
      task.cancel();
      expect(oldToken.isCancelled, isTrue);
      final newFile = File('${root.path}/new.exe');
      await task.start((_, _) async => newFile, url: 'new');
      pending.complete(oldFile);
      await first;
      expect(await oldFile.exists(), isFalse);
      expect(await staging.exists(), isFalse);
      expect(task.value.file, same(newFile));
    },
  );
  test(
    'failure stays in task state and retry does not leak an unhandled error',
    () async {
      var attempts = 0;
      await task.start((_, _) async {
        if (++attempts == 1) throw const FileSystemException('disk full');
        return File('/tmp/fixture-update.exe');
      }, url: 'fixture');
      expect(task.value.phase, AppUpdateDownloadPhase.failed);
      expect(task.value.error, isA<FileSystemException>());
      await task.retry();
      expect(attempts, 2);
      expect(task.value.phase, AppUpdateDownloadPhase.ready);
      expect(task.value.error, isNull);
    },
  );
  test('progress updates are bounded by displayed percent', () async {
    final pending = Completer<File>();
    late ProgressCallback progress;
    final operation = task.start((_, value) {
      progress = value;
      return pending.future;
    }, url: 'fixture');
    var updates = 0;
    task.addListener(() => updates++);
    for (var i = 1; i <= 10000; i++) {
      progress(i, 10000);
    }
    expect(updates, lessThanOrEqualTo(101));
    expect(task.value.progress, 1);
    progress(5, -1);
    expect(task.value.progress, isNull);
    pending.complete(File('/tmp/fixture-update.exe'));
    await operation;
  });
  test(
    'cancelled failure cannot become a failed-download notification',
    () async {
      final pending = Completer<File>();
      final operation = task.start((_, _) => pending.future, url: 'fixture');
      task.cancel();
      pending.completeError(StateError('late failure'));
      await operation;
      expect(task.value.phase, AppUpdateDownloadPhase.canceled);
      expect(task.value.error, isNull);
    },
  );

  test(
    'foreground reuse and startup cleanup preserve a streaming download',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'updater-stream-test-',
      );
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final client = Dio();
      final started = Completer<void>();
      final finish = Completer<void>();
      addTearDown(() async {
        if (!finish.isCompleted) finish.complete();
        client.close(force: true);
        await server.close(force: true);
        await directory.delete(recursive: true);
      });
      final stale = await directory.createTemp('flclash-update-');
      await File('${stale.path}/old.apk').writeAsString('old');
      server.listen((request) async {
        request.response.headers.contentType = ContentType.binary;
        request.response.bufferOutput = false;
        request.response.contentLength = 65536;
        request.response.add(List.filled(32768, 1));
        await request.response.flush();
        await finish.future;
        request.response.add(List.filled(32768, 2));
        await request.response.close();
      });
      final url = 'http://127.0.0.1:${server.port}/update.apk';
      final running = task.startDownload(
        (token, progress) => downloadAppUpdate(
          client: client,
          url: url,
          directory: directory,
          cancelToken: token,
          onProgress: (received, total) {
            progress(received, total);
            if (!started.isCompleted) started.complete();
          },
        ),
        url: url,
        directory: directory,
      );
      await started.future;
      expect(await stale.exists(), isFalse);
      expect(task.value.file, isNull);
      await task.cleanStaleDownloads(directory);
      final joined = task.startDownload(
        (_, _) async => throw StateError('must reuse task'),
        url: url,
        directory: directory,
      );
      expect(joined, same(running));
      finish.complete();
      await running;
      expect(task.value.phase, AppUpdateDownloadPhase.ready);
      expect(await task.value.file!.length(), 65536);
      await task.cleanStaleDownloads(directory);
      expect(await task.value.file!.exists(), isTrue);
    },
  );
}
