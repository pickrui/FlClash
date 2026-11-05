import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fl_clash/manager/connectivity_manager.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cold lookup, stale Wi-Fi result, and same-transport roaming', (
    tester,
  ) async {
    final c = ProviderContainer();
    addTearDown(c.dispose);
    c
        .read(networkSettingProvider.notifier)
        .update((s) => s.copyWith(excludeSSIDs: ['Home']));
    final events = StreamController<List<ConnectivityResult>>();
    addTearDown(events.close);
    var transport = [ConnectivityResult.wifi];
    var name = 'Home';
    Completer<String?>? pending;
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: ConnectivityManager(
          connectivityStream: events.stream,
          checkConnectivity: () async => transport,
          readSsid: () => pending?.future ?? Future.value(name),
          child: const SizedBox(),
        ),
      ),
    );
    await tester.pump();
    expect(c.read(suspendProvider), true);
    pending = Completer();
    events.add([ConnectivityResult.wifi]);
    await tester.pump();
    transport = [ConnectivityResult.mobile];
    events.add(transport);
    await tester.pump();
    pending.complete('Home');
    await tester.pump();
    expect(c.read(currentSSIDProvider), isNull);
    expect(c.read(suspendProvider), false);
    pending = null;
    transport = [ConnectivityResult.wifi];
    events.add(transport);
    await tester.pump();
    expect(c.read(suspendProvider), true);
    name = 'Other';
    await tester.pump(const Duration(seconds: 10));
    await tester.pump();
    expect(c.read(currentSSIDProvider), 'Other');
    expect(c.read(suspendProvider), false);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'disabled policy never requests location data, failure and unknown are empty',
    (tester) async {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      var reads = 0;
      var fail = false;
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: ConnectivityManager(
            connectivityStream: const Stream.empty(),
            checkConnectivity: () async => [ConnectivityResult.wifi],
            readSsid: () async {
              reads++;
              if (fail) throw StateError('denied');
              return '<unknown ssid>';
            },
            child: const SizedBox(),
          ),
        ),
      );
      await tester.pump();
      expect(reads, 0);
      c
          .read(networkSettingProvider.notifier)
          .update((s) => s.copyWith(excludeSSIDs: ['Home']));
      await tester.pump();
      expect(reads, 1);
      expect(c.read(currentSSIDProvider), isNull);
      fail = true;
      c.read(ssidRefreshProvider.notifier).update((v) => v + 1);
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(c.read(currentSSIDProvider), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
