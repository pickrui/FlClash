// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SetupParams _$SetupParamsFromJson(Map<String, dynamic> json) => _SetupParams(
  selectedMap: Map<String, String>.from(json['selected-map'] as Map),
  options: CoreOptions.fromJson(json['options'] as Map<String, dynamic>),
  rawConfig: json['raw-config'] as String? ?? '',
  managedSnapshot: json['managed-snapshot'] as String? ?? '',
  suspendOnIdle: json['suspend-on-idle'] as bool? ?? false,
);

Map<String, dynamic> _$SetupParamsToJson(_SetupParams instance) =>
    <String, dynamic>{
      'selected-map': instance.selectedMap,
      'options': instance.options,
      'raw-config': instance.rawConfig,
      'managed-snapshot': instance.managedSnapshot,
      'suspend-on-idle': instance.suspendOnIdle,
    };

_CoreOptions _$CoreOptionsFromJson(Map<String, dynamic> json) => _CoreOptions(
  testUrl: json['test-url'] as String,
  delayTestTimeout:
      (json['delay-test-timeout'] as num?)?.toInt() ?? defaultDelayTestTimeout,
  mitmCapture: json['mitm-capture'] as bool? ?? false,
);

Map<String, dynamic> _$CoreOptionsToJson(_CoreOptions instance) =>
    <String, dynamic>{
      'test-url': instance.testUrl,
      'delay-test-timeout': instance.delayTestTimeout,
      'mitm-capture': instance.mitmCapture,
    };

_MitmCertificate _$MitmCertificateFromJson(Map<String, dynamic> json) =>
    _MitmCertificate(
      pem: json['pem'] as String,
      fingerprint: json['fingerprint'] as String,
      subject: json['subject'] as String,
      notBefore: DateTime.parse(json['not-before'] as String),
      notAfter: DateTime.parse(json['not-after'] as String),
    );

Map<String, dynamic> _$MitmCertificateToJson(_MitmCertificate instance) =>
    <String, dynamic>{
      'pem': instance.pem,
      'fingerprint': instance.fingerprint,
      'subject': instance.subject,
      'not-before': instance.notBefore.toIso8601String(),
      'not-after': instance.notAfter.toIso8601String(),
    };

_MitmScriptOutput _$MitmScriptOutputFromJson(Map<String, dynamic> json) =>
    _MitmScriptOutput(
      logs:
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      result: json['result'] as String? ?? '',
      error: json['error'] as String? ?? '',
    );

Map<String, dynamic> _$MitmScriptOutputToJson(_MitmScriptOutput instance) =>
    <String, dynamic>{
      'logs': instance.logs,
      'result': instance.result,
      'error': instance.error,
    };

