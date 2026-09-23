import 'dart:async';

import 'package:fl_clash/common/common.dart';

class Debouncer {
  final Map<Object, Timer> _operations = {};

  void call(
    Object tag,
    Function func, {
    List<dynamic>? args,
    Duration? duration,
  }) {
    _operations[tag]?.cancel();
    _operations[tag] = Timer(duration ?? const Duration(milliseconds: 600), () {
      _operations.remove(tag);
      Function.apply(func, args);
    });
  }

  void cancel(Object tag) => _operations.remove(tag)?.cancel();
}

class Throttler {
  final Map<Object, Timer> _operations = {};

  bool call(
    Object tag,
    Function func, {
    List<dynamic>? args,
    Duration duration = const Duration(milliseconds: 600),
    bool fire = false,
  }) {
    if (_operations.containsKey(tag)) {
      return true;
    }
    if (fire) {
      Function.apply(func, args);
      _operations[tag] = Timer(duration, () => _operations.remove(tag));
    } else {
      _operations[tag] = Timer(duration, () {
        try {
          Function.apply(func, args);
        } finally {
          _operations.remove(tag);
        }
      });
    }
    return false;
  }

  void cancel(Object tag) => _operations.remove(tag)?.cancel();
}

Future<T> retry<T>({
  required Future<T> Function() task,
  int maxAttempts = 3,
  required bool Function(T res) retryIf,
  Duration delay = midDuration,
}) async {
  int attempts = 0;
  while (attempts < maxAttempts) {
    final res = await task();
    attempts++;
    if (!retryIf(res) || attempts >= maxAttempts) {
      return res;
    }
    await Future.delayed(delay);
  }
  throw 'retry error';
}

final debouncer = Debouncer();

final throttler = Throttler();
