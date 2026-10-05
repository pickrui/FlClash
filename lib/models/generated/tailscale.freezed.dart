// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tailscale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TailscaleNetwork {

 String get id; String get name;/// Names the node identity directory. It changes with the control server,
/// because a node key belongs to the server that registered it.
 String get stateId; String get hostname; TailscaleLoginMethod get loginMethod; String get controlUrl; bool get autoRoute; String get exitNode; bool get exitNodeAllowLanAccess;/// Learned after sign-in so MagicDNS names resolve through the tailnet in
/// DNS modes that do not map names to fake IPs.
 String get magicDnsSuffix;
/// Create a copy of TailscaleNetwork
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TailscaleNetworkCopyWith<TailscaleNetwork> get copyWith => _$TailscaleNetworkCopyWithImpl<TailscaleNetwork>(this as TailscaleNetwork, _$identity);

  /// Serializes this TailscaleNetwork to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TailscaleNetwork;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TailscaleNetwork&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.stateId, _this.stateId) || other.stateId == _this.stateId)&&(identical(other.hostname, _this.hostname) || other.hostname == _this.hostname)&&(identical(other.loginMethod, _this.loginMethod) || other.loginMethod == _this.loginMethod)&&(identical(other.controlUrl, _this.controlUrl) || other.controlUrl == _this.controlUrl)&&(identical(other.autoRoute, _this.autoRoute) || other.autoRoute == _this.autoRoute)&&(identical(other.exitNode, _this.exitNode) || other.exitNode == _this.exitNode)&&(identical(other.exitNodeAllowLanAccess, _this.exitNodeAllowLanAccess) || other.exitNodeAllowLanAccess == _this.exitNodeAllowLanAccess)&&(identical(other.magicDnsSuffix, _this.magicDnsSuffix) || other.magicDnsSuffix == _this.magicDnsSuffix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TailscaleNetwork;
  return Object.hash(runtimeType,_this.id,_this.name,_this.stateId,_this.hostname,_this.loginMethod,_this.controlUrl,_this.autoRoute,_this.exitNode,_this.exitNodeAllowLanAccess,_this.magicDnsSuffix);
}

@override
String toString() {
  final _this = this as TailscaleNetwork;
  return 'TailscaleNetwork(id: ${_this.id}, name: ${_this.name}, stateId: ${_this.stateId}, hostname: ${_this.hostname}, loginMethod: ${_this.loginMethod}, controlUrl: ${_this.controlUrl}, autoRoute: ${_this.autoRoute}, exitNode: ${_this.exitNode}, exitNodeAllowLanAccess: ${_this.exitNodeAllowLanAccess}, magicDnsSuffix: ${_this.magicDnsSuffix})';
}


}

