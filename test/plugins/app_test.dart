import 'dart:async';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('$packageName/app');

  setUp(() {
    App().clearPackageIconCache();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    App().clearPackageIconCache();
  });

  test('requests every package icon from Android only once', () async {
    var iconCallCount = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          iconCallCount++;
          return '/icons/${call.arguments['packageName']}.png';
        });

    final app = App();
    final results = await Future.wait([
      app.getPackageIcon('com.a'),
      app.getPackageIcon('com.a'),
    ]);
    final cached = await app.getPackageIcon('com.a');

    expect(iconCallCount, 1);
    expect(results.first, isNotNull);
    expect(cached, same(results.first));
    expect(app.hasPackageIcon('com.a'), isTrue);
    expect(app.getCachedPackageIcon('com.a'), same(results.first));

    await app.getPackageIcon('com.b');

    expect(iconCallCount, 2);
  });

  test(
    'caches packages without an icon and skips empty package names',
    () async {
      var iconCallCount = 0;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
            iconCallCount++;
            return null;
          });

      final app = App();

      expect(await app.getPackageIcon(''), isNull);
      expect(iconCallCount, 0);
      expect(app.hasPackageIcon(''), isFalse);

      expect(await app.getPackageIcon('com.a'), isNull);
      expect(await app.getPackageIcon('com.a'), isNull);

      expect(iconCallCount, 1);
      expect(app.hasPackageIcon('com.a'), isTrue);
    },
  );

  test('caches a failed package icon lookup', () async {
    var iconCallCount = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) async {
          iconCallCount++;
          throw PlatformException(code: 'unavailable');
        });

    final app = App();

    expect(await app.getPackageIcon('com.a'), isNull);
    expect(await app.getPackageIcon('com.a'), isNull);
    expect(iconCallCount, 1);
  });
  Future<void> packagesChanged() async {
    final completed = Completer<void>();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          channel.name,
          const StandardMethodCodec().encodeMethodCall(
            const MethodCall('packagesChanged'),
          ),
          (_) => completed.complete(),
        );
    await completed.future;
  }

  test(
    'package events invalidate both cached missing icons and app list subscribers',
    () async {
      var calls = 0;
      var changes = 0;
      final api = App();
      final subscription = api.packageChanges.listen((_) => changes++);
      addTearDown(subscription.cancel);
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (_) async => ++calls == 1 ? null : '/icons/updated.png',
          );
      expect(await api.getPackageIcon('updated.app'), isNull);
      await packagesChanged();
      expect(changes, 1);
      expect(await api.getPackageIcon('updated.app'), isNotNull);
      expect(calls, 2);
    },
  );

  test(
    'an old icon completion cannot overwrite or remove a new lookup',
    () async {
      final old = Completer<String>();
      final fresh = Completer<String>();
      var calls = 0;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            (_) => ++calls == 1 ? old.future : fresh.future,
          );
      final api = App();
      final oldTask = api.getPackageIcon('replaced.app');
      await Future<void>.delayed(Duration.zero);
      await packagesChanged();
      final newTask = api.getPackageIcon('replaced.app');
      await Future<void>.delayed(Duration.zero);
      old.complete('/icons/old.png');
      expect(await oldTask, isNull);
      expect(api.hasPackageIcon('replaced.app'), isFalse);
      expect(api.getPackageIcon('replaced.app'), same(newTask));
      fresh.complete('/icons/new.png');
      final icon = await newTask;
      expect(api.getCachedPackageIcon('replaced.app'), same(icon));
      expect(calls, 2);
    },
  );

  test(
    'permission and settings methods preserve denial and missing results',
    () async {
      final seen = <String>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            seen.add(call.method);
            return call.method == 'openAppSettings' ? true : null;
          });
      final api = App();
      expect(await api.isInstalledAppsPermissionGranted(), isFalse);
      expect(await api.requestInstalledAppsPermission(), isFalse);
      expect(await api.openAppSettings(), isTrue);
      expect(seen, [
        'isInstalledAppsPermissionGranted',
        'requestInstalledAppsPermission',
        'openAppSettings',
      ]);
    },
  );
}
