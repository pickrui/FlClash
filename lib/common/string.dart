import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:fl_clash/common/common.dart';

extension StringExtension on String {
  bool get isUrl {
    return RegExp(r'^(http|https|ftp)://').hasMatch(this);
  }

  dynamic get splitByMultipleSeparators {
    final parts = split(
      RegExp(r'[, ;]+'),
    ).where((part) => part.isNotEmpty).toList();

    return parts.length > 1 ? parts : this;
  }

  String appendUrlParams(String params) {
    if (params.isEmpty) return this;
    String base = this;
    String ext = '';

    // First, check if there's a file extension at the end without query strings
    int qIndex = base.indexOf('?');
    if (qIndex != -1) {
      String withoutQuery = base.substring(0, qIndex);
      var extMatch = RegExp(r'\.([a-zA-Z0-9]+)$').firstMatch(withoutQuery);
      if (extMatch != null) {
        ext = extMatch.group(0)!;
        base =
            withoutQuery.substring(0, withoutQuery.length - ext.length) +
            base.substring(qIndex);
      }
      if (ext.isEmpty) {
        var queryExtMatch = RegExp(r'\.([a-zA-Z0-9]+)$').firstMatch(base);
        if (queryExtMatch != null) {
          ext = queryExtMatch.group(0)!;
          if (ext.length <= 6) {
            base = base.substring(0, base.length - ext.length);
          } else {
            ext = '';
          }
        }
      }
    } else {
      var extMatch = RegExp(r'\.([a-zA-Z0-9]+)$').firstMatch(base);
      if (extMatch != null) {
        ext = extMatch.group(0)!;
        base = base.substring(0, base.length - ext.length);
      }
    }

    if (base.contains('?')) {
      if (!base.endsWith('?')) base += '&';
    } else {
      base += '?';
    }

    var newUrl = base + params;
    newUrl = newUrl.replaceAll('?&', '?').replaceAll('&&', '&');
    if (newUrl.endsWith('&')) {
      newUrl = newUrl.substring(0, newUrl.length - 1);
    }
    if (newUrl.endsWith('?')) {
      newUrl = newUrl.substring(0, newUrl.length - 1);
    }
    return newUrl + ext;
  }

  int compareToLower(String other) {
    return toLowerCase().compareTo(other.toLowerCase());
  }

  String safeSubstring(int start, [int? end]) {
    if (isEmpty) return '';
    final safeStart = start.clamp(0, length);
    if (end == null) {
      return substring(safeStart);
    }
    final safeEnd = end.clamp(safeStart, length);
    return substring(safeStart, safeEnd);
  }

  List<int> get encodeUtf16LeWithBom {
    final byteData = ByteData(length * 2);
    final bom = [0xFF, 0xFE];
    for (int i = 0; i < length; i++) {
      int charCode = codeUnitAt(i);
      byteData.setUint16(i * 2, charCode, Endian.little);
    }
    return bom + byteData.buffer.asUint8List();
  }

  Uint8List? get getBase64 {
    final regExp = RegExp(r'base64,(.*)');
    final match = regExp.firstMatch(this);
    final realValue = match?.group(1) ?? '';
    if (realValue.isEmpty) {
      return null;
    }
    try {
      return base64.decode(realValue);
    } catch (e) {
      return null;
    }
  }

  bool get isSvg {
    return endsWith('.svg');
  }

  bool get isRegex {
    try {
      RegExp(this);
      return true;
    } catch (e) {
      commonPrint.log(e.toString());
      return false;
    }
  }

  String toMd5() {
    final bytes = utf8.encode(this);
    return md5.convert(bytes).toString();
  }

  // bool containsToLower(String target) {
  //   return toLowerCase().contains(target);
  // }

  Future<T> commonToJSON<T>() async {
    final thresholdLimit = 51200;
    if (length < thresholdLimit) {
      return json.decode(this);
    } else {
      return await decodeJSONTask<T>(this);
    }
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
