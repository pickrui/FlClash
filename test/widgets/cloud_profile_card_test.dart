import 'package:fl_clash/common/oix_cloud.dart';
import 'package:fl_clash/common/oix_params_storage.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/views/cloud/cloud_profile_card.dart';
import 'package:fl_clash/widgets/inherited.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/test_app.dart';

const _managed = Profile(
  id: 1,
  url: oixCloudManagedProfileUrl,
  autoUpdateDuration: Duration(hours: 6),
);

CloudProfile _cloudProfile({required int planRank}) => CloudProfile(
  subscription: 'Fixture',
  planRank: planRank,
  expireTime: DateTime.utc(2030),
  todayUsed: '0 B',
  totalUsed: '0 B',
  totalTraffic: '0 B',
  usageProgress: 0,
  remaining: '0 B',
  balance: '0',
  commission: '0',
  points: '0',
);

class _Profiles extends Profiles {
  @override
  List<Profile> build() => const [_managed];
}

class _ProfileAction extends ProfileAction {
  final updated = <Profile>[];

  @override
  Future<Profile> updateProfile(
    Profile profile, {
    bool showLoading = false,
    bool applyIfCurrent = true,
    bool forceApplyIfCurrent = false,
    bool preserveCurrentState = true,
  }) async {
    updated.add(profile);
    return profile;
  }
}

class _SetupAction extends SetupAction {
  var applies = 0;

  @override
  void applyProfileDebounce({bool silence = false, bool force = false}) {
    applies++;
  }
}

Future<void> _pumpCard(
  WidgetTester tester,
  ValueNotifier<CloudProfile> profile, {
  ValueNotifier<bool>? active,
  _ProfileAction? profileAction,
  _SetupAction? setupAction,
}) async {
  await tester.pumpWidget(const SizedBox.shrink());
  final isActive = active ?? ValueNotifier(true);
  await tester.pumpWidget(
    TestApp(
      locale: const Locale('en'),
      overrides: [
        profilesProvider.overrideWith(_Profiles.new),
        profileActionProvider.overrideWith(
          () => profileAction ?? _ProfileAction(),
        ),
        setupActionProvider.overrideWith(() => setupAction ?? _SetupAction()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: ValueListenableBuilder<bool>(
            valueListenable: isActive,
            builder: (_, isActive, _) => PageActivityScope(
              isActive: isActive,
              child: ValueListenableBuilder<CloudProfile>(
                valueListenable: profile,
                builder: (_, profile, _) => CloudProfileCard(profile: profile),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

List<bool> _switchValues(WidgetTester tester) => tester
    .widgetList<Switch>(find.byType(Switch))
    .map((item) => item.value)
    .toList();

Future<void> _switchKeepsParamsSavedMeanwhile(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({
    'cloud_service_config_params': '&mode=premium&tfo=false',
  });
  final profileAction = _ProfileAction();
  final setupAction = _SetupAction();
  final profile = ValueNotifier(_cloudProfile(planRank: 40));
  addTearDown(profile.dispose);
  await _pumpCard(
    tester,
    profile,
    profileAction: profileAction,
    setupAction: setupAction,
  );
  expect(_switchValues(tester), [false, false, false]);

  await CloudParamsStorage.save(
    CloudParams.parse('&mode=premium&tfo=true&simplerules=true&extra=1'),
  );
  await tester.tap(find.byType(Switch).at(1));
  await tester.pumpAndSettle();

  final stored = await CloudParamsStorage.load();
  expect(stored.level, NetworkLevel.overseas);
  expect(stored.tfo, isTrue);
  expect(stored.simplerules, isTrue);
  expect(stored.extras, {'extra': '1'});
  expect(_switchValues(tester), [false, true, false]);
  expect(profileAction.updated, [_managed]);
  expect(setupAction.applies, 1);
}

Future<void> _planChangeShowsReconciledParams(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  final profile = ValueNotifier(_cloudProfile(planRank: 0));
  addTearDown(profile.dispose);
  await _pumpCard(tester, profile);
  expect(_switchValues(tester), [false]);

  await CloudParamsStorage.reconcileForTier(SubscriptionTier.alu);
  profile.value = _cloudProfile(planRank: 20);
  await tester.pumpAndSettle();

  expect((await CloudParamsStorage.load()).level, NetworkLevel.emergency);
  expect(_switchValues(tester), [false, false]);
}

Future<void> _returningShowsParamsEditedElsewhere(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({
    'cloud_service_config_params': '&mode=premium&tfo=false',
  });
  final profile = ValueNotifier(_cloudProfile(planRank: 40));
  final active = ValueNotifier(true);
  addTearDown(profile.dispose);
  addTearDown(active.dispose);
  await _pumpCard(tester, profile, active: active);

  active.value = false;
  await tester.pumpAndSettle();
  await CloudParamsStorage.save(CloudParams.parse('&mode=emergency'));
  active.value = true;
  await tester.pumpAndSettle();

  expect(_switchValues(tester), [false, false, true]);
}

void _cardTest(
  String description,
  Future<void> Function(WidgetTester tester) scenario,
) {
  testWidgets(description, (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await scenario(tester);
    expect(tester.takeException(), isNull);
  });
}

void main() {
  _cardTest(
    'a switch keeps params another writer saved meanwhile',
    _switchKeepsParamsSavedMeanwhile,
  );
  _cardTest(
    'a plan change shows the reconciled params',
    _planChangeShowsReconciledParams,
  );
  _cardTest(
    'returning to the page shows params edited elsewhere',
    _returningShowsParamsEditedElsewhere,
  );
}
