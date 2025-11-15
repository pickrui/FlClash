import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/dler_cloud.freezed.dart';
part 'generated/dler_cloud.g.dart';

/// 登录响应数据
@freezed
abstract class DlerCloudLoginData with _$DlerCloudLoginData {
  const factory DlerCloudLoginData({
    required String token,
    @JsonKey(name: 'token_expire') required String tokenExpire,
    required String plan,
    @JsonKey(name: 'plan_time') required String planTime,
    required String money,
    @JsonKey(name: 'aff_money') required String affMoney,
    @JsonKey(name: 'today_used') required String todayUsed,
    required String used,
    required String unused,
    required String traffic,
    required String integral,
  }) = _DlerCloudLoginData;

  factory DlerCloudLoginData.fromJson(Map<String, dynamic> json) =>
      _$DlerCloudLoginDataFromJson(json);
}

/// 用户信息数据
@freezed
abstract class DlerCloudUserInfo with _$DlerCloudUserInfo {
  const factory DlerCloudUserInfo({
    required String plan,
    @JsonKey(name: 'plan_time') required String planTime,
    required String money,
    @JsonKey(name: 'aff_money') required String affMoney,
    @JsonKey(name: 'today_used') required String todayUsed,
    required String used,
    required String unused,
    required String traffic,
    required String integral,
  }) = _DlerCloudUserInfo;

  factory DlerCloudUserInfo.fromJson(Map<String, dynamic> json) =>
      _$DlerCloudUserInfoFromJson(json);
}

/// 订阅地址数据
@freezed
abstract class DlerCloudManagedData with _$DlerCloudManagedData {
  const factory DlerCloudManagedData({
    required String name,
    required String smart,
    String? ss2022,
    String? vmess,
  }) = _DlerCloudManagedData;

  factory DlerCloudManagedData.fromJson(Map<String, dynamic> json) =>
      _$DlerCloudManagedDataFromJson(json);
}

/// 公告数据
@freezed
abstract class DlerCloudAnnouncement with _$DlerCloudAnnouncement {
  const factory DlerCloudAnnouncement({
    required int id,
    required String date,
    required String content,
    @Default('') String markdown,
  }) = _DlerCloudAnnouncement;

  factory DlerCloudAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$DlerCloudAnnouncementFromJson(json);
}

