import 'dart:io';
import 'package:setup_hooks/src/error.dart';
import 'package:setup_hooks/src/secrets.dart';
import 'package:setup_hooks/src/redaction.dart';
import 'package:test/test.dart';

void main() {
  late Directory root;
  const env = {
    'DNS_AUTH_PRIVATE_KEY': 'fixture-key-only',
    'DNS_AUTH_DOMAINS': 'example.invalid',
  };
  setUp(() {
    root = Directory.systemTemp.createTempSync('flclash-build-settings-');
  });
  tearDown(() {
    root.deleteSync(recursive: true);
  });
  test(
    'setup and later hooks use identical obfuscated inputs without plaintext files',
    () {
      final first = CoreBuildSecrets.load(
        rootDir: root.path,
        environment: env,
        requireSecrets: true,
      );
      final second = CoreBuildSecrets.load(
        rootDir: root.path,
        environment: env,
        requireSecrets: true,
      );
      final hook = CoreBuildSecrets.load(
        rootDir: root.path,
        environment: {},
        requireSecrets: true,
      );
      expect(second.ldflags, first.ldflags);
      expect(hook.ldflags, first.ldflags);
      final persisted = File(first.path).readAsStringSync();
      for (final plain in env.values) {
        expect(persisted, isNot(contains(plain)));
        expect(first.ldflags, isNot(contains(plain)));
      }
      if (!Platform.isWindows) {
        expect(File(first.path).statSync().mode & 0x1ff, 0x180);
      }
    },
  );
  test(
    'changing or explicitly clearing a value invalidates the prepared inputs',
    () {
      final first = CoreBuildSecrets.load(rootDir: root.path, environment: env);
      final changed = CoreBuildSecrets.load(
        rootDir: root.path,
        environment: {'DNS_AUTH_DOMAINS': 'changed.invalid'},
      );
      expect(changed.ldflags, isNot(first.ldflags));
      expect(
        changed.values['GlobalDNSAuthPrivateKey'],
        first.values['GlobalDNSAuthPrivateKey'],
      );
      final cleared = CoreBuildSecrets.load(
        rootDir: root.path,
        environment: {'DNS_AUTH_DOMAINS': ''},
      );
      expect(cleared.values.containsKey('GlobalDNSAuthDomains'), isFalse);
      expect(
        () => CoreBuildSecrets.load(
          rootDir: root.path,
          environment: {},
          requireSecrets: true,
        ),
        throwsA(isA<BuildException>()),
      );
    },
  );
  test(
    'a real hook cannot silently replace the Core without build settings',
    () {
      expect(
        () => CoreBuildSecrets.load(
          rootDir: root.path,
          environment: {},
          requireSecrets: true,
        ),
        throwsA(isA<BuildException>()),
      );
    },
  );
  test('packaging output hides app defines and Flutter define lists', () {
    const lines = [
      '--build-dart-define=BASE_DOMAIN=fixture.invalid',
      'flutter build apk --dart-define=SPARE_API_DOMAIN=fixture.invalid',
      '[ +3 ms] -dDartDefines=fixture.invalid -dTrackWidgetCreation=false',
      '    DART_DEFINES = fixture.invalid',
    ];
    for (final line in lines) {
      expect(redactBuildOutput(line), isNot(contains('fixture.invalid')));
    }
    expect(redactBuildOutput('APP_ENV=pre'), 'APP_ENV=pre');
  });
  test('normal and failing command diagnostics redact linker inputs', () {
    final secrets = CoreBuildSecrets.load(rootDir: root.path, environment: env);
    final text =
        'go build -ldflags=${secrets.ldflags} DNS_AUTH_PRIVATE_KEY=fixture-key-only';
    final failure = CommandFailedException(
      executable: 'go',
      arguments: [text],
      exitCode: 1,
      stdout: text,
      stderr: text,
    ).toString();
    for (final output in [redactBuildOutput(text), failure]) {
      expect(output, isNot(contains('fixture-key-only')));
      expect(output, isNot(contains('v2:')));
      expect(output, contains('<redacted>'));
    }
  });
}
