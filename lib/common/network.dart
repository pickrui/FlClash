import 'dart:io';

extension NetworkInterfaceExt on NetworkInterface {
  bool get isWifi {
    final nameLowCase = name.toLowerCase();
    if (nameLowCase.contains('wlan') ||
        nameLowCase.contains('wi-fi') ||
        nameLowCase == 'en0' ||
        nameLowCase == 'eth0') {
      return true;
    }

    return false;
  }

  bool get includesIPv4 {
    return addresses.any((addr) => addr.isIPv4);
  }
}

extension InternetAddressExt on InternetAddress {
  bool get isIPv4 {
    return type == InternetAddressType.IPv4;
  }

  bool get isGlobalIPv6 {
    if (type != InternetAddressType.IPv6) {
      return false;
    }
    if (isLoopback || isLinkLocal || isMulticast) {
      return false;
    }
    // Exclude unique-local addresses (fc00::/7).
    final firstByte = rawAddress.isNotEmpty ? rawAddress.first : 0;
    return (firstByte & 0xfe) != 0xfc;
  }
}

/// Mirrored by MAX_RULES in NetworkRuleMatcher.kt.
const maxNetworkRules = 16;

const _gatewayPrefix = 'gateway:';
final _octetPattern = RegExp(r'^\d{1,3}$');
final _prefixPattern = RegExp(r'^\d{1,2}$');

bool validNetworkRule(String rule) {
  var value = rule.trim();
  if (value.toLowerCase().startsWith(_gatewayPrefix)) {
    value = value.substring(_gatewayPrefix.length).trim();
  }
  final parts = value.split('/');
  if (parts.length > 2) return false;
  final octets = parts.first.split('.');
  if (octets.length != 4 ||
      octets.any(
        (part) => !_octetPattern.hasMatch(part) || int.parse(part) > 255,
      )) {
    return false;
  }
  if (parts.length == 1) return true;
  return _prefixPattern.hasMatch(parts[1]) && int.parse(parts[1]) <= 32;
}

List<String> parseNetworkRules(String value) => value
    .split(',')
    .map((v) => v.trim())
    .where((v) => v.isNotEmpty)
    .toSet()
    .toList();

bool validNetworkRules(String value) {
  final rules = parseNetworkRules(value);
  return rules.length <= maxNetworkRules && rules.every(validNetworkRule);
}
