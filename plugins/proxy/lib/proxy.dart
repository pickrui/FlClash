import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import 'proxy_platform_interface.dart';

enum ProxyTypes { http, https, socks }

typedef ProxyProcessRunner = Future<ProcessResult> Function(
  String executable,
  List<String> arguments, {
  bool runInShell,
});

typedef ProxyExecutableChecker = Future<bool> Function(String executable);

@immutable
class ProxyCommand {
  final String executable;
  final List<String> args;
  final bool runInShell;

  const ProxyCommand(this.executable, this.args, {this.runInShell = false});
}

enum LinuxProxyBackend { gnome, mate, kde }

enum _RestoreSnapshotStatus { absent, loaded, invalid }

typedef _RestoreSnapshot = ({
  _RestoreSnapshotStatus status,
  List<ProxyCommand>? commands,
  List<ProxyCommand>? managedCommands,
  List<ProxyCommand>? pendingCommands,
});

@immutable
class _MacosProxyState {
  final bool enabled;
  final String server;
  final String port;
  final bool authenticated;

  const _MacosProxyState({
    required this.enabled,
    required this.server,
    required this.port,
    required this.authenticated,
  });
}

@immutable
class _MacosAutoProxyState {
  final bool enabled;
  final String url;

  const _MacosAutoProxyState({required this.enabled, required this.url});
}

class Proxy extends ProxyPlatform {
  static String url = '127.0.0.1';

  final ProxyProcessRunner _processRunner;
  final ProxyExecutableChecker _executableChecker;
  final String? _stateFilePath;
  List<ProxyCommand>? _restoreCommands;
  List<ProxyCommand>? _managedCommands;
  List<ProxyCommand>? _pendingCommands;

  Proxy({
    ProxyProcessRunner? processRunner,
    ProxyExecutableChecker? executableChecker,
    String? stateFilePath,
  })  : _processRunner = processRunner ?? Process.run,
        _executableChecker = executableChecker ?? _hasExecutable,
        _stateFilePath = stateFilePath ??
            (processRunner == null ? _defaultStateFilePath() : null);

  @override
  Future<bool?> startProxy(
    int port, [
    List<String> bypassDomain = const [],
  ]) async {
    return switch (Platform.operatingSystem) {
      'macos' => await _startProxyWithMacos(port, bypassDomain),
      'linux' => await _startProxyWithLinux(port, bypassDomain),
      'windows' => await ProxyPlatform.instance.startProxy(port, bypassDomain),
      String() => false,
    };
  }

  @override
  Future<bool?> stopProxy() async {
    return switch (Platform.operatingSystem) {
      'macos' || 'linux' => await _restoreProxyState(),
      'windows' => await ProxyPlatform.instance.stopProxy(),
      String() => false,
    };
  }

  Future<bool> _startProxyWithLinux(int port, List<String> bypassDomain) async {
    final homeDir = Platform.environment['HOME'];
    if (homeDir == null || homeDir.isEmpty) {
      return false;
    }
    return _startProxyWithLinuxEnvironment(
      port,
      bypassDomain,
      desktop: Platform.environment['XDG_CURRENT_DESKTOP'],
      homeDir: homeDir,
      configHome: Platform.environment['XDG_CONFIG_HOME'],
    );
  }

  Future<bool> _startProxyWithLinuxEnvironment(
    int port,
    List<String> bypassDomain, {
    required String? desktop,
    required String homeDir,
    String? configHome,
  }) async {
    if ((_restoreCommands == null || _pendingCommands != null) &&
        !await _restoreProxyState()) {
      return false;
    }
    final backend = await _resolveLinuxBackend(desktop);
    if (backend == null) {
      return false;
    }
    String kdeConfigWriter = 'kwriteconfig5';
    String kdeConfigReader = 'kreadconfig5';
    if (backend == LinuxProxyBackend.kde) {
      final tools = await _resolveKdeConfigTools();
      if (tools == null) {
        return false;
      }
      kdeConfigWriter = tools.$1;
      kdeConfigReader = tools.$2;
    }
    final restoreCommands = switch (backend) {
      LinuxProxyBackend.gnome => await _captureGSettingsRestoreCommands(
          'org.gnome.system.proxy',
        ),
      LinuxProxyBackend.mate => await _captureGSettingsRestoreCommands(
          'org.mate.system.proxy',
        ),
      LinuxProxyBackend.kde => await _captureKdeRestoreCommands(
          configHome: configHome,
          homeDir: homeDir,
          reader: kdeConfigReader,
          writer: kdeConfigWriter,
        ),
    };
    if (restoreCommands == null) {
      return false;
    }
    final commands = _buildLinuxStartCommands(
      port: port,
      bypassDomain: bypassDomain,
      desktop: desktop,
      homeDir: homeDir,
      configHome: configHome,
      backend: backend,
      kdeConfigWriter: kdeConfigWriter,
    );
    return _applyProxyState(commands, restoreCommands);
  }

  Future<bool> _startProxyWithMacos(int port, List<String> bypassDomain) async {
    if ((_restoreCommands == null || _pendingCommands != null) &&
        !await _restoreProxyState()) {
      return false;
    }
    final services = await _getNetworkServicesWithMacos();
    if (services == null || services.isEmpty) {
      return false;
    }
    final managedServices = _restoreCommands == null
        ? services
        : services.where(_isCapturedMacosService).toList();
    if (managedServices.isEmpty) {
      return false;
    }
    final restoreCommands = await _captureMacosRestoreCommands(managedServices);
    if (restoreCommands == null) {
      return false;
    }
    return _applyProxyState(
      managedServices.expand(
        (service) => _buildMacosStartCommands(service, port, bypassDomain),
      ),
      restoreCommands,
    );
  }

