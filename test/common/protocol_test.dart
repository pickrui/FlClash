import 'package:fl_clash/common/protocol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProtocolRegistrationPlan', () {
    test('builds registry keys and quoted open command', () {
      const plan = ProtocolRegistrationPlan(
        scheme: 'flclash',
        executable: r'C:\Program Files\FlClash\FlClash.exe',
      );

      expect(plan.protocolKey, r'Software\Classes\flclash');
      expect(plan.commandKey, r'shell\open\command');
      expect(plan.command, r'"C:\Program Files\FlClash\FlClash.exe" "%1"');
    });
  });
}
