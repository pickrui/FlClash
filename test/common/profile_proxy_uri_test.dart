import 'package:fl_clash/features/overwrite/profile_proxy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const cases = <String, Map<String, Object>>{
    'ss://YWVzLTEyOC1nY206cGFzcw@1.2.3.4:8388#SS%20Node': {
      'name': 'SS Node',
      'type': 'ss',
      'server': '1.2.3.4',
      'port': 8388,
      'cipher': 'aes-128-gcm',
      'password': 'pass',
    },
    'ss://aes-128-gcm:pass@1.2.3.4:8388#Plain': {
      'name': 'Plain',
      'type': 'ss',
      'cipher': 'aes-128-gcm',
      'password': 'pass',
    },
    'ss://YWVzLTEyOC1nY206cGFzc0AxLjIuMy40OjgzODg=#Legacy': {
      'name': 'Legacy',
      'type': 'ss',
      'server': '1.2.3.4',
      'port': 8388,
      'cipher': 'aes-128-gcm',
      'password': 'pass',
    },
    'ssr://MS4yLjMuNDo4Mzg4Om9yaWdpbjphZXMtMjU2LWNmYjpwbGFpbjpjR0Z6Y3cvP3JlbWFya3M9VTFOU0lFNXZaR1UmcHJvdG9wYXJhbT1jSEE':
        {
          'name': 'SSR Node',
          'type': 'ssr',
          'server': '1.2.3.4',
          'port': 8388,
          'protocol': 'origin',
          'cipher': 'aes-256-cfb',
          'obfs': 'plain',
          'password': 'pass',
          'protocol-param': 'pp',
        },
    'vmess://eyJ2IjoiMiIsInBzIjoiVk1lc3MgSlNPTiIsImFkZCI6IjEuMi4zLjQiLCJwb3J0IjoiNDQzIiwiaWQiOiJ1dWlkLTEiLCJhaWQiOiIwIiwibmV0Ijoid3MiLCJwYXRoIjoiL3dzIiwiaG9zdCI6ImguZXhhbXBsZSIsInRscyI6InRscyIsInNuaSI6InNuaS5leGFtcGxlIn0=':
        {
          'name': 'VMess JSON',
          'type': 'vmess',
          'server': '1.2.3.4',
          'port': 443,
          'uuid': 'uuid-1',
          'tls': true,
          'servername': 'sni.example',
          'network': 'ws',
          'ws-opts': {
            'path': '/ws',
            'headers': {'Host': 'h.example'},
          },
        },
    'vmess://uuid-2@1.2.3.4:443?security=tls&type=ws&path=%2Fws#VMess%20URI': {
      'name': 'VMess URI',
      'type': 'vmess',
      'uuid': 'uuid-2',
      'tls': true,
      'network': 'ws',
      'ws-opts': {'path': '/ws'},
    },
    'vless://uuid-3@1.2.3.4:443?security=reality&pbk=PUB&sid=ab&sni=sni.example&fp=chrome&flow=xtls-rprx-vision&type=tcp#VLESS':
        {
          'name': 'VLESS',
          'type': 'vless',
          'uuid': 'uuid-3',
          'tls': true,
          'flow': 'xtls-rprx-vision',
          'servername': 'sni.example',
          'client-fingerprint': 'chrome',
          'reality-opts': {'public-key': 'PUB', 'short-id': 'ab'},
        },
    'trojan://pa%40ss@1.2.3.4:443?sni=sni.example&allowInsecure=1#Trojan': {
      'name': 'Trojan',
      'type': 'trojan',
      'password': 'pa@ss',
      'sni': 'sni.example',
      'skip-cert-verify': true,
    },
    'hysteria://1.2.3.4:443?auth=secret&peer=sni.example&upmbps=10&downmbps=50&insecure=1#Hy':
        {
          'name': 'Hy',
          'type': 'hysteria',
          'auth-str': 'secret',
          'sni': 'sni.example',
          'up': '10',
          'down': '50',
        },
    'hy2://pass@1.2.3.4?sni=sni.example&obfs=salamander&obfs-password=op#Hy2': {
      'name': 'Hy2',
      'type': 'hysteria2',
      'port': 443,
      'password': 'pass',
      'obfs': 'salamander',
      'obfs-password': 'op',
    },
    'tuic://uuid-4:pass@1.2.3.4:443?congestion-controller=bbr&alpn=h3&sni=sni.example#TUIC':
        {
          'name': 'TUIC',
          'type': 'tuic',
          'uuid': 'uuid-4',
          'password': 'pass',
          'alpn': ['h3'],
          'congestion-controller': 'bbr',
        },
    'wireguard://privkey@1.2.3.4:51820?publickey=pubkey&address=10.0.0.2/32,fd00::2/128&reserved=1,2,3&mtu=1280#WG':
        {
          'name': 'WG',
          'type': 'wireguard',
          'port': 51820,
          'private-key': 'privkey',
          'public-key': 'pubkey',
          'ip': '10.0.0.2',
          'ipv6': 'fd00::2',
          'reserved': [1, 2, 3],
          'mtu': 1280,
        },
    'anytls://pass@1.2.3.4:443?sni=sni.example#AnyTLS': {
      'name': 'AnyTLS',
      'type': 'anytls',
      'password': 'pass',
      'sni': 'sni.example',
    },
    'http://user:pass@1.2.3.4:8080#HTTP': {
      'name': 'HTTP',
      'type': 'http',
      'port': 8080,
      'username': 'user',
      'password': 'pass',
    },
    'https://1.2.3.4:8443': {'type': 'http', 'port': 8443, 'tls': true},
    'socks5://1.2.3.4': {'type': 'socks5', 'port': 1080},
    'socks5://user:p%2541ss@1.2.3.4:1080#x': {
      'type': 'socks5',
      'username': 'user',
      'password': 'p%41ss',
    },
    'http://dXNlcjpwYXNz@1.2.3.4:8080': {
      'username': 'user',
      'password': 'pass',
    },
    'socks5://dXNlcjpwJTQxc3M%3D@1.2.3.4:1080': {
      'username': 'user',
      'password': 'p%41ss',
    },
    'http://us%40er:pa%3Ass@h:1': {'username': 'us@er', 'password': 'pa:ss'},
  };

  for (final entry in cases.entries) {
    test('parses ${entry.key}', () {
      final proxy = parseProfileProxyUri(entry.key);
      for (final field in entry.value.entries) {
        expect(proxy[field.key], field.value, reason: field.key);
      }
    });
  }

  test('rejects an http URI without a port', () {
    expect(
      () => parseProfileProxyUri('http://1.2.3.4'),
      throwsA(isA<FormatException>()),
    );
  });
}
