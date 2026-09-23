import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/views/profiles/add.dart';
import 'package:fl_clash/widgets/pop_scope.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import '../helpers/test_app.dart';

class _ProfileAction extends ProfileAction {
  int imports = 0;
  @override
  Future<void> addProfileFormFile() async {
    imports++;
  }
}

class _BackAction extends BackBlockAction {
  int balance = 0;
  @override
  void backBlock() {
    balance++;
  }

  @override
  void unBackBlock() {
    balance--;
  }
}

class _WindowPort implements WindowPort {
  int toggles = 0;
  @override
  Future<void> toggle() async {
    toggles++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('cloud application logs never reach debug output', () {
    final previous = debugPrint;
    final messages = <String?>[];
    debugPrint = (message, {wrapWidth}) => messages.add(message);
    addTearDown(() => debugPrint = previous);

    commonPrint.log('oixCloud account request failed');
    commonPrint.log('[oixCloud API] request failed');
    commonPrint.log('CloudApiException: request failed');
    for (final domain in Secrets.cloudDomains) {
      commonPrint.log('GET https://$domain/account?token=private failed');
    }

    expect(messages, isEmpty);
  });

  test('cloud logs are discarded by log actions', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(logsProvider.notifier).value = FixedList<Log>(10);
    final action = container.read(logsActionProvider.notifier);
    for (final payload in [
      'oixCloud account error',
      ...Secrets.cloudDomains.map((domain) => 'GET https://$domain/account'),
    ]) {
      action.addLog(Log.app(payload));
      action.writePersistentLog(Log.app(payload));
    }
    container
        .read(logsProvider.notifier)
        .addLog(Log.app('ordinary connection'));

    expect(
      container.read(logsProvider).list.single.payload,
      'ordinary connection',
    );
  });

  test('added logs reach list listeners such as the open Logs page', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(logsProvider.notifier).value = FixedList<Log>(10);
    final updates = <List<Log>>[];
    container.listen(
      logsProvider.select((state) => state.list),
      (_, next) => updates.add(next),
    );

    container.read(logsProvider.notifier).addLog(Log.app('first'));
    container.read(logsProvider.notifier).addLog(Log.app('second'));

    expect(updates.map((logs) => logs.map((log) => log.payload)), [
      ['first'],
      ['first', 'second'],
    ]);
  });

  test('cloud requests never enter recent request history', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(requestsProvider.notifier);
    notifier.value = FixedList<TrackerInfo>(10);
    final ordinary = TrackerInfo(
      id: 'ordinary',
      start: DateTime(2026),
      metadata: const Metadata(host: 'public.example'),
      chains: const ['DIRECT'],
      rule: 'MATCH',
      rulePayload: '',
    );
    for (final domain in ['api.oixcloud.example', ...Secrets.cloudDomains]) {
      notifier.addRequest(ordinary.copyWith(metadata: Metadata(host: domain)));
    }
    notifier.addRequest(ordinary);

    expect(container.read(requestsProvider).list, [ordinary]);
  });

  test('visibility actions use the serialized window toggle', () async {
    final previous = windowPort;
    final port = _WindowPort();
    windowPort = port;
    addTearDown(() => windowPort = previous);
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(systemActionProvider.notifier).updateVisible();
    expect(port.toggles, 1);
  });

  testWidgets('profile import uses the action from its own ProviderScope', (
    tester,
  ) async {
    final action = _ProfileAction();
    final other = ProviderContainer(
      overrides: [profileActionProvider.overrideWith(_ProfileAction.new)],
    );
    addTearDown(other.dispose);
    final otherAction =
        other.read(profileActionProvider.notifier) as _ProfileAction;
    await tester.pumpWidget(
      TestApp(
        overrides: [profileActionProvider.overrideWith(() => action)],
        child: Scaffold(
          body: Builder(builder: (context) => AddProfileView(context: context)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(appLocalizations.file));
    await tester.pump();
    expect(action.imports, 1);
    expect(otherAction.imports, 0);
  });

  testWidgets('back blocking is balanced after its widget is removed', (
    tester,
  ) async {
    final action = _BackAction();
    final show = ValueNotifier(true);
    addTearDown(show.dispose);
    await tester.pumpWidget(
      TestApp(
        overrides: [backBlockActionProvider.overrideWith(() => action)],
        child: ValueListenableBuilder(
          valueListenable: show,
          builder: (_, value, _) => value
              ? const SystemBackBlock(child: SizedBox())
              : const SizedBox(),
        ),
      ),
    );
    await tester.pump();
    expect(action.balance, 1);
    show.value = false;
    await tester.pump();
    await tester.pump();
    expect(action.balance, 0);
    expect(tester.takeException(), isNull);
  });
}
