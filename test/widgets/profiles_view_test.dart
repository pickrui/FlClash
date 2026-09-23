import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/views/profiles/overwrite.dart';
import 'package:fl_clash/views/profiles/profiles.dart';
import 'package:fl_clash/widgets/sheet.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

final _updated = DateTime(2026, 9, 1);

const _first = Profile(
  id: 1,
  label: 'First',
  url: 'https://example.com/first',
  autoUpdateDuration: Duration(hours: 6),
  overwriteType: OverwriteType.script,
);
const _second = Profile(
  id: 2,
  label: 'Second',
  url: 'https://example.com/second',
  autoUpdateDuration: Duration(hours: 6),
);
const _third = Profile(
  id: 3,
  label: 'Third',
  autoUpdateDuration: Duration(hours: 6),
);

class _Profiles extends Profiles {
  final List<Profile> initial;

  _Profiles(this.initial);

  @override
  List<Profile> build() => initial;

  void replace(List<Profile> profiles) => state = profiles;
}

class _ProfileAction extends ProfileAction {
  List<Profile>? reordered;

  @override
  void reorder(List<Profile> profiles) => reordered = profiles;
}

class _SetupAction extends SetupAction {
  int autoApplies = 0;

  @override
  void autoApplyProfile() => autoApplies++;
}

class _Scripts extends Scripts {
  @override
  Stream<List<Script>> build() => Stream.value(const []);
}

Future<ProviderContainer> _pushRoute(
  WidgetTester tester,
  List<Override> overrides,
  Widget Function() page,
) async {
  const size = Size(800, 1200);
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  final container = ProviderContainer(
    overrides: [
      viewSizeProvider.overrideWithBuild((_, _) => size),
      ...overrides,
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: TestApp(
        child: Builder(
          builder: (context) => TextButton(
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute<void>(builder: (_) => page())),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return container;
}

void main() {
  testWidgets('saving the sort order keeps profile changes made meanwhile', (
    tester,
  ) async {
    final action = _ProfileAction();
    final container = await _pushRoute(
      tester,
      [
        profilesProvider.overrideWith(
          () => _Profiles([_first, _second, _third]),
        ),
        profileActionProvider.overrideWith(() => action),
      ],
      () => const ReorderableProfilesSheet(
        type: SheetType.page,
        profiles: [_first, _second, _third],
      ),
    );

    tester
        .widget<ReorderableListView>(find.byType(ReorderableListView))
        .onReorderItem!(0, 2);
    await tester.pump();
    const added = Profile(
      id: 4,
      label: 'Added',
      autoUpdateDuration: Duration(hours: 6),
    );
    final refreshed = _second.copyWith(lastUpdateDate: _updated);
    (container.read(profilesProvider.notifier) as _Profiles).replace([
      _first,
      refreshed,
      added,
    ]);

    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    expect(action.reordered, [refreshed, _first, added]);
    expect(find.byType(ReorderableProfilesSheet), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('leaving the override page reapplies the profile', (
    tester,
  ) async {
    final setup = _SetupAction();
    await _pushRoute(tester, [
      profilesProvider.overrideWith(() => _Profiles([_first])),
      setupActionProvider.overrideWith(() => setup),
      scriptsProvider.overrideWith(_Scripts.new),
    ], () => const OverwriteView(profileId: 1));
    expect(find.byType(OverwriteView), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.byType(OverwriteView), findsNothing);
    expect(setup.autoApplies, 1);
    expect(tester.takeException(), isNull);
  });
}
