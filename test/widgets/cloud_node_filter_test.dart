import 'package:dio/dio.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/views/cloud/cloud_account_page.dart';
import 'package:fl_clash/views/cloud/node_filter_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/test_app.dart';

NodeFilterCatalog _catalog(
  NodeFilter filter, {
  bool? customized,
  int kept = 3,
  bool available = true,
}) {
  return NodeFilterCatalog.fromJson({
    'available': available,
    'customized': customized ?? !filter.isEmpty,
    'system_link': customized ?? !filter.isEmpty,
    'filter': filter.toJson(),
    'lines': [
      {'key': 'fusion', 'name': 'Fusion', 'count': 2},
      {'key': 'gia', 'name': 'GIA', 'count': 1},
      {'key': 'edge', 'name': 'Edge', 'count': 1},
    ],
    'regions': [
      {'code': 'hk', 'name': 'Hong Kong', 'emoji': '🇭🇰', 'count': 3},
      {'code': 'jp', 'name': 'Japan', 'emoji': '🇯🇵', 'count': 1},
    ],
    'nodes': [
      {'name': 'HK Fusion 01', 'line': 'fusion', 'region': 'hk', 'kept': true},
      {'name': 'HK Fusion 02', 'line': 'fusion', 'region': 'hk', 'kept': true},
      {'name': 'HK GIA 01', 'line': 'gia', 'region': 'hk', 'kept': true},
      {'name': 'JP Edge 01', 'line': 'edge', 'region': 'jp', 'kept': false},
    ],
    'kept': kept,
    'total': 4,
  });
}

class _FakeApi implements CloudNodeFilterApi {
  _FakeApi(this.catalog);

  NodeFilterCatalog catalog;
  Object? fetchError;
  var fetches = 0;
  final previews = <NodeFilter>[];
  final saves = <NodeFilter>[];
  var resets = 0;
  int Function(NodeFilter filter) keptFor = (_) => 3;

  @override
  Future<NodeFilterCatalog> fetchNodeFilter() async {
    fetches++;
    if (fetchError case final error?) throw error;
    return catalog;
  }

  @override
  Future<NodeFilterCatalog> previewNodeFilter(NodeFilter filter) async {
    previews.add(filter);
    return _catalog(filter, kept: keptFor(filter));
  }

  @override
  Future<NodeFilterCatalog?> saveNodeFilter(NodeFilter filter) async {
    saves.add(filter);
    return _catalog(filter, customized: true, kept: keptFor(filter));
  }

  @override
  Future<NodeFilterCatalog?> resetNodeFilter() async {
    resets++;
    return _catalog(const NodeFilter());
  }
}

class _Account extends CloudAccountNotifier {
  _Account({this.planRank = 40});

  final int planRank;
  var refreshes = 0;
  var unauthorized = 0;

  @override
  CloudAccountState build() => CloudAccountState(
    isLoggedIn: true,
    profile: CloudProfile(
      subscription: 'Fixture',
      planCode: 'gold',
      planRank: planRank,
      nodeAccess: const ['fusion', 'gia'],
      expireTime: DateTime.utc(2030),
      todayUsed: '0 B',
      totalUsed: '0 B',
      totalTraffic: '1 GB',
      usageProgress: 0,
      remaining: '1 GB',
      balance: '0',
      commission: '0',
      points: '0',
    ),
  );

  @override
  Future<void> refreshProfile({bool force = false}) async {}

  @override
  Future<void> refreshManagedSubscription() async => refreshes++;

  @override
  Future<void> handleUnauthorized() async => unauthorized++;
}

class _Route {
  var popped = false;
  NodeFilterCatalog? result;
}

void _setView(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<_Route> _pumpEditor(
  WidgetTester tester,
  _FakeApi api,
  _Account account,
) async {
  _setView(tester);
  final route = _Route();
  await tester.pumpWidget(
    TestApp(
      locale: const Locale('en'),
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 1600)),
        cloudNodeFilterApiProvider.overrideWithValue(api),
        cloudAccountProvider.overrideWith(() => account),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () async {
                route.result = await Navigator.of(context)
                    .push<NodeFilterCatalog>(
                      MaterialPageRoute(
                        builder: (_) => const CloudNodeFilterPage(),
                      ),
                    );
                route.popped = true;
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return route;
}

Future<void> _pumpAccountPage(
  WidgetTester tester,
  _FakeApi api, {
  int planRank = 40,
  _Account? account,
}) async {
  _setView(tester);
  SharedPreferences.setMockInitialValues({});
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pumpWidget(
    TestApp(
      locale: const Locale('en'),
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 1600)),
        cloudAccountProvider.overrideWith(
          () => account ?? _Account(planRank: planRank),
        ),
        cloudServiceHealthCheckProvider.overrideWithValue(() async {}),
        cloudNodeFilterApiProvider.overrideWithValue(api),
      ],
      child: const CloudAccountPage(),
    ),
  );
  await tester.pumpAndSettle();
}

