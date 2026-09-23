import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fl_clash/common/common.dart';

extension StringExtension on String {
  bool get isUrl {
    final uri = Uri.tryParse(this);
    return uri != null &&
        (uri.scheme == 'http' ||
            uri.scheme == 'https' ||
            uri.scheme == 'ftp') &&
        uri.host.isNotEmpty;
  }

  dynamic get splitByMultipleSeparators {
    final parts = split(
      RegExp(r'[, ;]+'),
    ).where((part) => part.isNotEmpty).toList();

    return parts.length > 1 ? parts : this;
  }

  bool get isSvg {
    return endsWith('.svg');
  }

  String toMd5() {
    final bytes = utf8.encode(this);
    return md5.convert(bytes).toString();
  }

  Future<T> commonToJSON<T>() async {
    const thresholdLimit = 51200;
    if (length < thresholdLimit) {
      return json.decode(this);
    } else {
      return decodeJSONTask<T>(this);
    }
  }

  String? get value {
    if (isEmpty) {
      return null;
    }
    return this;
  }
}

extension StringNullExt on String? {
  String takeFirstValid(List<String?> others, {String defaultValue = ''}) {
    if (this != null && this!.trim().isNotEmpty) return this!.trim();

    for (final s in others) {
      if (s != null && s.trim().isNotEmpty) {
        return s.trim();
      }
    }
    return defaultValue;
  }
}
