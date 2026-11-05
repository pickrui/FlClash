import 'dart:async';

import 'package:fl_clash/controller.dart';
import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/core/interface.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final class _MockCoreHandler extends Mock implements CoreHandlerInterface {}

void main() {
  const setupParams = SetupParams(
    selectedMap: {},
    testUrl: 'https://example.com',
    rawConfig: 'mixed-port: 7890',
  );
  const updateParams = UpdateParams(
    tun: Tun(),
    mixedPort: 7895,
    allowLan: false,
    findProcessMode: FindProcessMode.off,
    mode: Mode.rule,
    logLevel: LogLevel.error,
    ipv6: false,
    tcpConcurrent: true,
    externalController: '',
    secret: '',
    unifiedDelay: true,
  );
  late _MockCoreHandler handler;
  late CoreController controller;

  setUp(() {
    handler = _MockCoreHandler();
    controller = CoreController.forTesting(handler: handler);
  });

  test('delay RPCs share a budget and release slots after failure', () async {
    final pending = <Completer<Delay>>[];
    when(() => handler.asyncTestDelay(any(), any())).thenAnswer((_) {
      final result = Completer<Delay>();
      pending.add(result);
      return result.future;
    });
    final requests = List.generate(
      maxConcurrentDelayTests + 2,
      (i) => controller.getDelay('https://example.com', 'node$i'),
    );
    final firstFailure = expectLater(requests.first, throwsStateError);
    await pumpEventQueue();
    expect(pending.length, maxConcurrentDelayTests);
    pending.first.completeError(StateError('disconnected'));
    await firstFailure;
    await pumpEventQueue();
    expect(pending.length, maxConcurrentDelayTests + 1);
    pending[1].complete(
      const Delay(name: 'node1', url: 'https://example.com', value: 20),
    );
    await pumpEventQueue();
    expect(pending.length, maxConcurrentDelayTests + 2);
    for (final result in pending.skip(2)) {
      result.complete(
        const Delay(name: 'node', url: 'https://example.com', value: 30),
      );
    }
    await Future.wait(requests.skip(1));
    final last = controller.getDelay('https://example.com', 'last');
    await pumpEventQueue();
    pending.last.complete(
      const Delay(name: 'last', url: 'https://example.com', value: 40),
    );
    expect((await last).value, 40);
  });

  test('obsolete queued probes never reach the Core or hold a slot', () async {
    final pending = <Completer<Delay>>[];
    when(() => handler.asyncTestDelay(any(), any())).thenAnswer((_) {
      final result = Completer<Delay>();
      pending.add(result);
      return result.future;
    });
    final running = List.generate(
      maxConcurrentDelayTests,
      (i) => controller.getDelay('https://example.com', 'running$i'),
    );
    var current = true;
    final obsolete = List.generate(
      3,
      (i) => controller.getDelay(
        'https://example.com',
        'obsolete$i',
        isCurrent: () => current,
      ),
    );
    final replacement = controller.getDelay(
      'https://example.com',
      'replacement',
    );
    current = false;
    pending.first.complete(
      const Delay(name: 'running0', url: 'https://example.com', value: 10),
    );
    final skipped = await Future.wait(obsolete);
    await pumpEventQueue();
    expect(skipped.map((delay) => delay.value), everyElement(isNull));
    verifyNever(() => handler.asyncTestDelay(any(), 'obsolete0'));
    verifyNever(() => handler.asyncTestDelay(any(), 'obsolete1'));
    verifyNever(() => handler.asyncTestDelay(any(), 'obsolete2'));
    verify(() => handler.asyncTestDelay(any(), 'replacement')).called(1);
    expect(pending.length, maxConcurrentDelayTests + 1);
    for (final result in pending.skip(1)) {
      result.complete(
        const Delay(name: 'node', url: 'https://example.com', value: 20),
      );
    }
    await Future.wait([...running, replacement]);
  });

  test('already obsolete probes do not consume a Core request', () async {
    final delay = await controller.getDelay(
      'https://example.com',
      'node',
      isCurrent: () => false,
    );
    expect(delay.value, isNull);
    verifyNoMoreInteractions(handler);
  });

  test(
    'desktop listeners wait for the profile configuration to load',
    () async {
      final configured = Completer<String>();
      when(
        () => handler.setupConfig(setupParams),
      ).thenAnswer((_) => configured.future);
      when(() => handler.startListener()).thenAnswer((_) async => true);

      final result = controller.setupConfig(
        params: setupParams,
        preloadInvoke: () async {
          expect(await controller.startListener(), isTrue);
        },
      );
      await pumpEventQueue();

      verifyNever(() => handler.startListener());
      configured.complete('');
      expect(await result, isEmpty);
      verifyInOrder([
        () => handler.setupConfig(setupParams),
        () => handler.startListener(),
      ]);
      verifyNoMoreInteractions(handler);
    },
  );

  test('rejected configuration does not open listeners', () async {
    when(
      () => handler.setupConfig(setupParams),
    ).thenAnswer((_) async => 'invalid profile');

    final result = await controller.setupConfig(
      params: setupParams,
      preloadInvoke: () async {
        fail('listeners must not start with a rejected profile');
      },
    );

    expect(result, 'invalid profile');
    verify(() => handler.setupConfig(setupParams)).called(1);
    verifyNoMoreInteractions(handler);
  });

  test('configuration transport failures do not start listeners', () async {
    final error = StateError('core disconnected');
    when(
      () => handler.setupConfig(setupParams),
    ).thenAnswer((_) async => throw error);

    await expectLater(
      controller.setupConfig(
        params: setupParams,
        preloadInvoke: () async {
          fail('listeners must not start after a configuration failure');
        },
      ),
      throwsA(same(error)),
    );

    verify(() => handler.setupConfig(setupParams)).called(1);
    verifyNoMoreInteractions(handler);
  });

  test('port recovery updates the loaded profile before retrying', () async {
    final updateStarted = Completer<void>();
    final updated = Completer<void>();
    final events = <String>[];
    var activePort = 0;
    when(() => handler.setupConfig(setupParams)).thenAnswer((_) async {
      activePort = 7890;
      events.add('setup');
      return '';
    });
    when(() => handler.startListener()).thenAnswer((_) async {
      events.add('listen:$activePort');
      return activePort == updateParams.mixedPort;
    });
    when(() => handler.updateConfig(updateParams)).thenAnswer((_) async {
      updateStarted.complete();
      await updated.future;
      activePort = updateParams.mixedPort;
      events.add('update:$activePort');
      return '';
    });

    final result = controller.setupConfig(
      params: setupParams,
      preloadInvoke: () async {
        expect(
          await startCoreWithPortRecovery(
            shouldContinue: () => true,
            start: () async {
              if (!await controller.startListener()) {
                throw const PortConflictException('occupied');
              }
            },
            resolveConflict: () async {
              final message = await controller.updateConfig(updateParams);
              if (message.isNotEmpty) throw message;
              return true;
            },
          ),
          isTrue,
        );
      },
    );

    await updateStarted.future;
    expect(events, ['setup', 'listen:7890']);
    updated.complete();

    expect(await result, isEmpty);
    expect(events, ['setup', 'listen:7890', 'update:7895', 'listen:7895']);
    verify(() => handler.setupConfig(setupParams)).called(1);
    verify(() => handler.updateConfig(updateParams)).called(1);
    verify(() => handler.startListener()).called(2);
    verifyNoMoreInteractions(handler);
  });

  group('GEO update requests', () {
    const params = UpdateGeoDataParams(
      geoType: 'GEOIP',
      geoName: 'GEOIP.dat',
      url: 'https://example.com/geoip.dat',
    );

    test('coalesces identical requests while downloading', () async {
      final completed = Completer<String>();
      when(
        () => handler.updateGeoData(params),
      ).thenAnswer((_) => completed.future);

      final first = controller.updateGeoData(params);
      final duplicate = controller.updateGeoData(params.copyWith());

      expect(duplicate, same(first));
      completed.complete('');
      expect(await first, isEmpty);
      expect(await duplicate, isEmpty);
      verify(() => handler.updateGeoData(params)).called(1);
      verifyNoMoreInteractions(handler);
    });

    test('a different source does not reuse a pending download', () async {
      final fallback = params.copyWith(
        url: 'https://backup.example.com/geoip.dat',
      );
      final originalCompleted = Completer<String>();
      final fallbackCompleted = Completer<String>();
      when(
        () => handler.updateGeoData(params),
      ).thenAnswer((_) => originalCompleted.future);
      when(
        () => handler.updateGeoData(fallback),
      ).thenAnswer((_) => fallbackCompleted.future);

      final original = controller.updateGeoData(params);
      final recovery = controller.updateGeoData(fallback);

      expect(recovery, isNot(same(original)));
      originalCompleted.complete('TLS handshake timeout');
      expect(await original, 'TLS handshake timeout');
      expect(controller.updateGeoData(fallback.copyWith()), same(recovery));
      fallbackCompleted.complete('');
      expect(await recovery, isEmpty);
      verify(() => handler.updateGeoData(params)).called(1);
      verify(() => handler.updateGeoData(fallback)).called(1);
      verifyNoMoreInteractions(handler);
    });

    test('completion releases the request for another download', () async {
      when(() => handler.updateGeoData(params)).thenAnswer((_) async => '');

      expect(await controller.updateGeoData(params), isEmpty);
      expect(await controller.updateGeoData(params.copyWith()), isEmpty);

      verify(() => handler.updateGeoData(params)).called(2);
      verifyNoMoreInteractions(handler);
    });

    test('transport failure releases the request for retry', () async {
      final error = StateError('core disconnected');
      var attempts = 0;
      when(() => handler.updateGeoData(params)).thenAnswer((_) async {
        if (++attempts == 1) throw error;
        return '';
      });

      await expectLater(controller.updateGeoData(params), throwsA(same(error)));
      expect(await controller.updateGeoData(params.copyWith()), isEmpty);

      verify(() => handler.updateGeoData(params)).called(2);
      verifyNoMoreInteractions(handler);
    });
  });
}
