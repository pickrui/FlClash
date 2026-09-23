part of '../action.dart';

@Riverpod(keepAlive: true)
class LogsAction extends _$LogsAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  void addLog(Log log, {bool persist = true}) =>
      _controller.addLog(log, persist: persist);

  Future<bool> exportLogs() => _controller.exportLogs();

  void writePersistentLog(Log log) => _controller.writePersistentLog(log);
}

extension LogsControllerExt on AppController {
  void addLog(Log log, {bool persist = true}) {
    if (Secrets.shouldSuppressOutput(log.payload)) return;
    _ref.read(logsProvider.notifier).addLog(log);
    if (persist) {
      writePersistentLog(log);
    }
  }

  Future<bool> exportLogs() async {
    final logString = await encodeLogsTask(
      _ref
          .read(logsProvider)
          .list
          .where((log) => !Secrets.shouldSuppressOutput(log.payload))
          .toList(),
    );
    final tempFilePath = await appPath.tempFilePath;
    final file = File(tempFilePath);
    await file.safeWriteAsString(logString);
    bool res = false;
    res = await picker.saveFileWithPath(utils.logFile, tempFilePath) != null;
    return res;
  }

  void writePersistentLog(Log log) {
    if (_persistentLogWritesSuspended ||
        Secrets.shouldSuppressOutput(log.payload)) {
      return;
    }
    _logFileWrite = _logFileWrite
        .then((_) => _appendPersistentLog(log))
        .catchError((error) {
          debugPrint('write persistent log failed: $error');
        });
  }

  Future<void> _appendPersistentLog(Log log) async {
    final file = await _preparePersistentLogFile();
    final line =
        '${log.dateTime} [${log.logLevel.name.toUpperCase()}] ${log.payload}\n';
    final encodedLine = limitLogLine(
      Uint8List.fromList(utf8.encode(line)),
      _persistentLogMaxBytes,
    );
    if (_persistentLogLength + encodedLine.length > _persistentLogMaxBytes) {
      final available = _persistentLogMaxBytes - encodedLine.length;
      await _rotatePersistentLog(
        file,
        available < _persistentLogKeepBytes
            ? available
            : _persistentLogKeepBytes,
      );
    }
    await file.writeAsBytes(encodedLine, mode: FileMode.append);
    _persistentLogLength += encodedLine.length;
  }

  Future<File> _preparePersistentLogFile() async {
    final cached = _persistentLogFile;
    if (cached != null) {
      return cached;
    }
    final homeDirPath = await appPath.homeDirPath;
    final logsDir = Directory(p.join(homeDirPath, 'logs'));
    await logsDir.create(recursive: true);
    final file = File(p.join(logsDir.path, _persistentLogFileName));
    _persistentLogLength = await file.exists() ? await file.length() : 0;
    _persistentLogFile = file;
    return file;
  }

  Future<void> _rotatePersistentLog(File file, int keepBytes) async {
    if (!await file.exists()) {
      _persistentLogLength = 0;
      return;
    }
    final bytes = await file.readAsBytes();
    final kept = retainCompleteLogLines(bytes, keepBytes);
    await file.writeAsBytes(kept);
    _persistentLogLength = kept.length;
  }
}
