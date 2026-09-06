import 'dart:async';

import 'package:fl_clash/controller.dart';
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
}