  Future<bool> _applyProxyState(
    Iterable<ProxyCommand> commands,
    List<ProxyCommand> rollbackCommands,
  ) async {
    final appliedCommands = commands.toList();
    final ownsProxy = _restoreCommands != null;
    final previousRestore = _restoreCommands;
    final previousManaged = _managedCommands;
    if (!await _persistRestoreCommands(
      previousRestore ?? rollbackCommands,
      previousManaged,
      appliedCommands,
    )) {
      return false;
    }
    _restoreCommands = previousRestore ?? rollbackCommands;
    _pendingCommands = appliedCommands;
    if (await _runCommands(appliedCommands)) {
      if (!await _persistRestoreCommands(
        _restoreCommands!,
        appliedCommands,
        null,
      )) {
        await _rollbackProxyTransition(
          rollbackCommands,
          ownsProxy: ownsProxy,
          previousRestore: previousRestore,
          previousManaged: previousManaged,
        );
        return false;
      }
      _managedCommands = appliedCommands;
      _pendingCommands = null;
      return true;
    }
    await _rollbackProxyTransition(
      rollbackCommands,
      ownsProxy: ownsProxy,
      previousRestore: previousRestore,
      previousManaged: previousManaged,
    );
    return false;
  }

  Future<bool> _rollbackProxyTransition(
    List<ProxyCommand> rollbackCommands, {
    required bool ownsProxy,
    required List<ProxyCommand>? previousRestore,
    required List<ProxyCommand>? previousManaged,
  }) async {
    final rolledBack = await _runCommands(
      rollbackCommands,
      continueOnError: true,
    );
    if (!rolledBack) return false;
    if (ownsProxy) {
      if (!await _persistRestoreCommands(
        previousRestore!,
        previousManaged,
        null,
      )) {
        return false;
      }
      _restoreCommands = previousRestore;
      _managedCommands = previousManaged;
      _pendingCommands = null;
      return true;
    }
    if (!await _clearPersistedRestoreCommands()) return false;
    _restoreCommands = null;
    _managedCommands = null;
    _pendingCommands = null;
    return true;
  }

  Future<bool> _restoreProxyState() async {
    final snapshot = _restoreCommands == null
        ? await _loadRestoreCommands()
        : (
            status: _RestoreSnapshotStatus.loaded,
            commands: _restoreCommands,
            managedCommands: _managedCommands,
            pendingCommands: _pendingCommands,
          );
    if (snapshot.status == _RestoreSnapshotStatus.invalid) {
      return false;
    }
    var commands = snapshot.commands;
    if (commands == null) {
      return true;
    }
    var managedCommands = snapshot.managedCommands;
    var pendingCommands = snapshot.pendingCommands;
    Set<String> unavailableKeys = <String>{};
    Set<String>? matchingKeys;
    if (managedCommands != null || pendingCommands != null) {
      final state = await _matchManagedCommandStates(
        managedCommands ?? pendingCommands!,
        alternateCommands: managedCommands == null ? null : pendingCommands,
      );
      if (state == null) {
        return false;
      }
      matchingKeys = state.matchingKeys;
      unavailableKeys = state.unavailableKeys;
    }
    final managedByKey = <String, ProxyCommand>{};
    for (final command in managedCommands ?? const <ProxyCommand>[]) {
      final key = _commandStateKey(command);
      if (key == null || managedByKey.containsKey(key)) {
        return false;
      }
      managedByKey[key] = command;
    }
    final pendingByKey = <String, ProxyCommand>{};
    for (final command in pendingCommands ?? const <ProxyCommand>[]) {
      final key = _commandStateKey(command);
      if (key == null || pendingByKey.containsKey(key)) return false;
      pendingByKey[key] = command;
    }
    final remainingCommands = <ProxyCommand>[];
    final remainingManaged = <ProxyCommand>[];
    final remainingPending = <ProxyCommand>[];
    for (final command in commands) {
      final key = _commandStateKey(command);
      if (managedCommands != null && key == null) {
        return false;
      }
      if (key != null && unavailableKeys.contains(key)) {
        remainingCommands.add(command);
        final managed = managedByKey[key];
        if (managed != null) remainingManaged.add(managed);
        final pending = pendingByKey[key];
        if (pending != null) remainingPending.add(pending);
        continue;
      }
      if (matchingKeys != null &&
          (key == null || !matchingKeys.contains(key))) {
        continue;
      }
      if (!await _runCommands([command])) {
        remainingCommands.add(command);
        final managed = key == null ? null : managedByKey[key];
        if (managed != null) remainingManaged.add(managed);
        final pending = key == null ? null : pendingByKey[key];
        if (pending != null) remainingPending.add(pending);
      }
    }
    if (remainingCommands.isEmpty) {
      if (!await _clearPersistedRestoreCommands()) {
        _restoreCommands = commands;
        _managedCommands = managedCommands;
        return false;
      }
      _restoreCommands = null;
      _managedCommands = null;
      _pendingCommands = null;
      return true;
    }
    final nextManaged = managedCommands == null || remainingManaged.isEmpty
        ? null
        : remainingManaged;
    final nextPending = pendingCommands == null || remainingPending.isEmpty
        ? null
        : remainingPending;
    if (!await _persistRestoreCommands(
      remainingCommands,
      nextManaged,
      nextPending,
    )) {
      _restoreCommands = commands;
      _managedCommands = managedCommands;
      _pendingCommands = pendingCommands;
      return false;
    }
    _restoreCommands = remainingCommands;
    _managedCommands = nextManaged;
    _pendingCommands = nextPending;
    return false;
  }

