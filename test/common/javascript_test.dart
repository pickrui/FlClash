import 'dart:io';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'default script with trailing whitespace can be evaluated repeatedly',
    () async {
      for (var index = 0; index < 10; index++) {
        final result = await globalState.handleEvaluate(
          '$scriptTemplate ',
          <String, dynamic>{'proxies': <dynamic>[]},
        );

        expect(result['proxies'], isEmpty);
        expect(result['proxy-providers'], isEmpty);
      }
    },
    skip: !Platform.isMacOS,
  );

  test(
    'script evaluation recovers after an error',
    () async {
      await expectLater(
        globalState.handleEvaluate('const main = (', <String, dynamic>{
          'proxies': <dynamic>[],
        }),
        throwsA(isA<String>()),
      );

      final result = await globalState.handleEvaluate(
        scriptTemplate,
        <String, dynamic>{'proxies': <dynamic>[]},
      );

      expect(result['proxies'], isEmpty);
      expect(result['proxy-providers'], isEmpty);
    },
    skip: !Platform.isMacOS,
  );
}