/// @nodoc
abstract mixin class $TailscaleNetworkCopyWith<$Res>  {
  factory $TailscaleNetworkCopyWith(TailscaleNetwork value, $Res Function(TailscaleNetwork) _then) = _$TailscaleNetworkCopyWithImpl;
@useResult
$Res call({
 String id, String name, String stateId, String hostname, TailscaleLoginMethod loginMethod, String controlUrl, bool autoRoute, String exitNode, bool exitNodeAllowLanAccess, String magicDnsSuffix
});




}
/// @nodoc
class _$TailscaleNetworkCopyWithImpl<$Res>
    implements $TailscaleNetworkCopyWith<$Res> {
  _$TailscaleNetworkCopyWithImpl(this._self, this._then);

  final TailscaleNetwork _self;
  final $Res Function(TailscaleNetwork) _then;

/// Create a copy of TailscaleNetwork
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? stateId = null,Object? hostname = null,Object? loginMethod = null,Object? controlUrl = null,Object? autoRoute = null,Object? exitNode = null,Object? exitNodeAllowLanAccess = null,Object? magicDnsSuffix = null,}) {
  return _then(TailscaleNetwork(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stateId: null == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as String,hostname: null == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String,loginMethod: null == loginMethod ? _self.loginMethod : loginMethod // ignore: cast_nullable_to_non_nullable
as TailscaleLoginMethod,controlUrl: null == controlUrl ? _self.controlUrl : controlUrl // ignore: cast_nullable_to_non_nullable
as String,autoRoute: null == autoRoute ? _self.autoRoute : autoRoute // ignore: cast_nullable_to_non_nullable
as bool,exitNode: null == exitNode ? _self.exitNode : exitNode // ignore: cast_nullable_to_non_nullable
as String,exitNodeAllowLanAccess: null == exitNodeAllowLanAccess ? _self.exitNodeAllowLanAccess : exitNodeAllowLanAccess // ignore: cast_nullable_to_non_nullable
as bool,magicDnsSuffix: null == magicDnsSuffix ? _self.magicDnsSuffix : magicDnsSuffix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TailscaleNetwork].
extension TailscaleNetworkPatterns on TailscaleNetwork {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TailscaleNetwork value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TailscaleNetwork() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TailscaleNetwork value)  $default,){
final _that = this;
switch (_that) {
case _TailscaleNetwork():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TailscaleNetwork value)?  $default,){
final _that = this;
switch (_that) {
case _TailscaleNetwork() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String stateId,  String hostname,  TailscaleLoginMethod loginMethod,  String controlUrl,  bool autoRoute,  String exitNode,  bool exitNodeAllowLanAccess,  String magicDnsSuffix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TailscaleNetwork() when $default != null:
return $default(_that.id,_that.name,_that.stateId,_that.hostname,_that.loginMethod,_that.controlUrl,_that.autoRoute,_that.exitNode,_that.exitNodeAllowLanAccess,_that.magicDnsSuffix);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String stateId,  String hostname,  TailscaleLoginMethod loginMethod,  String controlUrl,  bool autoRoute,  String exitNode,  bool exitNodeAllowLanAccess,  String magicDnsSuffix)  $default,) {final _that = this;
switch (_that) {
case _TailscaleNetwork():
return $default(_that.id,_that.name,_that.stateId,_that.hostname,_that.loginMethod,_that.controlUrl,_that.autoRoute,_that.exitNode,_that.exitNodeAllowLanAccess,_that.magicDnsSuffix);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String stateId,  String hostname,  TailscaleLoginMethod loginMethod,  String controlUrl,  bool autoRoute,  String exitNode,  bool exitNodeAllowLanAccess,  String magicDnsSuffix)?  $default,) {final _that = this;
switch (_that) {
case _TailscaleNetwork() when $default != null:
return $default(_that.id,_that.name,_that.stateId,_that.hostname,_that.loginMethod,_that.controlUrl,_that.autoRoute,_that.exitNode,_that.exitNodeAllowLanAccess,_that.magicDnsSuffix);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TailscaleNetwork implements TailscaleNetwork {
  const _TailscaleNetwork({required this.id, required this.name, required this.stateId, this.hostname = '', this.loginMethod = TailscaleLoginMethod.interactive, this.controlUrl = '', this.autoRoute = true, this.exitNode = '', this.exitNodeAllowLanAccess = false, this.magicDnsSuffix = ''});
  factory _TailscaleNetwork.fromJson(Map<String, dynamic> json) => _$TailscaleNetworkFromJson(json);

@override final  String id;
@override final  String name;
/// Names the node identity directory. It changes with the control server,
/// because a node key belongs to the server that registered it.
@override final  String stateId;
@override@JsonKey() final  String hostname;
@override@JsonKey() final  TailscaleLoginMethod loginMethod;
@override@JsonKey() final  String controlUrl;
@override@JsonKey() final  bool autoRoute;
@override@JsonKey() final  String exitNode;
@override@JsonKey() final  bool exitNodeAllowLanAccess;
/// Learned after sign-in so MagicDNS names resolve through the tailnet in
/// DNS modes that do not map names to fake IPs.
@override@JsonKey() final  String magicDnsSuffix;

/// Create a copy of TailscaleNetwork
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TailscaleNetworkCopyWith<_TailscaleNetwork> get copyWith => __$TailscaleNetworkCopyWithImpl<_TailscaleNetwork>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TailscaleNetworkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TailscaleNetwork&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.loginMethod, loginMethod) || other.loginMethod == loginMethod)&&(identical(other.controlUrl, controlUrl) || other.controlUrl == controlUrl)&&(identical(other.autoRoute, autoRoute) || other.autoRoute == autoRoute)&&(identical(other.exitNode, exitNode) || other.exitNode == exitNode)&&(identical(other.exitNodeAllowLanAccess, exitNodeAllowLanAccess) || other.exitNodeAllowLanAccess == exitNodeAllowLanAccess)&&(identical(other.magicDnsSuffix, magicDnsSuffix) || other.magicDnsSuffix == magicDnsSuffix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,stateId,hostname,loginMethod,controlUrl,autoRoute,exitNode,exitNodeAllowLanAccess,magicDnsSuffix);
}

@override
String toString() {
    return 'TailscaleNetwork(id: $id, name: $name, stateId: $stateId, hostname: $hostname, loginMethod: $loginMethod, controlUrl: $controlUrl, autoRoute: $autoRoute, exitNode: $exitNode, exitNodeAllowLanAccess: $exitNodeAllowLanAccess, magicDnsSuffix: $magicDnsSuffix)';
}


}

