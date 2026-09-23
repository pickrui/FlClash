import 'dart:async';
import 'dart:io';

import 'package:fl_clash/controller.dart';
import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/core/interface.dart';
import 'package:fl_clash/core/method.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

final class _MockCoreHandler extends Mock implements CoreHandlerInterface {}

void main() {
  late Directory tempDirectory;
  setUpAll(() async {
    registerFallbackValue(Duration.zero);
    tempDirectory = await Directory.systemTemp.createTemp('core-controller-');
    PathProviderPlatform.instance = _TempPaths(tempDirectory.path);
  });
  tearDownAll(() => tempDirectory.delete(recursive: true));
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

  test(
    'a custom probe budget reaches the Core after acquiring a shared slot',
    () async {
      when(
        () => handler.asyncTestDelay(
          any(),
          any(),
          timeout: any(named: 'timeout'),
          generation: any(named: 'generation'),
          session: any(named: 'session'),
        ),
      ).thenAnswer(
        (_) async => const Delay(name: 'node', url: 'url', value: 6000),
      );
      final delay = await controller.getDelay(
        'https://example.com',
        'node',
        timeout: const Duration(seconds: 15),
      );
      expect(delay.value, 6000);
      verify(
        () => handler.asyncTestDelay(
          'https://example.com',
          'node',
          timeout: const Duration(seconds: 15),
          generation: any(named: 'generation'),
          session: any(named: 'session'),
        ),
      ).called(1);
    },
  );

  test(
    'probe sessions are stable per frontend and distinct after recreation',
    () async {
      final sessions = <String>[];
      when(
        () => handler.asyncTestDelay(
          any(),
          any(),
          timeout: any(named: 'timeout'),
          generation: any(named: 'generation'),
          session: any(named: 'session'),
        ),
      ).thenAnswer((invocation) async {
        sessions.add(invocation.namedArguments[#session] as String);
        return const Delay(name: 'node', url: 'url', value: 20);
      });
      await controller.getDelay('url', 'node', generation: 100);
      await controller.getDelay('url', 'node', generation: 101);
      final recreated = CoreController.forTesting(handler: handler);
      await recreated.getDelay('url', 'node', generation: 1);
      expect(sessions[0], isNotEmpty);
      expect(sessions[1], sessions[0]);
      expect(sessions[2], isNot(sessions[0]));
    },
  );

  test('a full batch leaves room for its replacement to cancel it', () async {
    final pending = <Completer<Delay>>[];
    var replacementProbes = 0;
    const result = Delay(name: 'node', url: 'url', value: 20);
    void cancelPrevious() {
      for (final probe in pending) {
        if (!probe.isCompleted) probe.complete(result);
      }
    }

    when(
      () => handler.asyncTestDelay(
        any(),
        any(),
        timeout: any(named: 'timeout'),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    ).thenAnswer((invocation) {
      if (invocation.namedArguments[#generation] == 1) {
        final probe = Completer<Delay>();
        pending.add(probe);
        return probe.future;
      }
      replacementProbes++;
      cancelPrevious();
      return Future.value(result);
    });
    var current = 1;
    final previous = List.generate(
      maxConcurrentDelayTests,
      (i) => controller.getDelay(
        'url',
        'old$i',
        generation: 1,
        isCurrent: () => current == 1,
      ),
    );
    expect(pending.length, maxConcurrentDelayTests);
    current = 2;
    final replacement = List.generate(
      maxConcurrentDelayTests,
      (i) => controller.getDelay(
        'url',
        'new$i',
        generation: 2,
        isCurrent: () => current == 2,
      ),
    );
    try {
      await pumpEventQueue();
      expect(replacementProbes, maxConcurrentDelayTests);
    } finally {
      cancelPrevious();
      await Future.wait([...previous, ...replacement]);
    }
  });

  test('delay RPCs share a budget and release slots after failure', () async {
    final pending = <Completer<Delay>>[];
    when(
      () => handler.asyncTestDelay(
        any(),
        any(),
        timeout: any(named: 'timeout'),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    ).thenAnswer((_) {
      final result = Completer<Delay>();
      pending.add(result);
      return result.future;
    });
    final requests = List.generate(
      maxInFlightDelayTests + 2,
      (i) => controller.getDelay('https://example.com', 'node$i'),
    );
    final firstFailure = expectLater(requests.first, throwsStateError);
    await pumpEventQueue();
    expect(pending.length, maxInFlightDelayTests);
    pending.first.completeError(StateError('disconnected'));
    await firstFailure;
    await pumpEventQueue();
    expect(pending.length, maxInFlightDelayTests + 1);
    pending[1].complete(
      const Delay(name: 'node1', url: 'https://example.com', value: 20),
    );
    await pumpEventQueue();
    expect(pending.length, maxInFlightDelayTests + 2);
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

  testWidgets('time waiting for a shared slot does not shorten a probe', (
    tester,
  ) async {
    final pending = <Completer<Delay>>[];
    when(
      () => handler.asyncTestDelay(
        any(),
        any(),
        timeout: any(named: 'timeout'),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    ).thenAnswer((_) {
      final result = Completer<Delay>();
      pending.add(result);
      return result.future;
    });
    final requests = List.generate(
      maxInFlightDelayTests + 1,
      (i) => controller.getDelay('https://example.com', 'node$i'),
    );
    await tester.pump(const Duration(seconds: 20));
    expect(pending.length, maxInFlightDelayTests);
    pending.first.complete(
      const Delay(name: 'node0', url: 'https://example.com', value: 20),
    );
    await tester.pump();
    expect(pending.length, maxInFlightDelayTests + 1);
    verify(
      () => handler.asyncTestDelay(
        'https://example.com',
        'node$maxInFlightDelayTests',
        timeout: const Duration(seconds: 8),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    ).called(1);
    for (final result in pending.skip(1)) {
      result.complete(
        const Delay(name: 'node', url: 'https://example.com', value: 20),
      );
    }
    await Future.wait(requests);
  });

  test('obsolete queued probes never reach the Core or hold a slot', () async {
    final pending = <Completer<Delay>>[];
    when(
      () => handler.asyncTestDelay(
        any(),
        any(),
        timeout: any(named: 'timeout'),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    ).thenAnswer((_) {
      final result = Completer<Delay>();
      pending.add(result);
      return result.future;
    });
    final running = List.generate(
      maxInFlightDelayTests,
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
    verifyNever(
      () => handler.asyncTestDelay(
        any(),
        'obsolete0',
        timeout: any(named: 'timeout'),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    );
    verifyNever(
      () => handler.asyncTestDelay(
        any(),
        'obsolete1',
        timeout: any(named: 'timeout'),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    );
    verifyNever(
      () => handler.asyncTestDelay(
        any(),
        'obsolete2',
        timeout: any(named: 'timeout'),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    );
    verify(
      () => handler.asyncTestDelay(
        any(),
        'replacement',
        timeout: any(named: 'timeout'),
        generation: any(named: 'generation'),
        session: any(named: 'session'),
      ),
    ).called(1);
    expect(pending.length, maxInFlightDelayTests + 1);
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

  test('a failed detached Core call is logged, not left unhandled', () async {
    when(() => handler.closeConnections()).thenAnswer(
      (_) async => throw const CoreMethodException(
        code: 'transport_disconnected',
        message: 'Core transport disconnected',
      ),
    );

    controller.closeConnections();
    await pumpEventQueue();

    verify(() => handler.closeConnections()).called(1);
  });

  test(
    'validating edited data removes its temporary copy on failure',
    () async {
      String? validatedPath;
      var copyWritten = false;
      when(() => handler.validateConfig(any())).thenAnswer((invocation) async {
        validatedPath = invocation.positionalArguments.single as String;
        copyWritten = File(validatedPath!).existsSync();
        throw const CoreMethodException(
          code: 'transport_disconnected',
          message: 'Core transport disconnected',
        );
      });

      await expectLater(
        controller.validateConfigWithData('proxies: []'),
        throwsA(isA<CoreMethodException>()),
      );

      expect(validatedPath, startsWith(tempDirectory.path));
      expect(copyWritten, isTrue);
      expect(File(validatedPath!).existsSync(), isFalse);
    },
  );
}

class _TempPaths extends PathProviderPlatform {
  _TempPaths(this.path);

  final String path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getTemporaryPath() async => path;

  @override
  Future<String?> getDownloadsPath() async => path;
}