MitmUrlRewriteView _$MitmUrlRewriteViewFromJson(Map<String, dynamic> json) =>
    MitmUrlRewriteView(
      pattern: json['pattern'] as String,
      action: json['action'] as String,
      replacement: json['replacement'] as String?,
      requestHead: json['requestHead'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MitmUrlRewriteViewToJson(MitmUrlRewriteView instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'action': instance.action,
      'replacement': instance.replacement,
      'requestHead': instance.requestHead,
      'type': instance.$type,
    };

MitmHeaderRewriteView _$MitmHeaderRewriteViewFromJson(
  Map<String, dynamic> json,
) => MitmHeaderRewriteView(
  phase: json['phase'] as String,
  pattern: json['pattern'] as String,
  requestHead: json['requestHead'] as String?,
  responseHead: json['responseHead'] as String?,
  action: json['action'] as String,
  name: json['name'] as String?,
  value: json['value'] as String?,
  regex: json['regex'] as String?,
  replacement: json['replacement'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MitmHeaderRewriteViewToJson(
  MitmHeaderRewriteView instance,
) => <String, dynamic>{
  'phase': instance.phase,
  'pattern': instance.pattern,
  'requestHead': instance.requestHead,
  'responseHead': instance.responseHead,
  'action': instance.action,
  'name': instance.name,
  'value': instance.value,
  'regex': instance.regex,
  'replacement': instance.replacement,
  'type': instance.$type,
};

MitmBodyRewriteView _$MitmBodyRewriteViewFromJson(Map<String, dynamic> json) =>
    MitmBodyRewriteView(
      phase: json['phase'] as String,
      pattern: json['pattern'] as String,
      requestHead: json['requestHead'] as String?,
      responseHead: json['responseHead'] as String?,
      replacements:
          (json['replacements'] as List<dynamic>?)
              ?.map(
                (e) => MitmBodyReplacement.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      jq: json['jq'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MitmBodyRewriteViewToJson(
  MitmBodyRewriteView instance,
) => <String, dynamic>{
  'phase': instance.phase,
  'pattern': instance.pattern,
  'requestHead': instance.requestHead,
  'responseHead': instance.responseHead,
  'replacements': instance.replacements,
  'jq': instance.jq,
  'type': instance.$type,
};

MitmMapLocalView _$MitmMapLocalViewFromJson(Map<String, dynamic> json) =>
    MitmMapLocalView(
      pattern: json['pattern'] as String,
      requestHead: json['requestHead'] as String?,
      dataType: json['dataType'] as String,
      data: json['data'] as String? ?? '',
      status: (json['status'] as num?)?.toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MitmMapLocalViewToJson(MitmMapLocalView instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'requestHead': instance.requestHead,
      'dataType': instance.dataType,
      'data': instance.data,
      'status': instance.status,
      'type': instance.$type,
    };

MitmScriptView _$MitmScriptViewFromJson(Map<String, dynamic> json) =>
    MitmScriptView(
      name: json['name'] as String,
      kind: json['kind'] as String,
      pattern: json['pattern'] as String?,
      cronexp: json['cronexp'] as String?,
      event: json['event'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MitmScriptViewToJson(MitmScriptView instance) =>
    <String, dynamic>{
      'name': instance.name,
      'kind': instance.kind,
      'pattern': instance.pattern,
      'cronexp': instance.cronexp,
      'event': instance.event,
      'type': instance.$type,
    };

MitmHostsView _$MitmHostsViewFromJson(Map<String, dynamic> json) =>
    MitmHostsView(
      entries:
          (json['entries'] as List<dynamic>?)
              ?.map((e) => MitmHostEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MitmHostsViewToJson(MitmHostsView instance) =>
    <String, dynamic>{'entries': instance.entries, 'type': instance.$type};

MitmSourcesView _$MitmSourcesViewFromJson(Map<String, dynamic> json) =>
    MitmSourcesView(
      entries:
          (json['entries'] as List<dynamic>?)
              ?.map((e) => MitmSourceEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MitmSourcesViewToJson(MitmSourcesView instance) =>
    <String, dynamic>{'entries': instance.entries, 'type': instance.$type};

_MitmBodyReplacement _$MitmBodyReplacementFromJson(Map<String, dynamic> json) =>
    _MitmBodyReplacement(
      regex: json['regex'] as String,
      replacement: json['replacement'] as String,
    );

Map<String, dynamic> _$MitmBodyReplacementToJson(
  _MitmBodyReplacement instance,
) => <String, dynamic>{
  'regex': instance.regex,
  'replacement': instance.replacement,
};

_MitmHostEntry _$MitmHostEntryFromJson(Map<String, dynamic> json) =>
    _MitmHostEntry(
      host: json['host'] as String,
      port: (json['port'] as num?)?.toInt(),
      exclude: json['exclude'] as bool? ?? false,
    );

Map<String, dynamic> _$MitmHostEntryToJson(_MitmHostEntry instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'exclude': instance.exclude,
    };

_MitmSourceEntry _$MitmSourceEntryFromJson(Map<String, dynamic> json) =>
    _MitmSourceEntry(
      network: json['network'] as String,
      exclude: json['exclude'] as bool? ?? false,
    );

Map<String, dynamic> _$MitmSourceEntryToJson(_MitmSourceEntry instance) =>
    <String, dynamic>{'network': instance.network, 'exclude': instance.exclude};

_MitmExchangeSummary _$MitmExchangeSummaryFromJson(Map<String, dynamic> json) =>
    _MitmExchangeSummary(
      id: (json['id'] as num).toInt(),
      start: DateTime.parse(json['start'] as String),
      pending: json['pending'] as bool? ?? false,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      method: json['method'] as String? ?? '',
      url: json['url'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      requestSize: (json['request-size'] as num?)?.toInt() ?? 0,
      responseSize: (json['response-size'] as num?)?.toInt() ?? 0,
      error: json['error'] as String? ?? '',
    );

Map<String, dynamic> _$MitmExchangeSummaryToJson(
  _MitmExchangeSummary instance,
) => <String, dynamic>{
  'id': instance.id,
  'start': instance.start.toIso8601String(),
  'pending': instance.pending,
  'duration': instance.duration,
  'method': instance.method,
  'url': instance.url,
  'status': instance.status,
  'request-size': instance.requestSize,
  'response-size': instance.responseSize,
  'error': instance.error,
};

_MitmExchangeList _$MitmExchangeListFromJson(
  Map<String, dynamic> json,
) => _MitmExchangeList(
  capturing: json['capturing'] as bool? ?? false,
  since: json['since'] == null ? null : DateTime.parse(json['since'] as String),
  exchanges:
      (json['exchanges'] as List<dynamic>?)
          ?.map((e) => MitmExchangeSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  closed: json['closed'] as bool? ?? false,
);

Map<String, dynamic> _$MitmExchangeListToJson(_MitmExchangeList instance) =>
    <String, dynamic>{
      'capturing': instance.capturing,
      'since': instance.since?.toIso8601String(),
      'exchanges': instance.exchanges,
      'closed': instance.closed,
    };

_MitmAction _$MitmActionFromJson(Map<String, dynamic> json) => _MitmAction(
  kind: json['kind'] as String,
  phase: json['phase'] as String? ?? '',
  detail: json['detail'] as String? ?? '',
);

Map<String, dynamic> _$MitmActionToJson(_MitmAction instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'phase': instance.phase,
      'detail': instance.detail,
    };

_MitmExchange _$MitmExchangeFromJson(
  Map<String, dynamic> json,
) => _MitmExchange(
  id: (json['id'] as num).toInt(),
  start: DateTime.parse(json['start'] as String),
  pending: json['pending'] as bool? ?? false,
  duration: (json['duration'] as num?)?.toInt() ?? 0,
  ttfb: (json['ttfb'] as num?)?.toInt() ?? 0,
  method: json['method'] as String? ?? '',
  url: json['url'] as String? ?? '',
  originalUrl: json['original-url'] as String? ?? '',
  proto: json['proto'] as String? ?? '',
  status: (json['status'] as num?)?.toInt() ?? 0,
  requestSize: (json['request-size'] as num?)?.toInt() ?? 0,
  responseSize: (json['response-size'] as num?)?.toInt() ?? 0,
  error: json['error'] as String? ?? '',
  connection: json['connection'] as String? ?? '',
  requestHeader:
      (json['request-header'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
  responseHeader:
      (json['response-header'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
  actions:
      (json['actions'] as List<dynamic>?)
          ?.map((e) => MitmAction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$MitmExchangeToJson(_MitmExchange instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start.toIso8601String(),
      'pending': instance.pending,
      'duration': instance.duration,
      'ttfb': instance.ttfb,
      'method': instance.method,
      'url': instance.url,
      'original-url': instance.originalUrl,
      'proto': instance.proto,
      'status': instance.status,
      'request-size': instance.requestSize,
      'response-size': instance.responseSize,
      'error': instance.error,
      'connection': instance.connection,
      'request-header': instance.requestHeader,
      'response-header': instance.responseHeader,
      'actions': instance.actions,
    };

_MitmBody _$MitmBodyFromJson(Map<String, dynamic> json) => _MitmBody(
  data: json['data'] as String? ?? '',
  truncated: json['truncated'] as bool? ?? false,
  encoding: json['encoding'] as String? ?? '',
);

Map<String, dynamic> _$MitmBodyToJson(_MitmBody instance) => <String, dynamic>{
  'data': instance.data,
  'truncated': instance.truncated,
  'encoding': instance.encoding,
};

_UpdateParams _$UpdateParamsFromJson(Map<String, dynamic> json) =>
    _UpdateParams(
      tun: Tun.fromJson(json['tun'] as Map<String, dynamic>),
      mixedPort: (json['mixed-port'] as num).toInt(),
      allowLan: json['allow-lan'] as bool,
      findProcessMode: $enumDecode(
        _$FindProcessModeEnumMap,
        json['find-process-mode'],
      ),
      mode: $enumDecode(_$ModeEnumMap, json['mode']),
      logLevel: $enumDecode(_$LogLevelEnumMap, json['log-level']),
      ipv6: json['ipv6'] as bool?,
      tcpConcurrent: json['tcp-concurrent'] as bool?,
      externalController: json['external-controller'] as String,
      secret: json['secret'] as String,
      unifiedDelay: json['unified-delay'] as bool?,
      geoAutoUpdate: json['geo-auto-update'] as bool? ?? true,
      geoUpdateInterval: (json['geo-update-interval'] as num?)?.toInt() ?? 24,
      geoXUrl:
          (json['geox-url'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      suspendOnIdle: json['suspend-on-idle'] as bool? ?? false,
      options: json['options'] == null
          ? const CoreOptions(testUrl: defaultTestUrl)
          : CoreOptions.fromJson(json['options'] as Map<String, dynamic>),
      authentication:
          (json['authentication'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UpdateParamsToJson(_UpdateParams instance) =>
    <String, dynamic>{
      'tun': _tunCoreJson(instance.tun),
      'mixed-port': instance.mixedPort,
      'allow-lan': instance.allowLan,
      'find-process-mode': _$FindProcessModeEnumMap[instance.findProcessMode]!,
      'mode': _$ModeEnumMap[instance.mode]!,
      'log-level': _$LogLevelEnumMap[instance.logLevel]!,
      'ipv6': instance.ipv6,
      'tcp-concurrent': instance.tcpConcurrent,
      'external-controller': instance.externalController,
      'secret': instance.secret,
      'unified-delay': instance.unifiedDelay,
      'geo-auto-update': instance.geoAutoUpdate,
      'geo-update-interval': instance.geoUpdateInterval,
      'geox-url': instance.geoXUrl,
      'suspend-on-idle': instance.suspendOnIdle,
      'options': instance.options,
      'authentication': instance.authentication,
    };

const _$FindProcessModeEnumMap = {
  FindProcessMode.always: 'always',
  FindProcessMode.off: 'off',
  FindProcessMode.strict: 'strict',
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

_VpnOptions _$VpnOptionsFromJson(Map<String, dynamic> json) => _VpnOptions(
  enable: json['enable'] as bool,
  port: (json['port'] as num).toInt(),
  ipv6: json['ipv6'] as bool,
  dnsHijacking: json['dnsHijacking'] as bool,
  accessControlProps: AccessControlProps.fromJson(
    json['accessControlProps'] as Map<String, dynamic>,
  ),
  allowBypass: json['allowBypass'] as bool,
  systemProxy: json['systemProxy'] as bool,
  bypassDomain: (json['bypassDomain'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  stack: json['stack'] as String,
  routeAddress:
      (json['routeAddress'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  excludeSSIDs:
      (json['excludeSSIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  excludeNetworks:
      (json['excludeNetworks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  mtu: json['mtu'] == null
      ? defaultTunMtu
      : normalizeTunMtu((json['mtu'] as num?)?.toInt()),
  congestionController: json['congestionController'] as String? ?? '',
);

Map<String, dynamic> _$VpnOptionsToJson(_VpnOptions instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'port': instance.port,
      'ipv6': instance.ipv6,
      'dnsHijacking': instance.dnsHijacking,
      'accessControlProps': instance.accessControlProps,
      'allowBypass': instance.allowBypass,
      'systemProxy': instance.systemProxy,
      'bypassDomain': instance.bypassDomain,
      'stack': instance.stack,
      'routeAddress': instance.routeAddress,
      'excludeSSIDs': instance.excludeSSIDs,
      'excludeNetworks': instance.excludeNetworks,
      'mtu': instance.mtu,
      'congestionController': instance.congestionController,
    };

_InitParams _$InitParamsFromJson(Map<String, dynamic> json) => _InitParams(
  homeDir: json['home-dir'] as String,
  version: (json['version'] as num).toInt(),
  configAgeSecretKey: json['config-age-secret-key'] as String? ?? '',
  cloudDomains:
      (json['cloud-domains'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$InitParamsToJson(_InitParams instance) =>
    <String, dynamic>{
      'home-dir': instance.homeDir,
      'version': instance.version,
      'config-age-secret-key': instance.configAgeSecretKey,
      'cloud-domains': instance.cloudDomains,
    };

_ChangeProxyParams _$ChangeProxyParamsFromJson(Map<String, dynamic> json) =>
    _ChangeProxyParams(
      groupName: json['group-name'] as String,
      proxyName: json['proxy-name'] as String,
    );

Map<String, dynamic> _$ChangeProxyParamsToJson(_ChangeProxyParams instance) =>
    <String, dynamic>{
      'group-name': instance.groupName,
      'proxy-name': instance.proxyName,
    };

_ChangeProxyResult _$ChangeProxyResultFromJson(Map<String, dynamic> json) =>
    _ChangeProxyResult(
      message: json['message'] as String? ?? '',
      changed: json['changed'] as bool? ?? false,
    );

Map<String, dynamic> _$ChangeProxyResultToJson(_ChangeProxyResult instance) =>
    <String, dynamic>{'message': instance.message, 'changed': instance.changed};

_UpdateGeoDataParams _$UpdateGeoDataParamsFromJson(Map<String, dynamic> json) =>
    _UpdateGeoDataParams(
      geoType: json['geo-type'] as String,
      geoName: json['geo-name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$UpdateGeoDataParamsToJson(
  _UpdateGeoDataParams instance,
) => <String, dynamic>{
  'geo-type': instance.geoType,
  'geo-name': instance.geoName,
  'url': instance.url,
};

_CoreEvent _$CoreEventFromJson(Map<String, dynamic> json) => _CoreEvent(
  type: $enumDecode(_$CoreEventTypeEnumMap, json['type']),
  data: json['data'],
);

Map<String, dynamic> _$CoreEventToJson(_CoreEvent instance) =>
    <String, dynamic>{
      'type': _$CoreEventTypeEnumMap[instance.type]!,
      'data': instance.data,
    };

const _$CoreEventTypeEnumMap = {
  CoreEventType.log: 'log',
  CoreEventType.delay: 'delay',
  CoreEventType.request: 'request',
  CoreEventType.requestTraffic: 'requestTraffic',
  CoreEventType.connections: 'connections',
  CoreEventType.dns: 'dns',
  CoreEventType.loaded: 'loaded',
  CoreEventType.crash: 'crash',
  CoreEventType.geoUpdate: 'geoUpdate',
  CoreEventType.mode: 'mode',
  CoreEventType.dialerLoop: 'dialerLoop',
  CoreEventType.chainsOff: 'chainsOff',
};

_Delay _$DelayFromJson(Map<String, dynamic> json) => _Delay(
  name: json['name'] as String,
  url: json['url'] as String,
  value: (json['value'] as num?)?.toInt(),
  failure: $enumDecodeNullable(
    _$DelayFailureEnumMap,
    json['failure'],
    unknownValue: DelayFailure.other,
  ),
);

Map<String, dynamic> _$DelayToJson(_Delay instance) => <String, dynamic>{
  'name': instance.name,
  'url': instance.url,
  'value': instance.value,
  'failure': _$DelayFailureEnumMap[instance.failure],
};

const _$DelayFailureEnumMap = {
  DelayFailure.timeout: 'timeout',
  DelayFailure.dns: 'dns',
  DelayFailure.tls: 'tls',
  DelayFailure.connect: 'connect',
  DelayFailure.transport: 'transport',
  DelayFailure.vpnNotReady: 'vpnNotReady',
  DelayFailure.vpnProtect: 'vpnProtect',
  DelayFailure.queueTimeout: 'queueTimeout',
  DelayFailure.missingProxy: 'missingProxy',
  DelayFailure.canceled: 'canceled',
  DelayFailure.other: 'other',
};

_Now _$NowFromJson(Map<String, dynamic> json) =>
    _Now(name: json['name'] as String, value: json['value'] as String);

Map<String, dynamic> _$NowToJson(_Now instance) => <String, dynamic>{
  'name': instance.name,
  'value': instance.value,
};

_ExternalProvider _$ExternalProviderFromJson(Map<String, dynamic> json) =>
    _ExternalProvider(
      name: json['name'] as String,
      type: json['type'] as String,
      contentVersion: json['content-version'] as String? ?? '',
      path: json['path'] as String?,
      count: (json['count'] as num).toInt(),
      subscriptionInfo: subscriptionInfoFormCore(
        json['subscription-info'] as Map<String, Object?>?,
      ),
      vehicleType: json['vehicle-type'] as String,
      updateAt: DateTime.parse(json['update-at'] as String),
    );

Map<String, dynamic> _$ExternalProviderToJson(_ExternalProvider instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'content-version': instance.contentVersion,
      'path': instance.path,
      'count': instance.count,
      'subscription-info': instance.subscriptionInfo,
      'vehicle-type': instance.vehicleType,
      'update-at': instance.updateAt.toIso8601String(),
    };

_CoreMemoryStats _$CoreMemoryStatsFromJson(Map<String, dynamic> json) =>
    _CoreMemoryStats(
      rss: (json['rss'] as num?)?.toInt() ?? 0,
      heapInuse: (json['heap-inuse'] as num?)?.toInt() ?? 0,
      heapIdle: (json['heap-idle'] as num?)?.toInt() ?? 0,
      stackInuse: (json['stack-inuse'] as num?)?.toInt() ?? 0,
      runtimeOther: (json['runtime-other'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CoreMemoryStatsToJson(_CoreMemoryStats instance) =>
    <String, dynamic>{
      'rss': instance.rss,
      'heap-inuse': instance.heapInuse,
      'heap-idle': instance.heapIdle,
      'stack-inuse': instance.stackInuse,
      'runtime-other': instance.runtimeOther,
    };
