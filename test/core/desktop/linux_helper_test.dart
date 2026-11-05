import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/core/desktop/helper_client.dart';
import 'package:fl_clash/core/desktop/linux_helper.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:flutter_test/flutter_test.dart';

const sha = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
const session = '0123456789abcdef0123456789abcdef';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Exercise the real Unix transport instead of Flutter's HTTP 400 override.
  HttpOverrides.global = null;

  test(
    'Linux Helper uses a Unix socket and verifies path, SHA, session and protocol',
    () async {
      final dir = Directory.systemTemp.createTempSync('flclash-helper-');
      addTearDown(() => dir.deleteSync(recursive: true));
      final socket = '${dir.path}/helper.sock';
      final server = await HttpServer.bind(
        InternetAddress(socket, type: InternetAddressType.unix),
        0,
      );
      addTearDown(() => server.close(force: true));
      var wrongPath = false;
      final requests = <String>[];
      server.listen((request) async {
        requests.add(request.uri.path);
        request.response.headers.set(
          helperProtocolVersionHeader,
          helperProtocolVersion,
        );
        if (request.uri.path == '/ping') {
          expect(request.uri.queryParameters['coreSha256'], sha);
          request.response.write(
            wrongPath
                ? linuxHelperInstalledPath(sha).toUpperCase()
                : linuxHelperInstalledPath(sha),
          );
        } else {
          final body = jsonDecode(await utf8.decoder.bind(request).join());
          expect(body['sessionId'], session);
          request.response.headers.contentType = ContentType.json;
          request.response.write(
            jsonEncode(
              request.uri.path == '/start'
                  ? {'sessionId': session, 'pid': 1234}
                  : {'sessionId': session, 'stopped': true},
            ),
          );
        }
        await request.response.close();
      });
      final client = HelperClient(
        isLinux: true,
        socketPath: socket,
        readCoreSha256: () async => sha,
      );
      expect(await client.readiness(), HelperReadiness.ready);
      expect(
        (await client.start(
          address: '/tmp/FlClashSocket_123.sock',
          sessionId: session,
        )).pid,
        1234,
      );
      expect((await client.stop(session)).stopped, true);
      wrongPath = true;
      expect(await client.readiness(), HelperReadiness.notReady);
      expect(requests, ['/ping', '/start', '/stop', '/ping']);
    },
    skip: Platform.isWindows ? 'Unix sockets are tested on macOS/Linux' : false,
  );

  test(
    'installer passes literal paths through pkexec and waits for readiness',
    () async {
      final dir = Directory.systemTemp.createTempSync('flclash-helper-');
      addTearDown(() => dir.deleteSync(recursive: true));
      final exe = File('${dir.path}/Helper with spaces')
        ..writeAsStringSync('fixture');
      final client = _Client([HelperReadiness.notReady, HelperReadiness.ready]);
      final installer = LinuxHelperInstaller(
        probeReadiness: client.probe,
        executable: exe.path,
        hasSystemd: () => true,
        runProcess: (command, arguments) async {
          expect(command, 'pkexec');
          expect(arguments, [exe.path, 'install']);
          return ProcessResult(1, 0, '', '');
        },
      );
      expect(await installer.install(), AuthorizeCode.success);
    },
  );

  test(
    'cancelled elevation is final and missing manifest never elevates',
    () async {
      final dir = Directory.systemTemp.createTempSync('flclash-helper-');
      addTearDown(() => dir.deleteSync(recursive: true));
      final exe = File('${dir.path}/helper')..writeAsStringSync('fixture');
      var calls = 0;
      Future<ProcessResult> cancel(String _, List<String> _) async {
        calls++;
        return ProcessResult(1, 126, '', '');
      }

      final denied = LinuxHelperInstaller(
        probeReadiness: _Client([HelperReadiness.notReady]).probe,
        executable: exe.path,
        hasSystemd: () => true,
        runProcess: cancel,
      );
      expect(await denied.install(), AuthorizeCode.error);
      expect(calls, 1);
      final missing = LinuxHelperInstaller(
        probeReadiness: _Client([HelperReadiness.manifestMissing]).probe,
        executable: exe.path,
        hasSystemd: () => true,
        runProcess: cancel,
      );
      expect(await missing.install(), AuthorizeCode.error);
      expect(calls, 1);
      final unsupported = LinuxHelperInstaller(
        executable: exe.path,
        hasSystemd: () => false,
      );
      expect(unsupported.available, false);
    },
  );
}

class _Client {
  _Client(this.states);
  final List<HelperReadiness> states;
  Future<HelperReadiness> probe(Duration? timeout, bool logFailure) async =>
      states.removeAt(0);
}
