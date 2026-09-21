import 'dart:async';
import 'dart:io';

import 'package:fl_clash/common/function.dart';
import 'package:fl_clash/core/event.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/manager/core_manager.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../helpers/test_app.dart';

class _ProxiesAction extends ProxiesAction {
  int snapshots = 0;
  int groups = 0;
  Completer<void>? pending;

  @override
  Future<void> updateProviders() async {
    snapshots++;
    await pending?.future;
  }

  @override
  void updateGroupsDebounce() => groups++;
}

class _Paths extends PathProviderPlatform {
  _Paths(this.path);

  final String path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getApplicationCachePath() async => path;

  @override
  Future<String?> getTemporaryPath() async => path;

  @override
  Future<String?> getDownloadsPath() async => path;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  late PathProviderPlatform originalPaths;

  setUpAll(() async {
    directory = await Directory.systemTemp.createTemp('core-manager-');
    originalPaths = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _Paths(directory.path);
  });

  tearDownAll(() async {
    PathProviderPlatform.instance = originalPaths;
    await directory.delete(recursive: true);
  });

  tearDown(() => debouncer.cancel(FunctionTag.loadedProvider));

  Future<CoreEventListener> mount(
    WidgetTester tester,
    _ProxiesAction action,
  ) async {
    await tester.pumpWidget(
      TestApp(
        overrides: [
          currentSetupStateProvider.overrideWith((_) => null),
          proxiesActionProvider.overrideWith(() => action),
        ],
        child: const CoreManager(child: SizedBox()),
      ),
    );
    await tester.pump(const Duration(seconds: 11));
    return tester.state(find.byType(CoreManager)) as CoreEventListener;
  }

  testWidgets('loaded events coalesce into a complete typed snapshot', (
    tester,
  ) async {
    final action = _ProxiesAction();
    final listener = await mount(tester, action);
    listener.onLoaded('shared');
    listener.onLoaded('shared');
    listener.onLoaded('other');
    await tester.pump(const Duration(seconds: 5));
    expect(action.snapshots, 1);
    expect(action.groups, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('disposed manager does not refresh after a loaded event', (
    tester,
  ) async {
    final action = _ProxiesAction();
    final listener = await mount(tester, action);
    listener.onLoaded('shared');
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 5));
    expect(action.snapshots, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('snapshot failures are handled and a later event can retry', (
    tester,
  ) async {
    final action = _ProxiesAction()..pending = Completer<void>();
    final listener = await mount(tester, action);
    listener.onLoaded('shared');
    await tester.pump(const Duration(seconds: 5));
    action.pending!.completeError(StateError('core disconnected'));
    await tester.pump();
    expect(action.groups, 0);
    expect(tester.takeException(), isNull);
    action.pending = null;
    listener.onLoaded('shared');
    await tester.pump(const Duration(seconds: 5));
    expect(action.snapshots, 2);
    expect(action.groups, 1);
  });
}