/// @nodoc
abstract mixin class _$TailscaleNetworkCopyWith<$Res> implements $TailscaleNetworkCopyWith<$Res> {
  factory _$TailscaleNetworkCopyWith(_TailscaleNetwork value, $Res Function(_TailscaleNetwork) _then) = __$TailscaleNetworkCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String stateId, String hostname, TailscaleLoginMethod loginMethod, String controlUrl, bool autoRoute, String exitNode, bool exitNodeAllowLanAccess, String magicDnsSuffix
});




}
/// @nodoc
class __$TailscaleNetworkCopyWithImpl<$Res>
    implements _$TailscaleNetworkCopyWith<$Res> {
  __$TailscaleNetworkCopyWithImpl(this._self, this._then);

  final _TailscaleNetwork _self;
  final $Res Function(_TailscaleNetwork) _then;

/// Create a copy of TailscaleNetwork
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? stateId = null,Object? hostname = null,Object? loginMethod = null,Object? controlUrl = null,Object? autoRoute = null,Object? exitNode = null,Object? exitNodeAllowLanAccess = null,Object? magicDnsSuffix = null,}) {
  return _then(_TailscaleNetwork(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stateId: null == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as String,hostname: null == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String,loginMethod: null == loginMethod ? _self.loginMethod : loginMethod // ignore: cast_nullable_to_non_nullable
as TailscaleLoginMethod,controlUrl: null == controlUrl ? _self.controlUrl : controlUrl // ignore: cast_nullable_to_non_nullable
as String,autoRoute: null == autoRoute ? _self.autoRoute : autoRoute // ignore: cast_nullable_to_non_nullable
as bool,exitNode: null == exitNode ? _self.exitNode : exitNode // ignore: cast_nullable_to_non_nullable
as String,exitNodeAllowLanAccess: null == exitNodeAllowLanAccess ? _self.exitNodeAllowLanAccess : exitNodeAllowLanAccess // ignore: cast_nullable_to_non_nullable
as bool,magicDnsSuffix: null == magicDnsSuffix ? _self.magicDnsSuffix : magicDnsSuffix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TailscaleDevice {

 String get name; String get hostName; String get os; List<String> get addresses; bool get online; bool get direct; String get relay; bool get exitNodeOption; bool get exitNode;
/// Create a copy of TailscaleDevice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TailscaleDeviceCopyWith<TailscaleDevice> get copyWith => _$TailscaleDeviceCopyWithImpl<TailscaleDevice>(this as TailscaleDevice, _$identity);

  /// Serializes this TailscaleDevice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TailscaleDevice;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TailscaleDevice&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.hostName, _this.hostName) || other.hostName == _this.hostName)&&(identical(other.os, _this.os) || other.os == _this.os)&&const DeepCollectionEquality().equals(other.addresses, _this.addresses)&&(identical(other.online, _this.online) || other.online == _this.online)&&(identical(other.direct, _this.direct) || other.direct == _this.direct)&&(identical(other.relay, _this.relay) || other.relay == _this.relay)&&(identical(other.exitNodeOption, _this.exitNodeOption) || other.exitNodeOption == _this.exitNodeOption)&&(identical(other.exitNode, _this.exitNode) || other.exitNode == _this.exitNode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TailscaleDevice;
  return Object.hash(runtimeType,_this.name,_this.hostName,_this.os,const DeepCollectionEquality().hash(_this.addresses),_this.online,_this.direct,_this.relay,_this.exitNodeOption,_this.exitNode);
}

@override
String toString() {
  final _this = this as TailscaleDevice;
  return 'TailscaleDevice(name: ${_this.name}, hostName: ${_this.hostName}, os: ${_this.os}, addresses: ${_this.addresses}, online: ${_this.online}, direct: ${_this.direct}, relay: ${_this.relay}, exitNodeOption: ${_this.exitNodeOption}, exitNode: ${_this.exitNode})';
}


}

/// @nodoc
abstract mixin class $TailscaleDeviceCopyWith<$Res>  {
  factory $TailscaleDeviceCopyWith(TailscaleDevice value, $Res Function(TailscaleDevice) _then) = _$TailscaleDeviceCopyWithImpl;
@useResult
$Res call({
 String name, String hostName, String os, List<String> addresses, bool online, bool direct, String relay, bool exitNodeOption, bool exitNode
});




}
/// @nodoc
class _$TailscaleDeviceCopyWithImpl<$Res>
    implements $TailscaleDeviceCopyWith<$Res> {
  _$TailscaleDeviceCopyWithImpl(this._self, this._then);

  final TailscaleDevice _self;
  final $Res Function(TailscaleDevice) _then;

/// Create a copy of TailscaleDevice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? hostName = null,Object? os = null,Object? addresses = null,Object? online = null,Object? direct = null,Object? relay = null,Object? exitNodeOption = null,Object? exitNode = null,}) {
  return _then(TailscaleDevice(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hostName: null == hostName ? _self.hostName : hostName // ignore: cast_nullable_to_non_nullable
as String,os: null == os ? _self.os : os // ignore: cast_nullable_to_non_nullable
as String,addresses: null == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<String>,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,direct: null == direct ? _self.direct : direct // ignore: cast_nullable_to_non_nullable
as bool,relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as String,exitNodeOption: null == exitNodeOption ? _self.exitNodeOption : exitNodeOption // ignore: cast_nullable_to_non_nullable
as bool,exitNode: null == exitNode ? _self.exitNode : exitNode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TailscaleDevice].
extension TailscaleDevicePatterns on TailscaleDevice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TailscaleDevice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TailscaleDevice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TailscaleDevice value)  $default,){
final _that = this;
switch (_that) {
case _TailscaleDevice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TailscaleDevice value)?  $default,){
final _that = this;
switch (_that) {
case _TailscaleDevice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String hostName,  String os,  List<String> addresses,  bool online,  bool direct,  String relay,  bool exitNodeOption,  bool exitNode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TailscaleDevice() when $default != null:
return $default(_that.name,_that.hostName,_that.os,_that.addresses,_that.online,_that.direct,_that.relay,_that.exitNodeOption,_that.exitNode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String hostName,  String os,  List<String> addresses,  bool online,  bool direct,  String relay,  bool exitNodeOption,  bool exitNode)  $default,) {final _that = this;
switch (_that) {
case _TailscaleDevice():
return $default(_that.name,_that.hostName,_that.os,_that.addresses,_that.online,_that.direct,_that.relay,_that.exitNodeOption,_that.exitNode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String hostName,  String os,  List<String> addresses,  bool online,  bool direct,  String relay,  bool exitNodeOption,  bool exitNode)?  $default,) {final _that = this;
switch (_that) {
case _TailscaleDevice() when $default != null:
return $default(_that.name,_that.hostName,_that.os,_that.addresses,_that.online,_that.direct,_that.relay,_that.exitNodeOption,_that.exitNode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TailscaleDevice implements TailscaleDevice {
  const _TailscaleDevice({this.name = '', this.hostName = '', this.os = '',  List<String> addresses = const [], this.online = false, this.direct = false, this.relay = '', this.exitNodeOption = false, this.exitNode = false}): _addresses = addresses;
  factory _TailscaleDevice.fromJson(Map<String, dynamic> json) => _$TailscaleDeviceFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String hostName;
@override@JsonKey() final  String os;
 final  List<String> _addresses;
@override@JsonKey() List<String> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}

@override@JsonKey() final  bool online;
@override@JsonKey() final  bool direct;
@override@JsonKey() final  String relay;
@override@JsonKey() final  bool exitNodeOption;
@override@JsonKey() final  bool exitNode;

/// Create a copy of TailscaleDevice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TailscaleDeviceCopyWith<_TailscaleDevice> get copyWith => __$TailscaleDeviceCopyWithImpl<_TailscaleDevice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TailscaleDeviceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TailscaleDevice&&(identical(other.name, name) || other.name == name)&&(identical(other.hostName, hostName) || other.hostName == hostName)&&(identical(other.os, os) || other.os == os)&&const DeepCollectionEquality().equals(other.addresses, _addresses)&&(identical(other.online, online) || other.online == online)&&(identical(other.direct, direct) || other.direct == direct)&&(identical(other.relay, relay) || other.relay == relay)&&(identical(other.exitNodeOption, exitNodeOption) || other.exitNodeOption == exitNodeOption)&&(identical(other.exitNode, exitNode) || other.exitNode == exitNode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,hostName,os,const DeepCollectionEquality().hash(_addresses),online,direct,relay,exitNodeOption,exitNode);
}

@override
String toString() {
    return 'TailscaleDevice(name: $name, hostName: $hostName, os: $os, addresses: $addresses, online: $online, direct: $direct, relay: $relay, exitNodeOption: $exitNodeOption, exitNode: $exitNode)';
}


}

/// @nodoc
abstract mixin class _$TailscaleDeviceCopyWith<$Res> implements $TailscaleDeviceCopyWith<$Res> {
  factory _$TailscaleDeviceCopyWith(_TailscaleDevice value, $Res Function(_TailscaleDevice) _then) = __$TailscaleDeviceCopyWithImpl;
@override @useResult
$Res call({
 String name, String hostName, String os, List<String> addresses, bool online, bool direct, String relay, bool exitNodeOption, bool exitNode
});




}
/// @nodoc
class __$TailscaleDeviceCopyWithImpl<$Res>
    implements _$TailscaleDeviceCopyWith<$Res> {
  __$TailscaleDeviceCopyWithImpl(this._self, this._then);

  final _TailscaleDevice _self;
  final $Res Function(_TailscaleDevice) _then;

/// Create a copy of TailscaleDevice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? hostName = null,Object? os = null,Object? addresses = null,Object? online = null,Object? direct = null,Object? relay = null,Object? exitNodeOption = null,Object? exitNode = null,}) {
  return _then(_TailscaleDevice(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hostName: null == hostName ? _self.hostName : hostName // ignore: cast_nullable_to_non_nullable
as String,os: null == os ? _self.os : os // ignore: cast_nullable_to_non_nullable
as String,addresses: null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<String>,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,direct: null == direct ? _self.direct : direct // ignore: cast_nullable_to_non_nullable
as bool,relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as String,exitNodeOption: null == exitNodeOption ? _self.exitNodeOption : exitNodeOption // ignore: cast_nullable_to_non_nullable
as bool,exitNode: null == exitNode ? _self.exitNode : exitNode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TailscaleStatus {

@JsonKey(name: 'state') String get rawState; String get authUrl; String get error; String get tailnet; String get magicDnsSuffix; bool get keyExpired; List<String> get health; TailscaleDevice? get self; List<TailscaleDevice> get peers;
/// Create a copy of TailscaleStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TailscaleStatusCopyWith<TailscaleStatus> get copyWith => _$TailscaleStatusCopyWithImpl<TailscaleStatus>(this as TailscaleStatus, _$identity);

  /// Serializes this TailscaleStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TailscaleStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TailscaleStatus&&(identical(other.rawState, _this.rawState) || other.rawState == _this.rawState)&&(identical(other.authUrl, _this.authUrl) || other.authUrl == _this.authUrl)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.tailnet, _this.tailnet) || other.tailnet == _this.tailnet)&&(identical(other.magicDnsSuffix, _this.magicDnsSuffix) || other.magicDnsSuffix == _this.magicDnsSuffix)&&(identical(other.keyExpired, _this.keyExpired) || other.keyExpired == _this.keyExpired)&&const DeepCollectionEquality().equals(other.health, _this.health)&&(identical(other.self, _this.self) || other.self == _this.self)&&const DeepCollectionEquality().equals(other.peers, _this.peers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TailscaleStatus;
  return Object.hash(runtimeType,_this.rawState,_this.authUrl,_this.error,_this.tailnet,_this.magicDnsSuffix,_this.keyExpired,const DeepCollectionEquality().hash(_this.health),_this.self,const DeepCollectionEquality().hash(_this.peers));
}

@override
String toString() {
  final _this = this as TailscaleStatus;
  return 'TailscaleStatus(rawState: ${_this.rawState}, authUrl: ${_this.authUrl}, error: ${_this.error}, tailnet: ${_this.tailnet}, magicDnsSuffix: ${_this.magicDnsSuffix}, keyExpired: ${_this.keyExpired}, health: ${_this.health}, self: ${_this.self}, peers: ${_this.peers})';
}


}

/// @nodoc
abstract mixin class $TailscaleStatusCopyWith<$Res>  {
  factory $TailscaleStatusCopyWith(TailscaleStatus value, $Res Function(TailscaleStatus) _then) = _$TailscaleStatusCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'state') String rawState, String authUrl, String error, String tailnet, String magicDnsSuffix, bool keyExpired, List<String> health, TailscaleDevice? self, List<TailscaleDevice> peers
});


$TailscaleDeviceCopyWith<$Res>? get self;

}
/// @nodoc
class _$TailscaleStatusCopyWithImpl<$Res>
    implements $TailscaleStatusCopyWith<$Res> {
  _$TailscaleStatusCopyWithImpl(this._self, this._then);

  final TailscaleStatus _self;
  final $Res Function(TailscaleStatus) _then;

/// Create a copy of TailscaleStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rawState = null,Object? authUrl = null,Object? error = null,Object? tailnet = null,Object? magicDnsSuffix = null,Object? keyExpired = null,Object? health = null,Object? self = freezed,Object? peers = null,}) {
  return _then(TailscaleStatus(
rawState: null == rawState ? _self.rawState : rawState // ignore: cast_nullable_to_non_nullable
as String,authUrl: null == authUrl ? _self.authUrl : authUrl // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,tailnet: null == tailnet ? _self.tailnet : tailnet // ignore: cast_nullable_to_non_nullable
as String,magicDnsSuffix: null == magicDnsSuffix ? _self.magicDnsSuffix : magicDnsSuffix // ignore: cast_nullable_to_non_nullable
as String,keyExpired: null == keyExpired ? _self.keyExpired : keyExpired // ignore: cast_nullable_to_non_nullable
as bool,health: null == health ? _self.health : health // ignore: cast_nullable_to_non_nullable
as List<String>,self: freezed == self ? _self.self : self // ignore: cast_nullable_to_non_nullable
as TailscaleDevice?,peers: null == peers ? _self.peers : peers // ignore: cast_nullable_to_non_nullable
as List<TailscaleDevice>,
  ));
}
/// Create a copy of TailscaleStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TailscaleDeviceCopyWith<$Res>? get self {
    if (_self.self == null) {
    return null;
  }

  return $TailscaleDeviceCopyWith<$Res>(_self.self!, (value) {
    return _then(_self.copyWith(self: value));
  });
}
}


/// Adds pattern-matching-related methods to [TailscaleStatus].
extension TailscaleStatusPatterns on TailscaleStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TailscaleStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TailscaleStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TailscaleStatus value)  $default,){
final _that = this;
switch (_that) {
case _TailscaleStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TailscaleStatus value)?  $default,){
final _that = this;
switch (_that) {
case _TailscaleStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'state')  String rawState,  String authUrl,  String error,  String tailnet,  String magicDnsSuffix,  bool keyExpired,  List<String> health,  TailscaleDevice? self,  List<TailscaleDevice> peers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TailscaleStatus() when $default != null:
return $default(_that.rawState,_that.authUrl,_that.error,_that.tailnet,_that.magicDnsSuffix,_that.keyExpired,_that.health,_that.self,_that.peers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'state')  String rawState,  String authUrl,  String error,  String tailnet,  String magicDnsSuffix,  bool keyExpired,  List<String> health,  TailscaleDevice? self,  List<TailscaleDevice> peers)  $default,) {final _that = this;
switch (_that) {
case _TailscaleStatus():
return $default(_that.rawState,_that.authUrl,_that.error,_that.tailnet,_that.magicDnsSuffix,_that.keyExpired,_that.health,_that.self,_that.peers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'state')  String rawState,  String authUrl,  String error,  String tailnet,  String magicDnsSuffix,  bool keyExpired,  List<String> health,  TailscaleDevice? self,  List<TailscaleDevice> peers)?  $default,) {final _that = this;
switch (_that) {
case _TailscaleStatus() when $default != null:
return $default(_that.rawState,_that.authUrl,_that.error,_that.tailnet,_that.magicDnsSuffix,_that.keyExpired,_that.health,_that.self,_that.peers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TailscaleStatus implements TailscaleStatus {
  const _TailscaleStatus({@JsonKey(name: 'state') this.rawState = '', this.authUrl = '', this.error = '', this.tailnet = '', this.magicDnsSuffix = '', this.keyExpired = false,  List<String> health = const [], this.self,  List<TailscaleDevice> peers = const []}): _health = health,_peers = peers;
  factory _TailscaleStatus.fromJson(Map<String, dynamic> json) => _$TailscaleStatusFromJson(json);

@override@JsonKey(name: 'state') final  String rawState;
@override@JsonKey() final  String authUrl;
@override@JsonKey() final  String error;
@override@JsonKey() final  String tailnet;
@override@JsonKey() final  String magicDnsSuffix;
@override@JsonKey() final  bool keyExpired;
 final  List<String> _health;
@override@JsonKey() List<String> get health {
  if (_health is EqualUnmodifiableListView) return _health;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_health);
}

@override final  TailscaleDevice? self;
 final  List<TailscaleDevice> _peers;
@override@JsonKey() List<TailscaleDevice> get peers {
  if (_peers is EqualUnmodifiableListView) return _peers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_peers);
}


/// Create a copy of TailscaleStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TailscaleStatusCopyWith<_TailscaleStatus> get copyWith => __$TailscaleStatusCopyWithImpl<_TailscaleStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TailscaleStatusToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TailscaleStatus&&(identical(other.rawState, rawState) || other.rawState == rawState)&&(identical(other.authUrl, authUrl) || other.authUrl == authUrl)&&(identical(other.error, error) || other.error == error)&&(identical(other.tailnet, tailnet) || other.tailnet == tailnet)&&(identical(other.magicDnsSuffix, magicDnsSuffix) || other.magicDnsSuffix == magicDnsSuffix)&&(identical(other.keyExpired, keyExpired) || other.keyExpired == keyExpired)&&const DeepCollectionEquality().equals(other.health, _health)&&(identical(other.self, self) || other.self == self)&&const DeepCollectionEquality().equals(other.peers, _peers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,rawState,authUrl,error,tailnet,magicDnsSuffix,keyExpired,const DeepCollectionEquality().hash(_health),self,const DeepCollectionEquality().hash(_peers));
}

@override
String toString() {
    return 'TailscaleStatus(rawState: $rawState, authUrl: $authUrl, error: $error, tailnet: $tailnet, magicDnsSuffix: $magicDnsSuffix, keyExpired: $keyExpired, health: $health, self: $self, peers: $peers)';
}


}

