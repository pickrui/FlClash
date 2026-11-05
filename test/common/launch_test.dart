import 'package:fl_clash/common/launch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('shouldLaunchSilently', () {
    test('shows manual launches', () {
      expect(shouldLaunchSilently(enabled: true, arguments: const []), isFalse);
    });

    test('shows launches when silent mode is disabled', () {
      expect(
        shouldLaunchSilently(
          enabled: false,
          arguments: const [silentLaunchArgument],
        ),
        isFalse,
      );
    });

    test('hides enabled auto launches', () {
      expect(
        shouldLaunchSilently(
          enabled: true,
          arguments: const [silentLaunchArgument],
        ),
        isTrue,
      );
    });
  });
}
