// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionInfo _$SubscriptionInfoFromJson(Map<String, dynamic> json) =>
    _SubscriptionInfo(
      upload: (json['upload'] as num?)?.toInt() ?? 0,
      download: (json['download'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      expire: (json['expire'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SubscriptionInfoToJson(_SubscriptionInfo instance) =>
    <String, dynamic>{
      'upload': instance.upload,
      'download': instance.download,
      'total': instance.total,
      'expire': instance.expire,
    };

_ProxyChain _$ProxyChainFromJson(Map<String, dynamic> json) => _ProxyChain(
  id: (json['id'] as num).toInt(),
  enable: json['enable'] as bool? ?? true,
  name: json['name'] as String? ?? '',
  proxies:
      (json['proxies'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ProxyChainToJson(_ProxyChain instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enable': instance.enable,
      'name': instance.name,
      'proxies': instance.proxies,
    };

_ProfileProxy _$ProfileProxyFromJson(Map<String, dynamic> json) =>
    _ProfileProxy(
      id: (json['id'] as num).toInt(),
      enable: json['enable'] as bool? ?? true,
      uri: json['uri'] as String? ?? '',
      proxy: json['proxy'] as Map<String, dynamic>? ?? const {},
      emptyOptions:
          (json['emptyOptions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$ProfileProxyToJson(_ProfileProxy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enable': instance.enable,
      'uri': instance.uri,
      'proxy': instance.proxy,
      'emptyOptions': instance.emptyOptions.toList(),
    };

_ProviderHealthCheck _$ProviderHealthCheckFromJson(Map<String, dynamic> json) =>
    _ProviderHealthCheck(
      url: json['url'] as String?,
      interval: (json['interval'] as num?)?.toInt(),
      timeout: (json['timeout'] as num?)?.toInt(),
      lazy: json['lazy'] as bool?,
      expectedStatus: json['expected-status'] as String?,
    );

Map<String, dynamic> _$ProviderHealthCheckToJson(
  _ProviderHealthCheck instance,
) => <String, dynamic>{
  'url': instance.url,
  'interval': instance.interval,
  'timeout': instance.timeout,
  'lazy': instance.lazy,
  'expected-status': instance.expectedStatus,
};

_ProviderOverride _$ProviderOverrideFromJson(Map<String, dynamic> json) =>
    _ProviderOverride(
      additionalPrefix: json['additional-prefix'] as String?,
      additionalSuffix: json['additional-suffix'] as String?,
      udp: json['udp'] as bool?,
      ipVersion: json['ip-version'] as String?,
    );

Map<String, dynamic> _$ProviderOverrideToJson(_ProviderOverride instance) =>
    <String, dynamic>{
      'additional-prefix': instance.additionalPrefix,
      'additional-suffix': instance.additionalSuffix,
      'udp': instance.udp,
      'ip-version': instance.ipVersion,
    };

_ProxyProviderOptions _$ProxyProviderOptionsFromJson(
  Map<String, dynamic> json,
) => _ProxyProviderOptions(
  healthCheck: json['health-check'] == null
      ? const ProviderHealthCheck()
      : ProviderHealthCheck.fromJson(
          json['health-check'] as Map<String, dynamic>,
        ),
  filter: json['filter'] as String?,
  excludeFilter: json['exclude-filter'] as String?,
  proxyOverride: json['override'] == null
      ? const ProviderOverride()
      : ProviderOverride.fromJson(json['override'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProxyProviderOptionsToJson(
  _ProxyProviderOptions instance,
) => <String, dynamic>{
  'health-check': instance.healthCheck,
  'filter': instance.filter,
  'exclude-filter': instance.excludeFilter,
  'override': instance.proxyOverride,
};

_ProfileOverrides _$ProfileOverridesFromJson(Map<String, dynamic> json) =>
    _ProfileOverrides(
      dns: json['dns'] == null
          ? defaultDns
          : Dns.safeDnsFromJson(json['dns'] as Map<String, Object?>),
      dnsOverrideKeys: json['dns-override-keys'] == null
          ? const {}
          : dnsOverrideKeysFromJson(json['dns-override-keys'] as List),
      ntp: json['ntp'] == null
          ? defaultNtp
          : Ntp.safeNtpFromJson(json['ntp'] as Map<String, Object?>),
      ntpOverrideKeys: json['ntp-override-keys'] == null
          ? const {}
          : ntpOverrideKeysFromJson(json['ntp-override-keys'] as List),
      sniffer: json['sniffer'] == null
          ? defaultSniffer
          : Sniffer.safeSnifferFromJson(
              json['sniffer'] as Map<String, Object?>,
            ),
      snifferOverrideKeys: json['sniffer-override-keys'] == null
          ? const {}
          : snifferOverrideKeysFromJson(json['sniffer-override-keys'] as List),
      tun: json['tun'] == null
          ? defaultProfileTun
          : ProfileTun.safeFromJson(json['tun'] as Map<String, Object?>),
      tunOverrideKeys: json['tun-override-keys'] == null
          ? const {}
          : tunOverrideKeysFromJson(json['tun-override-keys'] as List),
      proxyProviders:
          (json['proxy-providers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              ProxyProviderOptions.fromJson(e as Map<String, dynamic>),
            ),
          ) ??
          const {},
    );

Map<String, dynamic> _$ProfileOverridesToJson(_ProfileOverrides instance) =>
    <String, dynamic>{
      'dns': instance.dns,
      'dns-override-keys': instance.dnsOverrideKeys
          .map((e) => _$DnsOverrideKeyEnumMap[e]!)
          .toList(),
      'ntp': instance.ntp,
      'ntp-override-keys': instance.ntpOverrideKeys
          .map((e) => _$NtpOverrideKeyEnumMap[e]!)
          .toList(),
      'sniffer': instance.sniffer,
      'sniffer-override-keys': instance.snifferOverrideKeys
          .map((e) => _$SnifferOverrideKeyEnumMap[e]!)
          .toList(),
      'tun': instance.tun,
      'tun-override-keys': instance.tunOverrideKeys
          .map((e) => _$TunOverrideKeyEnumMap[e]!)
          .toList(),
      'proxy-providers': instance.proxyProviders,
    };

const _$DnsOverrideKeyEnumMap = {
  DnsOverrideKey.enable: 'enable',
  DnsOverrideKey.listen: 'listen',
  DnsOverrideKey.listenRoutingMark: 'listen-routing-mark',
  DnsOverrideKey.useHosts: 'use-hosts',
  DnsOverrideKey.useSystemHosts: 'use-system-hosts',
  DnsOverrideKey.ipv6: 'ipv6',
  DnsOverrideKey.ipv6Timeout: 'ipv6-timeout',
  DnsOverrideKey.respectRules: 'respect-rules',
  DnsOverrideKey.preferH3: 'prefer-h3',
  DnsOverrideKey.cacheAlgorithm: 'cache-algorithm',
  DnsOverrideKey.cacheMaxSize: 'cache-max-size',
  DnsOverrideKey.enhancedMode: 'enhanced-mode',
  DnsOverrideKey.fakeIpRange: 'fake-ip-range',
  DnsOverrideKey.fakeIpRange6: 'fake-ip-range6',
  DnsOverrideKey.fakeIpFilter: 'fake-ip-filter',
  DnsOverrideKey.fakeIpFilterMode: 'fake-ip-filter-mode',
  DnsOverrideKey.fakeIpTtl: 'fake-ip-ttl',
  DnsOverrideKey.defaultNameserver: 'default-nameserver',
  DnsOverrideKey.nameserverPolicy: 'nameserver-policy',
  DnsOverrideKey.nameserver: 'nameserver',
  DnsOverrideKey.fallback: 'fallback',
  DnsOverrideKey.fallbackLazyQuery: 'fallback-lazy-query',
  DnsOverrideKey.proxyServerNameserver: 'proxy-server-nameserver',
  DnsOverrideKey.proxyServerNameserverPolicy: 'proxy-server-nameserver-policy',
  DnsOverrideKey.directNameserver: 'direct-nameserver',
  DnsOverrideKey.directNameserverFollowPolicy:
      'direct-nameserver-follow-policy',
  DnsOverrideKey.fallbackFilterGeoip: 'fallback-filter.geoip',
  DnsOverrideKey.fallbackFilterGeoipCode: 'fallback-filter.geoip-code',
  DnsOverrideKey.fallbackFilterGeosite: 'fallback-filter.geosite',
  DnsOverrideKey.fallbackFilterIpcidr: 'fallback-filter.ipcidr',
  DnsOverrideKey.fallbackFilterDomain: 'fallback-filter.domain',
};

const _$NtpOverrideKeyEnumMap = {
  NtpOverrideKey.enable: 'enable',
  NtpOverrideKey.server: 'server',
  NtpOverrideKey.port: 'port',
  NtpOverrideKey.interval: 'interval',
  NtpOverrideKey.dialerProxy: 'dialer-proxy',
  NtpOverrideKey.writeToSystem: 'write-to-system',
};

const _$SnifferOverrideKeyEnumMap = {
  SnifferOverrideKey.enable: 'enable',
  SnifferOverrideKey.overrideDest: 'override-destination',
  SnifferOverrideKey.forceDnsMapping: 'force-dns-mapping',
  SnifferOverrideKey.parsePureIp: 'parse-pure-ip',
  SnifferOverrideKey.forceDomain: 'force-domain',
  SnifferOverrideKey.skipDomain: 'skip-domain',
  SnifferOverrideKey.skipSrcAddress: 'skip-src-address',
  SnifferOverrideKey.skipDstAddress: 'skip-dst-address',
  SnifferOverrideKey.sniffHttp: 'sniff.HTTP',
  SnifferOverrideKey.sniffTls: 'sniff.TLS',
  SnifferOverrideKey.sniffQuic: 'sniff.QUIC',
};

const _$TunOverrideKeyEnumMap = {
  TunOverrideKey.mtu: 'mtu',
  TunOverrideKey.congestionController: 'congestion-controller',
  TunOverrideKey.strictRoute: 'strict-route',
  TunOverrideKey.routeAddress: 'route-address',
  TunOverrideKey.routeExcludeAddress: 'route-exclude-address',
  TunOverrideKey.dnsHijack: 'dns-hijack',
  TunOverrideKey.udpTimeout: 'udp-timeout',
  TunOverrideKey.disableIcmpForwarding: 'disable-icmp-forwarding',
  TunOverrideKey.gso: 'gso',
  TunOverrideKey.includeInterface: 'include-interface',
  TunOverrideKey.excludeInterface: 'exclude-interface',
  TunOverrideKey.includeUid: 'include-uid',
  TunOverrideKey.excludeUid: 'exclude-uid',
  TunOverrideKey.excludeSrcPort: 'exclude-src-port',
  TunOverrideKey.excludeDstPort: 'exclude-dst-port',
};

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: (json['id'] as num).toInt(),
  label: json['label'] as String? ?? '',
  currentGroupName: json['currentGroupName'] as String?,
  url: json['url'] as String? ?? '',
  lastUpdateDate: json['lastUpdateDate'] == null
      ? null
      : DateTime.parse(json['lastUpdateDate'] as String),
  autoUpdateDuration: Duration(
    microseconds: (json['autoUpdateDuration'] as num).toInt(),
  ),
  subscriptionInfo: json['subscriptionInfo'] == null
      ? null
      : SubscriptionInfo.fromJson(
          json['subscriptionInfo'] as Map<String, dynamic>,
        ),
  autoUpdate: json['autoUpdate'] as bool? ?? true,
  selectedMap:
      (json['selectedMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  unfoldSet:
      (json['unfoldSet'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
      const {},
  overwriteType:
      $enumDecodeNullable(_$OverwriteTypeEnumMap, json['overwriteType']) ??
      OverwriteType.standard,
  proxyChains:
      (json['proxyChains'] as List<dynamic>?)
          ?.map((e) => ProxyChain.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  profileProxies:
      (json['profileProxies'] as List<dynamic>?)
          ?.map((e) => ProfileProxy.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  customProxyGroups:
      (json['customProxyGroups'] as List<dynamic>?)
          ?.map((e) => ProxyGroup.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  customRules:
      (json['customRules'] as List<dynamic>?)
          ?.map((e) => Rule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  scriptId: (json['scriptId'] as num?)?.toInt(),
  matchTarget: json['matchTarget'] as String?,
  order: (json['order'] as num?)?.toInt(),
  profileType: $enumDecodeNullable(_$ProfileTypeEnumMap, json['profileType']),
  overrides: json['overrides'] == null
      ? const ProfileOverrides()
      : ProfileOverrides.safeFromJson(
          json['overrides'] as Map<String, Object?>,
        ),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'currentGroupName': instance.currentGroupName,
  'url': instance.url,
  'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
  'autoUpdateDuration': instance.autoUpdateDuration.inMicroseconds,
  'subscriptionInfo': instance.subscriptionInfo,
  'autoUpdate': instance.autoUpdate,
  'selectedMap': instance.selectedMap,
  'unfoldSet': instance.unfoldSet.toList(),
  'overwriteType': _$OverwriteTypeEnumMap[instance.overwriteType]!,
  'proxyChains': instance.proxyChains,
  'profileProxies': instance.profileProxies,
  'customProxyGroups': instance.customProxyGroups,
  'customRules': instance.customRules,
  'scriptId': instance.scriptId,
  'matchTarget': instance.matchTarget,
  'order': instance.order,
  'profileType': _$ProfileTypeEnumMap[instance.profileType],
  'overrides': instance.overrides,
};

const _$OverwriteTypeEnumMap = {
  OverwriteType.standard: 'standard',
  OverwriteType.script: 'script',
  OverwriteType.custom: 'custom',
  OverwriteType.merge: 'merge',
};

const _$ProfileTypeEnumMap = {
  ProfileType.file: 'file',
  ProfileType.url: 'url',
  ProfileType.custom: 'custom',
};
