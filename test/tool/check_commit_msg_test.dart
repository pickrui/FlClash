import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final script = File('tool/check_commit_msg.sh').absolute.path;
  const scissors = '# ------------------------ >8 ------------------------';
  late Directory temp;

  setUp(() {
    temp = Directory.systemTemp.createTempSync('flclash-commit-msg-');
  });
  tearDown(() => temp.deleteSync(recursive: true));

  Future<ProcessResult> check(String message) {
    final file = File('${temp.path}/COMMIT_EDITMSG')
      ..writeAsStringSync(message);
    return Process.run('bash', [script, file.path]);
  }

  test('ignores the staged diff that git commit -v appends', () async {
    final result = await check(
      'docs: describe the agent rules\n\n'
      '# Please enter the commit message for your changes.\n'
      '$scissors\n'
      'diff --git a/CLAUDE.md b/CLAUDE.md\n'
      '+Please read AGENTS.md\n',
    );
    expect(result.exitCode, 0, reason: '${result.stderr}');
  });

  test(
    'a footer below the scissors does not satisfy a breaking change',
    () async {
      final result = await check(
        'feat(x)!: drop y\n\n$scissors\nBREAKING CHANGE: in the diff\n',
      );
      expect(result.exitCode, 1);
      expect('${result.stderr}', contains('BREAKING CHANGE footer'));
    },
  );

  test('still rejects a coding agent named above the scissors', () async {
    final result = await check('docs: note from Claude\n\n$scissors\n');
    expect(result.exitCode, 1);
    expect('${result.stderr}', contains('Do not mention a coding agent'));
  });
}
