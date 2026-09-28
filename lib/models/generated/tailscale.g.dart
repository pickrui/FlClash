// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tailscale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TailscaleNetwork _$TailscaleNetworkFromJson(Map<String, dynamic> json) =>
    _TailscaleNetwork(
      id: json['id'] as String,
      name: json['name'] as String,
      stateId: json['stateId'] as String,
      hostname: json['hostname'] as String? ?? '',
      loginMethod:
          $enumDecodeNullable(
            _$TailscaleLoginMethodEnumMap,
            json['loginMethod'],
          ) ??
          TailscaleLoginMethod.interactive,
      controlUrl: json['controlUrl'] as String? ?? '',
      autoRoute: json['autoRoute'] as bool? ?? true,
      exitNode: json['exitNode'] as String? ?? '',
      exitNodeAllowLanAccess: json['exitNodeAllowLanAccess'] as bool? ?? false,
      magicDnsSuffix: json['magicDnsSuffix'] as String? ?? '',
    );

Map<String, dynamic> _$TailscaleNetworkToJson(_TailscaleNetwork instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stateId': instance.stateId,
      'hostname': instance.hostname,
      'loginMethod': _$TailscaleLoginMethodEnumMap[instance.loginMethod]!,
      'controlUrl': instance.controlUrl,
      'autoRoute': instance.autoRoute,
      'exitNode': instance.exitNode,
      'exitNodeAllowLanAccess': instance.exitNodeAllowLanAccess,
      'magicDnsSuffix': instance.magicDnsSuffix,
    };

const _$TailscaleLoginMethodEnumMap = {
  TailscaleLoginMethod.interactive: 'interactive',
  TailscaleLoginMethod.authKey: 'authKey',
};

_TailscaleDevice _$TailscaleDeviceFromJson(Map<String, dynamic> json) =>
    _TailscaleDevice(
      name: json['name'] as String? ?? '',
      hostName: json['hostName'] as String? ?? '',
      os: json['os'] as String? ?? '',
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      online: json['online'] as bool? ?? false,
      direct: json['direct'] as bool? ?? false,
      relay: json['relay'] as String? ?? '',
      exitNodeOption: json['exitNodeOption'] as bool? ?? false,
      exitNode: json['exitNode'] as bool? ?? false,
    );

Map<String, dynamic> _$TailscaleDeviceToJson(_TailscaleDevice instance) =>
    <String, dynamic>{
      'name': instance.name,
      'hostName': instance.hostName,
      'os': instance.os,
      'addresses': instance.addresses,
      'online': instance.online,
      'direct': instance.direct,
      'relay': instance.relay,
      'exitNodeOption': instance.exitNodeOption,
      'exitNode': instance.exitNode,
    };

_TailscaleStatus _$TailscaleStatusFromJson(Map<String, dynamic> json) =>
    _TailscaleStatus(
      rawState: json['state'] as String? ?? '',
      authUrl: json['authUrl'] as String? ?? '',
      error: json['error'] as String? ?? '',
      tailnet: json['tailnet'] as String? ?? '',
      magicDnsSuffix: json['magicDnsSuffix'] as String? ?? '',
      keyExpired: json['keyExpired'] as bool? ?? false,
      health:
          (json['health'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      self: json['self'] == null
          ? null
          : TailscaleDevice.fromJson(json['self'] as Map<String, dynamic>),
      peers:
          (json['peers'] as List<dynamic>?)
              ?.map((e) => TailscaleDevice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TailscaleStatusToJson(_TailscaleStatus instance) =>
    <String, dynamic>{
      'state': instance.rawState,
      'authUrl': instance.authUrl,
      'error': instance.error,
      'tailnet': instance.tailnet,
      'magicDnsSuffix': instance.magicDnsSuffix,
      'keyExpired': instance.keyExpired,
      'health': instance.health,
      'self': instance.self,
      'peers': instance.peers,
    };
