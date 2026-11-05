import 'package:dio/dio.dart';

class TimeCheck {
  static const _timeCheckUrls = [
    'https://www.apple.com',
    'https://www.microsoft.com',
    'https://www.cloudflare.com',
  ];
  
  static const _maxAllowedDifference = Duration(seconds: 30);
  
  static Future<Duration?> getTimeDifference() async {
    for (final url in _timeCheckUrls) {
      try {
        final dio = Dio();
        final response = await dio.head(
          url,
          options: Options(
            receiveTimeout: const Duration(seconds: 5),
            sendTimeout: const Duration(seconds: 5),
            validateStatus: (status) => true,
          ),
        );
        
        final dateHeader = response.headers.value('date');
        if (dateHeader != null) {
          final serverTimeUtc = DateTime.parse(dateHeader);
          final serverTimeLocal = serverTimeUtc.toLocal();
          final localTime = DateTime.now();
          final difference = localTime.difference(serverTimeLocal);
          return difference;
        }
      } catch (_) {
        continue;
      }
    }
    return null;
  }
  
  static Future<bool> checkSystemTime() async {
    final difference = await getTimeDifference();
    if (difference == null) return true;
    
    return difference.abs() <= _maxAllowedDifference;
  }
}

