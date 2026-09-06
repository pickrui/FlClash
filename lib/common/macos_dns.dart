import 'dart:io';

typedef DnsProcessRunner =
    Future<ProcessResult> Function(String executable, List<String> arguments);

class MacosDnsController {
  final DnsProcessRunner _runProcess;
  final _overrides = <String, ({List<String> before, List<String> applied})>{};
  Future<void> _pending = Future.value();

  MacosDnsController({DnsProcessRunner? runProcess})
    : _runProcess =
          runProcess ?? ((command, args) => Process.run(command, args));

  Future<void> updateDns(bool restore) {
    final operation = _pending.then((_) => restore ? _restore() : _apply());
    _pending = operation.then<void>((_) {}, onError: (_, _) {});
    return operation;
  }

  Future<String?> get defaultServiceName async {
    final route = await _runProcess('/sbin/route', ['-n', 'get', 'default']);
    if (route.exitCode != 0) return null;
    final device = RegExp(
      r'^\s*interface:\s*(\S+)\s*$',
      multiLine: true,
    ).firstMatch(route.stdout.toString())?.group(1);
    if (device == null) return null;
    final result = await _runProcess('/usr/sbin/networksetup', [
      '-listnetworkserviceorder',
    ]);
    if (result.exitCode != 0) return null;
    String? service;
    for (final line in result.stdout.toString().split('\n')) {
      final heading = RegExp(r'^\((\d+|\*)\)\s+(.+)$').firstMatch(line.trim());
      if (heading != null) {
        service = heading.group(1) == '*' ? null : heading.group(2)!.trim();
        continue;
      }
      final serviceDevice = RegExp(r'Device:\s*([^,)]+)').firstMatch(line);
      if (serviceDevice?.group(1)?.trim() == device &&
          service != null &&
          !service.startsWith('*')) {
        return service;
      }
    }
    return null;
  }

  Future<List<String>> _readDns(String service) async {
    final result = await _runProcess('/usr/sbin/networksetup', [
      '-getdnsservers',
      service,
    ]);
    if (result.exitCode != 0) {
      throw StateError('Unable to read system DNS for $service');
    }
    final output = result.stdout.toString().trim();
    if (output.startsWith("There aren't any DNS Servers set on")) return [];
    final dns = output.split('\n').map((value) => value.trim()).toList();
    if (dns.any((value) => InternetAddress.tryParse(value) == null)) {
      throw StateError('Invalid system DNS response for $service');
    }
    return dns;
  }

  Future<void> _writeDns(String service, List<String> dns) async {
    final result = await _runProcess('/usr/sbin/networksetup', [
      '-setdnsservers',
      service,
      if (dns.isEmpty) 'Empty' else ...dns,
    ]);
    if (result.exitCode != 0) {
      throw StateError('Unable to update system DNS for $service');
    }
  }

  Future<void> _apply() async {
    final service = await defaultServiceName;
    if (service == null) return;
    final current = await _readDns(service);
    const addedDns = '223.5.5.5';
    if (current.contains(addedDns)) return;
    final applied = [...current, addedDns];
    // Keep the original target and values even if the default network changes.
    _overrides[service] = (before: current, applied: applied);
    await _writeDns(service, applied);
  }

  Future<void> _restore() async {
    Object? firstError;
    StackTrace? firstStackTrace;
    for (final entry in _overrides.entries.toList()) {
      try {
        final current = await _readDns(entry.key);
        final applied = entry.value.applied;
        final stillOwned =
            current.length == applied.length &&
            Iterable<int>.generate(
              current.length,
            ).every((index) => current[index] == applied[index]);
        if (stillOwned) await _writeDns(entry.key, entry.value.before);
        _overrides.remove(entry.key);
      } catch (error, stackTrace) {
        firstError ??= error;
        firstStackTrace ??= stackTrace;
      }
    }
    if (firstError != null) {
      Error.throwWithStackTrace(firstError, firstStackTrace!);
    }
  }
}