  bool _isCapturedMacosService(String service) {
    final commands = _restoreCommands;
    return commands != null &&
        commands.any(
          (command) =>
              command.executable == '/usr/sbin/networksetup' &&
              command.args.length > 1 &&
              command.args[1] == service,
        );
  }

  Future<bool> _persistRestoreCommands(
    List<ProxyCommand> commands,
    List<ProxyCommand>? managedCommands,
    List<ProxyCommand>? pendingCommands,
  ) async {
    final path = _stateFilePath;
    if (path == null) {
      return true;
    }
    final file = File(path);
    final temporary = File('$path.tmp');
    try {
      if (!_validateRestoreCommands(commands)) {
        return false;
      }
      if (managedCommands != null &&
          !_validateRestoreCommands(managedCommands)) {
        return false;
      }
      if (pendingCommands != null &&
          !_validateRestoreCommands(pendingCommands)) {
        return false;
      }
      final directoryExisted = await file.parent.exists();
      await file.parent.create(recursive: true);
      if (!directoryExisted) {
        await _syncDirectory(file.parent.parent.path);
      }
      if (!await _setPermissions(file.parent.path, '700')) {
        return false;
      }
      final data = jsonEncode({
        'version': 3,
        'restoreCommands': commands
            .map((command) => {
                  'executable': command.executable,
                  'args': command.args,
                })
            .toList(),
        'managedCommands': managedCommands
            ?.map((command) => {
                  'executable': command.executable,
                  'args': command.args,
                })
            .toList(),
        'pendingCommands': pendingCommands
            ?.map((command) => {
                  'executable': command.executable,
                  'args': command.args,
                })
            .toList(),
      });
      if (utf8.encode(data).length > 1024 * 1024) {
        return false;
      }
      await temporary.writeAsString(data, flush: true);
      if (!await _setPermissions(temporary.path, '600')) {
        await temporary.delete();
        return false;
      }
      await _durableRename(temporary.path, path);
      return true;
    } catch (_) {
      if (await temporary.exists()) {
        await temporary.delete();
      }
      return false;
    }
  }

  Future<_RestoreSnapshot> _loadRestoreCommands() async {
    final path = _stateFilePath;
    if (path == null) {
      return (
        status: _RestoreSnapshotStatus.absent,
        commands: null,
        managedCommands: null,
        pendingCommands: null,
      );
    }
    final file = File(path);
    try {
      final type = await FileSystemEntity.type(path, followLinks: false);
      if (type == FileSystemEntityType.notFound) {
        return (
          status: _RestoreSnapshotStatus.absent,
          commands: null,
          managedCommands: null,
          pendingCommands: null,
        );
      }
      if (type != FileSystemEntityType.file ||
          await file.length() > 1024 * 1024) {
        return (
          status: _RestoreSnapshotStatus.invalid,
          commands: null,
          managedCommands: null,
          pendingCommands: null,
        );
      }
      final stat = await file.stat();
      if (stat.mode & 0x3f != 0) {
        return (
          status: _RestoreSnapshotStatus.invalid,
          commands: null,
          managedCommands: null,
          pendingCommands: null,
        );
      }
      final value = jsonDecode(await file.readAsString());
      if (value is! Map || value['version'] is! int) {
        return (
          status: _RestoreSnapshotStatus.invalid,
          commands: null,
          managedCommands: null,
          pendingCommands: null,
        );
      }
      final version = value['version'] as int;
      final rawCommands = switch (version) {
        1 => value['commands'],
        2 || 3 => value['restoreCommands'],
        _ => null,
      };
      if (rawCommands is! List) {
        return (
          status: _RestoreSnapshotStatus.invalid,
          commands: null,
          managedCommands: null,
          pendingCommands: null,
        );
      }
      if (rawCommands.isEmpty || rawCommands.length > 512) {
        return (
          status: _RestoreSnapshotStatus.invalid,
          commands: null,
          managedCommands: null,
          pendingCommands: null,
        );
      }
      List<ProxyCommand>? parseCommands(Object? rawValue) {
        if (rawValue is! List || rawValue.isEmpty || rawValue.length > 512) {
          return null;
        }
        final parsed = <ProxyCommand>[];
        for (final raw in rawValue) {
          if (raw is! Map ||
              raw['executable'] is! String ||
              raw['args'] is! List) {
            return null;
          }
          final executable = raw['executable'] as String;
          final args = (raw['args'] as List).whereType<String>().toList();
          if (args.length != (raw['args'] as List).length ||
              args.length > 4096 ||
              args.any((argument) => argument.length > 4096) ||
              !_isAllowedRestoreCommand(executable, args)) {
            return null;
          }
          parsed.add(ProxyCommand(executable, args));
        }
        return parsed;
      }

      final commands = parseCommands(rawCommands);
      final managedCommands = version >= 2 && value['managedCommands'] != null
          ? parseCommands(value['managedCommands'])
          : null;
      final pendingCommands = version >= 3 && value['pendingCommands'] != null
          ? parseCommands(value['pendingCommands'])
          : null;
      if (commands == null ||
          (version >= 2 &&
              value['managedCommands'] != null &&
              managedCommands == null) ||
          (version >= 3 &&
              value['pendingCommands'] != null &&
              pendingCommands == null)) {
        return (
          status: _RestoreSnapshotStatus.invalid,
          commands: null,
          managedCommands: null,
          pendingCommands: null,
        );
      }
      return (
        status: _RestoreSnapshotStatus.loaded,
        commands: commands,
        managedCommands: managedCommands,
        pendingCommands: pendingCommands,
      );
    } catch (_) {
      return (
        status: _RestoreSnapshotStatus.invalid,
        commands: null,
        managedCommands: null,
        pendingCommands: null,
      );
    }
  }

