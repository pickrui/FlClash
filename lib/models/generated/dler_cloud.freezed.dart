// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../dler_cloud.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DlerCloudLoginData {

 String get token;@JsonKey(name: 'token_expire') String get tokenExpire; String get plan;@JsonKey(name: 'plan_time') String get planTime; String get money;@JsonKey(name: 'aff_money') String get affMoney;@JsonKey(name: 'today_used') String get todayUsed; String get used; String get unused; String get traffic; String get integral;
/// Create a copy of DlerCloudLoginData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DlerCloudLoginDataCopyWith<DlerCloudLoginData> get copyWith => _$DlerCloudLoginDataCopyWithImpl<DlerCloudLoginData>(this as DlerCloudLoginData, _$identity);

  /// Serializes this DlerCloudLoginData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DlerCloudLoginData&&(identical(other.token, token) || other.token == token)&&(identical(other.tokenExpire, tokenExpire) || other.tokenExpire == tokenExpire)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.planTime, planTime) || other.planTime == planTime)&&(identical(other.money, money) || other.money == money)&&(identical(other.affMoney, affMoney) || other.affMoney == affMoney)&&(identical(other.todayUsed, todayUsed) || other.todayUsed == todayUsed)&&(identical(other.used, used) || other.used == used)&&(identical(other.unused, unused) || other.unused == unused)&&(identical(other.traffic, traffic) || other.traffic == traffic)&&(identical(other.integral, integral) || other.integral == integral));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,tokenExpire,plan,planTime,money,affMoney,todayUsed,used,unused,traffic,integral);

@override
String toString() {
  return 'DlerCloudLoginData(token: $token, tokenExpire: $tokenExpire, plan: $plan, planTime: $planTime, money: $money, affMoney: $affMoney, todayUsed: $todayUsed, used: $used, unused: $unused, traffic: $traffic, integral: $integral)';
}


}

