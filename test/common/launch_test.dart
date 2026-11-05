import 'package:fl_clash/common/launch.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('resolveLaunchArguments', () {
    const channel = MethodChannel('launch_at_startup');
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    final calls = <MethodCall>[];
    bool? launchedAtLogin;

    setUp(() {
      calls.clear();
      launchedAtLogin = false;
      messenger.setMockMethodCallHandler(channel, (call) async {
        calls.add(call);
        expect(call.method, 'launchAtStartupWasLaunchedAtLogin');
        return launchedAtLogin;
      });
    });

    tearDown(() => messenger.setMockMethodCallHandler(channel, null));

    test(
      'marks macOS login launches and preserves existing arguments',
      () async {
        launchedAtLogin = true;
        final arguments = await resolveLaunchArguments(
          arguments: ['--example'],
          isMacOS: true,
        );

        expect(arguments, ['--example', silentLaunchArgument]);
        expect(
          shouldLaunchSilently(enabled: true, arguments: arguments),
          isTrue,
        );
        expect(
          shouldLaunchSilently(enabled: false, arguments: arguments),
          isFalse,
        );
        expect(calls, hasLength(1));
      },
    );

    for (final loginState in [false, null]) {
      test(
        'preserves macOS manual launches with login state $loginState',
        () async {
          launchedAtLogin = loginState;
          final arguments = await resolveLaunchArguments(
            arguments: [],
            isMacOS: true,
          );

          expect(arguments, isEmpty);
          expect(
            shouldLaunchSilently(enabled: true, arguments: arguments),
            isFalse,
          );
        },
      );
    }

    test('does not duplicate an explicit silent launch argument', () async {
      final arguments = await resolveLaunchArguments(
        arguments: [silentLaunchArgument],
        isMacOS: true,
      );

      expect(arguments, [silentLaunchArgument]);
      expect(calls, isEmpty);
    });

    test('does not query the macOS channel on other platforms', () async {
      final arguments = await resolveLaunchArguments(
        arguments: [silentLaunchArgument],
        isMacOS: false,
      );
      final manualArguments = await resolveLaunchArguments(
        arguments: [],
        isMacOS: false,
      );

      expect(arguments, [silentLaunchArgument]);
      expect(manualArguments, isEmpty);
      expect(calls, isEmpty);
    });
  });

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
