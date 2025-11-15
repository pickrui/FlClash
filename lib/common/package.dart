import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

import 'common.dart';

extension PackageInfoExtension on PackageInfo {
  String get ua => [
        '$appName/v$version',
        'clash-verge',
        'Platform/${Platform.operatingSystem}',
      ].join(' ');
  
  /// 获取完整版本号（包含构建号）
  String get fullVersion {
    if (buildNumber.isNotEmpty && buildNumber != '0') {
      return '$version+$buildNumber';
    }
    return version;
  }
}