/// @nodoc
abstract mixin class $DlerCloudLoginDataCopyWith<$Res>  {
  factory $DlerCloudLoginDataCopyWith(DlerCloudLoginData value, $Res Function(DlerCloudLoginData) _then) = _$DlerCloudLoginDataCopyWithImpl;
@useResult
$Res call({
 String token,@JsonKey(name: 'token_expire') String tokenExpire, String plan,@JsonKey(name: 'plan_time') String planTime, String money,@JsonKey(name: 'aff_money') String affMoney,@JsonKey(name: 'today_used') String todayUsed, String used, String unused, String traffic, String integral
});




}
/// @nodoc
class _$DlerCloudLoginDataCopyWithImpl<$Res>
    implements $DlerCloudLoginDataCopyWith<$Res> {
  _$DlerCloudLoginDataCopyWithImpl(this._self, this._then);

  final DlerCloudLoginData _self;
  final $Res Function(DlerCloudLoginData) _then;

/// Create a copy of DlerCloudLoginData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? tokenExpire = null,Object? plan = null,Object? planTime = null,Object? money = null,Object? affMoney = null,Object? todayUsed = null,Object? used = null,Object? unused = null,Object? traffic = null,Object? integral = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,tokenExpire: null == tokenExpire ? _self.tokenExpire : tokenExpire // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,planTime: null == planTime ? _self.planTime : planTime // ignore: cast_nullable_to_non_nullable
as String,money: null == money ? _self.money : money // ignore: cast_nullable_to_non_nullable
as String,affMoney: null == affMoney ? _self.affMoney : affMoney // ignore: cast_nullable_to_non_nullable
as String,todayUsed: null == todayUsed ? _self.todayUsed : todayUsed // ignore: cast_nullable_to_non_nullable
as String,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as String,unused: null == unused ? _self.unused : unused // ignore: cast_nullable_to_non_nullable
as String,traffic: null == traffic ? _self.traffic : traffic // ignore: cast_nullable_to_non_nullable
as String,integral: null == integral ? _self.integral : integral // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DlerCloudLoginData].
extension DlerCloudLoginDataPatterns on DlerCloudLoginData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DlerCloudLoginData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DlerCloudLoginData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DlerCloudLoginData value)  $default,){
final _that = this;
switch (_that) {
case _DlerCloudLoginData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DlerCloudLoginData value)?  $default,){
final _that = this;
switch (_that) {
case _DlerCloudLoginData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token, @JsonKey(name: 'token_expire')  String tokenExpire,  String plan, @JsonKey(name: 'plan_time')  String planTime,  String money, @JsonKey(name: 'aff_money')  String affMoney, @JsonKey(name: 'today_used')  String todayUsed,  String used,  String unused,  String traffic,  String integral)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DlerCloudLoginData() when $default != null:
return $default(_that.token,_that.tokenExpire,_that.plan,_that.planTime,_that.money,_that.affMoney,_that.todayUsed,_that.used,_that.unused,_that.traffic,_that.integral);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token, @JsonKey(name: 'token_expire')  String tokenExpire,  String plan, @JsonKey(name: 'plan_time')  String planTime,  String money, @JsonKey(name: 'aff_money')  String affMoney, @JsonKey(name: 'today_used')  String todayUsed,  String used,  String unused,  String traffic,  String integral)  $default,) {final _that = this;
switch (_that) {
case _DlerCloudLoginData():
return $default(_that.token,_that.tokenExpire,_that.plan,_that.planTime,_that.money,_that.affMoney,_that.todayUsed,_that.used,_that.unused,_that.traffic,_that.integral);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token, @JsonKey(name: 'token_expire')  String tokenExpire,  String plan, @JsonKey(name: 'plan_time')  String planTime,  String money, @JsonKey(name: 'aff_money')  String affMoney, @JsonKey(name: 'today_used')  String todayUsed,  String used,  String unused,  String traffic,  String integral)?  $default,) {final _that = this;
switch (_that) {
case _DlerCloudLoginData() when $default != null:
return $default(_that.token,_that.tokenExpire,_that.plan,_that.planTime,_that.money,_that.affMoney,_that.todayUsed,_that.used,_that.unused,_that.traffic,_that.integral);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DlerCloudLoginData implements DlerCloudLoginData {
  const _DlerCloudLoginData({required this.token, @JsonKey(name: 'token_expire') required this.tokenExpire, required this.plan, @JsonKey(name: 'plan_time') required this.planTime, required this.money, @JsonKey(name: 'aff_money') required this.affMoney, @JsonKey(name: 'today_used') required this.todayUsed, required this.used, required this.unused, required this.traffic, required this.integral});
  factory _DlerCloudLoginData.fromJson(Map<String, dynamic> json) => _$DlerCloudLoginDataFromJson(json);

@override final  String token;
@override@JsonKey(name: 'token_expire') final  String tokenExpire;
@override final  String plan;
@override@JsonKey(name: 'plan_time') final  String planTime;
@override final  String money;
@override@JsonKey(name: 'aff_money') final  String affMoney;
@override@JsonKey(name: 'today_used') final  String todayUsed;
@override final  String used;
@override final  String unused;
@override final  String traffic;
@override final  String integral;

/// Create a copy of DlerCloudLoginData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DlerCloudLoginDataCopyWith<_DlerCloudLoginData> get copyWith => __$DlerCloudLoginDataCopyWithImpl<_DlerCloudLoginData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DlerCloudLoginDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DlerCloudLoginData&&(identical(other.token, token) || other.token == token)&&(identical(other.tokenExpire, tokenExpire) || other.tokenExpire == tokenExpire)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.planTime, planTime) || other.planTime == planTime)&&(identical(other.money, money) || other.money == money)&&(identical(other.affMoney, affMoney) || other.affMoney == affMoney)&&(identical(other.todayUsed, todayUsed) || other.todayUsed == todayUsed)&&(identical(other.used, used) || other.used == used)&&(identical(other.unused, unused) || other.unused == unused)&&(identical(other.traffic, traffic) || other.traffic == traffic)&&(identical(other.integral, integral) || other.integral == integral));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,tokenExpire,plan,planTime,money,affMoney,todayUsed,used,unused,traffic,integral);

@override
String toString() {
  return 'DlerCloudLoginData(token: $token, tokenExpire: $tokenExpire, plan: $plan, planTime: $planTime, money: $money, affMoney: $affMoney, todayUsed: $todayUsed, used: $used, unused: $unused, traffic: $traffic, integral: $integral)';
}


}

/// @nodoc
abstract mixin class _$DlerCloudLoginDataCopyWith<$Res> implements $DlerCloudLoginDataCopyWith<$Res> {
  factory _$DlerCloudLoginDataCopyWith(_DlerCloudLoginData value, $Res Function(_DlerCloudLoginData) _then) = __$DlerCloudLoginDataCopyWithImpl;
@override @useResult
$Res call({
 String token,@JsonKey(name: 'token_expire') String tokenExpire, String plan,@JsonKey(name: 'plan_time') String planTime, String money,@JsonKey(name: 'aff_money') String affMoney,@JsonKey(name: 'today_used') String todayUsed, String used, String unused, String traffic, String integral
});




}
/// @nodoc
class __$DlerCloudLoginDataCopyWithImpl<$Res>
    implements _$DlerCloudLoginDataCopyWith<$Res> {
  __$DlerCloudLoginDataCopyWithImpl(this._self, this._then);

  final _DlerCloudLoginData _self;
  final $Res Function(_DlerCloudLoginData) _then;

/// Create a copy of DlerCloudLoginData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? tokenExpire = null,Object? plan = null,Object? planTime = null,Object? money = null,Object? affMoney = null,Object? todayUsed = null,Object? used = null,Object? unused = null,Object? traffic = null,Object? integral = null,}) {
  return _then(_DlerCloudLoginData(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,tokenExpire: null == tokenExpire ? _self.tokenExpire : tokenExpire // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,planTime: null == planTime ? _self.planTime : planTime // ignore: cast_nullable_to_non_nullable
as String,money: null == money ? _self.money : money // ignore: cast_nullable_to_non_nullable
as String,affMoney: null == affMoney ? _self.affMoney : affMoney // ignore: cast_nullable_to_non_nullable
as String,todayUsed: null == todayUsed ? _self.todayUsed : todayUsed // ignore: cast_nullable_to_non_nullable
as String,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as String,unused: null == unused ? _self.unused : unused // ignore: cast_nullable_to_non_nullable
as String,traffic: null == traffic ? _self.traffic : traffic // ignore: cast_nullable_to_non_nullable
as String,integral: null == integral ? _self.integral : integral // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DlerCloudUserInfo {

 String get plan;@JsonKey(name: 'plan_time') String get planTime; String get money;@JsonKey(name: 'aff_money') String get affMoney;@JsonKey(name: 'today_used') String get todayUsed; String get used; String get unused; String get traffic; String get integral;
/// Create a copy of DlerCloudUserInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DlerCloudUserInfoCopyWith<DlerCloudUserInfo> get copyWith => _$DlerCloudUserInfoCopyWithImpl<DlerCloudUserInfo>(this as DlerCloudUserInfo, _$identity);

  /// Serializes this DlerCloudUserInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DlerCloudUserInfo&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.planTime, planTime) || other.planTime == planTime)&&(identical(other.money, money) || other.money == money)&&(identical(other.affMoney, affMoney) || other.affMoney == affMoney)&&(identical(other.todayUsed, todayUsed) || other.todayUsed == todayUsed)&&(identical(other.used, used) || other.used == used)&&(identical(other.unused, unused) || other.unused == unused)&&(identical(other.traffic, traffic) || other.traffic == traffic)&&(identical(other.integral, integral) || other.integral == integral));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,planTime,money,affMoney,todayUsed,used,unused,traffic,integral);

@override
String toString() {
  return 'DlerCloudUserInfo(plan: $plan, planTime: $planTime, money: $money, affMoney: $affMoney, todayUsed: $todayUsed, used: $used, unused: $unused, traffic: $traffic, integral: $integral)';
}


}

/// @nodoc
abstract mixin class $DlerCloudUserInfoCopyWith<$Res>  {
  factory $DlerCloudUserInfoCopyWith(DlerCloudUserInfo value, $Res Function(DlerCloudUserInfo) _then) = _$DlerCloudUserInfoCopyWithImpl;
@useResult
$Res call({
 String plan,@JsonKey(name: 'plan_time') String planTime, String money,@JsonKey(name: 'aff_money') String affMoney,@JsonKey(name: 'today_used') String todayUsed, String used, String unused, String traffic, String integral
});




}
/// @nodoc
class _$DlerCloudUserInfoCopyWithImpl<$Res>
    implements $DlerCloudUserInfoCopyWith<$Res> {
  _$DlerCloudUserInfoCopyWithImpl(this._self, this._then);

  final DlerCloudUserInfo _self;
  final $Res Function(DlerCloudUserInfo) _then;

/// Create a copy of DlerCloudUserInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = null,Object? planTime = null,Object? money = null,Object? affMoney = null,Object? todayUsed = null,Object? used = null,Object? unused = null,Object? traffic = null,Object? integral = null,}) {
  return _then(_self.copyWith(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,planTime: null == planTime ? _self.planTime : planTime // ignore: cast_nullable_to_non_nullable
as String,money: null == money ? _self.money : money // ignore: cast_nullable_to_non_nullable
as String,affMoney: null == affMoney ? _self.affMoney : affMoney // ignore: cast_nullable_to_non_nullable
as String,todayUsed: null == todayUsed ? _self.todayUsed : todayUsed // ignore: cast_nullable_to_non_nullable
as String,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as String,unused: null == unused ? _self.unused : unused // ignore: cast_nullable_to_non_nullable
as String,traffic: null == traffic ? _self.traffic : traffic // ignore: cast_nullable_to_non_nullable
as String,integral: null == integral ? _self.integral : integral // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DlerCloudUserInfo].
extension DlerCloudUserInfoPatterns on DlerCloudUserInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DlerCloudUserInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DlerCloudUserInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DlerCloudUserInfo value)  $default,){
final _that = this;
switch (_that) {
case _DlerCloudUserInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DlerCloudUserInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DlerCloudUserInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String plan, @JsonKey(name: 'plan_time')  String planTime,  String money, @JsonKey(name: 'aff_money')  String affMoney, @JsonKey(name: 'today_used')  String todayUsed,  String used,  String unused,  String traffic,  String integral)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DlerCloudUserInfo() when $default != null:
return $default(_that.plan,_that.planTime,_that.money,_that.affMoney,_that.todayUsed,_that.used,_that.unused,_that.traffic,_that.integral);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String plan, @JsonKey(name: 'plan_time')  String planTime,  String money, @JsonKey(name: 'aff_money')  String affMoney, @JsonKey(name: 'today_used')  String todayUsed,  String used,  String unused,  String traffic,  String integral)  $default,) {final _that = this;
switch (_that) {
case _DlerCloudUserInfo():
return $default(_that.plan,_that.planTime,_that.money,_that.affMoney,_that.todayUsed,_that.used,_that.unused,_that.traffic,_that.integral);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String plan, @JsonKey(name: 'plan_time')  String planTime,  String money, @JsonKey(name: 'aff_money')  String affMoney, @JsonKey(name: 'today_used')  String todayUsed,  String used,  String unused,  String traffic,  String integral)?  $default,) {final _that = this;
switch (_that) {
case _DlerCloudUserInfo() when $default != null:
return $default(_that.plan,_that.planTime,_that.money,_that.affMoney,_that.todayUsed,_that.used,_that.unused,_that.traffic,_that.integral);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DlerCloudUserInfo implements DlerCloudUserInfo {
  const _DlerCloudUserInfo({required this.plan, @JsonKey(name: 'plan_time') required this.planTime, required this.money, @JsonKey(name: 'aff_money') required this.affMoney, @JsonKey(name: 'today_used') required this.todayUsed, required this.used, required this.unused, required this.traffic, required this.integral});
  factory _DlerCloudUserInfo.fromJson(Map<String, dynamic> json) => _$DlerCloudUserInfoFromJson(json);

@override final  String plan;
@override@JsonKey(name: 'plan_time') final  String planTime;
@override final  String money;
@override@JsonKey(name: 'aff_money') final  String affMoney;
@override@JsonKey(name: 'today_used') final  String todayUsed;
@override final  String used;
@override final  String unused;
@override final  String traffic;
@override final  String integral;

/// Create a copy of DlerCloudUserInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DlerCloudUserInfoCopyWith<_DlerCloudUserInfo> get copyWith => __$DlerCloudUserInfoCopyWithImpl<_DlerCloudUserInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DlerCloudUserInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DlerCloudUserInfo&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.planTime, planTime) || other.planTime == planTime)&&(identical(other.money, money) || other.money == money)&&(identical(other.affMoney, affMoney) || other.affMoney == affMoney)&&(identical(other.todayUsed, todayUsed) || other.todayUsed == todayUsed)&&(identical(other.used, used) || other.used == used)&&(identical(other.unused, unused) || other.unused == unused)&&(identical(other.traffic, traffic) || other.traffic == traffic)&&(identical(other.integral, integral) || other.integral == integral));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,planTime,money,affMoney,todayUsed,used,unused,traffic,integral);

@override
String toString() {
  return 'DlerCloudUserInfo(plan: $plan, planTime: $planTime, money: $money, affMoney: $affMoney, todayUsed: $todayUsed, used: $used, unused: $unused, traffic: $traffic, integral: $integral)';
}


}

/// @nodoc
abstract mixin class _$DlerCloudUserInfoCopyWith<$Res> implements $DlerCloudUserInfoCopyWith<$Res> {
  factory _$DlerCloudUserInfoCopyWith(_DlerCloudUserInfo value, $Res Function(_DlerCloudUserInfo) _then) = __$DlerCloudUserInfoCopyWithImpl;
@override @useResult
$Res call({
 String plan,@JsonKey(name: 'plan_time') String planTime, String money,@JsonKey(name: 'aff_money') String affMoney,@JsonKey(name: 'today_used') String todayUsed, String used, String unused, String traffic, String integral
});




}
/// @nodoc
class __$DlerCloudUserInfoCopyWithImpl<$Res>
    implements _$DlerCloudUserInfoCopyWith<$Res> {
  __$DlerCloudUserInfoCopyWithImpl(this._self, this._then);

  final _DlerCloudUserInfo _self;
  final $Res Function(_DlerCloudUserInfo) _then;

/// Create a copy of DlerCloudUserInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? planTime = null,Object? money = null,Object? affMoney = null,Object? todayUsed = null,Object? used = null,Object? unused = null,Object? traffic = null,Object? integral = null,}) {
  return _then(_DlerCloudUserInfo(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,planTime: null == planTime ? _self.planTime : planTime // ignore: cast_nullable_to_non_nullable
as String,money: null == money ? _self.money : money // ignore: cast_nullable_to_non_nullable
as String,affMoney: null == affMoney ? _self.affMoney : affMoney // ignore: cast_nullable_to_non_nullable
as String,todayUsed: null == todayUsed ? _self.todayUsed : todayUsed // ignore: cast_nullable_to_non_nullable
as String,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as String,unused: null == unused ? _self.unused : unused // ignore: cast_nullable_to_non_nullable
as String,traffic: null == traffic ? _self.traffic : traffic // ignore: cast_nullable_to_non_nullable
as String,integral: null == integral ? _self.integral : integral // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DlerCloudManagedData {

 String get name; String get smart; String? get ss2022; String? get vmess;
/// Create a copy of DlerCloudManagedData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DlerCloudManagedDataCopyWith<DlerCloudManagedData> get copyWith => _$DlerCloudManagedDataCopyWithImpl<DlerCloudManagedData>(this as DlerCloudManagedData, _$identity);

  /// Serializes this DlerCloudManagedData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DlerCloudManagedData&&(identical(other.name, name) || other.name == name)&&(identical(other.smart, smart) || other.smart == smart)&&(identical(other.ss2022, ss2022) || other.ss2022 == ss2022)&&(identical(other.vmess, vmess) || other.vmess == vmess));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,smart,ss2022,vmess);

@override
String toString() {
  return 'DlerCloudManagedData(name: $name, smart: $smart, ss2022: $ss2022, vmess: $vmess)';
}


}

/// @nodoc
abstract mixin class $DlerCloudManagedDataCopyWith<$Res>  {
  factory $DlerCloudManagedDataCopyWith(DlerCloudManagedData value, $Res Function(DlerCloudManagedData) _then) = _$DlerCloudManagedDataCopyWithImpl;
@useResult
$Res call({
 String name, String smart, String? ss2022, String? vmess
});




}
/// @nodoc
class _$DlerCloudManagedDataCopyWithImpl<$Res>
    implements $DlerCloudManagedDataCopyWith<$Res> {
  _$DlerCloudManagedDataCopyWithImpl(this._self, this._then);

  final DlerCloudManagedData _self;
  final $Res Function(DlerCloudManagedData) _then;

/// Create a copy of DlerCloudManagedData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? smart = null,Object? ss2022 = freezed,Object? vmess = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,smart: null == smart ? _self.smart : smart // ignore: cast_nullable_to_non_nullable
as String,ss2022: freezed == ss2022 ? _self.ss2022 : ss2022 // ignore: cast_nullable_to_non_nullable
as String?,vmess: freezed == vmess ? _self.vmess : vmess // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DlerCloudManagedData].
extension DlerCloudManagedDataPatterns on DlerCloudManagedData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DlerCloudManagedData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DlerCloudManagedData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DlerCloudManagedData value)  $default,){
final _that = this;
switch (_that) {
case _DlerCloudManagedData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DlerCloudManagedData value)?  $default,){
final _that = this;
switch (_that) {
case _DlerCloudManagedData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String smart,  String? ss2022,  String? vmess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DlerCloudManagedData() when $default != null:
return $default(_that.name,_that.smart,_that.ss2022,_that.vmess);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String smart,  String? ss2022,  String? vmess)  $default,) {final _that = this;
switch (_that) {
case _DlerCloudManagedData():
return $default(_that.name,_that.smart,_that.ss2022,_that.vmess);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String smart,  String? ss2022,  String? vmess)?  $default,) {final _that = this;
switch (_that) {
case _DlerCloudManagedData() when $default != null:
return $default(_that.name,_that.smart,_that.ss2022,_that.vmess);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DlerCloudManagedData implements DlerCloudManagedData {
  const _DlerCloudManagedData({required this.name, required this.smart, this.ss2022, this.vmess});
  factory _DlerCloudManagedData.fromJson(Map<String, dynamic> json) => _$DlerCloudManagedDataFromJson(json);

@override final  String name;
@override final  String smart;
@override final  String? ss2022;
@override final  String? vmess;

/// Create a copy of DlerCloudManagedData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DlerCloudManagedDataCopyWith<_DlerCloudManagedData> get copyWith => __$DlerCloudManagedDataCopyWithImpl<_DlerCloudManagedData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DlerCloudManagedDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DlerCloudManagedData&&(identical(other.name, name) || other.name == name)&&(identical(other.smart, smart) || other.smart == smart)&&(identical(other.ss2022, ss2022) || other.ss2022 == ss2022)&&(identical(other.vmess, vmess) || other.vmess == vmess));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,smart,ss2022,vmess);

@override
String toString() {
  return 'DlerCloudManagedData(name: $name, smart: $smart, ss2022: $ss2022, vmess: $vmess)';
}


}

/// @nodoc
abstract mixin class _$DlerCloudManagedDataCopyWith<$Res> implements $DlerCloudManagedDataCopyWith<$Res> {
  factory _$DlerCloudManagedDataCopyWith(_DlerCloudManagedData value, $Res Function(_DlerCloudManagedData) _then) = __$DlerCloudManagedDataCopyWithImpl;
@override @useResult
$Res call({
 String name, String smart, String? ss2022, String? vmess
});




}
/// @nodoc
class __$DlerCloudManagedDataCopyWithImpl<$Res>
    implements _$DlerCloudManagedDataCopyWith<$Res> {
  __$DlerCloudManagedDataCopyWithImpl(this._self, this._then);

  final _DlerCloudManagedData _self;
  final $Res Function(_DlerCloudManagedData) _then;

/// Create a copy of DlerCloudManagedData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? smart = null,Object? ss2022 = freezed,Object? vmess = freezed,}) {
  return _then(_DlerCloudManagedData(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,smart: null == smart ? _self.smart : smart // ignore: cast_nullable_to_non_nullable
as String,ss2022: freezed == ss2022 ? _self.ss2022 : ss2022 // ignore: cast_nullable_to_non_nullable
as String?,vmess: freezed == vmess ? _self.vmess : vmess // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DlerCloudAnnouncement {

 int get id; String get date; String get content; String get markdown;
/// Create a copy of DlerCloudAnnouncement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DlerCloudAnnouncementCopyWith<DlerCloudAnnouncement> get copyWith => _$DlerCloudAnnouncementCopyWithImpl<DlerCloudAnnouncement>(this as DlerCloudAnnouncement, _$identity);

  /// Serializes this DlerCloudAnnouncement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DlerCloudAnnouncement&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.content, content) || other.content == content)&&(identical(other.markdown, markdown) || other.markdown == markdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,content,markdown);

@override
String toString() {
  return 'DlerCloudAnnouncement(id: $id, date: $date, content: $content, markdown: $markdown)';
}


}

/// @nodoc
abstract mixin class $DlerCloudAnnouncementCopyWith<$Res>  {
  factory $DlerCloudAnnouncementCopyWith(DlerCloudAnnouncement value, $Res Function(DlerCloudAnnouncement) _then) = _$DlerCloudAnnouncementCopyWithImpl;
@useResult
$Res call({
 int id, String date, String content, String markdown
});




}
/// @nodoc
class _$DlerCloudAnnouncementCopyWithImpl<$Res>
    implements $DlerCloudAnnouncementCopyWith<$Res> {
  _$DlerCloudAnnouncementCopyWithImpl(this._self, this._then);

  final DlerCloudAnnouncement _self;
  final $Res Function(DlerCloudAnnouncement) _then;

/// Create a copy of DlerCloudAnnouncement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? content = null,Object? markdown = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,markdown: null == markdown ? _self.markdown : markdown // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DlerCloudAnnouncement].
extension DlerCloudAnnouncementPatterns on DlerCloudAnnouncement {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DlerCloudAnnouncement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DlerCloudAnnouncement() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DlerCloudAnnouncement value)  $default,){
final _that = this;
switch (_that) {
case _DlerCloudAnnouncement():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DlerCloudAnnouncement value)?  $default,){
final _that = this;
switch (_that) {
case _DlerCloudAnnouncement() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String date,  String content,  String markdown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DlerCloudAnnouncement() when $default != null:
return $default(_that.id,_that.date,_that.content,_that.markdown);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String date,  String content,  String markdown)  $default,) {final _that = this;
switch (_that) {
case _DlerCloudAnnouncement():
return $default(_that.id,_that.date,_that.content,_that.markdown);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String date,  String content,  String markdown)?  $default,) {final _that = this;
switch (_that) {
case _DlerCloudAnnouncement() when $default != null:
return $default(_that.id,_that.date,_that.content,_that.markdown);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DlerCloudAnnouncement implements DlerCloudAnnouncement {
  const _DlerCloudAnnouncement({required this.id, required this.date, required this.content, this.markdown = ''});
  factory _DlerCloudAnnouncement.fromJson(Map<String, dynamic> json) => _$DlerCloudAnnouncementFromJson(json);

@override final  int id;
@override final  String date;
@override final  String content;
@override@JsonKey() final  String markdown;

/// Create a copy of DlerCloudAnnouncement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DlerCloudAnnouncementCopyWith<_DlerCloudAnnouncement> get copyWith => __$DlerCloudAnnouncementCopyWithImpl<_DlerCloudAnnouncement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DlerCloudAnnouncementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DlerCloudAnnouncement&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.content, content) || other.content == content)&&(identical(other.markdown, markdown) || other.markdown == markdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,content,markdown);

@override
String toString() {
  return 'DlerCloudAnnouncement(id: $id, date: $date, content: $content, markdown: $markdown)';
}


}

/// @nodoc
abstract mixin class _$DlerCloudAnnouncementCopyWith<$Res> implements $DlerCloudAnnouncementCopyWith<$Res> {
  factory _$DlerCloudAnnouncementCopyWith(_DlerCloudAnnouncement value, $Res Function(_DlerCloudAnnouncement) _then) = __$DlerCloudAnnouncementCopyWithImpl;
@override @useResult
$Res call({
 int id, String date, String content, String markdown
});




}
/// @nodoc
class __$DlerCloudAnnouncementCopyWithImpl<$Res>
    implements _$DlerCloudAnnouncementCopyWith<$Res> {
  __$DlerCloudAnnouncementCopyWithImpl(this._self, this._then);

  final _DlerCloudAnnouncement _self;
  final $Res Function(_DlerCloudAnnouncement) _then;

/// Create a copy of DlerCloudAnnouncement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? content = null,Object? markdown = null,}) {
  return _then(_DlerCloudAnnouncement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,markdown: null == markdown ? _self.markdown : markdown // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
