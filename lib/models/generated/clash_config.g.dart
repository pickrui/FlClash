// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../clash_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProxyGroup _$ProxyGroupFromJson(Map<String, dynamic> json) => _ProxyGroup(
  id: (json['id'] as num?)?.toInt(),
  profileId: (json['profileId'] as num?)?.toInt(),
  order: json['order'] as String?,
  name: json['name'] as String,
  type: GroupType.parseProfileType(json['type'] as String),
  proxies: _parseStringList(json['proxies']),
  use: _parseStringList(json['use']),
  usePosition: usePositionOf(json['use-position']),
  interval: _parseInt(json['interval']),
  tolerance: _parseInt(json['tolerance']),
  lazy: _parseBool(json['lazy']),
  disableUdp: _parseBool(json['disable-udp']),
  url: json['url'] as String?,
  timeout: _parseInt(json['timeout']),
  maxFailedTimes: _parseInt(json['max-failed-times']),
  filter: json['filter'] as String?,
  excludeFilter: json['exclude-filter'] as String?,
  excludeType: json['exclude-type'] as String?,
  emptyFallback: json['empty-fallback'] as String?,
  expectedStatus: json['expected-status'],
  includeAll: _parseBool(json['include-all']),
  includeAllProxies: _parseBool(json['include-all-proxies']),
  includeAllProviders: _parseBool(json['include-all-providers']),
  strategy: json['strategy'] as String?,
  hashKey: json['hash-key'] as String?,
  defaultSelected: json['default-selected'] as String?,
  hidden: _parseBool(json['hidden']),
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$ProxyGroupToJson(_ProxyGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$GroupTypeEnumMap[instance.type]!,
      'proxies': instance.proxies,
      'use': instance.use,
      'use-position': instance.usePosition,
      'interval': instance.interval,
      'tolerance': instance.tolerance,
      'lazy': instance.lazy,
      'disable-udp': instance.disableUdp,
      'url': instance.url,
      'timeout': instance.timeout,
      'max-failed-times': instance.maxFailedTimes,
      'filter': instance.filter,
      'exclude-filter': instance.excludeFilter,
      'exclude-type': instance.excludeType,
      'empty-fallback': instance.emptyFallback,
      'expected-status': instance.expectedStatus,
      'include-all': instance.includeAll,
      'include-all-proxies': instance.includeAllProxies,
      'include-all-providers': instance.includeAllProviders,
      'strategy': instance.strategy,
      'hash-key': instance.hashKey,
      'default-selected': instance.defaultSelected,
      'hidden': instance.hidden,
      'icon': instance.icon,
    };

const _$GroupTypeEnumMap = {
  GroupType.Selector: 'select',
  GroupType.URLTest: 'url-test',
  GroupType.Fallback: 'fallback',
  GroupType.LoadBalance: 'load-balance',
  GroupType.Relay: 'relay',
};

_RuleProvider _$RuleProviderFromJson(Map<String, dynamic> json) =>
    _RuleProvider(name: json['name'] as String);

Map<String, dynamic> _$RuleProviderToJson(_RuleProvider instance) =>
    <String, dynamic>{'name': instance.name};