  Future<({Set<String> matchingKeys, Set<String> unavailableKeys})?>
      _matchManagedCommandStates(
    List<ProxyCommand> commands, {
    List<ProxyCommand>? alternateCommands,
  }) async {
    try {
      final expected = _commandStateMap(commands);
      if (expected.length != commands.length) return null;
      final alternate = alternateCommands == null
          ? const <String, String>{}
          : _commandStateMap(alternateCommands);
      if (alternateCommands != null &&
          alternate.length != alternateCommands.length) {
        return null;
      }
      final current = <String, String>{};
      final unavailable = <String>{};
      if (commands.every((command) => command.executable == 'gsettings')) {
        for (final command in commands) {
          final key = _commandStateKey(command);
          if (key == null) return null;
          final value = await _readCommand('gsettings', [
            'get',
            command.args[1],
            command.args[2],
          ]);
          if (value == null) return null;
          current[key] = _normalizeGSettingsValue(value);
        }
      } else if (commands.every(
        (command) => command.executable.startsWith('kwriteconfig'),
      )) {
        for (final command in commands) {
          final key = _commandStateKey(command);
          if (key == null) return null;
          final reader = command.executable.replaceFirst(
            'kwriteconfig',
            'kreadconfig',
          );
          final value = await _readCommand(reader, [
            ...command.args.take(6),
            '--default',
            '__flclash_missing_proxy_value__',
          ]);
          if (value == null) return null;
          current[key] = value;
        }
      } else if (commands.every(
        (command) => command.executable == '/usr/sbin/networksetup',
      )) {
        final services = await _getNetworkServicesWithMacos();
        if (services == null) return null;
        final serviceSet = services.toSet();
        for (final command in commands) {
          final key = _commandStateKey(command);
          final service = _macosService(command);
          if (key == null || service == null) return null;
          if (!serviceSet.contains(service)) unavailable.add(key);
        }
        final capturedServices = commands
            .where((command) => command.args.length > 1)
            .map((command) => command.args[1])
            .where(serviceSet.contains)
            .toSet()
            .toList();
        if (capturedServices.isNotEmpty) {
          final captured = await _captureMacosRestoreCommands(capturedServices);
          if (captured == null) return null;
          current.addAll(_commandStateMap(captured));
        }
      } else {
        return null;
      }
      final matching = <String>{};
      for (final entry in expected.entries) {
        if (!unavailable.contains(entry.key) &&
            (current[entry.key] == entry.value ||
                current[entry.key] == alternate[entry.key])) {
          matching.add(entry.key);
        }
      }
      return (matchingKeys: matching, unavailableKeys: unavailable);
    } catch (_) {
      return null;
    }
  }

  static Map<String, String> _commandStateMap(List<ProxyCommand> commands) {
    return {
      for (final command in commands)
        if (_commandStateKey(command) case final key?)
          key: _commandStateValue(command),
    };
  }

  static String? _commandStateKey(ProxyCommand command) {
    final args = command.args;
    if (command.executable == 'gsettings' && args.length == 4) {
      return 'g\u0000${args[1]}\u0000${args[2]}';
    }
    if (command.executable.startsWith('kwriteconfig') && args.length == 7) {
      return 'k\u0000${args[1]}\u0000${args[3]}\u0000${args[5]}';
    }
    if (command.executable == '/usr/sbin/networksetup' && args.length >= 3) {
      final setting = switch (args.first) {
        '-setwebproxy' => 'webproxy',
        '-setwebproxystate' => 'webproxystate',
        '-setsecurewebproxy' => 'securewebproxy',
        '-setsecurewebproxystate' => 'securewebproxystate',
        '-setsocksfirewallproxy' => 'socksproxy',
        '-setsocksfirewallproxystate' => 'socksproxystate',
        '-setproxybypassdomains' => 'bypass',
        '-setautoproxystate' => 'autoproxy',
        '-setproxyautodiscovery' => 'autodiscovery',
        _ => null,
      };
      return setting == null ? null : 'm\u0000${args[1]}\u0000$setting';
    }
    return null;
  }

  static String _commandStateValue(ProxyCommand command) {
    if (command.executable == 'gsettings') {
      return _normalizeGSettingsValue(command.args[3]);
    }
    if (command.executable.startsWith('kwriteconfig')) {
      return command.args[6];
    }
    return command.args.skip(2).join('\u0000');
  }

  static String? _macosService(ProxyCommand command) {
    return command.executable == '/usr/sbin/networksetup' &&
            command.args.length > 1
        ? command.args[1]
        : null;
  }

