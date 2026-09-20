import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/geo_recovery.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/resources.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() {
    tempDir = Directory.systemTemp.createTempSync('flclash_geo_resource_');
    PathProviderPlatform.instance = _FakePathProvider(tempDir.path);
  });

  tearDownAll(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  // The file is stat-ed on the real event loop, outside fake-async.
  Future<void> settle(WidgetTester tester, {int rounds = 1}) async {
    for (var i = 0; i < rounds; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
    for (var i = 0; i < 100; i++) {
      await settle(tester);
      if (finder.evaluate().isNotEmpty) {
        return;
      }
    }
    fail('timed out waiting for $finder');
  }

  testWidgets('refreshes the file info once the core finishes updating', (
    tester,
  ) async {
    const size = Size(1000, 1000);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final file = File(p.join(tempDir.path, geoFileName(GeoResource.MMDB)))
      ..writeAsBytesSync(List.filled(1024, 0));
    addTearDown(() {
      if (file.existsSync()) file.deleteSync();
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);
    globalState.container = container;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TestApp(
          child: Scaffold(
            body: GeoDataListItem(geoItem: GeoItem(type: GeoResource.MMDB)),
          ),
        ),
      ),
    );
    await pumpUntilFound(tester, find.textContaining(1024.traffic.show));

    final updatingKey = GeoResource.MMDB.updatingKey;
    container.read(isUpdatingProvider(updatingKey).notifier).value = true;
    await settle(tester);

    file.writeAsBytesSync(List.filled(4096, 0));
    await settle(tester, rounds: 3);
    expect(
      find.textContaining(1024.traffic.show),
      findsOneWidget,
      reason: 'the info must not change while the core is still writing',
    );

    container.read(isUpdatingProvider(updatingKey).notifier).value = false;
    await pumpUntilFound(tester, find.textContaining(4096.traffic.show));

    expect(find.textContaining(1024.traffic.show), findsNothing);
    expect(tester.takeException(), null);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}

class _FakePathProvider extends PathProviderPlatform {
  final String path;

  _FakePathProvider(this.path);

  @override
  Future<String?> getTemporaryPath() async => path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getApplicationCachePath() async => path;

  @override
  Future<String?> getDownloadsPath() async => path;
}
