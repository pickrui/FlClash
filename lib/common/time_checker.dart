import 'dart:io';
import 'package:fl_clash/common/system.dart';

class TimeChecker {
  static const int _maxTimeOffsetSeconds = 30;
  static const String _timeServerUrl = 'http://time.apple.com';

  static Future<TimeCheckResult> checkSystemTime() async {
    try {
      final client = HttpClient()..connectionTimeout = const Duration(seconds: 5);
      final request = await client.getUrl(Uri.parse(_timeServerUrl));
      final response = await request.close();
      
      final serverDateStr = response.headers.value('date');
      if (serverDateStr == null) {
        return const TimeCheckResult(isAccurate: true, message: '无法获取服务器时间');
      }
      
      final serverTime = HttpDate.parse(serverDateStr);
      final offset = DateTime.now().toUtc().difference(serverTime).inSeconds.abs();
      
      client.close();
      
      return offset > _maxTimeOffsetSeconds
          ? TimeCheckResult(isAccurate: false, message: _getTimeSyncMessage())
          : const TimeCheckResult(isAccurate: true);
    } catch (e) {
      return const TimeCheckResult(isAccurate: true, message: '无法检测系统时间');
    }
  }

  static String _getTimeSyncMessage() {
    const prefix = '系统时间与标准时间相差较大，可能影响服务使用\n\n建议开启自动时间同步：\n';
    
    final steps = switch (system) {
      _ when system.isMacOS => '1. 打开"系统设置"\n2. 点击"通用" → "日期与时间"\n3. 开启"自动设置日期和时间"',
      _ when system.isWindows => '1. 打开"设置"\n2. 点击"时间和语言" → "日期和时间"\n3. 开启"自动设置时间"和"自动设置时区"',
      _ when system.isLinux => '1. 打开"系统设置"\n2. 找到"日期和时间"设置\n3. 开启"自动设置日期和时间"',
      _ when system.isAndroid => '1. 打开"设置"\n2. 点击"系统" → "日期和时间"\n3. 开启"自动设置日期和时间"\n4. 开启"自动设置时区"',
      _ => '请在系统设置中开启自动时间同步',
    };
    
    return steps == '请在系统设置中开启自动时间同步' 
        ? '系统时间与标准时间相差较大，$steps'
        : '$prefix$steps';
  }
}

class TimeCheckResult {
  final bool isAccurate;
  final String? message;

  const TimeCheckResult({required this.isAccurate, this.message});
}
