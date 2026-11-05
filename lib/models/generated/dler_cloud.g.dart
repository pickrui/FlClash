// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../dler_cloud.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DlerCloudLoginData _$DlerCloudLoginDataFromJson(Map<String, dynamic> json) =>
    _DlerCloudLoginData(
      token: json['token'] as String,
      tokenExpire: json['token_expire'] as String,
      plan: json['plan'] as String,
      planTime: json['plan_time'] as String,
      money: json['money'] as String,
      affMoney: json['aff_money'] as String,
      todayUsed: json['today_used'] as String,
      used: json['used'] as String,
      unused: json['unused'] as String,
      traffic: json['traffic'] as String,
      integral: json['integral'] as String,
    );

Map<String, dynamic> _$DlerCloudLoginDataToJson(_DlerCloudLoginData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'token_expire': instance.tokenExpire,
      'plan': instance.plan,
      'plan_time': instance.planTime,
      'money': instance.money,
      'aff_money': instance.affMoney,
      'today_used': instance.todayUsed,
      'used': instance.used,
      'unused': instance.unused,
      'traffic': instance.traffic,
      'integral': instance.integral,
    };

_DlerCloudUserInfo _$DlerCloudUserInfoFromJson(Map<String, dynamic> json) =>
    _DlerCloudUserInfo(
      plan: json['plan'] as String,
      planTime: json['plan_time'] as String,
      money: json['money'] as String,
      affMoney: json['aff_money'] as String,
      todayUsed: json['today_used'] as String,
      used: json['used'] as String,
      unused: json['unused'] as String,
      traffic: json['traffic'] as String,
      integral: json['integral'] as String,
    );

Map<String, dynamic> _$DlerCloudUserInfoToJson(_DlerCloudUserInfo instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'plan_time': instance.planTime,
      'money': instance.money,
      'aff_money': instance.affMoney,
      'today_used': instance.todayUsed,
      'used': instance.used,
      'unused': instance.unused,
      'traffic': instance.traffic,
      'integral': instance.integral,
    };

_DlerCloudManagedData _$DlerCloudManagedDataFromJson(
  Map<String, dynamic> json,
) => _DlerCloudManagedData(
  name: json['name'] as String,
  smart: json['smart'] as String,
  ss2022: json['ss2022'] as String?,
  vmess: json['vmess'] as String?,
);

Map<String, dynamic> _$DlerCloudManagedDataToJson(
  _DlerCloudManagedData instance,
) => <String, dynamic>{
  'name': instance.name,
  'smart': instance.smart,
  'ss2022': instance.ss2022,
  'vmess': instance.vmess,
};

_DlerCloudAnnouncement _$DlerCloudAnnouncementFromJson(
  Map<String, dynamic> json,
) => _DlerCloudAnnouncement(
  id: (json['id'] as num).toInt(),
  date: json['date'] as String,
  content: json['content'] as String,
  markdown: json['markdown'] as String? ?? '',
);

Map<String, dynamic> _$DlerCloudAnnouncementToJson(
  _DlerCloudAnnouncement instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'content': instance.content,
  'markdown': instance.markdown,
};
