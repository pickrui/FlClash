import 'package:flutter/foundation.dart' show visibleForTesting;

class Snowflake {
  static Snowflake? _instance;

  Snowflake._internal(this._now);

  factory Snowflake() {
    _instance ??= Snowflake._internal(_systemNow);
    return _instance!;
  }

  @visibleForTesting
  Snowflake.withClock(this._now);

  static int _systemNow() => DateTime.now().millisecondsSinceEpoch;

  static const int _twepoch = 1704067200000;

  static const int _workerIdBits = 10;
  static const int _sequenceBits = 12;

  static const int _sequenceMask = -1 ^ (-1 << _sequenceBits);

  static const int _workerIdShift = _sequenceBits;
  static const int _timestampLeftShift = _sequenceBits + _workerIdBits;

  final int Function() _now;
  final int _workerId = 1;
  int _lastTimestamp = -1;
  int _sequence = 0;

  /// Survives a wall clock stepped back (NTP, a manual fix) without throwing.
  int get id {
    var timestamp = _now();
    if (timestamp <= _lastTimestamp) {
      timestamp = _lastTimestamp;
      _sequence = (_sequence + 1) & _sequenceMask;
      if (_sequence == 0) timestamp++;
    } else {
      _sequence = 0;
    }
    _lastTimestamp = timestamp;

    return ((timestamp - _twepoch) << _timestampLeftShift) |
        (_workerId << _workerIdShift) |
        _sequence;
  }
}

final snowflake = Snowflake();