/// @nodoc
abstract mixin class _$TailscaleStatusCopyWith<$Res> implements $TailscaleStatusCopyWith<$Res> {
  factory _$TailscaleStatusCopyWith(_TailscaleStatus value, $Res Function(_TailscaleStatus) _then) = __$TailscaleStatusCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'state') String rawState, String authUrl, String error, String tailnet, String magicDnsSuffix, bool keyExpired, List<String> health, TailscaleDevice? self, List<TailscaleDevice> peers
});


@override $TailscaleDeviceCopyWith<$Res>? get self;

}
/// @nodoc
class __$TailscaleStatusCopyWithImpl<$Res>
    implements _$TailscaleStatusCopyWith<$Res> {
  __$TailscaleStatusCopyWithImpl(this._self, this._then);

  final _TailscaleStatus _self;
  final $Res Function(_TailscaleStatus) _then;

/// Create a copy of TailscaleStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rawState = null,Object? authUrl = null,Object? error = null,Object? tailnet = null,Object? magicDnsSuffix = null,Object? keyExpired = null,Object? health = null,Object? self = freezed,Object? peers = null,}) {
  return _then(_TailscaleStatus(
rawState: null == rawState ? _self.rawState : rawState // ignore: cast_nullable_to_non_nullable
as String,authUrl: null == authUrl ? _self.authUrl : authUrl // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,tailnet: null == tailnet ? _self.tailnet : tailnet // ignore: cast_nullable_to_non_nullable
as String,magicDnsSuffix: null == magicDnsSuffix ? _self.magicDnsSuffix : magicDnsSuffix // ignore: cast_nullable_to_non_nullable
as String,keyExpired: null == keyExpired ? _self.keyExpired : keyExpired // ignore: cast_nullable_to_non_nullable
as bool,health: null == health ? _self._health : health // ignore: cast_nullable_to_non_nullable
as List<String>,self: freezed == self ? _self.self : self // ignore: cast_nullable_to_non_nullable
as TailscaleDevice?,peers: null == peers ? _self._peers : peers // ignore: cast_nullable_to_non_nullable
as List<TailscaleDevice>,
  ));
}

/// Create a copy of TailscaleStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TailscaleDeviceCopyWith<$Res>? get self {
    if (_self.self == null) {
    return null;
  }

  return $TailscaleDeviceCopyWith<$Res>(_self.self!, (value) {
    return _then(_self.copyWith(self: value));
  });
}
}

// dart format on
