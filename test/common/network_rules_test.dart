import 'package:fl_clash/common/network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('accepts numeric IPv4 hosts, subnets and gateway rules', () {
    for (final rule in [
      '192.168.1.2',
      '192.168.0.0/16',
      '0.0.0.0/0',
      ' gateway:10.0.0.1 ',
      'GATEWAY:172.16.0.0/12',
    ]) {
      expect(validNetworkRule(rule), true, reason: rule);
    }
    expect(parseNetworkRules(' 10.0.0.1,,10.0.0.1 '), ['10.0.0.1']);
    expect(validNetworkRules(''), true);
  });
  test('rejects hostnames, malformed subnets and excessive rules', () {
    for (final rule in [
      'example.com',
      '::1',
      '10.0.0.256',
      '+1.2.3.4',
      '1.2.3.4/-1',
      '1.2.3.4/33',
      '1.2.3.4/1/2',
      'gateway:gateway:1.2.3.4',
    ]) {
      expect(validNetworkRule(rule), false, reason: rule);
    }
    expect(
      validNetworkRules(List.generate(17, (i) => '10.0.0.$i').join(',')),
      false,
    );
  });
}
