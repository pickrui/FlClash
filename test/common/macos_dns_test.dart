import 'dart:async';
import 'dart:io';

import 'package:fl_clash/common/macos_dns.dart';
import 'package:test/test.dart';

void main() {
  test(
    'restores the original service after the default network changes',
    () async {
      final system = _FakeDnsSystem();
      final controller = MacosDnsController(runProcess: system.run);
      await controller.updateDns(false);
      system.device = 'en1';
      await controller.updateDns(true);
      expect(system.dns['Wi-Fi'], ['1.1.1.1']);
      expect(system.dns['USB Ethernet'], ['9.9.9.9']);
      expect(system.writes.map((args) => args[1]), ['Wi-Fi', 'Wi-Fi']);
    },
  );

  test(
    'keeps complete service names and restores every changed service',
    () async {
      final system = _FakeDnsSystem();
      final controller = MacosDnsController(runProcess: system.run);
      await controller.updateDns(false);
      system.device = 'en1';
      await controller.updateDns(false);
      expect(system.dns['USB Ethernet'], ['9.9.9.9', '223.5.5.5']);
      await controller.updateDns(true);
      expect(system.dns, {
        'Wi-Fi': ['1.1.1.1'],
        'USB Ethernet': ['9.9.9.9'],
      });
    },
  );

  test('restoration waits for an in-flight installation', () async {
    final system = _FakeDnsSystem();
    final writeEntered = Completer<void>();
    final releaseWrite = Completer<void>();
    system.beforeWrite = () async {
      if (!writeEntered.isCompleted) {
        writeEntered.complete();
        await releaseWrite.future;
      }
    };
    final controller = MacosDnsController(runProcess: system.run);
    final apply = controller.updateDns(false);
    await writeEntered.future;
    final restore = controller.updateDns(true);
    releaseWrite.complete();
    await Future.wait([apply, restore]);
    expect(system.dns['Wi-Fi'], ['1.1.1.1']);
    expect(system.writes.length, 2);
  });

  test(
    'a network change during capture does not redirect DNS writes',
    () async {
      final system = _FakeDnsSystem();
      system.afterRead = () => system.device = 'en1';
      final controller = MacosDnsController(runProcess: system.run);
      await controller.updateDns(false);
      expect(system.dns['Wi-Fi'], ['1.1.1.1', '223.5.5.5']);
      expect(system.dns['USB Ethernet'], ['9.9.9.9']);
    },
  );

  test('repeated installation preserves the original DNS snapshot', () async {
    final system = _FakeDnsSystem();
    final controller = MacosDnsController(runProcess: system.run);
    await controller.updateDns(false);
    await controller.updateDns(false);
    await controller.updateDns(true);
    expect(system.dns['Wi-Fi'], ['1.1.1.1']);
    expect(system.writes.length, 2);
  });

  test('restoration preserves DNS changed outside FlClash', () async {
    final system = _FakeDnsSystem();
    final controller = MacosDnsController(runProcess: system.run);
    await controller.updateDns(false);
    system.dns['Wi-Fi'] = ['8.8.8.8'];
    await controller.updateDns(true);
    expect(system.dns['Wi-Fi'], ['8.8.8.8']);
    expect(system.writes.length, 1);
  });

  test(
    'restores DHCP DNS with Empty and leaves preexisting added DNS alone',
    () async {
      final system = _FakeDnsSystem()..dns['Wi-Fi'] = [];
      final controller = MacosDnsController(runProcess: system.run);
      await controller.updateDns(false);
      await controller.updateDns(true);
      expect(system.writes.last, ['-setdnsservers', 'Wi-Fi', 'Empty']);
      system.dns['Wi-Fi'] = ['223.5.5.5'];
      await controller.updateDns(false);
      await controller.updateDns(true);
      expect(system.writes.length, 2);
      expect(system.dns['Wi-Fi'], ['223.5.5.5']);
    },
  );

  test(
    'failed restoration remains retryable and restores other services',
    () async {
      final system = _FakeDnsSystem();
      final controller = MacosDnsController(runProcess: system.run);
      await controller.updateDns(false);
      system.device = 'en1';
      await controller.updateDns(false);
      system.failingService = 'Wi-Fi';
      await expectLater(controller.updateDns(true), throwsStateError);
      expect(system.dns['USB Ethernet'], ['9.9.9.9']);
      system.failingService = null;
      await controller.updateDns(true);
      expect(system.dns['Wi-Fi'], ['1.1.1.1']);
    },
  );

  test(
    'a failed installation can be retried without breaking the queue',
    () async {
      final system = _FakeDnsSystem()..failingService = 'Wi-Fi';
      final controller = MacosDnsController(runProcess: system.run);
      await expectLater(controller.updateDns(false), throwsStateError);
      system.failingService = null;
      await controller.updateDns(false);
      await controller.updateDns(true);
      expect(system.dns['Wi-Fi'], ['1.1.1.1']);
    },
  );

  test('invalid command output never becomes a DNS write', () async {
    final system = _FakeDnsSystem()..readOutput = 'networksetup failed';
    final controller = MacosDnsController(runProcess: system.run);
    await expectLater(controller.updateDns(false), throwsStateError);
    expect(system.writes, isEmpty);
  });

  test('a disabled service never reuses the previous service name', () async {
    final system = _FakeDnsSystem()
      ..device = 'en1'
      ..serviceOrder = '''
(1) Wi-Fi
(Hardware Port: Wi-Fi, Device: en0)
(*) USB Ethernet
(Hardware Port: USB LAN, Device: en1)
''';
    final controller = MacosDnsController(runProcess: system.run);
    await controller.updateDns(false);
    expect(system.writes, isEmpty);
  });
}

class _FakeDnsSystem {
  String device = 'en0';
  String? failingService;
  String? readOutput;
  String? serviceOrder;
  Future<void> Function()? beforeWrite;
  void Function()? afterRead;
  final dns = <String, List<String>>{
    'Wi-Fi': ['1.1.1.1'],
    'USB Ethernet': ['9.9.9.9'],
  };
  final writes = <List<String>>[];

  Future<ProcessResult> run(String executable, List<String> arguments) async {
    if (executable == '/sbin/route') {
      return ProcessResult(1, 0, '  interface: $device\n', '');
    }
    expect(executable, '/usr/sbin/networksetup');
    switch (arguments.first) {
      case '-listnetworkserviceorder':
        return ProcessResult(
          1,
          0,
          serviceOrder ??
              '''
An asterisk (*) denotes that a network service is disabled.
(1) Wi-Fi
(Hardware Port: Wi-Fi, Device: en0)
(2) USB Ethernet
(Hardware Port: USB LAN, Device: en1)
''',
          '',
        );
      case '-getdnsservers':
        final values = dns[arguments[1]]!;
        afterRead?.call();
        return ProcessResult(
          1,
          0,
          readOutput ??
              (values.isEmpty
                  ? "There aren't any DNS Servers set on ${arguments[1]}."
                  : values.join('\n')),
          '',
        );
      case '-setdnsservers':
        await beforeWrite?.call();
        writes.add(List.of(arguments));
        if (arguments[1] == failingService) {
          return ProcessResult(1, 1, '', 'failed');
        }
        dns[arguments[1]] = arguments[2] == 'Empty' ? [] : arguments.sublist(2);
        return ProcessResult(1, 0, '', '');
      default:
        fail('unexpected command: $arguments');
    }
  }
}