_Tun _$TunFromJson(Map<String, dynamic> json) => _Tun(
  enable: json['enable'] as bool? ?? false,
  device: json['device'] as String? ?? appName,
  stack:
      $enumDecodeNullable(_$TunStackEnumMap, json['stack']) ?? TunStack.mixed,
  mtu: json['mtu'] == null
      ? defaultTunMtu
      : normalizeTunMtu((json['mtu'] as num?)?.toInt()),
  routeAddress:
      (json['route-address'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  routeExcludeAddress:
      (json['route-exclude-address'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  congestionController: json['congestion-controller'] == null
      ? defaultCongestionController
      : normalizeCongestionController(json['congestion-controller'] as String?),
);

Map<String, dynamic> _$TunToJson(_Tun instance) => <String, dynamic>{
  'enable': instance.enable,
  'device': instance.device,
  'stack': _$TunStackEnumMap[instance.stack]!,
  'mtu': instance.mtu,
  'route-address': instance.routeAddress,
  'route-exclude-address': instance.routeExcludeAddress,
  'congestion-controller': instance.congestionController,
};

const _$TunStackEnumMap = {
  TunStack.gvisor: 'gvisor',
  TunStack.system: 'system',
  TunStack.mixed: 'mixed',
  TunStack.mips: 'mips',
};

_ProfileTun _$ProfileTunFromJson(Map<String, dynamic> json) => _ProfileTun(
  mtu: json['mtu'] == null
      ? defaultTunMtu
      : normalizeTunMtu((json['mtu'] as num?)?.toInt()),
  congestionController: json['congestion-controller'] == null
      ? defaultCongestionController
      : normalizeCongestionController(json['congestion-controller'] as String?),
  strictRoute: json['strict-route'] as bool? ?? false,
  routeAddress:
      (json['route-address'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  routeExcludeAddress:
      (json['route-exclude-address'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  dnsHijack:
      (json['dns-hijack'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      defaultDnsHijack,
  udpTimeout: (json['udp-timeout'] as num?)?.toInt() ?? defaultTunUdpTimeout,
  disableIcmpForwarding: json['disable-icmp-forwarding'] as bool? ?? false,
  gso: json['gso'] as bool? ?? false,
  includeInterface:
      (json['include-interface'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  excludeInterface:
      (json['exclude-interface'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  includeUid:
      (json['include-uid'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  excludeUid:
      (json['exclude-uid'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  excludeSrcPort:
      (json['exclude-src-port'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  excludeDstPort:
      (json['exclude-dst-port'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProfileTunToJson(_ProfileTun instance) =>
    <String, dynamic>{
      'mtu': instance.mtu,
      'congestion-controller': instance.congestionController,
      'strict-route': instance.strictRoute,
      'route-address': instance.routeAddress,
      'route-exclude-address': instance.routeExcludeAddress,
      'dns-hijack': instance.dnsHijack,
      'udp-timeout': instance.udpTimeout,
      'disable-icmp-forwarding': instance.disableIcmpForwarding,
      'gso': instance.gso,
      'include-interface': instance.includeInterface,
      'exclude-interface': instance.excludeInterface,
      'include-uid': instance.includeUid,
      'exclude-uid': instance.excludeUid,
      'exclude-src-port': instance.excludeSrcPort,
      'exclude-dst-port': instance.excludeDstPort,
    };

_FallbackFilter _$FallbackFilterFromJson(
  Map<String, dynamic> json,
) => _FallbackFilter(
  geoip: json['geoip'] as bool? ?? true,
  geoipCode: json['geoip-code'] as String? ?? 'CN',
  geosite:
      (json['geosite'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const ['gfw'],
  ipcidr:
      (json['ipcidr'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const ['240.0.0.0/4'],
  domain:
      (json['domain'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const ['+.google.com', '+.facebook.com', '+.youtube.com'],
);

Map<String, dynamic> _$FallbackFilterToJson(_FallbackFilter instance) =>
    <String, dynamic>{
      'geoip': instance.geoip,
      'geoip-code': instance.geoipCode,
      'geosite': instance.geosite,
      'ipcidr': instance.ipcidr,
      'domain': instance.domain,
    };

_Dns _$DnsFromJson(Map<String, dynamic> json) => _Dns(
  enable: json['enable'] as bool? ?? true,
  listen: json['listen'] as String? ?? '',
  listenRoutingMark: (json['listen-routing-mark'] as num?)?.toInt() ?? 0,
  preferH3: json['prefer-h3'] as bool? ?? false,
  useHosts: json['use-hosts'] as bool? ?? true,
  useSystemHosts: json['use-system-hosts'] as bool? ?? true,
  respectRules: json['respect-rules'] as bool? ?? false,
  ipv6: json['ipv6'] as bool? ?? false,
  ipv6Timeout: (json['ipv6-timeout'] as num?)?.toInt() ?? 100,
  cacheAlgorithm:
      $enumDecodeNullable(
        _$DnsCacheAlgorithmEnumMap,
        json['cache-algorithm'],
      ) ??
      DnsCacheAlgorithm.lru,
  cacheMaxSize: (json['cache-max-size'] as num?)?.toInt() ?? 4096,
  fakeIpTtl: (json['fake-ip-ttl'] as num?)?.toInt() ?? 1,
  fakeIpRange6: json['fake-ip-range6'] as String? ?? 'fdfe:dcba:9876::1/64',
  fakeIpFilterMode:
      $enumDecodeNullable(
        _$FakeIpFilterModeEnumMap,
        json['fake-ip-filter-mode'],
      ) ??
      FakeIpFilterMode.blacklist,
  proxyServerNameserverPolicy:
      (json['proxy-server-nameserver-policy'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  directNameserver:
      (json['direct-nameserver'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  directNameserverFollowPolicy:
      json['direct-nameserver-follow-policy'] as bool? ?? false,
  defaultNameserver:
      (json['default-nameserver'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const ['223.5.5.5'],
  enhancedMode:
      $enumDecodeNullable(_$DnsModeEnumMap, json['enhanced-mode']) ??
      DnsMode.fakeIp,
  fakeIpRange: json['fake-ip-range'] as String? ?? '198.18.0.1/16',
  fakeIpFilter:
      (json['fake-ip-filter'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const ['*.lan', 'localhost.ptlogin2.qq.com'],
  nameserverPolicy:
      (json['nameserver-policy'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  nameserver:
      (json['nameserver'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const ['https://doh.pub/dns-query', 'https://dns.alidns.com/dns-query'],
  fallback:
      (json['fallback'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  fallbackLazyQuery: json['fallback-lazy-query'] as bool? ?? false,
  proxyServerNameserver:
      (json['proxy-server-nameserver'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  fallbackFilter: json['fallback-filter'] == null
      ? const FallbackFilter()
      : FallbackFilter.fromJson(
          json['fallback-filter'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$DnsToJson(_Dns instance) => <String, dynamic>{
  'enable': instance.enable,
  'listen': instance.listen,
  'listen-routing-mark': instance.listenRoutingMark,
  'prefer-h3': instance.preferH3,
  'use-hosts': instance.useHosts,
  'use-system-hosts': instance.useSystemHosts,
  'respect-rules': instance.respectRules,
  'ipv6': instance.ipv6,
  'ipv6-timeout': instance.ipv6Timeout,
  'cache-algorithm': _$DnsCacheAlgorithmEnumMap[instance.cacheAlgorithm]!,
  'cache-max-size': instance.cacheMaxSize,
  'fake-ip-ttl': instance.fakeIpTtl,
  'fake-ip-range6': instance.fakeIpRange6,
  'fake-ip-filter-mode': _$FakeIpFilterModeEnumMap[instance.fakeIpFilterMode]!,
  'proxy-server-nameserver-policy': instance.proxyServerNameserverPolicy,
  'direct-nameserver': instance.directNameserver,
  'direct-nameserver-follow-policy': instance.directNameserverFollowPolicy,
  'default-nameserver': instance.defaultNameserver,
  'enhanced-mode': _$DnsModeEnumMap[instance.enhancedMode]!,
  'fake-ip-range': instance.fakeIpRange,
  'fake-ip-filter': instance.fakeIpFilter,
  'nameserver-policy': instance.nameserverPolicy,
  'nameserver': instance.nameserver,
  'fallback': instance.fallback,
  'fallback-lazy-query': instance.fallbackLazyQuery,
  'proxy-server-nameserver': instance.proxyServerNameserver,
  'fallback-filter': instance.fallbackFilter,
};

const _$DnsCacheAlgorithmEnumMap = {
  DnsCacheAlgorithm.lru: 'lru',
  DnsCacheAlgorithm.arc: 'arc',
};

const _$FakeIpFilterModeEnumMap = {
  FakeIpFilterMode.blacklist: 'blacklist',
  FakeIpFilterMode.whitelist: 'whitelist',
  FakeIpFilterMode.rule: 'rule',
};

const _$DnsModeEnumMap = {
  DnsMode.normal: 'normal',
  DnsMode.fakeIp: 'fake-ip',
  DnsMode.redirHost: 'redir-host',
  DnsMode.hosts: 'hosts',
};

_Ntp _$NtpFromJson(Map<String, dynamic> json) => _Ntp(
  enable: json['enable'] as bool? ?? false,
  server: json['server'] as String? ?? 'time.apple.com',
  port: (json['port'] as num?)?.toInt() ?? 123,
  interval: (json['interval'] as num?)?.toInt() ?? 30,
  dialerProxy: json['dialer-proxy'] as String? ?? '',
  writeToSystem: json['write-to-system'] as bool? ?? false,
);

Map<String, dynamic> _$NtpToJson(_Ntp instance) => <String, dynamic>{
  'enable': instance.enable,
  'server': instance.server,
  'port': instance.port,
  'interval': instance.interval,
  'dialer-proxy': instance.dialerProxy,
  'write-to-system': instance.writeToSystem,
};

_Sniffer _$SnifferFromJson(Map<String, dynamic> json) => _Sniffer(
  enable: json['enable'] as bool? ?? false,
  overrideDest: json['override-destination'] as bool? ?? true,
  forceDnsMapping: json['force-dns-mapping'] as bool? ?? true,
  parsePureIp: json['parse-pure-ip'] as bool? ?? true,
  forceDomain:
      (json['force-domain'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  skipDomain:
      (json['skip-domain'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  skipSrcAddress:
      (json['skip-src-address'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  skipDstAddress:
      (json['skip-dst-address'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sniff:
      (json['sniff'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, SnifferConfig.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
);

Map<String, dynamic> _$SnifferToJson(_Sniffer instance) => <String, dynamic>{
  'enable': instance.enable,
  'override-destination': instance.overrideDest,
  'force-dns-mapping': instance.forceDnsMapping,
  'parse-pure-ip': instance.parsePureIp,
  'force-domain': instance.forceDomain,
  'skip-domain': instance.skipDomain,
  'skip-src-address': instance.skipSrcAddress,
  'skip-dst-address': instance.skipDstAddress,
  'sniff': instance.sniff,
};

_SnifferConfig _$SnifferConfigFromJson(Map<String, dynamic> json) =>
    _SnifferConfig(
      ports: json['ports'] == null
          ? const []
          : _portsFromJson(json['ports'] as List?),
      overrideDest: json['override-destination'] as bool?,
    );

Map<String, dynamic> _$SnifferConfigToJson(_SnifferConfig instance) =>
    <String, dynamic>{
      'ports': instance.ports,
      'override-destination': ?instance.overrideDest,
    };

_GeoXUrl _$GeoXUrlFromJson(Map<String, dynamic> json) => _GeoXUrl(
  mmdb: json['mmdb'] as String? ?? 'https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geoip.metadb',
  asn: json['asn'] as String? ?? 'https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/GeoLite2-ASN.mmdb',
  geoip: json['geoip'] as String? ?? 'https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geoip.dat',
  geosite: json['geosite'] as String? ?? 'https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geosite.dat',
);

Map<String, dynamic> _$GeoXUrlToJson(_GeoXUrl instance) => <String, dynamic>{
  'mmdb': instance.mmdb,
  'asn': instance.asn,
  'geoip': instance.geoip,
  'geosite': instance.geosite,
};

_Rule _$RuleFromJson(Map<String, dynamic> json) => _Rule(
  id: (json['id'] as num).toInt(),
  value: json['value'] as String,
  order: json['order'] as String?,
);

Map<String, dynamic> _$RuleToJson(_Rule instance) => <String, dynamic>{
  'id': instance.id,
  'value': instance.value,
  'order': instance.order,
};

_SubRule _$SubRuleFromJson(Map<String, dynamic> json) =>
    _SubRule(name: json['name'] as String);

Map<String, dynamic> _$SubRuleToJson(_SubRule instance) => <String, dynamic>{
  'name': instance.name,
};

_ClashConfigSnippet _$ClashConfigSnippetFromJson(Map<String, dynamic> json) =>
    _ClashConfigSnippet(
      proxyGroups:
          (json['proxy-groups'] as List<dynamic>?)
              ?.map((e) => ProxyGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rule: json['rules'] == null ? const [] : _genRule(json['rules'] as List?),
      ruleProvider: json['rule-providers'] == null
          ? const []
          : _genRuleProviders(json['rule-providers'] as Map<String, dynamic>),
      subRules: json['sub-rules'] == null
          ? const []
          : _genSubRules(json['sub-rules'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClashConfigSnippetToJson(_ClashConfigSnippet instance) =>
    <String, dynamic>{
      'proxy-groups': instance.proxyGroups,
      'rules': instance.rule,
      'rule-providers': instance.ruleProvider,
      'sub-rules': instance.subRules,
    };

_ClashConfig _$ClashConfigFromJson(Map<String, dynamic> json) => _ClashConfig(
  mixedPort: (json['mixed-port'] as num?)?.toInt() ?? defaultMixedPort,
  socksPort: (json['socks-port'] as num?)?.toInt() ?? 0,
  port: (json['port'] as num?)?.toInt() ?? 0,
  redirPort: (json['redir-port'] as num?)?.toInt() ?? 0,
  tproxyPort: (json['tproxy-port'] as num?)?.toInt() ?? 0,
  mode: $enumDecodeNullable(_$ModeEnumMap, json['mode']) ?? Mode.rule,
  allowLan: json['allow-lan'] as bool? ?? false,
  logLevel:
      $enumDecodeNullable(_$LogLevelEnumMap, json['log-level']) ??
      LogLevel.error,
  ipv6: json['ipv6'] as bool? ?? false,
  findProcessMode:
      $enumDecodeNullable(
        _$FindProcessModeEnumMap,
        json['find-process-mode'],
        unknownValue: FindProcessMode.off,
      ) ??
      FindProcessMode.off,
  keepAliveInterval:
      (json['keep-alive-interval'] as num?)?.toInt() ??
      defaultKeepAliveInterval,
  keepAliveIdle:
      (json['keep-alive-idle'] as num?)?.toInt() ?? defaultKeepAliveIdle,
  disableKeepAlive: json['disable-keep-alive'] as bool? ?? false,
  routingMark: (json['routing-mark'] as num?)?.toInt() ?? 0,
  unifiedDelay: json['unified-delay'] as bool? ?? true,
  tcpConcurrent: json['tcp-concurrent'] as bool? ?? true,
  tun: json['tun'] == null
      ? defaultTun
      : Tun.safeFormJson(json['tun'] as Map<String, Object?>?),
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
  tunOverride: json['tun-override'] == null
      ? defaultProfileTun
      : ProfileTun.safeFromJson(json['tun-override'] as Map<String, Object?>),
  tunOverrideKeys: json['tun-override-keys'] == null
      ? const {}
      : tunOverrideKeysFromJson(json['tun-override-keys'] as List),
  geoXUrl: json['geox-url'] == null
      ? defaultGeoXUrl
      : GeoXUrl.safeFormJson(json['geox-url'] as Map<String, Object?>?),
  geodataLoader:
      $enumDecodeNullable(_$GeodataLoaderEnumMap, json['geodata-loader']) ??
      GeodataLoader.memconservative,
  proxyGroups:
      (json['proxy-groups'] as List<dynamic>?)
          ?.map((e) => ProxyGroup.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  rule:
      (json['rule'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  interfaceName: json['interface-name'] as String?,
  externalController:
      $enumDecodeNullable(
        _$ExternalControllerStatusEnumMap,
        json['external-controller'],
      ) ??
      ExternalControllerStatus.close,
  externalControllerAddress:
      json['external-controller-address'] as String? ??
      defaultExternalControllerAddress,
  secret: json['secret'] as String? ?? '',
  hosts:
      (json['hosts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  geoAutoUpdate: json['geo-auto-update'] as bool? ?? true,
  geoUpdateInterval:
      (json['geo-update-interval'] as num?)?.toInt() ??
      defaultGeoUpdateInterval,
);

Map<String, dynamic> _$ClashConfigToJson(_ClashConfig instance) =>
    <String, dynamic>{
      'mixed-port': instance.mixedPort,
      'socks-port': instance.socksPort,
      'port': instance.port,
      'redir-port': instance.redirPort,
      'tproxy-port': instance.tproxyPort,
      'mode': _$ModeEnumMap[instance.mode]!,
      'allow-lan': instance.allowLan,
      'log-level': _$LogLevelEnumMap[instance.logLevel]!,
      'ipv6': instance.ipv6,
      'find-process-mode': _$FindProcessModeEnumMap[instance.findProcessMode]!,
      'keep-alive-interval': instance.keepAliveInterval,
      'keep-alive-idle': instance.keepAliveIdle,
      'disable-keep-alive': instance.disableKeepAlive,
      'routing-mark': instance.routingMark,
      'unified-delay': instance.unifiedDelay,
      'tcp-concurrent': instance.tcpConcurrent,
      'tun': instance.tun,
      'dns': instance.dns,
      'dns-override-keys': instance.dnsOverrideKeys
          .map((e) => _$DnsOverrideKeyEnumMap[e]!)
          .toList(),
      'ntp': instance.ntp,
      'ntp-override-keys': instance.ntpOverrideKeys
          .map((e) => _$NtpOverrideKeyEnumMap[e]!)
          .toList(),
      'tun-override': instance.tunOverride,
      'tun-override-keys': instance.tunOverrideKeys
          .map((e) => _$TunOverrideKeyEnumMap[e]!)
          .toList(),
      'geox-url': instance.geoXUrl,
      'geodata-loader': _$GeodataLoaderEnumMap[instance.geodataLoader]!,
      'proxy-groups': instance.proxyGroups,
      'rule': instance.rule,
      'interface-name': instance.interfaceName,
      'external-controller':
          _$ExternalControllerStatusEnumMap[instance.externalController]!,
      'external-controller-address': instance.externalControllerAddress,
      'secret': instance.secret,
      'hosts': instance.hosts,
      'geo-auto-update': instance.geoAutoUpdate,
      'geo-update-interval': instance.geoUpdateInterval,
    };

const _$ModeEnumMap = {
  Mode.rule: 'rule',
  Mode.global: 'global',
  Mode.direct: 'direct',
};

const _$LogLevelEnumMap = {
  LogLevel.debug: 'debug',
  LogLevel.info: 'info',
  LogLevel.warning: 'warning',
  LogLevel.error: 'error',
  LogLevel.silent: 'silent',
};

const _$FindProcessModeEnumMap = {
  FindProcessMode.always: 'always',
  FindProcessMode.off: 'off',
  FindProcessMode.strict: 'strict',
};

const _$GeodataLoaderEnumMap = {
  GeodataLoader.standard: 'standard',
  GeodataLoader.memconservative: 'memconservative',
};

const _$ExternalControllerStatusEnumMap = {
  ExternalControllerStatus.close: '',
  ExternalControllerStatus.open: '127.0.0.1:9090',
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