  static String _normalizeGSettingsValue(String value) {
    final trimmed = value.trim();
    if (trimmed.length >= 2 &&
        trimmed.startsWith("'") &&
        trimmed.endsWith("'")) {
      return trimmed
          .substring(1, trimmed.length - 1)
          .replaceAll(r"\'", "'")
          .replaceAll(r'\\', r'\');
    }
    return trimmed;
  }

  static bool _validateRestoreCommands(List<ProxyCommand> commands) {
    return commands.isNotEmpty &&
        commands.length <= 512 &&
        commands.every(
          (command) =>
              !command.runInShell &&
              command.args.length <= 4096 &&
              command.args.every((argument) => argument.length <= 4096) &&
              _isAllowedRestoreCommand(command.executable, command.args),
        );
  }

  Future<bool> _clearPersistedRestoreCommands() async {
    final path = _stateFilePath;
    if (path == null) {
      return true;
    }
    try {
      final file = File(path);
      if (await file.exists()) {
        await _durableDeleteFile(path);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static bool _isAllowedRestoreCommand(String executable, List<String> args) {
    if (executable == '/usr/sbin/networksetup') {
      if (args.isEmpty) {
        return false;
      }
      return switch (args.first) {
        '-setwebproxy' ||
        '-setsecurewebproxy' ||
        '-setsocksfirewallproxy' =>
          args.length == 4,
        '-setwebproxystate' ||
        '-setsecurewebproxystate' ||
        '-setsocksfirewallproxystate' ||
        '-setautoproxystate' ||
        '-setproxyautodiscovery' =>
          args.length == 3 && const {'on', 'off'}.contains(args.last),
        '-setproxybypassdomains' => args.length >= 3,
        String() => false,
      };
    }
    if (executable == 'gsettings') {
      return args.length == 4 &&
          args.first == 'set' &&
          (args[1] == 'org.gnome.system.proxy' ||
              args[1].startsWith('org.gnome.system.proxy.') ||
              args[1] == 'org.mate.system.proxy' ||
              args[1].startsWith('org.mate.system.proxy.'));
    }
    if (executable == 'kwriteconfig5' || executable == 'kwriteconfig6') {
      return args.length == 7 &&
          args[0] == '--file' &&
          isAbsolute(args[1]) &&
          basename(args[1]) == 'kioslaverc' &&
          args[2] == '--group' &&
          args[3] == 'Proxy Settings' &&
          args[4] == '--key' &&
          const {
            'NoProxyFor',
            'httpProxy',
            'httpsProxy',
            'socksProxy',
            'ReversedException',
            'ProxyType',
          }.contains(args[5]);
    }
    return false;
  }

  static Future<bool> _setPermissions(String path, String mode) async {
    try {
      final result = await Process.run('/bin/chmod', [mode, path]);
      return result.exitCode == 0;
    } catch (_) {
      return false;
    }
  }

  static Future<void> _durableRename(String source, String target) async {
    await File(source).rename(target);
    await _syncDirectory(dirname(source));
    if (dirname(source) != dirname(target)) {
      await _syncDirectory(dirname(target));
    }
  }

  static Future<void> _durableDeleteFile(String path) async {
    await File(path).delete();
    await _syncDirectory(dirname(path));
  }

  static Future<void> _syncDirectory(String path) async {
    if (Platform.isWindows) {
      return;
    }
    final bindings = _UnixFileBindings.instance;
    final pathPointer = path.toNativeUtf8();
    try {
      final descriptor = bindings.open(pathPointer, 0);
      if (descriptor < 0) {
        throw FileSystemException('Unable to open directory for sync', path);
      }
      try {
        if (bindings.fsync(descriptor) != 0) {
          throw FileSystemException('Unable to sync directory', path);
        }
      } finally {
        bindings.close(descriptor);
      }
    } finally {
      calloc.free(pathPointer);
    }
  }

  static String? _defaultStateFilePath() {
    final home = Platform.environment['HOME'];
    if (home == null || home.isEmpty) {
      return null;
    }
    return join(home, '.flclash', 'proxy-restore.json');
  }

  Future<List<String>?> _getNetworkServicesWithMacos() async {
    final result = await _processRunner(
      '/usr/sbin/networksetup',
      ['-listallnetworkservices'],
    );
    if (result.exitCode != 0) {
      return null;
    }
    return _parseMacosNetworkServices(result.stdout.toString());
  }

  Future<bool> _runCommands(
    Iterable<ProxyCommand> commands, {
    bool continueOnError = false,
  }) async {
    var success = true;
    for (final command in commands) {
      try {
        final result = await _processRunner(
          command.executable,
          command.args,
          runInShell: command.runInShell,
        );
        if (result.exitCode != 0) {
          success = false;
          if (!continueOnError) {
            return false;
          }
        }
      } catch (_) {
        success = false;
        if (!continueOnError) {
          return false;
        }
      }
    }
    return success;
  }

  Future<String?> _readCommand(
    String executable,
    List<String> args,
  ) async {
    try {
      final result = await _processRunner(executable, args);
      if (result.exitCode != 0) {
        return null;
      }
      return result.stdout.toString().trim();
    } catch (_) {
      return null;
    }
  }

  Future<List<ProxyCommand>?> _captureGSettingsRestoreCommands(
    String schemaPrefix,
  ) async {
    final keys = <(String, String)>[
      (schemaPrefix, 'ignore-hosts'),
      for (final type in ProxyTypes.values) ...[
        ('$schemaPrefix.${type.name}', 'host'),
        ('$schemaPrefix.${type.name}', 'port'),
      ],
      (schemaPrefix, 'mode'),
    ];
    final commands = <ProxyCommand>[];
    for (final (schema, key) in keys) {
      final value = await _readCommand('gsettings', ['get', schema, key]);
      if (value == null || value.isEmpty) {
        return null;
      }
      commands.add(
        ProxyCommand('gsettings', ['set', schema, key, value]),
      );
    }
    return commands;
  }

  Future<(String, String)?> _resolveKdeConfigTools() async {
    for (final version in ['6', '5']) {
      final writer = 'kwriteconfig$version';
      final reader = 'kreadconfig$version';
      if (await _executableChecker(writer) &&
          await _executableChecker(reader)) {
        return (writer, reader);
      }
    }
    return null;
  }

  Future<List<ProxyCommand>?> _captureKdeRestoreCommands({
    required String? configHome,
    required String homeDir,
    required String reader,
    required String writer,
  }) async {
    const missingValue = '__flclash_missing_proxy_value__';
    final configPath = _kdeConfigPath(homeDir, configHome);
    final keys = <String>[
      'NoProxyFor',
      for (final type in ProxyTypes.values) '${type.name}Proxy',
      'ReversedException',
      'ProxyType',
    ];
    final commands = <ProxyCommand>[];
    for (final key in keys) {
      final value = await _readCommand(reader, [
        '--file',
        configPath,
        '--group',
        'Proxy Settings',
        '--key',
        key,
        '--default',
        missingValue,
      ]);
      if (value == null) {
        return null;
      }
      commands.add(
        ProxyCommand(writer, [
          '--file',
          configPath,
          '--group',
          'Proxy Settings',
          '--key',
          key,
          if (value == missingValue) '--delete' else value,
        ]),
      );
    }
    return commands;
  }

  Future<List<ProxyCommand>?> _captureMacosRestoreCommands(
    List<String> services,
  ) async {
    final commands = <ProxyCommand>[];
    const proxyTypes = [
      ('-getwebproxy', '-setwebproxy', '-setwebproxystate'),
      (
        '-getsecurewebproxy',
        '-setsecurewebproxy',
        '-setsecurewebproxystate',
      ),
      (
        '-getsocksfirewallproxy',
        '-setsocksfirewallproxy',
        '-setsocksfirewallproxystate',
      ),
    ];
    for (final service in services) {
      final autoDiscoveryOutput = await _readCommand(
        '/usr/sbin/networksetup',
        ['-getproxyautodiscovery', service],
      );
      final autoDiscoveryEnabled = autoDiscoveryOutput == null
          ? null
          : _parseMacosAutoDiscoveryState(autoDiscoveryOutput);
      if (autoDiscoveryEnabled == null) {
        return null;
      }
      final autoProxyOutput = await _readCommand('/usr/sbin/networksetup', [
        '-getautoproxyurl',
        service,
      ]);
      final autoProxyState = autoProxyOutput == null
          ? null
          : _parseMacosAutoProxyState(autoProxyOutput);
      if (autoProxyState == null ||
          (autoProxyState.enabled && autoProxyState.url.isEmpty)) {
        return null;
      }
      for (final (getCommand, setCommand, stateCommand) in proxyTypes) {
        final output = await _readCommand('/usr/sbin/networksetup', [
          getCommand,
          service,
        ]);
        final state = output == null ? null : _parseMacosProxyState(output);
        if (state == null || state.authenticated) {
          return null;
        }
        if (int.tryParse(state.port) != null) {
          commands.add(
            ProxyCommand('/usr/sbin/networksetup', [
              setCommand,
              service,
              state.server,
              state.port,
            ]),
          );
        } else if (state.enabled) {
          return null;
        }
        commands.add(
          ProxyCommand('/usr/sbin/networksetup', [
            stateCommand,
            service,
            if (state.enabled) 'on' else 'off',
          ]),
        );
      }
      final bypassOutput = await _readCommand('/usr/sbin/networksetup', [
        '-getproxybypassdomains',
        service,
      ]);
      if (bypassOutput == null) {
        return null;
      }
      commands.add(
        _buildMacosProxyBypassCommand(
          service,
          _parseMacosProxyBypassDomains(bypassOutput),
        ),
      );
      commands.add(
        ProxyCommand('/usr/sbin/networksetup', [
          '-setautoproxystate',
          service,
          if (autoProxyState.enabled) 'on' else 'off',
        ]),
      );
      commands.add(
        ProxyCommand('/usr/sbin/networksetup', [
          '-setproxyautodiscovery',
          service,
          if (autoDiscoveryEnabled) 'on' else 'off',
        ]),
      );
    }
    return commands;
  }

  Future<LinuxProxyBackend?> _resolveLinuxBackend(String? desktop) async {
    final preferredBackend = _preferredLinuxBackend(desktop);
    if (preferredBackend != null &&
        await _isLinuxBackendAvailable(preferredBackend)) {
      return preferredBackend;
    }
    for (final backend in LinuxProxyBackend.values) {
      if (await _isLinuxBackendAvailable(backend)) {
        return backend;
      }
    }
    return null;
  }

  Future<bool> _isLinuxBackendAvailable(LinuxProxyBackend backend) async {
    return switch (backend) {
      LinuxProxyBackend.gnome ||
      LinuxProxyBackend.mate =>
        await _executableChecker('gsettings'),
      LinuxProxyBackend.kde => (await _executableChecker('kwriteconfig6') &&
              await _executableChecker('kreadconfig6')) ||
          (await _executableChecker('kwriteconfig5') &&
              await _executableChecker('kreadconfig5')),
    };
  }

  static Future<bool> _hasExecutable(String executable) async {
    final result = await Process.run('which', [executable]);
    return result.exitCode == 0;
  }

  static LinuxProxyBackend? _preferredLinuxBackend(String? desktop) {
    final desktops = _linuxDesktops(desktop);
    if (desktops.contains('KDE')) {
      return LinuxProxyBackend.kde;
    }
    if (desktops.contains('MATE')) {
      return LinuxProxyBackend.mate;
    }
    if (desktops.any(
      (value) => const {
        'GNOME',
        'CINNAMON',
        'BUDGIE',
        'UNITY',
      }.contains(value),
    )) {
      return LinuxProxyBackend.gnome;
    }
    return null;
  }

  static Set<String> _linuxDesktops(String? desktop) {
    if (desktop == null || desktop.isEmpty) {
      return {};
    }
    return desktop
        .split(':')
        .map((value) => value.trim().toUpperCase())
        .where((value) => value.isNotEmpty)
        .toSet();
  }

  static List<ProxyCommand> _buildLinuxStartCommands({
    required int port,
    required List<String> bypassDomain,
    required String? desktop,
    required String homeDir,
    String? configHome,
    LinuxProxyBackend? backend,
    String kdeConfigWriter = 'kwriteconfig5',
    Set<String>? availableExecutables,
  }) {
    final resolvedBackend = backend ??
        _resolveLinuxBackendForBuild(
          desktop: desktop,
          availableExecutables: availableExecutables,
        );
    if (resolvedBackend == null) {
      return [];
    }
    return switch (resolvedBackend) {
      LinuxProxyBackend.gnome => _buildGSettingsStartCommands(
          port: port,
          bypassDomain: bypassDomain,
          schemaPrefix: 'org.gnome.system.proxy',
        ),
      LinuxProxyBackend.mate => _buildGSettingsStartCommands(
          port: port,
          bypassDomain: bypassDomain,
          schemaPrefix: 'org.mate.system.proxy',
        ),
      LinuxProxyBackend.kde => _buildKdeStartCommands(
          port: port,
          bypassDomain: bypassDomain,
          homeDir: homeDir,
          configHome: configHome,
          executable: _resolveKdeConfigWriterForBuild(
            availableExecutables,
            fallback: kdeConfigWriter,
          ),
        ),
    };
  }

  static LinuxProxyBackend? _resolveLinuxBackendForBuild({
    required String? desktop,
    required Set<String>? availableExecutables,
  }) {
    final preferredBackend = _preferredLinuxBackend(desktop);
    if (preferredBackend != null) {
      return preferredBackend;
    }
    if (availableExecutables == null) {
      return LinuxProxyBackend.gnome;
    }
    for (final backend in LinuxProxyBackend.values) {
      if (_isLinuxBackendAvailableForBuild(backend, availableExecutables)) {
        return backend;
      }
    }
    return null;
  }

  static bool _isLinuxBackendAvailableForBuild(
    LinuxProxyBackend backend,
    Set<String> availableExecutables,
  ) {
    return switch (backend) {
      LinuxProxyBackend.gnome ||
      LinuxProxyBackend.mate =>
        availableExecutables.contains('gsettings'),
      LinuxProxyBackend.kde => availableExecutables.contains('kwriteconfig6') ||
          availableExecutables.contains('kwriteconfig5'),
    };
  }

  static String _resolveKdeConfigWriterForBuild(
    Set<String>? availableExecutables, {
    required String fallback,
  }) {
    if (availableExecutables?.contains('kwriteconfig6') ?? false) {
      return 'kwriteconfig6';
    }
    if (availableExecutables?.contains('kwriteconfig5') ?? false) {
      return 'kwriteconfig5';
    }
    return fallback;
  }

  static List<ProxyCommand> _buildGSettingsStartCommands({
    required int port,
    required List<String> bypassDomain,
    required String schemaPrefix,
  }) {
    final commands = <ProxyCommand>[
      ProxyCommand('gsettings', [
        'set',
        schemaPrefix,
        'ignore-hosts',
        _formatGSettingsStringList(bypassDomain),
      ]),
    ];
    for (final type in ProxyTypes.values) {
      commands.addAll([
        ProxyCommand('gsettings', [
          'set',
          '$schemaPrefix.${type.name}',
          'host',
          url,
        ]),
        ProxyCommand('gsettings', [
          'set',
          '$schemaPrefix.${type.name}',
          'port',
          '$port',
        ]),
      ]);
    }
    commands.add(
      ProxyCommand('gsettings', ['set', schemaPrefix, 'mode', 'manual']),
    );
    return commands;
  }

  static List<ProxyCommand> _buildKdeStartCommands({
    required int port,
    required List<String> bypassDomain,
    required String homeDir,
    String? configHome,
    required String executable,
  }) {
    final configPath = _kdeConfigPath(homeDir, configHome);
    final commands = <ProxyCommand>[
      ProxyCommand(executable, [
        '--file',
        configPath,
        '--group',
        'Proxy Settings',
        '--key',
        'NoProxyFor',
        bypassDomain.join(','),
      ]),
      ProxyCommand(executable, [
        '--file',
        configPath,
        '--group',
        'Proxy Settings',
        '--key',
        'ReversedException',
        'false',
      ]),
    ];
    for (final type in ProxyTypes.values) {
      commands.add(
        ProxyCommand(executable, [
          '--file',
          configPath,
          '--group',
          'Proxy Settings',
          '--key',
          '${type.name}Proxy',
          '${type.name}://$url:$port',
        ]),
      );
    }
    commands.add(
      ProxyCommand(executable, [
        '--file',
        configPath,
        '--group',
        'Proxy Settings',
        '--key',
        'ProxyType',
        '1',
      ]),
    );
    return commands;
  }

  static String _formatGSettingsStringList(List<String> values) {
    if (values.isEmpty) {
      return '[]';
    }
    final escaped = values.map((value) => "'${value.replaceAll("'", r"\'")}'");
    return '[${escaped.join(', ')}]';
  }

  static List<ProxyCommand> _buildMacosStartCommands(
    String service,
    int port,
    List<String> bypassDomain,
  ) {
    return [
      ProxyCommand('/usr/sbin/networksetup', [
        '-setproxyautodiscovery',
        service,
        'off',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setautoproxystate',
        service,
        'off',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setwebproxy',
        service,
        url,
        '$port',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setwebproxystate',
        service,
        'on',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsecurewebproxy',
        service,
        url,
        '$port',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsecurewebproxystate',
        service,
        'on',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsocksfirewallproxy',
        service,
        url,
        '$port',
      ]),
      ProxyCommand('/usr/sbin/networksetup', [
        '-setsocksfirewallproxystate',
        service,
        'on',
      ]),
      _buildMacosProxyBypassCommand(service, bypassDomain),
    ];
  }

  static ProxyCommand _buildMacosProxyBypassCommand(
    String service,
    List<String> bypassDomain,
  ) {
    return ProxyCommand('/usr/sbin/networksetup', [
      '-setproxybypassdomains',
      service,
      if (bypassDomain.isEmpty) 'Empty' else ...bypassDomain,
    ]);
  }

  static List<String> _parseMacosNetworkServices(String stdout) {
    return stdout
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .where((line) => !line.startsWith('*'))
        .where((line) => !line.startsWith('An asterisk '))
        .toList();
  }

  static _MacosProxyState? _parseMacosProxyState(String stdout) {
    final values = _parseMacosNetworkSetupValues(stdout);
    final enabled = values['Enabled'];
    final server = values['Server'];
    final port = values['Port'];
    if (enabled == null || server == null || port == null) {
      return null;
    }
    final authenticated = values['Authenticated Proxy Enabled'];
    return _MacosProxyState(
      enabled: enabled.toLowerCase() == 'yes',
      server: server,
      port: port,
      authenticated:
          authenticated == '1' || authenticated?.toLowerCase() == 'yes',
    );
  }

  static _MacosAutoProxyState? _parseMacosAutoProxyState(String stdout) {
    final values = _parseMacosNetworkSetupValues(stdout);
    final enabled = values['Enabled'];
    final url = values['URL'];
    if (enabled == null || url == null) {
      return null;
    }
    return _MacosAutoProxyState(
      enabled: enabled.toLowerCase() == 'yes',
      url: url == '(null)' ? '' : url,
    );
  }

  static bool? _parseMacosAutoDiscoveryState(String stdout) {
    final value = stdout.trim().toLowerCase();
    if (value.endsWith(': on') || value == 'on') {
      return true;
    }
    if (value.endsWith(': off') || value == 'off') {
      return false;
    }
    return null;
  }

  static String _kdeConfigPath(String homeDir, String? configHome) {
    final root =
        configHome == null || configHome.isEmpty || !isAbsolute(configHome)
            ? join(homeDir, '.config')
            : configHome;
    return join(root, 'kioslaverc');
  }

  static Map<String, String> _parseMacosNetworkSetupValues(String stdout) {
    final values = <String, String>{};
    for (final line in stdout.split('\n')) {
      final separator = line.indexOf(':');
      if (separator == -1) {
        continue;
      }
      values[line.substring(0, separator).trim()] =
          line.substring(separator + 1).trim();
    }
    return values;
  }

  static List<String> _parseMacosProxyBypassDomains(String stdout) {
    final value = stdout.trim();
    if (value.isEmpty || value.startsWith("There aren't any")) {
      return [];
    }
    return value
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }

  @visibleForTesting
  Future<bool> startLinuxProxyForTest(
    int port,
    List<String> bypassDomain, {
    required String? desktop,
    required String homeDir,
    String? configHome,
  }) {
    return _startProxyWithLinuxEnvironment(
      port,
      bypassDomain,
      desktop: desktop,
      homeDir: homeDir,
      configHome: configHome,
    );
  }

  @visibleForTesting
  Future<bool> startMacosProxyForTest(
    int port,
    List<String> bypassDomain,
  ) {
    return _startProxyWithMacos(port, bypassDomain);
  }

  @visibleForTesting
  Future<bool> restoreProxyForTest() => _restoreProxyState();

  @visibleForTesting
  static List<ProxyCommand> buildLinuxStartCommandsForTest({
    required int port,
    required List<String> bypassDomain,
    required String? desktop,
    required String homeDir,
    String? configHome,
    Set<String>? availableExecutables,
  }) {
    return _buildLinuxStartCommands(
      port: port,
      bypassDomain: bypassDomain,
      desktop: desktop,
      homeDir: homeDir,
      configHome: configHome,
      availableExecutables: availableExecutables,
    );
  }

  @visibleForTesting
  static List<String> parseMacosNetworkServicesForTest(String stdout) {
    return _parseMacosNetworkServices(stdout);
  }

  @visibleForTesting
  static ProxyCommand buildMacosProxyBypassCommandForTest(
    String service,
    List<String> bypassDomain,
  ) {
    return _buildMacosProxyBypassCommand(service, bypassDomain);
  }
}

class _UnixFileBindings {
  final int Function(Pointer<Utf8>, int) open;
  final int Function(int) fsync;
  final int Function(int) close;

  _UnixFileBindings._(DynamicLibrary library)
    : open = library
          .lookupFunction<
            Int32 Function(Pointer<Utf8>, Int32),
            int Function(Pointer<Utf8>, int)
          >('open'),
      fsync = library.lookupFunction<Int32 Function(Int32), int Function(int)>(
        'fsync',
      ),
      close = library.lookupFunction<Int32 Function(Int32), int Function(int)>(
        'close',
      );

  static final instance = _UnixFileBindings._(DynamicLibrary.process());
}
