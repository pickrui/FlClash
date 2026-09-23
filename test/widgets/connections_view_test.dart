import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/core/interface.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/connection/connections.dart';
import 'package:fl_clash/views/connection/item.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final class _MockCoreHandler extends Mock implements CoreHandlerInterface {}

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    globalState.container = container;
  });

  tearDown(() {
    container.dispose();
  });

  List<TrackerInfo> buildConnections(int count) {
    return List.generate(
      count,
      (index) => TrackerInfo(
        id: '$index',
        start: DateTime(2024),
        metadata: Metadata(
          network: 'tcp',
          host: 'host-$index.com',
          destinationPort: '443',
        ),
        chains: const ['proxy-a'],
        rule: 'MATCH',
        rulePayload: '',
      ),
    );
  }

  Future<void> pumpConnections(
    WidgetTester tester, {
    required Future<List<TrackerInfo>> Function() connectionsReader,
    bool isPageActive = true,
    CoreController? core,
  }) async {
    tester.view.physicalSize = const Size(600, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          child: PageActivityScope(
            isActive: isPageActive,
            child: ConnectionsView(
              connectionsReader: connectionsReader,
              core: core,
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('ConnectionsView lazily builds every connection', (tester) async {
    final connections = buildConnections(100);

    await pumpConnections(tester, connectionsReader: () async => connections);
    await tester.pump();

    final builtItems = find.byType(TrackerInfoItem).evaluate().length;
    expect(builtItems, greaterThan(0));
    expect(builtItems, lessThan(connections.length));
    expect(find.text('tcp://host-0.com:443'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('tcp://host-99.com:443'),
      800,
      scrollable: find.byWidgetPredicate(
        (widget) =>
            widget is Scrollable &&
            widget.axisDirection == AxisDirection.down &&
            widget.controller != null,
      ),
    );

    expect(find.text('tcp://host-99.com:443'), findsOneWidget);
    expect(tester.takeException(), null);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('ConnectionsView polls only while the page is active', (
    tester,
  ) async {
    var readCount = 0;

    Future<List<TrackerInfo>> readConnections() async {
      readCount++;
      return const [];
    }

    await pumpConnections(
      tester,
      connectionsReader: readConnections,
      isPageActive: false,
    );
    await tester.pump(const Duration(seconds: 3));

    expect(readCount, 0);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          child: PageActivityScope(
            isActive: true,
            child: ConnectionsView(connectionsReader: readConnections),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(readCount, 1);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(readCount, 2);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          child: PageActivityScope(
            isActive: false,
            child: ConnectionsView(connectionsReader: readConnections),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 3));

    expect(readCount, 2);
    expect(tester.takeException(), null);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('ConnectionsView stops polling while the app is paused', (
    tester,
  ) async {
    var readCount = 0;

    Future<List<TrackerInfo>> readConnections() async {
      readCount++;
      return const [];
    }

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await pumpConnections(tester, connectionsReader: readConnections);
    await tester.pump();

    expect(readCount, 1);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump(const Duration(seconds: 4));

    expect(readCount, 1);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    expect(readCount, 2);
    expect(tester.takeException(), null);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('ConnectionsView refreshes only after the Core closes', (
    tester,
  ) async {
    final handler = _MockCoreHandler();
    var connections = buildConnections(3);
    var readCount = 0;
    final closeAll = Completer<bool>();
    final closeOne = Completer<bool>();
    when(() => handler.closeConnections()).thenAnswer((_) => closeAll.future);
    when(() => handler.closeConnection('0')).thenAnswer((_) => closeOne.future);

    await pumpConnections(
      tester,
      connectionsReader: () async {
        readCount++;
        return connections;
      },
      core: CoreController.forTesting(handler: handler),
    );
    await tester.pump();
    expect(readCount, 1);

    await tester.tap(find.byIcon(Icons.block).first);
    await tester.pump();
    expect(readCount, 1);

    connections = connections.sublist(1);
    closeOne.complete(true);
    await tester.pump();
    expect(readCount, 2);
    expect(find.text('tcp://host-0.com:443'), findsNothing);
    expect(find.text('tcp://host-1.com:443'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_sweep_outlined));
    await tester.pump();
    expect(readCount, 2);

    connections = const [];
    closeAll.complete(true);
    await tester.pump();
    expect(readCount, 3);
    expect(find.byType(TrackerInfoItem), findsNothing);
    expect(tester.takeException(), null);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('ConnectionsView drops a poll that ends after a later refresh', (
    tester,
  ) async {
    final handler = _MockCoreHandler();
    when(() => handler.closeConnections()).thenAnswer((_) async => true);
    final reads = <Completer<List<TrackerInfo>>>[];

    await pumpConnections(
      tester,
      connectionsReader: () {
        final read = Completer<List<TrackerInfo>>();
        reads.add(read);
        return read.future;
      },
      core: CoreController.forTesting(handler: handler),
    );
    reads.single.complete(buildConnections(3));
    await tester.pump();
    expect(find.text('tcp://host-0.com:443'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(reads, hasLength(2));

    await tester.tap(find.byIcon(Icons.delete_sweep_outlined));
    await tester.pump();
    expect(reads, hasLength(3));

    reads[2].complete(const []);
    await tester.pump();
    expect(find.byType(TrackerInfoItem), findsNothing);

    reads[1].complete(buildConnections(3));
    await tester.pump();
    expect(find.byType(TrackerInfoItem), findsNothing);
    expect(tester.takeException(), null);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalState.navigatorKey,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      builder: (context, child) {
        globalState.measure = Measure.of(context, 1);
        globalState.theme = CommonTheme.of(context, 1);
        return child!;
      },
      home: child,
    );
  }
}
