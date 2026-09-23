import 'package:fl_clash/common/http.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('splitRoutes trims and de-duplicates find-proxy entries', () {
    expect(
      FlClashHttpOverrides.splitRoutes('PROXY localhost:7890; DIRECT;DIRECT'),
      {'PROXY localhost:7890', 'DIRECT'},
    );
    expect(FlClashHttpOverrides.splitRoutes('DIRECT'), {'DIRECT'});
  });

  test('pinnedRoute keeps loopback targets direct on every request', () {
    final findProxy = FlClashHttpOverrides.pinnedRoute('PROXY localhost:7890');
    for (final target in [
      'http://localhost/a',
      'http://LOCALHOST:8080/a',
      'http://127.0.0.1/a',
      'http://127.8.0.1/a',
      'http://[::1]:5005/a',
    ]) {
      expect(findProxy(Uri.parse(target)), 'DIRECT', reason: target);
    }
    for (final target in [
      'https://example.com/a',
      'http://192.168.1.2/a',
      'http://localhost.example.com/a',
    ]) {
      expect(
        findProxy(Uri.parse(target)),
        'PROXY localhost:7890',
        reason: target,
      );
    }
  });
}
