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