VoidCallback? _onPressed<T extends ButtonStyleButton>(
  WidgetTester tester,
  String label,
) => tester.widget<T>(find.widgetWithText(T, label)).onPressed;

void main() {
  tearDown(() => cloudNodeFilterPageBuilder = null);

  group('oixCloud tab entry', () {
    testWidgets('is offered from plan rank 20', (tester) async {
      final api = _FakeApi(_catalog(const NodeFilter()));
      await _pumpAccountPage(tester, api, planRank: 10);
      expect(find.text('Node Filter'), findsNothing);
      expect(api.fetches, 0);

      await _pumpAccountPage(tester, api, planRank: 20);
      expect(find.text('Node Filter'), findsOneWidget);
      expect(find.text('Smart Selection'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows how many nodes a customized filter keeps', (
      tester,
    ) async {
      final api = _FakeApi(
        _catalog(const NodeFilter(includeLines: ['fusion']), kept: 2),
      );
      await _pumpAccountPage(tester, api);
      expect(find.text('Customized · 2 of 4 nodes kept'), findsOneWidget);
    });

    testWidgets('hides when the panel does not offer a filter', (tester) async {
      final api = _FakeApi(_catalog(const NodeFilter(), available: false));
      await _pumpAccountPage(tester, api);
      expect(find.text('Node Filter'), findsNothing);

      final missing = _FakeApi(_catalog(const NodeFilter()))
        ..fetchError = DioException(
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: 404),
        );
      await _pumpAccountPage(tester, missing);
      expect(find.text('Node Filter'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('takes the saved catalog back from the editor', (tester) async {
      cloudNodeFilterPageBuilder = (_) => const CloudNodeFilterPage();
      final api = _FakeApi(_catalog(const NodeFilter()));
      final account = _Account();
      await _pumpAccountPage(tester, api, account: account);

      await tester.tap(find.text('Node Filter'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('GIA'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();

      expect(find.byType(CloudNodeFilterPage), findsNothing);
      expect(find.text('Customized · 3 of 4 nodes kept'), findsOneWidget);
      expect(account.refreshes, 1);
      expect(tester.takeException(), isNull);
    });
  });

  group('node filter editor', () {
    testWidgets('chips cycle any, only and exclude', (tester) async {
      final semantics = tester.ensureSemantics();
      final api = _FakeApi(_catalog(const NodeFilter()));
      await _pumpEditor(tester, api, _Account());
      expect(find.bySemanticsLabel('GIA, Any'), findsOneWidget);

      await tester.tap(find.text('GIA'));
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('GIA, Only'), findsOneWidget);

      await tester.tap(find.text('GIA'));
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('GIA, Exclude'), findsOneWidget);

      await tester.tap(find.text('🇭🇰 Hong Kong'));
      await tester.tap(find.text('GIA'));
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('GIA, Any'), findsOneWidget);
      expect(find.bySemanticsLabel('🇭🇰 Hong Kong, Only'), findsOneWidget);

      expect(api.previews, const [
        NodeFilter(includeLines: ['gia']),
        NodeFilter(excludeLines: ['gia']),
        NodeFilter(includeRegions: ['hk']),
      ]);
      semantics.dispose();
      expect(tester.takeException(), isNull);
    });

    testWidgets('name patterns are previewed once typing pauses', (
      tester,
    ) async {
      final api = _FakeApi(_catalog(const NodeFilter()));
      await _pumpEditor(tester, api, _Account());

      await tester.enterText(
        find.widgetWithText(TextField, 'Name contains'),
        'H',
      );
      await tester.pump(const Duration(milliseconds: 200));
      await tester.enterText(
        find.widgetWithText(TextField, 'Name contains'),
        'HK',
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(api.previews, isEmpty);
      await tester.pumpAndSettle();

      expect(api.previews, const [NodeFilter(match: 'HK')]);
    });

    testWidgets('name pattern examples read as hints', (tester) async {
      final api = _FakeApi(_catalog(const NodeFilter()));
      await _pumpEditor(tester, api, _Account());
      final context = tester.element(find.byType(CloudNodeFilterPage));
      final hintColor = Theme.of(
        context,
      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.6);

      for (final label in ['Name contains', 'Name excludes']) {
        final field = tester.widget<TextField>(
          find.widgetWithText(TextField, label),
        );
        expect(field.decoration?.hintStyle?.color, hintColor, reason: label);
      }
    });

    testWidgets('a filter that keeps nothing cannot be saved', (tester) async {
      final api = _FakeApi(_catalog(const NodeFilter()))
        ..keptFor = (filter) => filter.excludeLines.contains('fusion') ? 0 : 2;
      await _pumpEditor(tester, api, _Account());
      expect(find.text('Smart Selection · 3 of 4 nodes kept'), findsOneWidget);
      expect(_onPressed<FilledButton>(tester, 'Save'), isNull);

      await tester.tap(find.text('Fusion'));
      await tester.pump();
      expect(_onPressed<FilledButton>(tester, 'Save'), isNull);
      await tester.pumpAndSettle();
      expect(find.text('Customized · 2 of 4 nodes kept'), findsOneWidget);
      expect(_onPressed<FilledButton>(tester, 'Save'), isNotNull);

      await tester.tap(find.text('Fusion'));
      await tester.pumpAndSettle();
      expect(find.text('Customized · 0 of 4 nodes kept'), findsOneWidget);
      expect(find.text('Keep at least one node'), findsOneWidget);
      expect(_onPressed<FilledButton>(tester, 'Save'), isNull);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the preview header names the state of the draft', (
      tester,
    ) async {
      final api = _FakeApi(
        _catalog(const NodeFilter(includeLines: ['gia']), kept: 1),
      )..keptFor = (filter) => filter.isEmpty ? 3 : 1;
      await _pumpEditor(tester, api, _Account());
      expect(find.text('Customized · 1 of 4 nodes kept'), findsOneWidget);

      await tester.tap(find.text('GIA'));
      await tester.pumpAndSettle();
      expect(find.text('Customized · 1 of 4 nodes kept'), findsOneWidget);

      await tester.tap(find.text('GIA'));
      await tester.pump();
      expect(find.text('Smart Selection · 1 of 4 nodes kept'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Smart Selection · 3 of 4 nodes kept'), findsOneWidget);

      await tester.enterText(
        find.widgetWithText(TextField, 'Name excludes'),
        'test',
      );
      await tester.pump();
      expect(find.text('Customized · 3 of 4 nodes kept'), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextField, 'Name excludes'),
        '  ',
      );
      await tester.pumpAndSettle();
      expect(find.text('Smart Selection · 3 of 4 nodes kept'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('save stores the edited filter and refreshes the profile', (
      tester,
    ) async {
      final api = _FakeApi(_catalog(const NodeFilter()));
      final account = _Account();
      final route = await _pumpEditor(tester, api, account);

      await tester.tap(find.text('🇯🇵 Japan'));
      await tester.tap(find.text('🇯🇵 Japan'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();

      expect(api.saves, const [
        NodeFilter(excludeRegions: ['jp']),
      ]);
      expect(account.refreshes, 1);
      expect(route.popped, isTrue);
      expect(route.result?.customized, isTrue);
      expect(tester.takeException(), isNull);
    });

    testWidgets('restore default clears a saved filter', (tester) async {
      final api = _FakeApi(
        _catalog(const NodeFilter(includeLines: ['gia']), kept: 1),
      );
      final account = _Account();
      final route = await _pumpEditor(tester, api, account);
      expect(_onPressed<FilledButton>(tester, 'Save'), isNull);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Restore Default'));
      await tester.pumpAndSettle();

      expect(api.resets, 1);
      expect(account.refreshes, 1);
      expect(route.popped, isTrue);
      expect(route.result?.customized, isFalse);
    });

    testWidgets('restore default waits for a saved filter', (tester) async {
      final api = _FakeApi(_catalog(const NodeFilter()));
      await _pumpEditor(tester, api, _Account());

      expect(_onPressed<OutlinedButton>(tester, 'Restore Default'), isNull);
    });

    testWidgets('the search narrows the preview list', (tester) async {
      final api = _FakeApi(_catalog(const NodeFilter()));
      await _pumpEditor(tester, api, _Account());
      expect(find.text('HK GIA 01'), findsOneWidget);

      await tester.enterText(
        find.widgetWithText(TextField, 'Search nodes'),
        'jp',
      );
      await tester.pumpAndSettle();

      expect(find.text('JP Edge 01'), findsOneWidget);
      expect(find.text('HK GIA 01'), findsNothing);
      expect(api.previews, isEmpty);
    });

    testWidgets('a failed load offers a retry', (tester) async {
      final api = _FakeApi(_catalog(const NodeFilter()))
        ..fetchError = const CloudApiException('Service unavailable');
      await _pumpEditor(tester, api, _Account());
      expect(find.text('Service unavailable'), findsOneWidget);

      api.fetchError = null;
      await tester.tap(find.text('Refresh'));
      await tester.pumpAndSettle();

      expect(api.fetches, 2);
      expect(find.text('Fusion'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('an expired session is handed to the account', (tester) async {
      final api = _FakeApi(_catalog(const NodeFilter()))
        ..fetchError = const CloudApiException('Unauthorized');
      final account = _Account();
      await _pumpEditor(tester, api, account);

      expect(account.unauthorized, 1);
    });
  });
}
