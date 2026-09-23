import 'dart:async';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import '../../setup.dart' as setup;

void main() {
  test('desktop host architecture resolves documented aliases', () {
    expect(setup.resolveHostArch('ARM64'), setup.Arch.arm64);
    expect(setup.resolveHostArch('aarch64'), setup.Arch.arm64);
    expect(setup.resolveHostArch('AMD64'), setup.Arch.amd64);
    expect(setup.resolveHostArch('x86_64'), setup.Arch.amd64);
    expect(setup.resolveHostArch('unknown'), isNull);
  });

  test(
    'failed dependency commands abort even without a display name',
    () async {
      final temp = Directory.systemTemp.createTempSync(
        'flclash setup fixture ',
      );
      addTearDown(() => temp.deleteSync(recursive: true));
      final script = File('${temp.path}/failing command.dart')
        ..writeAsStringSync("import 'dart:io'; void main() { exit(7); }");
      await expectLater(
        setup.Build.exec(['dart', script.path], runInShell: false),
        throwsA(isA<ProcessException>().having((e) => e.errorCode, 'exit', 7)),
      );
    },
  );

  test('build commands preserve paths and arguments containing spaces', () async {
    final temp = Directory.systemTemp.createTempSync('flclash setup fixture ');
    addTearDown(() => temp.deleteSync(recursive: true));
    final output = File('${temp.path}/received args.txt');
    final script = File('${temp.path}/echo args.dart')
      ..writeAsStringSync(
        "import 'dart:io'; void main(List<String> args) { File(args[0]).writeAsStringSync(args[1]); }",
      );
    await setup.Build.exec([
      'dart',
      script.path,
      output.path,
      'one argument with spaces',
    ], runInShell: false);
    expect(output.readAsStringSync(), 'one argument with spaces');
  });

  test('build commands hide secret environment entries', () async {
    final lines = <String>[];
    await runZoned(
      () => setup.Build.exec(
        ['dart', '--version'],
        environment: {
          'PROFILE_KEY': ' fixture-secret',
          'EXTRA_DEFINE': 'v2:Zml4dHVyZQ==',
          'FLUTTER_XCODE_ARCHS': 'arm64',
        },
        runInShell: false,
      ),
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) => lines.add(line),
      ),
    );
    expect(
      lines,
      contains(
        'env: PROFILE_KEY=<redacted> EXTRA_DEFINE=<redacted> '
        'FLUTTER_XCODE_ARCHS=arm64',
      ),
    );
  });
}
