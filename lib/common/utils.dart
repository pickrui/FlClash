import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

class Utils {
  static Utils? _instance;

  Utils._internal();

  factory Utils() {
    _instance ??= Utils._internal();
    return _instance!;
  }

  Color? getDelayColor(int? delay) {
    if (delay == null) return null;
    if (delay < 0) return Colors.red;
    if (delay < 600) return Colors.green;
    return const Color(0xFFC57F0A);
  }

  String get id {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final random = Random();
    final randomStr = String.fromCharCodes(
      List.generate(8, (_) => random.nextInt(26) + 97),
    );
    return '$timestamp$randomStr';
  }

  String getDateStringLast2(int value) {
    final valueRaw = '0$value';
    return valueRaw.substring(valueRaw.length - 2);
  }

  String generateRandomString({int minLength = 10, int maxLength = 100}) {
    const latinChars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();

    final length = minLength + random.nextInt(maxLength - minLength + 1);

    String result = '';
    for (int i = 0; i < length; i++) {
      if (random.nextBool()) {
        result += String.fromCharCode(
          0x4E00 + random.nextInt(0x9FA5 - 0x4E00 + 1),
        );
      } else {
        result += latinChars[random.nextInt(latinChars.length)];
      }
    }

    return result;
  }

  String get uuidV4 {
    final Random random = Random();
    final bytes = List.generate(16, (_) => random.nextInt(256));

    bytes[6] = (bytes[6] & 0x0F) | 0x40;
    bytes[8] = (bytes[8] & 0x3F) | 0x80;

    final hex = bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();

    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}';
  }

  String getTimeText(int? milliseconds) {
    if (milliseconds == null) {
      return '00:00:00';
    }
    final duration = Duration(milliseconds: milliseconds);
    final inHours = duration.inHours;
    final inMinutes = duration.inMinutes % 60;
    final hoursText = inHours.toString().padLeft(2, '0');
    if (inHours > 99) {
      return '$hoursText:${getDateStringLast2(inMinutes)}';
    }
    final inSeconds = duration.inSeconds % 60;

    return '$hoursText:${getDateStringLast2(inMinutes)}:${getDateStringLast2(inSeconds)}';
  }

  Locale? getLocaleForString(String? localString) {
    if (localString == null) return null;
    final localSplit = localString.split('_');
    if (localSplit.length == 1) {
      return Locale(localSplit[0]);
    }
    if (localSplit.length == 2) {
      return Locale(localSplit[0], localSplit[1]);
    }
    if (localSplit.length == 3) {
      return Locale.fromSubtags(
        languageCode: localSplit[0],
        scriptCode: localSplit[1],
        countryCode: localSplit[2],
      );
    }
    return null;
  }

  String getOverwriteLabel(String label) {
    final match = RegExp(r'\((\d+)\)$').firstMatch(label);
    final number = int.tryParse(match?[1] ?? '');
    if (match == null || number == null) return '$label(1)';
    return '${label.substring(0, match.start)}(${number + 1})';
  }

  String? getFileNameForDisposition(String? disposition) {
    if (disposition == null) return null;
    final Map<String, String?> parameters;
    try {
      parameters = HeaderValue.parse(disposition).parameters;
    } on HttpException {
      return null;
    }
    final encoded = parameters['filename*']?.split("''");
    if (encoded != null && encoded.length >= 2) {
      try {
        return Uri.decodeComponent(encoded[1]);
      } catch (_) {}
    }
    return parameters['filename'];
  }

  ViewMode getViewMode(double viewWidth) {
    if (viewWidth <= maxMobileWidth) return ViewMode.mobile;
    if (viewWidth <= maxLaptopWidth) return ViewMode.laptop;
    return ViewMode.desktop;
  }

  int getProxiesColumns(double viewWidth, ProxiesLayout proxiesLayout) {
    final columns = max((viewWidth / 250).ceil(), 2);
    return switch (proxiesLayout) {
      ProxiesLayout.tight => columns + 1,
      ProxiesLayout.standard => columns,
      ProxiesLayout.loose => columns - 1,
    };
  }

  int getProfilesColumns(double viewWidth) {
    return max((viewWidth / 280).floor(), 1);
  }

  String getBackupFileName() {
    return '${appName}_backup_${DateTime.now().show}.zip';
  }

  String get logFile {
    return '${appName}_${DateTime.now().show}.log';
  }

  Future<String?> getLocalIpAddress() async {
    final interfaces = await NetworkInterface.list(includeLoopback: false);
    interfaces.sort((a, b) {
      if (a.isWifi && !b.isWifi) return -1;
      if (!a.isWifi && b.isWifi) return 1;
      if (a.includesIPv4 && !b.includesIPv4) return -1;
      if (!a.includesIPv4 && b.includesIPv4) return 1;
      return 0;
    });
    for (final interface in interfaces) {
      final addresses = interface.addresses;
      if (addresses.isEmpty) {
        continue;
      }
      addresses.sort((a, b) {
        if (a.isIPv4 && !b.isIPv4) return -1;
        if (!a.isIPv4 && b.isIPv4) return 1;
        return 0;
      });
      return addresses.first.address;
    }
    return '';
  }

  Future<bool> hasGlobalIpv6() async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv6,
      );
      for (final interface in interfaces) {
        for (final address in interface.addresses) {
          if (address.isGlobalIPv6) {
            return true;
          }
        }
      }
    } catch (_) {}
    return false;
  }

  SingleActivator controlSingleActivator(LogicalKeyboardKey trigger) {
    final control = system.isMacOS ? false : true;
    return SingleActivator(trigger, control: control, meta: !control);
  }

  FutureOr<T> handleWatch<T>({
    required Function function,
    required void Function(T data, int elapsedMilliseconds) onWatch,
  }) async {
    if (kDebugMode && watchExecution) {
      final stopwatch = Stopwatch()..start();
      final res = await function();
      stopwatch.stop();
      onWatch(res, stopwatch.elapsedMilliseconds);
      return res;
    }
    return await function();
  }

  int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}

final utils = Utils();
