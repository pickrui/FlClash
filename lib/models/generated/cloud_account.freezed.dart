// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../cloud_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CloudProfile {

 String get subscription; String get planCode; int? get planRank; List<String> get nodeAccess; DateTime get expireTime; String get todayUsed; String get totalUsed; String get totalTraffic; double get usageProgress; String get remaining; String get balance; String get commission; String get points;
/// Create a copy of CloudProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CloudProfileCopyWith<CloudProfile> get copyWith => _$CloudProfileCopyWithImpl<CloudProfile>(this as CloudProfile, _$identity);

  /// Serializes this CloudProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloudProfile&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.planCode, planCode) || other.planCode == planCode)&&(identical(other.planRank, planRank) || other.planRank == planRank)&&const DeepCollectionEquality().equals(other.nodeAccess, nodeAccess)&&(identical(other.expireTime, expireTime) || other.expireTime == expireTime)&&(identical(other.todayUsed, todayUsed) || other.todayUsed == todayUsed)&&(identical(other.totalUsed, totalUsed) || other.totalUsed == totalUsed)&&(identical(other.totalTraffic, totalTraffic) || other.totalTraffic == totalTraffic)&&(identical(other.usageProgress, usageProgress) || other.usageProgress == usageProgress)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscription,planCode,planRank,const DeepCollectionEquality().hash(nodeAccess),expireTime,todayUsed,totalUsed,totalTraffic,usageProgress,remaining,balance,commission,points);

@override
String toString() {
  return 'CloudProfile(subscription: $subscription, planCode: $planCode, planRank: $planRank, nodeAccess: $nodeAccess, expireTime: $expireTime, todayUsed: $todayUsed, totalUsed: $totalUsed, totalTraffic: $totalTraffic, usageProgress: $usageProgress, remaining: $remaining, balance: $balance, commission: $commission, points: $points)';
}


}

