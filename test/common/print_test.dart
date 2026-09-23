import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app logs before attach reach only debug output', () {
    final previous = debugPrint;
    final messages = <String?>[];
    debugPrint = (message, {wrapWidth}) => messages.add(message);
    addTearDown(() => debugPrint = previous);

    expect(appController.canRecordLogs, isFalse);
    expect(appController.isAttach, isFalse);
    commonPrint.log('startup before attach');

    expect(messages, ['[APP] startup before attach']);
  });
}