/// @nodoc
abstract mixin class $CloudProfileCopyWith<$Res>  {
  factory $CloudProfileCopyWith(CloudProfile value, $Res Function(CloudProfile) _then) = _$CloudProfileCopyWithImpl;
@useResult
$Res call({
 String subscription, String planCode, int? planRank, List<String> nodeAccess, DateTime expireTime, String todayUsed, String totalUsed, String totalTraffic, double usageProgress, String remaining, String balance, String commission, String points
});




}
/// @nodoc
class _$CloudProfileCopyWithImpl<$Res>
    implements $CloudProfileCopyWith<$Res> {
  _$CloudProfileCopyWithImpl(this._self, this._then);

  final CloudProfile _self;
  final $Res Function(CloudProfile) _then;

/// Create a copy of CloudProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subscription = null,Object? planCode = null,Object? planRank = freezed,Object? nodeAccess = null,Object? expireTime = null,Object? todayUsed = null,Object? totalUsed = null,Object? totalTraffic = null,Object? usageProgress = null,Object? remaining = null,Object? balance = null,Object? commission = null,Object? points = null,}) {
  return _then(_self.copyWith(
subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as String,planCode: null == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String,planRank: freezed == planRank ? _self.planRank : planRank // ignore: cast_nullable_to_non_nullable
as int?,nodeAccess: null == nodeAccess ? _self.nodeAccess : nodeAccess // ignore: cast_nullable_to_non_nullable
as List<String>,expireTime: null == expireTime ? _self.expireTime : expireTime // ignore: cast_nullable_to_non_nullable
as DateTime,todayUsed: null == todayUsed ? _self.todayUsed : todayUsed // ignore: cast_nullable_to_non_nullable
as String,totalUsed: null == totalUsed ? _self.totalUsed : totalUsed // ignore: cast_nullable_to_non_nullable
as String,totalTraffic: null == totalTraffic ? _self.totalTraffic : totalTraffic // ignore: cast_nullable_to_non_nullable
as String,usageProgress: null == usageProgress ? _self.usageProgress : usageProgress // ignore: cast_nullable_to_non_nullable
as double,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CloudProfile].
extension CloudProfilePatterns on CloudProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CloudProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CloudProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CloudProfile value)  $default,){
final _that = this;
switch (_that) {
case _CloudProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CloudProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CloudProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subscription,  String planCode,  int? planRank,  List<String> nodeAccess,  DateTime expireTime,  String todayUsed,  String totalUsed,  String totalTraffic,  double usageProgress,  String remaining,  String balance,  String commission,  String points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CloudProfile() when $default != null:
return $default(_that.subscription,_that.planCode,_that.planRank,_that.nodeAccess,_that.expireTime,_that.todayUsed,_that.totalUsed,_that.totalTraffic,_that.usageProgress,_that.remaining,_that.balance,_that.commission,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subscription,  String planCode,  int? planRank,  List<String> nodeAccess,  DateTime expireTime,  String todayUsed,  String totalUsed,  String totalTraffic,  double usageProgress,  String remaining,  String balance,  String commission,  String points)  $default,) {final _that = this;
switch (_that) {
case _CloudProfile():
return $default(_that.subscription,_that.planCode,_that.planRank,_that.nodeAccess,_that.expireTime,_that.todayUsed,_that.totalUsed,_that.totalTraffic,_that.usageProgress,_that.remaining,_that.balance,_that.commission,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subscription,  String planCode,  int? planRank,  List<String> nodeAccess,  DateTime expireTime,  String todayUsed,  String totalUsed,  String totalTraffic,  double usageProgress,  String remaining,  String balance,  String commission,  String points)?  $default,) {final _that = this;
switch (_that) {
case _CloudProfile() when $default != null:
return $default(_that.subscription,_that.planCode,_that.planRank,_that.nodeAccess,_that.expireTime,_that.todayUsed,_that.totalUsed,_that.totalTraffic,_that.usageProgress,_that.remaining,_that.balance,_that.commission,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CloudProfile implements CloudProfile {
  const _CloudProfile({required this.subscription, this.planCode = '', this.planRank, final  List<String> nodeAccess = const <String>[], required this.expireTime, required this.todayUsed, required this.totalUsed, required this.totalTraffic, required this.usageProgress, required this.remaining, required this.balance, required this.commission, required this.points}): _nodeAccess = nodeAccess;
  factory _CloudProfile.fromJson(Map<String, dynamic> json) => _$CloudProfileFromJson(json);

@override final  String subscription;
@override@JsonKey() final  String planCode;
@override final  int? planRank;
 final  List<String> _nodeAccess;
@override@JsonKey() List<String> get nodeAccess {
  if (_nodeAccess is EqualUnmodifiableListView) return _nodeAccess;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nodeAccess);
}

@override final  DateTime expireTime;
@override final  String todayUsed;
@override final  String totalUsed;
@override final  String totalTraffic;
@override final  double usageProgress;
@override final  String remaining;
@override final  String balance;
@override final  String commission;
@override final  String points;

/// Create a copy of CloudProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CloudProfileCopyWith<_CloudProfile> get copyWith => __$CloudProfileCopyWithImpl<_CloudProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CloudProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloudProfile&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.planCode, planCode) || other.planCode == planCode)&&(identical(other.planRank, planRank) || other.planRank == planRank)&&const DeepCollectionEquality().equals(other._nodeAccess, _nodeAccess)&&(identical(other.expireTime, expireTime) || other.expireTime == expireTime)&&(identical(other.todayUsed, todayUsed) || other.todayUsed == todayUsed)&&(identical(other.totalUsed, totalUsed) || other.totalUsed == totalUsed)&&(identical(other.totalTraffic, totalTraffic) || other.totalTraffic == totalTraffic)&&(identical(other.usageProgress, usageProgress) || other.usageProgress == usageProgress)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscription,planCode,planRank,const DeepCollectionEquality().hash(_nodeAccess),expireTime,todayUsed,totalUsed,totalTraffic,usageProgress,remaining,balance,commission,points);

@override
String toString() {
  return 'CloudProfile(subscription: $subscription, planCode: $planCode, planRank: $planRank, nodeAccess: $nodeAccess, expireTime: $expireTime, todayUsed: $todayUsed, totalUsed: $totalUsed, totalTraffic: $totalTraffic, usageProgress: $usageProgress, remaining: $remaining, balance: $balance, commission: $commission, points: $points)';
}


}

/// @nodoc
abstract mixin class _$CloudProfileCopyWith<$Res> implements $CloudProfileCopyWith<$Res> {
  factory _$CloudProfileCopyWith(_CloudProfile value, $Res Function(_CloudProfile) _then) = __$CloudProfileCopyWithImpl;
@override @useResult
$Res call({
 String subscription, String planCode, int? planRank, List<String> nodeAccess, DateTime expireTime, String todayUsed, String totalUsed, String totalTraffic, double usageProgress, String remaining, String balance, String commission, String points
});




}
/// @nodoc
class __$CloudProfileCopyWithImpl<$Res>
    implements _$CloudProfileCopyWith<$Res> {
  __$CloudProfileCopyWithImpl(this._self, this._then);

  final _CloudProfile _self;
  final $Res Function(_CloudProfile) _then;

/// Create a copy of CloudProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subscription = null,Object? planCode = null,Object? planRank = freezed,Object? nodeAccess = null,Object? expireTime = null,Object? todayUsed = null,Object? totalUsed = null,Object? totalTraffic = null,Object? usageProgress = null,Object? remaining = null,Object? balance = null,Object? commission = null,Object? points = null,}) {
  return _then(_CloudProfile(
subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as String,planCode: null == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String,planRank: freezed == planRank ? _self.planRank : planRank // ignore: cast_nullable_to_non_nullable
as int?,nodeAccess: null == nodeAccess ? _self._nodeAccess : nodeAccess // ignore: cast_nullable_to_non_nullable
as List<String>,expireTime: null == expireTime ? _self.expireTime : expireTime // ignore: cast_nullable_to_non_nullable
as DateTime,todayUsed: null == todayUsed ? _self.todayUsed : todayUsed // ignore: cast_nullable_to_non_nullable
as String,totalUsed: null == totalUsed ? _self.totalUsed : totalUsed // ignore: cast_nullable_to_non_nullable
as String,totalTraffic: null == totalTraffic ? _self.totalTraffic : totalTraffic // ignore: cast_nullable_to_non_nullable
as String,usageProgress: null == usageProgress ? _self.usageProgress : usageProgress // ignore: cast_nullable_to_non_nullable
as double,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CloudNotification {

 String get cleanMessage; DateTime get publishTime;
/// Create a copy of CloudNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CloudNotificationCopyWith<CloudNotification> get copyWith => _$CloudNotificationCopyWithImpl<CloudNotification>(this as CloudNotification, _$identity);

  /// Serializes this CloudNotification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloudNotification&&(identical(other.cleanMessage, cleanMessage) || other.cleanMessage == cleanMessage)&&(identical(other.publishTime, publishTime) || other.publishTime == publishTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cleanMessage,publishTime);

@override
String toString() {
  return 'CloudNotification(cleanMessage: $cleanMessage, publishTime: $publishTime)';
}


}

/// @nodoc
abstract mixin class $CloudNotificationCopyWith<$Res>  {
  factory $CloudNotificationCopyWith(CloudNotification value, $Res Function(CloudNotification) _then) = _$CloudNotificationCopyWithImpl;
@useResult
$Res call({
 String cleanMessage, DateTime publishTime
});




}
/// @nodoc
class _$CloudNotificationCopyWithImpl<$Res>
    implements $CloudNotificationCopyWith<$Res> {
  _$CloudNotificationCopyWithImpl(this._self, this._then);

  final CloudNotification _self;
  final $Res Function(CloudNotification) _then;

/// Create a copy of CloudNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cleanMessage = null,Object? publishTime = null,}) {
  return _then(_self.copyWith(
cleanMessage: null == cleanMessage ? _self.cleanMessage : cleanMessage // ignore: cast_nullable_to_non_nullable
as String,publishTime: null == publishTime ? _self.publishTime : publishTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CloudNotification].
extension CloudNotificationPatterns on CloudNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CloudNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CloudNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CloudNotification value)  $default,){
final _that = this;
switch (_that) {
case _CloudNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CloudNotification value)?  $default,){
final _that = this;
switch (_that) {
case _CloudNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cleanMessage,  DateTime publishTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CloudNotification() when $default != null:
return $default(_that.cleanMessage,_that.publishTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cleanMessage,  DateTime publishTime)  $default,) {final _that = this;
switch (_that) {
case _CloudNotification():
return $default(_that.cleanMessage,_that.publishTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cleanMessage,  DateTime publishTime)?  $default,) {final _that = this;
switch (_that) {
case _CloudNotification() when $default != null:
return $default(_that.cleanMessage,_that.publishTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CloudNotification implements CloudNotification {
  const _CloudNotification({required this.cleanMessage, required this.publishTime});
  factory _CloudNotification.fromJson(Map<String, dynamic> json) => _$CloudNotificationFromJson(json);

@override final  String cleanMessage;
@override final  DateTime publishTime;

/// Create a copy of CloudNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CloudNotificationCopyWith<_CloudNotification> get copyWith => __$CloudNotificationCopyWithImpl<_CloudNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CloudNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloudNotification&&(identical(other.cleanMessage, cleanMessage) || other.cleanMessage == cleanMessage)&&(identical(other.publishTime, publishTime) || other.publishTime == publishTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cleanMessage,publishTime);

@override
String toString() {
  return 'CloudNotification(cleanMessage: $cleanMessage, publishTime: $publishTime)';
}


}

/// @nodoc
abstract mixin class _$CloudNotificationCopyWith<$Res> implements $CloudNotificationCopyWith<$Res> {
  factory _$CloudNotificationCopyWith(_CloudNotification value, $Res Function(_CloudNotification) _then) = __$CloudNotificationCopyWithImpl;
@override @useResult
$Res call({
 String cleanMessage, DateTime publishTime
});




}
/// @nodoc
class __$CloudNotificationCopyWithImpl<$Res>
    implements _$CloudNotificationCopyWith<$Res> {
  __$CloudNotificationCopyWithImpl(this._self, this._then);

  final _CloudNotification _self;
  final $Res Function(_CloudNotification) _then;

/// Create a copy of CloudNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cleanMessage = null,Object? publishTime = null,}) {
  return _then(_CloudNotification(
cleanMessage: null == cleanMessage ? _self.cleanMessage : cleanMessage // ignore: cast_nullable_to_non_nullable
as String,publishTime: null == publishTime ? _self.publishTime : publishTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$CloudAccountState {

 bool get isLoading; bool get isRefreshing; bool get isSyncing; bool get isLoggedIn; CloudProfile? get profile; CloudNotification? get latestNotification; String? get error;
/// Create a copy of CloudAccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CloudAccountStateCopyWith<CloudAccountState> get copyWith => _$CloudAccountStateCopyWithImpl<CloudAccountState>(this as CloudAccountState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloudAccountState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.latestNotification, latestNotification) || other.latestNotification == latestNotification)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,isSyncing,isLoggedIn,profile,latestNotification,error);

@override
String toString() {
  return 'CloudAccountState(isLoading: $isLoading, isRefreshing: $isRefreshing, isSyncing: $isSyncing, isLoggedIn: $isLoggedIn, profile: $profile, latestNotification: $latestNotification, error: $error)';
}


}

/// @nodoc
abstract mixin class $CloudAccountStateCopyWith<$Res>  {
  factory $CloudAccountStateCopyWith(CloudAccountState value, $Res Function(CloudAccountState) _then) = _$CloudAccountStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isRefreshing, bool isSyncing, bool isLoggedIn, CloudProfile? profile, CloudNotification? latestNotification, String? error
});


$CloudProfileCopyWith<$Res>? get profile;$CloudNotificationCopyWith<$Res>? get latestNotification;

}
/// @nodoc
class _$CloudAccountStateCopyWithImpl<$Res>
    implements $CloudAccountStateCopyWith<$Res> {
  _$CloudAccountStateCopyWithImpl(this._self, this._then);

  final CloudAccountState _self;
  final $Res Function(CloudAccountState) _then;

/// Create a copy of CloudAccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? isSyncing = null,Object? isLoggedIn = null,Object? profile = freezed,Object? latestNotification = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CloudProfile?,latestNotification: freezed == latestNotification ? _self.latestNotification : latestNotification // ignore: cast_nullable_to_non_nullable
as CloudNotification?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CloudAccountState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CloudProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $CloudProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of CloudAccountState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CloudNotificationCopyWith<$Res>? get latestNotification {
    if (_self.latestNotification == null) {
    return null;
  }

  return $CloudNotificationCopyWith<$Res>(_self.latestNotification!, (value) {
    return _then(_self.copyWith(latestNotification: value));
  });
}
}


/// Adds pattern-matching-related methods to [CloudAccountState].
extension CloudAccountStatePatterns on CloudAccountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CloudAccountState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CloudAccountState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CloudAccountState value)  $default,){
final _that = this;
switch (_that) {
case _CloudAccountState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CloudAccountState value)?  $default,){
final _that = this;
switch (_that) {
case _CloudAccountState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  bool isSyncing,  bool isLoggedIn,  CloudProfile? profile,  CloudNotification? latestNotification,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CloudAccountState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.isSyncing,_that.isLoggedIn,_that.profile,_that.latestNotification,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  bool isSyncing,  bool isLoggedIn,  CloudProfile? profile,  CloudNotification? latestNotification,  String? error)  $default,) {final _that = this;
switch (_that) {
case _CloudAccountState():
return $default(_that.isLoading,_that.isRefreshing,_that.isSyncing,_that.isLoggedIn,_that.profile,_that.latestNotification,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isRefreshing,  bool isSyncing,  bool isLoggedIn,  CloudProfile? profile,  CloudNotification? latestNotification,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _CloudAccountState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.isSyncing,_that.isLoggedIn,_that.profile,_that.latestNotification,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CloudAccountState implements CloudAccountState {
  const _CloudAccountState({this.isLoading = false, this.isRefreshing = false, this.isSyncing = false, this.isLoggedIn = false, this.profile, this.latestNotification, this.error});


@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isSyncing;
@override@JsonKey() final  bool isLoggedIn;
@override final  CloudProfile? profile;
@override final  CloudNotification? latestNotification;
@override final  String? error;

/// Create a copy of CloudAccountState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CloudAccountStateCopyWith<_CloudAccountState> get copyWith => __$CloudAccountStateCopyWithImpl<_CloudAccountState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloudAccountState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.latestNotification, latestNotification) || other.latestNotification == latestNotification)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,isSyncing,isLoggedIn,profile,latestNotification,error);

@override
String toString() {
  return 'CloudAccountState(isLoading: $isLoading, isRefreshing: $isRefreshing, isSyncing: $isSyncing, isLoggedIn: $isLoggedIn, profile: $profile, latestNotification: $latestNotification, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CloudAccountStateCopyWith<$Res> implements $CloudAccountStateCopyWith<$Res> {
  factory _$CloudAccountStateCopyWith(_CloudAccountState value, $Res Function(_CloudAccountState) _then) = __$CloudAccountStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isRefreshing, bool isSyncing, bool isLoggedIn, CloudProfile? profile, CloudNotification? latestNotification, String? error
});


@override $CloudProfileCopyWith<$Res>? get profile;@override $CloudNotificationCopyWith<$Res>? get latestNotification;

}
/// @nodoc
class __$CloudAccountStateCopyWithImpl<$Res>
    implements _$CloudAccountStateCopyWith<$Res> {
  __$CloudAccountStateCopyWithImpl(this._self, this._then);

  final _CloudAccountState _self;
  final $Res Function(_CloudAccountState) _then;

/// Create a copy of CloudAccountState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? isSyncing = null,Object? isLoggedIn = null,Object? profile = freezed,Object? latestNotification = freezed,Object? error = freezed,}) {
  return _then(_CloudAccountState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CloudProfile?,latestNotification: freezed == latestNotification ? _self.latestNotification : latestNotification // ignore: cast_nullable_to_non_nullable
as CloudNotification?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CloudAccountState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CloudProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $CloudProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of CloudAccountState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CloudNotificationCopyWith<$Res>? get latestNotification {
    if (_self.latestNotification == null) {
    return null;
  }

  return $CloudNotificationCopyWith<$Res>(_self.latestNotification!, (value) {
    return _then(_self.copyWith(latestNotification: value));
  });
}
}

// dart format on
