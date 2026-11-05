// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionInfo {

 int get upload; int get download; int get total; int get expire;
/// Create a copy of SubscriptionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionInfoCopyWith<SubscriptionInfo> get copyWith => _$SubscriptionInfoCopyWithImpl<SubscriptionInfo>(this as SubscriptionInfo, _$identity);

  /// Serializes this SubscriptionInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionInfo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionInfo&&(identical(other.upload, _this.upload) || other.upload == _this.upload)&&(identical(other.download, _this.download) || other.download == _this.download)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.expire, _this.expire) || other.expire == _this.expire));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionInfo;
  return Object.hash(runtimeType,_this.upload,_this.download,_this.total,_this.expire);
}

@override
String toString() {
  final _this = this as SubscriptionInfo;
  return 'SubscriptionInfo(upload: ${_this.upload}, download: ${_this.download}, total: ${_this.total}, expire: ${_this.expire})';
}


}

/// @nodoc
abstract mixin class $SubscriptionInfoCopyWith<$Res>  {
  factory $SubscriptionInfoCopyWith(SubscriptionInfo value, $Res Function(SubscriptionInfo) _then) = _$SubscriptionInfoCopyWithImpl;
@useResult
$Res call({
 int upload, int download, int total, int expire
});




}
/// @nodoc
class _$SubscriptionInfoCopyWithImpl<$Res>
    implements $SubscriptionInfoCopyWith<$Res> {
  _$SubscriptionInfoCopyWithImpl(this._self, this._then);

  final SubscriptionInfo _self;
  final $Res Function(SubscriptionInfo) _then;

/// Create a copy of SubscriptionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upload = null,Object? download = null,Object? total = null,Object? expire = null,}) {
  return _then(SubscriptionInfo(
upload: null == upload ? _self.upload : upload // ignore: cast_nullable_to_non_nullable
as int,download: null == download ? _self.download : download // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,expire: null == expire ? _self.expire : expire // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionInfo].
extension SubscriptionInfoPatterns on SubscriptionInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionInfo value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int upload,  int download,  int total,  int expire)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionInfo() when $default != null:
return $default(_that.upload,_that.download,_that.total,_that.expire);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int upload,  int download,  int total,  int expire)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionInfo():
return $default(_that.upload,_that.download,_that.total,_that.expire);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int upload,  int download,  int total,  int expire)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionInfo() when $default != null:
return $default(_that.upload,_that.download,_that.total,_that.expire);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionInfo implements SubscriptionInfo {
  const _SubscriptionInfo({this.upload = 0, this.download = 0, this.total = 0, this.expire = 0});
  factory _SubscriptionInfo.fromJson(Map<String, dynamic> json) => _$SubscriptionInfoFromJson(json);

@override@JsonKey() final  int upload;
@override@JsonKey() final  int download;
@override@JsonKey() final  int total;
@override@JsonKey() final  int expire;

/// Create a copy of SubscriptionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionInfoCopyWith<_SubscriptionInfo> get copyWith => __$SubscriptionInfoCopyWithImpl<_SubscriptionInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionInfoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionInfo&&(identical(other.upload, upload) || other.upload == upload)&&(identical(other.download, download) || other.download == download)&&(identical(other.total, total) || other.total == total)&&(identical(other.expire, expire) || other.expire == expire));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,upload,download,total,expire);
}

@override
String toString() {
    return 'SubscriptionInfo(upload: $upload, download: $download, total: $total, expire: $expire)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionInfoCopyWith<$Res> implements $SubscriptionInfoCopyWith<$Res> {
  factory _$SubscriptionInfoCopyWith(_SubscriptionInfo value, $Res Function(_SubscriptionInfo) _then) = __$SubscriptionInfoCopyWithImpl;
@override @useResult
$Res call({
 int upload, int download, int total, int expire
});




}
/// @nodoc
class __$SubscriptionInfoCopyWithImpl<$Res>
    implements _$SubscriptionInfoCopyWith<$Res> {
  __$SubscriptionInfoCopyWithImpl(this._self, this._then);

  final _SubscriptionInfo _self;
  final $Res Function(_SubscriptionInfo) _then;

/// Create a copy of SubscriptionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upload = null,Object? download = null,Object? total = null,Object? expire = null,}) {
  return _then(_SubscriptionInfo(
upload: null == upload ? _self.upload : upload // ignore: cast_nullable_to_non_nullable
as int,download: null == download ? _self.download : download // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,expire: null == expire ? _self.expire : expire // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ProxyChain {

 int get id; bool get enable; String get name; List<String> get proxies;
/// Create a copy of ProxyChain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyChainCopyWith<ProxyChain> get copyWith => _$ProxyChainCopyWithImpl<ProxyChain>(this as ProxyChain, _$identity);

  /// Serializes this ProxyChain to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProxyChain;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyChain&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.enable, _this.enable) || other.enable == _this.enable)&&(identical(other.name, _this.name) || other.name == _this.name)&&const DeepCollectionEquality().equals(other.proxies, _this.proxies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProxyChain;
  return Object.hash(runtimeType,_this.id,_this.enable,_this.name,const DeepCollectionEquality().hash(_this.proxies));
}

@override
String toString() {
  final _this = this as ProxyChain;
  return 'ProxyChain(id: ${_this.id}, enable: ${_this.enable}, name: ${_this.name}, proxies: ${_this.proxies})';
}


}

/// @nodoc
abstract mixin class $ProxyChainCopyWith<$Res>  {
  factory $ProxyChainCopyWith(ProxyChain value, $Res Function(ProxyChain) _then) = _$ProxyChainCopyWithImpl;
@useResult
$Res call({
 int id, bool enable, String name, List<String> proxies
});




}
/// @nodoc
class _$ProxyChainCopyWithImpl<$Res>
    implements $ProxyChainCopyWith<$Res> {
  _$ProxyChainCopyWithImpl(this._self, this._then);

  final ProxyChain _self;
  final $Res Function(ProxyChain) _then;

/// Create a copy of ProxyChain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? enable = null,Object? name = null,Object? proxies = null,}) {
  return _then(ProxyChain(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,proxies: null == proxies ? _self.proxies : proxies // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyChain].
extension ProxyChainPatterns on ProxyChain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyChain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyChain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyChain value)  $default,){
final _that = this;
switch (_that) {
case _ProxyChain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyChain value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyChain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  bool enable,  String name,  List<String> proxies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyChain() when $default != null:
return $default(_that.id,_that.enable,_that.name,_that.proxies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  bool enable,  String name,  List<String> proxies)  $default,) {final _that = this;
switch (_that) {
case _ProxyChain():
return $default(_that.id,_that.enable,_that.name,_that.proxies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  bool enable,  String name,  List<String> proxies)?  $default,) {final _that = this;
switch (_that) {
case _ProxyChain() when $default != null:
return $default(_that.id,_that.enable,_that.name,_that.proxies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyChain implements ProxyChain {
  const _ProxyChain({required this.id, this.enable = true, this.name = '',  List<String> proxies = const []}): _proxies = proxies;
  factory _ProxyChain.fromJson(Map<String, dynamic> json) => _$ProxyChainFromJson(json);

@override final  int id;
@override@JsonKey() final  bool enable;
@override@JsonKey() final  String name;
 final  List<String> _proxies;
@override@JsonKey() List<String> get proxies {
  if (_proxies is EqualUnmodifiableListView) return _proxies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proxies);
}


/// Create a copy of ProxyChain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyChainCopyWith<_ProxyChain> get copyWith => __$ProxyChainCopyWithImpl<_ProxyChain>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyChainToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyChain&&(identical(other.id, id) || other.id == id)&&(identical(other.enable, enable) || other.enable == enable)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.proxies, _proxies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,enable,name,const DeepCollectionEquality().hash(_proxies));
}

@override
String toString() {
    return 'ProxyChain(id: $id, enable: $enable, name: $name, proxies: $proxies)';
}


}

/// @nodoc
abstract mixin class _$ProxyChainCopyWith<$Res> implements $ProxyChainCopyWith<$Res> {
  factory _$ProxyChainCopyWith(_ProxyChain value, $Res Function(_ProxyChain) _then) = __$ProxyChainCopyWithImpl;
@override @useResult
$Res call({
 int id, bool enable, String name, List<String> proxies
});




}
/// @nodoc
class __$ProxyChainCopyWithImpl<$Res>
    implements _$ProxyChainCopyWith<$Res> {
  __$ProxyChainCopyWithImpl(this._self, this._then);

  final _ProxyChain _self;
  final $Res Function(_ProxyChain) _then;

/// Create a copy of ProxyChain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? enable = null,Object? name = null,Object? proxies = null,}) {
  return _then(_ProxyChain(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,proxies: null == proxies ? _self._proxies : proxies // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ProfileProxy {

 int get id; bool get enable; String get uri; Map<String, Object?> get proxy; Set<String> get emptyOptions;
/// Create a copy of ProfileProxy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileProxyCopyWith<ProfileProxy> get copyWith => _$ProfileProxyCopyWithImpl<ProfileProxy>(this as ProfileProxy, _$identity);

  /// Serializes this ProfileProxy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileProxy;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileProxy&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.enable, _this.enable) || other.enable == _this.enable)&&(identical(other.uri, _this.uri) || other.uri == _this.uri)&&const DeepCollectionEquality().equals(other.proxy, _this.proxy)&&const DeepCollectionEquality().equals(other.emptyOptions, _this.emptyOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileProxy;
  return Object.hash(runtimeType,_this.id,_this.enable,_this.uri,const DeepCollectionEquality().hash(_this.proxy),const DeepCollectionEquality().hash(_this.emptyOptions));
}

@override
String toString() {
  final _this = this as ProfileProxy;
  return 'ProfileProxy(id: ${_this.id}, enable: ${_this.enable}, uri: ${_this.uri}, proxy: ${_this.proxy}, emptyOptions: ${_this.emptyOptions})';
}


}

/// @nodoc
abstract mixin class $ProfileProxyCopyWith<$Res>  {
  factory $ProfileProxyCopyWith(ProfileProxy value, $Res Function(ProfileProxy) _then) = _$ProfileProxyCopyWithImpl;
@useResult
$Res call({
 int id, bool enable, String uri, Map<String, Object?> proxy, Set<String> emptyOptions
});




}
/// @nodoc
class _$ProfileProxyCopyWithImpl<$Res>
    implements $ProfileProxyCopyWith<$Res> {
  _$ProfileProxyCopyWithImpl(this._self, this._then);

  final ProfileProxy _self;
  final $Res Function(ProfileProxy) _then;

/// Create a copy of ProfileProxy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? enable = null,Object? uri = null,Object? proxy = null,Object? emptyOptions = null,}) {
  return _then(ProfileProxy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,proxy: null == proxy ? _self.proxy : proxy // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,emptyOptions: null == emptyOptions ? _self.emptyOptions : emptyOptions // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileProxy].
extension ProfileProxyPatterns on ProfileProxy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileProxy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileProxy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileProxy value)  $default,){
final _that = this;
switch (_that) {
case _ProfileProxy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileProxy value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileProxy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  bool enable,  String uri,  Map<String, Object?> proxy,  Set<String> emptyOptions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileProxy() when $default != null:
return $default(_that.id,_that.enable,_that.uri,_that.proxy,_that.emptyOptions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  bool enable,  String uri,  Map<String, Object?> proxy,  Set<String> emptyOptions)  $default,) {final _that = this;
switch (_that) {
case _ProfileProxy():
return $default(_that.id,_that.enable,_that.uri,_that.proxy,_that.emptyOptions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  bool enable,  String uri,  Map<String, Object?> proxy,  Set<String> emptyOptions)?  $default,) {final _that = this;
switch (_that) {
case _ProfileProxy() when $default != null:
return $default(_that.id,_that.enable,_that.uri,_that.proxy,_that.emptyOptions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileProxy implements ProfileProxy {
  const _ProfileProxy({required this.id, this.enable = true, this.uri = '',  Map<String, Object?> proxy = const {},  Set<String> emptyOptions = const {}}): _proxy = proxy,_emptyOptions = emptyOptions;
  factory _ProfileProxy.fromJson(Map<String, dynamic> json) => _$ProfileProxyFromJson(json);

@override final  int id;
@override@JsonKey() final  bool enable;
@override@JsonKey() final  String uri;
 final  Map<String, Object?> _proxy;
@override@JsonKey() Map<String, Object?> get proxy {
  if (_proxy is EqualUnmodifiableMapView) return _proxy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_proxy);
}

 final  Set<String> _emptyOptions;
@override@JsonKey() Set<String> get emptyOptions {
  if (_emptyOptions is EqualUnmodifiableSetView) return _emptyOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_emptyOptions);
}


/// Create a copy of ProfileProxy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileProxyCopyWith<_ProfileProxy> get copyWith => __$ProfileProxyCopyWithImpl<_ProfileProxy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileProxyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileProxy&&(identical(other.id, id) || other.id == id)&&(identical(other.enable, enable) || other.enable == enable)&&(identical(other.uri, uri) || other.uri == uri)&&const DeepCollectionEquality().equals(other.proxy, _proxy)&&const DeepCollectionEquality().equals(other.emptyOptions, _emptyOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,enable,uri,const DeepCollectionEquality().hash(_proxy),const DeepCollectionEquality().hash(_emptyOptions));
}

@override
String toString() {
    return 'ProfileProxy(id: $id, enable: $enable, uri: $uri, proxy: $proxy, emptyOptions: $emptyOptions)';
}


}

/// @nodoc
abstract mixin class _$ProfileProxyCopyWith<$Res> implements $ProfileProxyCopyWith<$Res> {
  factory _$ProfileProxyCopyWith(_ProfileProxy value, $Res Function(_ProfileProxy) _then) = __$ProfileProxyCopyWithImpl;
@override @useResult
$Res call({
 int id, bool enable, String uri, Map<String, Object?> proxy, Set<String> emptyOptions
});




}
/// @nodoc
class __$ProfileProxyCopyWithImpl<$Res>
    implements _$ProfileProxyCopyWith<$Res> {
  __$ProfileProxyCopyWithImpl(this._self, this._then);

  final _ProfileProxy _self;
  final $Res Function(_ProfileProxy) _then;

/// Create a copy of ProfileProxy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? enable = null,Object? uri = null,Object? proxy = null,Object? emptyOptions = null,}) {
  return _then(_ProfileProxy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,proxy: null == proxy ? _self._proxy : proxy // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,emptyOptions: null == emptyOptions ? _self._emptyOptions : emptyOptions // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}


/// @nodoc
mixin _$ProviderHealthCheck {

 String? get url; int? get interval; int? get timeout; bool? get lazy;@JsonKey(name: 'expected-status') String? get expectedStatus;
/// Create a copy of ProviderHealthCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderHealthCheckCopyWith<ProviderHealthCheck> get copyWith => _$ProviderHealthCheckCopyWithImpl<ProviderHealthCheck>(this as ProviderHealthCheck, _$identity);

  /// Serializes this ProviderHealthCheck to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProviderHealthCheck;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderHealthCheck&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.interval, _this.interval) || other.interval == _this.interval)&&(identical(other.timeout, _this.timeout) || other.timeout == _this.timeout)&&(identical(other.lazy, _this.lazy) || other.lazy == _this.lazy)&&(identical(other.expectedStatus, _this.expectedStatus) || other.expectedStatus == _this.expectedStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProviderHealthCheck;
  return Object.hash(runtimeType,_this.url,_this.interval,_this.timeout,_this.lazy,_this.expectedStatus);
}

@override
String toString() {
  final _this = this as ProviderHealthCheck;
  return 'ProviderHealthCheck(url: ${_this.url}, interval: ${_this.interval}, timeout: ${_this.timeout}, lazy: ${_this.lazy}, expectedStatus: ${_this.expectedStatus})';
}


}

/// @nodoc
abstract mixin class $ProviderHealthCheckCopyWith<$Res>  {
  factory $ProviderHealthCheckCopyWith(ProviderHealthCheck value, $Res Function(ProviderHealthCheck) _then) = _$ProviderHealthCheckCopyWithImpl;
@useResult
$Res call({
 String? url, int? interval, int? timeout, bool? lazy,@JsonKey(name: 'expected-status') String? expectedStatus
});




}
/// @nodoc
class _$ProviderHealthCheckCopyWithImpl<$Res>
    implements $ProviderHealthCheckCopyWith<$Res> {
  _$ProviderHealthCheckCopyWithImpl(this._self, this._then);

  final ProviderHealthCheck _self;
  final $Res Function(ProviderHealthCheck) _then;

/// Create a copy of ProviderHealthCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? interval = freezed,Object? timeout = freezed,Object? lazy = freezed,Object? expectedStatus = freezed,}) {
  return _then(ProviderHealthCheck(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,interval: freezed == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int?,timeout: freezed == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int?,lazy: freezed == lazy ? _self.lazy : lazy // ignore: cast_nullable_to_non_nullable
as bool?,expectedStatus: freezed == expectedStatus ? _self.expectedStatus : expectedStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderHealthCheck].
extension ProviderHealthCheckPatterns on ProviderHealthCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderHealthCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderHealthCheck() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderHealthCheck value)  $default,){
final _that = this;
switch (_that) {
case _ProviderHealthCheck():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderHealthCheck value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderHealthCheck() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url,  int? interval,  int? timeout,  bool? lazy, @JsonKey(name: 'expected-status')  String? expectedStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderHealthCheck() when $default != null:
return $default(_that.url,_that.interval,_that.timeout,_that.lazy,_that.expectedStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url,  int? interval,  int? timeout,  bool? lazy, @JsonKey(name: 'expected-status')  String? expectedStatus)  $default,) {final _that = this;
switch (_that) {
case _ProviderHealthCheck():
return $default(_that.url,_that.interval,_that.timeout,_that.lazy,_that.expectedStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url,  int? interval,  int? timeout,  bool? lazy, @JsonKey(name: 'expected-status')  String? expectedStatus)?  $default,) {final _that = this;
switch (_that) {
case _ProviderHealthCheck() when $default != null:
return $default(_that.url,_that.interval,_that.timeout,_that.lazy,_that.expectedStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderHealthCheck implements ProviderHealthCheck {
  const _ProviderHealthCheck({this.url, this.interval, this.timeout, this.lazy, @JsonKey(name: 'expected-status') this.expectedStatus});
  factory _ProviderHealthCheck.fromJson(Map<String, dynamic> json) => _$ProviderHealthCheckFromJson(json);

@override final  String? url;
@override final  int? interval;
@override final  int? timeout;
@override final  bool? lazy;
@override@JsonKey(name: 'expected-status') final  String? expectedStatus;

/// Create a copy of ProviderHealthCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderHealthCheckCopyWith<_ProviderHealthCheck> get copyWith => __$ProviderHealthCheckCopyWithImpl<_ProviderHealthCheck>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderHealthCheckToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderHealthCheck&&(identical(other.url, url) || other.url == url)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.lazy, lazy) || other.lazy == lazy)&&(identical(other.expectedStatus, expectedStatus) || other.expectedStatus == expectedStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,url,interval,timeout,lazy,expectedStatus);
}

@override
String toString() {
    return 'ProviderHealthCheck(url: $url, interval: $interval, timeout: $timeout, lazy: $lazy, expectedStatus: $expectedStatus)';
}


}

/// @nodoc
abstract mixin class _$ProviderHealthCheckCopyWith<$Res> implements $ProviderHealthCheckCopyWith<$Res> {
  factory _$ProviderHealthCheckCopyWith(_ProviderHealthCheck value, $Res Function(_ProviderHealthCheck) _then) = __$ProviderHealthCheckCopyWithImpl;
@override @useResult
$Res call({
 String? url, int? interval, int? timeout, bool? lazy,@JsonKey(name: 'expected-status') String? expectedStatus
});




}
/// @nodoc
class __$ProviderHealthCheckCopyWithImpl<$Res>
    implements _$ProviderHealthCheckCopyWith<$Res> {
  __$ProviderHealthCheckCopyWithImpl(this._self, this._then);

  final _ProviderHealthCheck _self;
  final $Res Function(_ProviderHealthCheck) _then;

/// Create a copy of ProviderHealthCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? interval = freezed,Object? timeout = freezed,Object? lazy = freezed,Object? expectedStatus = freezed,}) {
  return _then(_ProviderHealthCheck(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,interval: freezed == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int?,timeout: freezed == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int?,lazy: freezed == lazy ? _self.lazy : lazy // ignore: cast_nullable_to_non_nullable
as bool?,expectedStatus: freezed == expectedStatus ? _self.expectedStatus : expectedStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProviderOverride {

@JsonKey(name: 'additional-prefix') String? get additionalPrefix;@JsonKey(name: 'additional-suffix') String? get additionalSuffix; bool? get udp;@JsonKey(name: 'ip-version') String? get ipVersion;
/// Create a copy of ProviderOverride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderOverrideCopyWith<ProviderOverride> get copyWith => _$ProviderOverrideCopyWithImpl<ProviderOverride>(this as ProviderOverride, _$identity);

  /// Serializes this ProviderOverride to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProviderOverride;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderOverride&&(identical(other.additionalPrefix, _this.additionalPrefix) || other.additionalPrefix == _this.additionalPrefix)&&(identical(other.additionalSuffix, _this.additionalSuffix) || other.additionalSuffix == _this.additionalSuffix)&&(identical(other.udp, _this.udp) || other.udp == _this.udp)&&(identical(other.ipVersion, _this.ipVersion) || other.ipVersion == _this.ipVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProviderOverride;
  return Object.hash(runtimeType,_this.additionalPrefix,_this.additionalSuffix,_this.udp,_this.ipVersion);
}

@override
String toString() {
  final _this = this as ProviderOverride;
  return 'ProviderOverride(additionalPrefix: ${_this.additionalPrefix}, additionalSuffix: ${_this.additionalSuffix}, udp: ${_this.udp}, ipVersion: ${_this.ipVersion})';
}


}

/// @nodoc
abstract mixin class $ProviderOverrideCopyWith<$Res>  {
  factory $ProviderOverrideCopyWith(ProviderOverride value, $Res Function(ProviderOverride) _then) = _$ProviderOverrideCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'additional-prefix') String? additionalPrefix,@JsonKey(name: 'additional-suffix') String? additionalSuffix, bool? udp,@JsonKey(name: 'ip-version') String? ipVersion
});




}
/// @nodoc
class _$ProviderOverrideCopyWithImpl<$Res>
    implements $ProviderOverrideCopyWith<$Res> {
  _$ProviderOverrideCopyWithImpl(this._self, this._then);

  final ProviderOverride _self;
  final $Res Function(ProviderOverride) _then;

/// Create a copy of ProviderOverride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? additionalPrefix = freezed,Object? additionalSuffix = freezed,Object? udp = freezed,Object? ipVersion = freezed,}) {
  return _then(ProviderOverride(
additionalPrefix: freezed == additionalPrefix ? _self.additionalPrefix : additionalPrefix // ignore: cast_nullable_to_non_nullable
as String?,additionalSuffix: freezed == additionalSuffix ? _self.additionalSuffix : additionalSuffix // ignore: cast_nullable_to_non_nullable
as String?,udp: freezed == udp ? _self.udp : udp // ignore: cast_nullable_to_non_nullable
as bool?,ipVersion: freezed == ipVersion ? _self.ipVersion : ipVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderOverride].
extension ProviderOverridePatterns on ProviderOverride {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderOverride value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderOverride() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderOverride value)  $default,){
final _that = this;
switch (_that) {
case _ProviderOverride():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderOverride value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderOverride() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'additional-prefix')  String? additionalPrefix, @JsonKey(name: 'additional-suffix')  String? additionalSuffix,  bool? udp, @JsonKey(name: 'ip-version')  String? ipVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderOverride() when $default != null:
return $default(_that.additionalPrefix,_that.additionalSuffix,_that.udp,_that.ipVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'additional-prefix')  String? additionalPrefix, @JsonKey(name: 'additional-suffix')  String? additionalSuffix,  bool? udp, @JsonKey(name: 'ip-version')  String? ipVersion)  $default,) {final _that = this;
switch (_that) {
case _ProviderOverride():
return $default(_that.additionalPrefix,_that.additionalSuffix,_that.udp,_that.ipVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'additional-prefix')  String? additionalPrefix, @JsonKey(name: 'additional-suffix')  String? additionalSuffix,  bool? udp, @JsonKey(name: 'ip-version')  String? ipVersion)?  $default,) {final _that = this;
switch (_that) {
case _ProviderOverride() when $default != null:
return $default(_that.additionalPrefix,_that.additionalSuffix,_that.udp,_that.ipVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderOverride implements ProviderOverride {
  const _ProviderOverride({@JsonKey(name: 'additional-prefix') this.additionalPrefix, @JsonKey(name: 'additional-suffix') this.additionalSuffix, this.udp, @JsonKey(name: 'ip-version') this.ipVersion});
  factory _ProviderOverride.fromJson(Map<String, dynamic> json) => _$ProviderOverrideFromJson(json);

@override@JsonKey(name: 'additional-prefix') final  String? additionalPrefix;
@override@JsonKey(name: 'additional-suffix') final  String? additionalSuffix;
@override final  bool? udp;
@override@JsonKey(name: 'ip-version') final  String? ipVersion;

/// Create a copy of ProviderOverride
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderOverrideCopyWith<_ProviderOverride> get copyWith => __$ProviderOverrideCopyWithImpl<_ProviderOverride>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderOverrideToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderOverride&&(identical(other.additionalPrefix, additionalPrefix) || other.additionalPrefix == additionalPrefix)&&(identical(other.additionalSuffix, additionalSuffix) || other.additionalSuffix == additionalSuffix)&&(identical(other.udp, udp) || other.udp == udp)&&(identical(other.ipVersion, ipVersion) || other.ipVersion == ipVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,additionalPrefix,additionalSuffix,udp,ipVersion);
}

@override
String toString() {
    return 'ProviderOverride(additionalPrefix: $additionalPrefix, additionalSuffix: $additionalSuffix, udp: $udp, ipVersion: $ipVersion)';
}


}

/// @nodoc
abstract mixin class _$ProviderOverrideCopyWith<$Res> implements $ProviderOverrideCopyWith<$Res> {
  factory _$ProviderOverrideCopyWith(_ProviderOverride value, $Res Function(_ProviderOverride) _then) = __$ProviderOverrideCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'additional-prefix') String? additionalPrefix,@JsonKey(name: 'additional-suffix') String? additionalSuffix, bool? udp,@JsonKey(name: 'ip-version') String? ipVersion
});




}
/// @nodoc
class __$ProviderOverrideCopyWithImpl<$Res>
    implements _$ProviderOverrideCopyWith<$Res> {
  __$ProviderOverrideCopyWithImpl(this._self, this._then);

  final _ProviderOverride _self;
  final $Res Function(_ProviderOverride) _then;

/// Create a copy of ProviderOverride
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? additionalPrefix = freezed,Object? additionalSuffix = freezed,Object? udp = freezed,Object? ipVersion = freezed,}) {
  return _then(_ProviderOverride(
additionalPrefix: freezed == additionalPrefix ? _self.additionalPrefix : additionalPrefix // ignore: cast_nullable_to_non_nullable
as String?,additionalSuffix: freezed == additionalSuffix ? _self.additionalSuffix : additionalSuffix // ignore: cast_nullable_to_non_nullable
as String?,udp: freezed == udp ? _self.udp : udp // ignore: cast_nullable_to_non_nullable
as bool?,ipVersion: freezed == ipVersion ? _self.ipVersion : ipVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProxyProviderOptions {

@JsonKey(name: 'health-check') ProviderHealthCheck get healthCheck; String? get filter;@JsonKey(name: 'exclude-filter') String? get excludeFilter;@JsonKey(name: 'override') ProviderOverride get proxyOverride;
/// Create a copy of ProxyProviderOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyProviderOptionsCopyWith<ProxyProviderOptions> get copyWith => _$ProxyProviderOptionsCopyWithImpl<ProxyProviderOptions>(this as ProxyProviderOptions, _$identity);

  /// Serializes this ProxyProviderOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProxyProviderOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyProviderOptions&&(identical(other.healthCheck, _this.healthCheck) || other.healthCheck == _this.healthCheck)&&(identical(other.filter, _this.filter) || other.filter == _this.filter)&&(identical(other.excludeFilter, _this.excludeFilter) || other.excludeFilter == _this.excludeFilter)&&(identical(other.proxyOverride, _this.proxyOverride) || other.proxyOverride == _this.proxyOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProxyProviderOptions;
  return Object.hash(runtimeType,_this.healthCheck,_this.filter,_this.excludeFilter,_this.proxyOverride);
}

@override
String toString() {
  final _this = this as ProxyProviderOptions;
  return 'ProxyProviderOptions(healthCheck: ${_this.healthCheck}, filter: ${_this.filter}, excludeFilter: ${_this.excludeFilter}, proxyOverride: ${_this.proxyOverride})';
}


}

/// @nodoc
abstract mixin class $ProxyProviderOptionsCopyWith<$Res>  {
  factory $ProxyProviderOptionsCopyWith(ProxyProviderOptions value, $Res Function(ProxyProviderOptions) _then) = _$ProxyProviderOptionsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'health-check') ProviderHealthCheck healthCheck, String? filter,@JsonKey(name: 'exclude-filter') String? excludeFilter,@JsonKey(name: 'override') ProviderOverride proxyOverride
});


$ProviderHealthCheckCopyWith<$Res> get healthCheck;$ProviderOverrideCopyWith<$Res> get proxyOverride;

}
/// @nodoc
class _$ProxyProviderOptionsCopyWithImpl<$Res>
    implements $ProxyProviderOptionsCopyWith<$Res> {
  _$ProxyProviderOptionsCopyWithImpl(this._self, this._then);

  final ProxyProviderOptions _self;
  final $Res Function(ProxyProviderOptions) _then;

/// Create a copy of ProxyProviderOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? healthCheck = null,Object? filter = freezed,Object? excludeFilter = freezed,Object? proxyOverride = null,}) {
  return _then(ProxyProviderOptions(
healthCheck: null == healthCheck ? _self.healthCheck : healthCheck // ignore: cast_nullable_to_non_nullable
as ProviderHealthCheck,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as String?,excludeFilter: freezed == excludeFilter ? _self.excludeFilter : excludeFilter // ignore: cast_nullable_to_non_nullable
as String?,proxyOverride: null == proxyOverride ? _self.proxyOverride : proxyOverride // ignore: cast_nullable_to_non_nullable
as ProviderOverride,
  ));
}
/// Create a copy of ProxyProviderOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderHealthCheckCopyWith<$Res> get healthCheck {
  
  return $ProviderHealthCheckCopyWith<$Res>(_self.healthCheck, (value) {
    return _then(_self.copyWith(healthCheck: value));
  });
}/// Create a copy of ProxyProviderOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderOverrideCopyWith<$Res> get proxyOverride {
  
  return $ProviderOverrideCopyWith<$Res>(_self.proxyOverride, (value) {
    return _then(_self.copyWith(proxyOverride: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProxyProviderOptions].
extension ProxyProviderOptionsPatterns on ProxyProviderOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyProviderOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyProviderOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyProviderOptions value)  $default,){
final _that = this;
switch (_that) {
case _ProxyProviderOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyProviderOptions value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyProviderOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'health-check')  ProviderHealthCheck healthCheck,  String? filter, @JsonKey(name: 'exclude-filter')  String? excludeFilter, @JsonKey(name: 'override')  ProviderOverride proxyOverride)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyProviderOptions() when $default != null:
return $default(_that.healthCheck,_that.filter,_that.excludeFilter,_that.proxyOverride);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'health-check')  ProviderHealthCheck healthCheck,  String? filter, @JsonKey(name: 'exclude-filter')  String? excludeFilter, @JsonKey(name: 'override')  ProviderOverride proxyOverride)  $default,) {final _that = this;
switch (_that) {
case _ProxyProviderOptions():
return $default(_that.healthCheck,_that.filter,_that.excludeFilter,_that.proxyOverride);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'health-check')  ProviderHealthCheck healthCheck,  String? filter, @JsonKey(name: 'exclude-filter')  String? excludeFilter, @JsonKey(name: 'override')  ProviderOverride proxyOverride)?  $default,) {final _that = this;
switch (_that) {
case _ProxyProviderOptions() when $default != null:
return $default(_that.healthCheck,_that.filter,_that.excludeFilter,_that.proxyOverride);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyProviderOptions implements ProxyProviderOptions {
  const _ProxyProviderOptions({@JsonKey(name: 'health-check') this.healthCheck = const ProviderHealthCheck(), this.filter, @JsonKey(name: 'exclude-filter') this.excludeFilter, @JsonKey(name: 'override') this.proxyOverride = const ProviderOverride()});
  factory _ProxyProviderOptions.fromJson(Map<String, dynamic> json) => _$ProxyProviderOptionsFromJson(json);

@override@JsonKey(name: 'health-check') final  ProviderHealthCheck healthCheck;
@override final  String? filter;
@override@JsonKey(name: 'exclude-filter') final  String? excludeFilter;
@override@JsonKey(name: 'override') final  ProviderOverride proxyOverride;

/// Create a copy of ProxyProviderOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyProviderOptionsCopyWith<_ProxyProviderOptions> get copyWith => __$ProxyProviderOptionsCopyWithImpl<_ProxyProviderOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyProviderOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyProviderOptions&&(identical(other.healthCheck, healthCheck) || other.healthCheck == healthCheck)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.excludeFilter, excludeFilter) || other.excludeFilter == excludeFilter)&&(identical(other.proxyOverride, proxyOverride) || other.proxyOverride == proxyOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,healthCheck,filter,excludeFilter,proxyOverride);
}

@override
String toString() {
    return 'ProxyProviderOptions(healthCheck: $healthCheck, filter: $filter, excludeFilter: $excludeFilter, proxyOverride: $proxyOverride)';
}


}

/// @nodoc
abstract mixin class _$ProxyProviderOptionsCopyWith<$Res> implements $ProxyProviderOptionsCopyWith<$Res> {
  factory _$ProxyProviderOptionsCopyWith(_ProxyProviderOptions value, $Res Function(_ProxyProviderOptions) _then) = __$ProxyProviderOptionsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'health-check') ProviderHealthCheck healthCheck, String? filter,@JsonKey(name: 'exclude-filter') String? excludeFilter,@JsonKey(name: 'override') ProviderOverride proxyOverride
});


@override $ProviderHealthCheckCopyWith<$Res> get healthCheck;@override $ProviderOverrideCopyWith<$Res> get proxyOverride;

}
/// @nodoc
class __$ProxyProviderOptionsCopyWithImpl<$Res>
    implements _$ProxyProviderOptionsCopyWith<$Res> {
  __$ProxyProviderOptionsCopyWithImpl(this._self, this._then);

  final _ProxyProviderOptions _self;
  final $Res Function(_ProxyProviderOptions) _then;

/// Create a copy of ProxyProviderOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? healthCheck = null,Object? filter = freezed,Object? excludeFilter = freezed,Object? proxyOverride = null,}) {
  return _then(_ProxyProviderOptions(
healthCheck: null == healthCheck ? _self.healthCheck : healthCheck // ignore: cast_nullable_to_non_nullable
as ProviderHealthCheck,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as String?,excludeFilter: freezed == excludeFilter ? _self.excludeFilter : excludeFilter // ignore: cast_nullable_to_non_nullable
as String?,proxyOverride: null == proxyOverride ? _self.proxyOverride : proxyOverride // ignore: cast_nullable_to_non_nullable
as ProviderOverride,
  ));
}

/// Create a copy of ProxyProviderOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderHealthCheckCopyWith<$Res> get healthCheck {
  
  return $ProviderHealthCheckCopyWith<$Res>(_self.healthCheck, (value) {
    return _then(_self.copyWith(healthCheck: value));
  });
}/// Create a copy of ProxyProviderOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderOverrideCopyWith<$Res> get proxyOverride {
  
  return $ProviderOverrideCopyWith<$Res>(_self.proxyOverride, (value) {
    return _then(_self.copyWith(proxyOverride: value));
  });
}
}


/// @nodoc
mixin _$ProfileOverrides {

@JsonKey(fromJson: Dns.safeDnsFromJson) Dns get dns;@JsonKey(name: dnsOverrideKeysJsonKey, fromJson: dnsOverrideKeysFromJson) Set<DnsOverrideKey> get dnsOverrideKeys;@JsonKey(fromJson: Ntp.safeNtpFromJson) Ntp get ntp;@JsonKey(name: ntpOverrideKeysJsonKey, fromJson: ntpOverrideKeysFromJson) Set<NtpOverrideKey> get ntpOverrideKeys;@JsonKey(fromJson: Sniffer.safeSnifferFromJson) Sniffer get sniffer;@JsonKey(name: snifferOverrideKeysJsonKey, fromJson: snifferOverrideKeysFromJson) Set<SnifferOverrideKey> get snifferOverrideKeys;@JsonKey(fromJson: ProfileTun.safeFromJson) ProfileTun get tun;@JsonKey(name: tunOverrideKeysJsonKey, fromJson: tunOverrideKeysFromJson) Set<TunOverrideKey> get tunOverrideKeys;@JsonKey(name: 'proxy-providers') Map<String, ProxyProviderOptions> get proxyProviders;
/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileOverridesCopyWith<ProfileOverrides> get copyWith => _$ProfileOverridesCopyWithImpl<ProfileOverrides>(this as ProfileOverrides, _$identity);

  /// Serializes this ProfileOverrides to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileOverrides;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileOverrides&&(identical(other.dns, _this.dns) || other.dns == _this.dns)&&const DeepCollectionEquality().equals(other.dnsOverrideKeys, _this.dnsOverrideKeys)&&(identical(other.ntp, _this.ntp) || other.ntp == _this.ntp)&&const DeepCollectionEquality().equals(other.ntpOverrideKeys, _this.ntpOverrideKeys)&&(identical(other.sniffer, _this.sniffer) || other.sniffer == _this.sniffer)&&const DeepCollectionEquality().equals(other.snifferOverrideKeys, _this.snifferOverrideKeys)&&(identical(other.tun, _this.tun) || other.tun == _this.tun)&&const DeepCollectionEquality().equals(other.tunOverrideKeys, _this.tunOverrideKeys)&&const DeepCollectionEquality().equals(other.proxyProviders, _this.proxyProviders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileOverrides;
  return Object.hash(runtimeType,_this.dns,const DeepCollectionEquality().hash(_this.dnsOverrideKeys),_this.ntp,const DeepCollectionEquality().hash(_this.ntpOverrideKeys),_this.sniffer,const DeepCollectionEquality().hash(_this.snifferOverrideKeys),_this.tun,const DeepCollectionEquality().hash(_this.tunOverrideKeys),const DeepCollectionEquality().hash(_this.proxyProviders));
}

@override
String toString() {
  final _this = this as ProfileOverrides;
  return 'ProfileOverrides(dns: ${_this.dns}, dnsOverrideKeys: ${_this.dnsOverrideKeys}, ntp: ${_this.ntp}, ntpOverrideKeys: ${_this.ntpOverrideKeys}, sniffer: ${_this.sniffer}, snifferOverrideKeys: ${_this.snifferOverrideKeys}, tun: ${_this.tun}, tunOverrideKeys: ${_this.tunOverrideKeys}, proxyProviders: ${_this.proxyProviders})';
}


}

/// @nodoc
abstract mixin class $ProfileOverridesCopyWith<$Res>  {
  factory $ProfileOverridesCopyWith(ProfileOverrides value, $Res Function(ProfileOverrides) _then) = _$ProfileOverridesCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: Dns.safeDnsFromJson) Dns dns,@JsonKey(name: dnsOverrideKeysJsonKey, fromJson: dnsOverrideKeysFromJson) Set<DnsOverrideKey> dnsOverrideKeys,@JsonKey(fromJson: Ntp.safeNtpFromJson) Ntp ntp,@JsonKey(name: ntpOverrideKeysJsonKey, fromJson: ntpOverrideKeysFromJson) Set<NtpOverrideKey> ntpOverrideKeys,@JsonKey(fromJson: Sniffer.safeSnifferFromJson) Sniffer sniffer,@JsonKey(name: snifferOverrideKeysJsonKey, fromJson: snifferOverrideKeysFromJson) Set<SnifferOverrideKey> snifferOverrideKeys,@JsonKey(fromJson: ProfileTun.safeFromJson) ProfileTun tun,@JsonKey(name: tunOverrideKeysJsonKey, fromJson: tunOverrideKeysFromJson) Set<TunOverrideKey> tunOverrideKeys,@JsonKey(name: 'proxy-providers') Map<String, ProxyProviderOptions> proxyProviders
});


$DnsCopyWith<$Res> get dns;$NtpCopyWith<$Res> get ntp;$SnifferCopyWith<$Res> get sniffer;$ProfileTunCopyWith<$Res> get tun;

}
/// @nodoc
class _$ProfileOverridesCopyWithImpl<$Res>
    implements $ProfileOverridesCopyWith<$Res> {
  _$ProfileOverridesCopyWithImpl(this._self, this._then);

  final ProfileOverrides _self;
  final $Res Function(ProfileOverrides) _then;

/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dns = null,Object? dnsOverrideKeys = null,Object? ntp = null,Object? ntpOverrideKeys = null,Object? sniffer = null,Object? snifferOverrideKeys = null,Object? tun = null,Object? tunOverrideKeys = null,Object? proxyProviders = null,}) {
  return _then(ProfileOverrides(
dns: null == dns ? _self.dns : dns // ignore: cast_nullable_to_non_nullable
as Dns,dnsOverrideKeys: null == dnsOverrideKeys ? _self.dnsOverrideKeys : dnsOverrideKeys // ignore: cast_nullable_to_non_nullable
as Set<DnsOverrideKey>,ntp: null == ntp ? _self.ntp : ntp // ignore: cast_nullable_to_non_nullable
as Ntp,ntpOverrideKeys: null == ntpOverrideKeys ? _self.ntpOverrideKeys : ntpOverrideKeys // ignore: cast_nullable_to_non_nullable
as Set<NtpOverrideKey>,sniffer: null == sniffer ? _self.sniffer : sniffer // ignore: cast_nullable_to_non_nullable
as Sniffer,snifferOverrideKeys: null == snifferOverrideKeys ? _self.snifferOverrideKeys : snifferOverrideKeys // ignore: cast_nullable_to_non_nullable
as Set<SnifferOverrideKey>,tun: null == tun ? _self.tun : tun // ignore: cast_nullable_to_non_nullable
as ProfileTun,tunOverrideKeys: null == tunOverrideKeys ? _self.tunOverrideKeys : tunOverrideKeys // ignore: cast_nullable_to_non_nullable
as Set<TunOverrideKey>,proxyProviders: null == proxyProviders ? _self.proxyProviders : proxyProviders // ignore: cast_nullable_to_non_nullable
as Map<String, ProxyProviderOptions>,
  ));
}
/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DnsCopyWith<$Res> get dns {
  
  return $DnsCopyWith<$Res>(_self.dns, (value) {
    return _then(_self.copyWith(dns: value));
  });
}/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NtpCopyWith<$Res> get ntp {
  
  return $NtpCopyWith<$Res>(_self.ntp, (value) {
    return _then(_self.copyWith(ntp: value));
  });
}/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SnifferCopyWith<$Res> get sniffer {
  
  return $SnifferCopyWith<$Res>(_self.sniffer, (value) {
    return _then(_self.copyWith(sniffer: value));
  });
}/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileTunCopyWith<$Res> get tun {
  
  return $ProfileTunCopyWith<$Res>(_self.tun, (value) {
    return _then(_self.copyWith(tun: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileOverrides].
extension ProfileOverridesPatterns on ProfileOverrides {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileOverrides value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileOverrides() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileOverrides value)  $default,){
final _that = this;
switch (_that) {
case _ProfileOverrides():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileOverrides value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileOverrides() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: Dns.safeDnsFromJson)  Dns dns, @JsonKey(name: dnsOverrideKeysJsonKey, fromJson: dnsOverrideKeysFromJson)  Set<DnsOverrideKey> dnsOverrideKeys, @JsonKey(fromJson: Ntp.safeNtpFromJson)  Ntp ntp, @JsonKey(name: ntpOverrideKeysJsonKey, fromJson: ntpOverrideKeysFromJson)  Set<NtpOverrideKey> ntpOverrideKeys, @JsonKey(fromJson: Sniffer.safeSnifferFromJson)  Sniffer sniffer, @JsonKey(name: snifferOverrideKeysJsonKey, fromJson: snifferOverrideKeysFromJson)  Set<SnifferOverrideKey> snifferOverrideKeys, @JsonKey(fromJson: ProfileTun.safeFromJson)  ProfileTun tun, @JsonKey(name: tunOverrideKeysJsonKey, fromJson: tunOverrideKeysFromJson)  Set<TunOverrideKey> tunOverrideKeys, @JsonKey(name: 'proxy-providers')  Map<String, ProxyProviderOptions> proxyProviders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileOverrides() when $default != null:
return $default(_that.dns,_that.dnsOverrideKeys,_that.ntp,_that.ntpOverrideKeys,_that.sniffer,_that.snifferOverrideKeys,_that.tun,_that.tunOverrideKeys,_that.proxyProviders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: Dns.safeDnsFromJson)  Dns dns, @JsonKey(name: dnsOverrideKeysJsonKey, fromJson: dnsOverrideKeysFromJson)  Set<DnsOverrideKey> dnsOverrideKeys, @JsonKey(fromJson: Ntp.safeNtpFromJson)  Ntp ntp, @JsonKey(name: ntpOverrideKeysJsonKey, fromJson: ntpOverrideKeysFromJson)  Set<NtpOverrideKey> ntpOverrideKeys, @JsonKey(fromJson: Sniffer.safeSnifferFromJson)  Sniffer sniffer, @JsonKey(name: snifferOverrideKeysJsonKey, fromJson: snifferOverrideKeysFromJson)  Set<SnifferOverrideKey> snifferOverrideKeys, @JsonKey(fromJson: ProfileTun.safeFromJson)  ProfileTun tun, @JsonKey(name: tunOverrideKeysJsonKey, fromJson: tunOverrideKeysFromJson)  Set<TunOverrideKey> tunOverrideKeys, @JsonKey(name: 'proxy-providers')  Map<String, ProxyProviderOptions> proxyProviders)  $default,) {final _that = this;
switch (_that) {
case _ProfileOverrides():
return $default(_that.dns,_that.dnsOverrideKeys,_that.ntp,_that.ntpOverrideKeys,_that.sniffer,_that.snifferOverrideKeys,_that.tun,_that.tunOverrideKeys,_that.proxyProviders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: Dns.safeDnsFromJson)  Dns dns, @JsonKey(name: dnsOverrideKeysJsonKey, fromJson: dnsOverrideKeysFromJson)  Set<DnsOverrideKey> dnsOverrideKeys, @JsonKey(fromJson: Ntp.safeNtpFromJson)  Ntp ntp, @JsonKey(name: ntpOverrideKeysJsonKey, fromJson: ntpOverrideKeysFromJson)  Set<NtpOverrideKey> ntpOverrideKeys, @JsonKey(fromJson: Sniffer.safeSnifferFromJson)  Sniffer sniffer, @JsonKey(name: snifferOverrideKeysJsonKey, fromJson: snifferOverrideKeysFromJson)  Set<SnifferOverrideKey> snifferOverrideKeys, @JsonKey(fromJson: ProfileTun.safeFromJson)  ProfileTun tun, @JsonKey(name: tunOverrideKeysJsonKey, fromJson: tunOverrideKeysFromJson)  Set<TunOverrideKey> tunOverrideKeys, @JsonKey(name: 'proxy-providers')  Map<String, ProxyProviderOptions> proxyProviders)?  $default,) {final _that = this;
switch (_that) {
case _ProfileOverrides() when $default != null:
return $default(_that.dns,_that.dnsOverrideKeys,_that.ntp,_that.ntpOverrideKeys,_that.sniffer,_that.snifferOverrideKeys,_that.tun,_that.tunOverrideKeys,_that.proxyProviders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileOverrides implements ProfileOverrides {
  const _ProfileOverrides({@JsonKey(fromJson: Dns.safeDnsFromJson) this.dns = defaultDns, @JsonKey(name: dnsOverrideKeysJsonKey, fromJson: dnsOverrideKeysFromJson)  Set<DnsOverrideKey> dnsOverrideKeys = const {}, @JsonKey(fromJson: Ntp.safeNtpFromJson) this.ntp = defaultNtp, @JsonKey(name: ntpOverrideKeysJsonKey, fromJson: ntpOverrideKeysFromJson)  Set<NtpOverrideKey> ntpOverrideKeys = const {}, @JsonKey(fromJson: Sniffer.safeSnifferFromJson) this.sniffer = defaultSniffer, @JsonKey(name: snifferOverrideKeysJsonKey, fromJson: snifferOverrideKeysFromJson)  Set<SnifferOverrideKey> snifferOverrideKeys = const {}, @JsonKey(fromJson: ProfileTun.safeFromJson) this.tun = defaultProfileTun, @JsonKey(name: tunOverrideKeysJsonKey, fromJson: tunOverrideKeysFromJson)  Set<TunOverrideKey> tunOverrideKeys = const {}, @JsonKey(name: 'proxy-providers')  Map<String, ProxyProviderOptions> proxyProviders = const {}}): _dnsOverrideKeys = dnsOverrideKeys,_ntpOverrideKeys = ntpOverrideKeys,_snifferOverrideKeys = snifferOverrideKeys,_tunOverrideKeys = tunOverrideKeys,_proxyProviders = proxyProviders;
  factory _ProfileOverrides.fromJson(Map<String, dynamic> json) => _$ProfileOverridesFromJson(json);

@override@JsonKey(fromJson: Dns.safeDnsFromJson) final  Dns dns;
 final  Set<DnsOverrideKey> _dnsOverrideKeys;
@override@JsonKey(name: dnsOverrideKeysJsonKey, fromJson: dnsOverrideKeysFromJson) Set<DnsOverrideKey> get dnsOverrideKeys {
  if (_dnsOverrideKeys is EqualUnmodifiableSetView) return _dnsOverrideKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_dnsOverrideKeys);
}

@override@JsonKey(fromJson: Ntp.safeNtpFromJson) final  Ntp ntp;
 final  Set<NtpOverrideKey> _ntpOverrideKeys;
@override@JsonKey(name: ntpOverrideKeysJsonKey, fromJson: ntpOverrideKeysFromJson) Set<NtpOverrideKey> get ntpOverrideKeys {
  if (_ntpOverrideKeys is EqualUnmodifiableSetView) return _ntpOverrideKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_ntpOverrideKeys);
}

@override@JsonKey(fromJson: Sniffer.safeSnifferFromJson) final  Sniffer sniffer;
 final  Set<SnifferOverrideKey> _snifferOverrideKeys;
@override@JsonKey(name: snifferOverrideKeysJsonKey, fromJson: snifferOverrideKeysFromJson) Set<SnifferOverrideKey> get snifferOverrideKeys {
  if (_snifferOverrideKeys is EqualUnmodifiableSetView) return _snifferOverrideKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_snifferOverrideKeys);
}

@override@JsonKey(fromJson: ProfileTun.safeFromJson) final  ProfileTun tun;
 final  Set<TunOverrideKey> _tunOverrideKeys;
@override@JsonKey(name: tunOverrideKeysJsonKey, fromJson: tunOverrideKeysFromJson) Set<TunOverrideKey> get tunOverrideKeys {
  if (_tunOverrideKeys is EqualUnmodifiableSetView) return _tunOverrideKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_tunOverrideKeys);
}

 final  Map<String, ProxyProviderOptions> _proxyProviders;
@override@JsonKey(name: 'proxy-providers') Map<String, ProxyProviderOptions> get proxyProviders {
  if (_proxyProviders is EqualUnmodifiableMapView) return _proxyProviders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_proxyProviders);
}


/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileOverridesCopyWith<_ProfileOverrides> get copyWith => __$ProfileOverridesCopyWithImpl<_ProfileOverrides>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileOverridesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileOverrides&&(identical(other.dns, dns) || other.dns == dns)&&const DeepCollectionEquality().equals(other.dnsOverrideKeys, _dnsOverrideKeys)&&(identical(other.ntp, ntp) || other.ntp == ntp)&&const DeepCollectionEquality().equals(other.ntpOverrideKeys, _ntpOverrideKeys)&&(identical(other.sniffer, sniffer) || other.sniffer == sniffer)&&const DeepCollectionEquality().equals(other.snifferOverrideKeys, _snifferOverrideKeys)&&(identical(other.tun, tun) || other.tun == tun)&&const DeepCollectionEquality().equals(other.tunOverrideKeys, _tunOverrideKeys)&&const DeepCollectionEquality().equals(other.proxyProviders, _proxyProviders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dns,const DeepCollectionEquality().hash(_dnsOverrideKeys),ntp,const DeepCollectionEquality().hash(_ntpOverrideKeys),sniffer,const DeepCollectionEquality().hash(_snifferOverrideKeys),tun,const DeepCollectionEquality().hash(_tunOverrideKeys),const DeepCollectionEquality().hash(_proxyProviders));
}

@override
String toString() {
    return 'ProfileOverrides(dns: $dns, dnsOverrideKeys: $dnsOverrideKeys, ntp: $ntp, ntpOverrideKeys: $ntpOverrideKeys, sniffer: $sniffer, snifferOverrideKeys: $snifferOverrideKeys, tun: $tun, tunOverrideKeys: $tunOverrideKeys, proxyProviders: $proxyProviders)';
}


}

/// @nodoc
abstract mixin class _$ProfileOverridesCopyWith<$Res> implements $ProfileOverridesCopyWith<$Res> {
  factory _$ProfileOverridesCopyWith(_ProfileOverrides value, $Res Function(_ProfileOverrides) _then) = __$ProfileOverridesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: Dns.safeDnsFromJson) Dns dns,@JsonKey(name: dnsOverrideKeysJsonKey, fromJson: dnsOverrideKeysFromJson) Set<DnsOverrideKey> dnsOverrideKeys,@JsonKey(fromJson: Ntp.safeNtpFromJson) Ntp ntp,@JsonKey(name: ntpOverrideKeysJsonKey, fromJson: ntpOverrideKeysFromJson) Set<NtpOverrideKey> ntpOverrideKeys,@JsonKey(fromJson: Sniffer.safeSnifferFromJson) Sniffer sniffer,@JsonKey(name: snifferOverrideKeysJsonKey, fromJson: snifferOverrideKeysFromJson) Set<SnifferOverrideKey> snifferOverrideKeys,@JsonKey(fromJson: ProfileTun.safeFromJson) ProfileTun tun,@JsonKey(name: tunOverrideKeysJsonKey, fromJson: tunOverrideKeysFromJson) Set<TunOverrideKey> tunOverrideKeys,@JsonKey(name: 'proxy-providers') Map<String, ProxyProviderOptions> proxyProviders
});


@override $DnsCopyWith<$Res> get dns;@override $NtpCopyWith<$Res> get ntp;@override $SnifferCopyWith<$Res> get sniffer;@override $ProfileTunCopyWith<$Res> get tun;

}
/// @nodoc
class __$ProfileOverridesCopyWithImpl<$Res>
    implements _$ProfileOverridesCopyWith<$Res> {
  __$ProfileOverridesCopyWithImpl(this._self, this._then);

  final _ProfileOverrides _self;
  final $Res Function(_ProfileOverrides) _then;

/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dns = null,Object? dnsOverrideKeys = null,Object? ntp = null,Object? ntpOverrideKeys = null,Object? sniffer = null,Object? snifferOverrideKeys = null,Object? tun = null,Object? tunOverrideKeys = null,Object? proxyProviders = null,}) {
  return _then(_ProfileOverrides(
dns: null == dns ? _self.dns : dns // ignore: cast_nullable_to_non_nullable
as Dns,dnsOverrideKeys: null == dnsOverrideKeys ? _self._dnsOverrideKeys : dnsOverrideKeys // ignore: cast_nullable_to_non_nullable
as Set<DnsOverrideKey>,ntp: null == ntp ? _self.ntp : ntp // ignore: cast_nullable_to_non_nullable
as Ntp,ntpOverrideKeys: null == ntpOverrideKeys ? _self._ntpOverrideKeys : ntpOverrideKeys // ignore: cast_nullable_to_non_nullable
as Set<NtpOverrideKey>,sniffer: null == sniffer ? _self.sniffer : sniffer // ignore: cast_nullable_to_non_nullable
as Sniffer,snifferOverrideKeys: null == snifferOverrideKeys ? _self._snifferOverrideKeys : snifferOverrideKeys // ignore: cast_nullable_to_non_nullable
as Set<SnifferOverrideKey>,tun: null == tun ? _self.tun : tun // ignore: cast_nullable_to_non_nullable
as ProfileTun,tunOverrideKeys: null == tunOverrideKeys ? _self._tunOverrideKeys : tunOverrideKeys // ignore: cast_nullable_to_non_nullable
as Set<TunOverrideKey>,proxyProviders: null == proxyProviders ? _self._proxyProviders : proxyProviders // ignore: cast_nullable_to_non_nullable
as Map<String, ProxyProviderOptions>,
  ));
}

/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DnsCopyWith<$Res> get dns {
  
  return $DnsCopyWith<$Res>(_self.dns, (value) {
    return _then(_self.copyWith(dns: value));
  });
}/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NtpCopyWith<$Res> get ntp {
  
  return $NtpCopyWith<$Res>(_self.ntp, (value) {
    return _then(_self.copyWith(ntp: value));
  });
}/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SnifferCopyWith<$Res> get sniffer {
  
  return $SnifferCopyWith<$Res>(_self.sniffer, (value) {
    return _then(_self.copyWith(sniffer: value));
  });
}/// Create a copy of ProfileOverrides
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileTunCopyWith<$Res> get tun {
  
  return $ProfileTunCopyWith<$Res>(_self.tun, (value) {
    return _then(_self.copyWith(tun: value));
  });
}
}


/// @nodoc
mixin _$Profile {

 int get id; String get label; String? get currentGroupName; String get url; String get ageSecretKey; DateTime? get lastUpdateDate; Duration get autoUpdateDuration; SubscriptionInfo? get subscriptionInfo; bool get autoUpdate; Map<String, String> get selectedMap; Set<String> get unfoldSet; OverwriteType get overwriteType; List<ProxyChain> get proxyChains; List<ProfileProxy> get profileProxies; List<ProxyGroup> get customProxyGroups; List<Rule> get customRules; int? get scriptId; String? get matchTarget; int? get order; ProfileType? get profileType;@JsonKey(fromJson: ProfileOverrides.safeFromJson) ProfileOverrides get overrides;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Profile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.currentGroupName, _this.currentGroupName) || other.currentGroupName == _this.currentGroupName)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.ageSecretKey, _this.ageSecretKey) || other.ageSecretKey == _this.ageSecretKey)&&(identical(other.lastUpdateDate, _this.lastUpdateDate) || other.lastUpdateDate == _this.lastUpdateDate)&&(identical(other.autoUpdateDuration, _this.autoUpdateDuration) || other.autoUpdateDuration == _this.autoUpdateDuration)&&(identical(other.subscriptionInfo, _this.subscriptionInfo) || other.subscriptionInfo == _this.subscriptionInfo)&&(identical(other.autoUpdate, _this.autoUpdate) || other.autoUpdate == _this.autoUpdate)&&const DeepCollectionEquality().equals(other.selectedMap, _this.selectedMap)&&const DeepCollectionEquality().equals(other.unfoldSet, _this.unfoldSet)&&(identical(other.overwriteType, _this.overwriteType) || other.overwriteType == _this.overwriteType)&&const DeepCollectionEquality().equals(other.proxyChains, _this.proxyChains)&&const DeepCollectionEquality().equals(other.profileProxies, _this.profileProxies)&&const DeepCollectionEquality().equals(other.customProxyGroups, _this.customProxyGroups)&&const DeepCollectionEquality().equals(other.customRules, _this.customRules)&&(identical(other.scriptId, _this.scriptId) || other.scriptId == _this.scriptId)&&(identical(other.matchTarget, _this.matchTarget) || other.matchTarget == _this.matchTarget)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.profileType, _this.profileType) || other.profileType == _this.profileType)&&(identical(other.overrides, _this.overrides) || other.overrides == _this.overrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Profile;
  return Object.hashAll([runtimeType,_this.id,_this.label,_this.currentGroupName,_this.url,_this.ageSecretKey,_this.lastUpdateDate,_this.autoUpdateDuration,_this.subscriptionInfo,_this.autoUpdate,const DeepCollectionEquality().hash(_this.selectedMap),const DeepCollectionEquality().hash(_this.unfoldSet),_this.overwriteType,const DeepCollectionEquality().hash(_this.proxyChains),const DeepCollectionEquality().hash(_this.profileProxies),const DeepCollectionEquality().hash(_this.customProxyGroups),const DeepCollectionEquality().hash(_this.customRules),_this.scriptId,_this.matchTarget,_this.order,_this.profileType,_this.overrides]);
}

@override
String toString() {
  final _this = this as Profile;
  return 'Profile(id: ${_this.id}, label: ${_this.label}, currentGroupName: ${_this.currentGroupName}, url: ${_this.url}, ageSecretKey: ${_this.ageSecretKey}, lastUpdateDate: ${_this.lastUpdateDate}, autoUpdateDuration: ${_this.autoUpdateDuration}, subscriptionInfo: ${_this.subscriptionInfo}, autoUpdate: ${_this.autoUpdate}, selectedMap: ${_this.selectedMap}, unfoldSet: ${_this.unfoldSet}, overwriteType: ${_this.overwriteType}, proxyChains: ${_this.proxyChains}, profileProxies: ${_this.profileProxies}, customProxyGroups: ${_this.customProxyGroups}, customRules: ${_this.customRules}, scriptId: ${_this.scriptId}, matchTarget: ${_this.matchTarget}, order: ${_this.order}, profileType: ${_this.profileType}, overrides: ${_this.overrides})';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 int id, String label, String? currentGroupName, String url, String ageSecretKey, DateTime? lastUpdateDate, Duration autoUpdateDuration, SubscriptionInfo? subscriptionInfo, bool autoUpdate, Map<String, String> selectedMap, Set<String> unfoldSet, OverwriteType overwriteType, List<ProxyChain> proxyChains, List<ProfileProxy> profileProxies, List<ProxyGroup> customProxyGroups, List<Rule> customRules, int? scriptId, String? matchTarget, int? order, ProfileType? profileType,@JsonKey(fromJson: ProfileOverrides.safeFromJson) ProfileOverrides overrides
});


$SubscriptionInfoCopyWith<$Res>? get subscriptionInfo;$ProfileOverridesCopyWith<$Res> get overrides;

}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? currentGroupName = freezed,Object? url = null,Object? ageSecretKey = null,Object? lastUpdateDate = freezed,Object? autoUpdateDuration = null,Object? subscriptionInfo = freezed,Object? autoUpdate = null,Object? selectedMap = null,Object? unfoldSet = null,Object? overwriteType = null,Object? proxyChains = null,Object? profileProxies = null,Object? customProxyGroups = null,Object? customRules = null,Object? scriptId = freezed,Object? matchTarget = freezed,Object? order = freezed,Object? profileType = freezed,Object? overrides = null,}) {
  return _then(Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,currentGroupName: freezed == currentGroupName ? _self.currentGroupName : currentGroupName // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,ageSecretKey: null == ageSecretKey ? _self.ageSecretKey : ageSecretKey // ignore: cast_nullable_to_non_nullable
as String,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,autoUpdateDuration: null == autoUpdateDuration ? _self.autoUpdateDuration : autoUpdateDuration // ignore: cast_nullable_to_non_nullable
as Duration,subscriptionInfo: freezed == subscriptionInfo ? _self.subscriptionInfo : subscriptionInfo // ignore: cast_nullable_to_non_nullable
as SubscriptionInfo?,autoUpdate: null == autoUpdate ? _self.autoUpdate : autoUpdate // ignore: cast_nullable_to_non_nullable
as bool,selectedMap: null == selectedMap ? _self.selectedMap : selectedMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,unfoldSet: null == unfoldSet ? _self.unfoldSet : unfoldSet // ignore: cast_nullable_to_non_nullable
as Set<String>,overwriteType: null == overwriteType ? _self.overwriteType : overwriteType // ignore: cast_nullable_to_non_nullable
as OverwriteType,proxyChains: null == proxyChains ? _self.proxyChains : proxyChains // ignore: cast_nullable_to_non_nullable
as List<ProxyChain>,profileProxies: null == profileProxies ? _self.profileProxies : profileProxies // ignore: cast_nullable_to_non_nullable
as List<ProfileProxy>,customProxyGroups: null == customProxyGroups ? _self.customProxyGroups : customProxyGroups // ignore: cast_nullable_to_non_nullable
as List<ProxyGroup>,customRules: null == customRules ? _self.customRules : customRules // ignore: cast_nullable_to_non_nullable
as List<Rule>,scriptId: freezed == scriptId ? _self.scriptId : scriptId // ignore: cast_nullable_to_non_nullable
as int?,matchTarget: freezed == matchTarget ? _self.matchTarget : matchTarget // ignore: cast_nullable_to_non_nullable
as String?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,profileType: freezed == profileType ? _self.profileType : profileType // ignore: cast_nullable_to_non_nullable
as ProfileType?,overrides: null == overrides ? _self.overrides : overrides // ignore: cast_nullable_to_non_nullable
as ProfileOverrides,
  ));
}
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionInfoCopyWith<$Res>? get subscriptionInfo {
    if (_self.subscriptionInfo == null) {
    return null;
  }

  return $SubscriptionInfoCopyWith<$Res>(_self.subscriptionInfo!, (value) {
    return _then(_self.copyWith(subscriptionInfo: value));
  });
}/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileOverridesCopyWith<$Res> get overrides {
  
  return $ProfileOverridesCopyWith<$Res>(_self.overrides, (value) {
    return _then(_self.copyWith(overrides: value));
  });
}
}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String label,  String? currentGroupName,  String url,  String ageSecretKey,  DateTime? lastUpdateDate,  Duration autoUpdateDuration,  SubscriptionInfo? subscriptionInfo,  bool autoUpdate,  Map<String, String> selectedMap,  Set<String> unfoldSet,  OverwriteType overwriteType,  List<ProxyChain> proxyChains,  List<ProfileProxy> profileProxies,  List<ProxyGroup> customProxyGroups,  List<Rule> customRules,  int? scriptId,  String? matchTarget,  int? order,  ProfileType? profileType, @JsonKey(fromJson: ProfileOverrides.safeFromJson)  ProfileOverrides overrides)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.label,_that.currentGroupName,_that.url,_that.ageSecretKey,_that.lastUpdateDate,_that.autoUpdateDuration,_that.subscriptionInfo,_that.autoUpdate,_that.selectedMap,_that.unfoldSet,_that.overwriteType,_that.proxyChains,_that.profileProxies,_that.customProxyGroups,_that.customRules,_that.scriptId,_that.matchTarget,_that.order,_that.profileType,_that.overrides);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String label,  String? currentGroupName,  String url,  String ageSecretKey,  DateTime? lastUpdateDate,  Duration autoUpdateDuration,  SubscriptionInfo? subscriptionInfo,  bool autoUpdate,  Map<String, String> selectedMap,  Set<String> unfoldSet,  OverwriteType overwriteType,  List<ProxyChain> proxyChains,  List<ProfileProxy> profileProxies,  List<ProxyGroup> customProxyGroups,  List<Rule> customRules,  int? scriptId,  String? matchTarget,  int? order,  ProfileType? profileType, @JsonKey(fromJson: ProfileOverrides.safeFromJson)  ProfileOverrides overrides)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.id,_that.label,_that.currentGroupName,_that.url,_that.ageSecretKey,_that.lastUpdateDate,_that.autoUpdateDuration,_that.subscriptionInfo,_that.autoUpdate,_that.selectedMap,_that.unfoldSet,_that.overwriteType,_that.proxyChains,_that.profileProxies,_that.customProxyGroups,_that.customRules,_that.scriptId,_that.matchTarget,_that.order,_that.profileType,_that.overrides);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String label,  String? currentGroupName,  String url,  String ageSecretKey,  DateTime? lastUpdateDate,  Duration autoUpdateDuration,  SubscriptionInfo? subscriptionInfo,  bool autoUpdate,  Map<String, String> selectedMap,  Set<String> unfoldSet,  OverwriteType overwriteType,  List<ProxyChain> proxyChains,  List<ProfileProxy> profileProxies,  List<ProxyGroup> customProxyGroups,  List<Rule> customRules,  int? scriptId,  String? matchTarget,  int? order,  ProfileType? profileType, @JsonKey(fromJson: ProfileOverrides.safeFromJson)  ProfileOverrides overrides)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.label,_that.currentGroupName,_that.url,_that.ageSecretKey,_that.lastUpdateDate,_that.autoUpdateDuration,_that.subscriptionInfo,_that.autoUpdate,_that.selectedMap,_that.unfoldSet,_that.overwriteType,_that.proxyChains,_that.profileProxies,_that.customProxyGroups,_that.customRules,_that.scriptId,_that.matchTarget,_that.order,_that.profileType,_that.overrides);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.id, this.label = '', this.currentGroupName, this.url = '', this.ageSecretKey = '', this.lastUpdateDate, required this.autoUpdateDuration, this.subscriptionInfo, this.autoUpdate = true,  Map<String, String> selectedMap = const {},  Set<String> unfoldSet = const {}, this.overwriteType = OverwriteType.standard,  List<ProxyChain> proxyChains = const [],  List<ProfileProxy> profileProxies = const [],  List<ProxyGroup> customProxyGroups = const [],  List<Rule> customRules = const [], this.scriptId, this.matchTarget, this.order, this.profileType, @JsonKey(fromJson: ProfileOverrides.safeFromJson) this.overrides = const ProfileOverrides()}): _selectedMap = selectedMap,_unfoldSet = unfoldSet,_proxyChains = proxyChains,_profileProxies = profileProxies,_customProxyGroups = customProxyGroups,_customRules = customRules;
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  int id;
@override@JsonKey() final  String label;
@override final  String? currentGroupName;
@override@JsonKey() final  String url;
@override@JsonKey() final  String ageSecretKey;
@override final  DateTime? lastUpdateDate;
@override final  Duration autoUpdateDuration;
@override final  SubscriptionInfo? subscriptionInfo;
@override@JsonKey() final  bool autoUpdate;
 final  Map<String, String> _selectedMap;
@override@JsonKey() Map<String, String> get selectedMap {
  if (_selectedMap is EqualUnmodifiableMapView) return _selectedMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedMap);
}

 final  Set<String> _unfoldSet;
@override@JsonKey() Set<String> get unfoldSet {
  if (_unfoldSet is EqualUnmodifiableSetView) return _unfoldSet;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_unfoldSet);
}

@override@JsonKey() final  OverwriteType overwriteType;
 final  List<ProxyChain> _proxyChains;
@override@JsonKey() List<ProxyChain> get proxyChains {
  if (_proxyChains is EqualUnmodifiableListView) return _proxyChains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proxyChains);
}

 final  List<ProfileProxy> _profileProxies;
@override@JsonKey() List<ProfileProxy> get profileProxies {
  if (_profileProxies is EqualUnmodifiableListView) return _profileProxies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_profileProxies);
}

 final  List<ProxyGroup> _customProxyGroups;
@override@JsonKey() List<ProxyGroup> get customProxyGroups {
  if (_customProxyGroups is EqualUnmodifiableListView) return _customProxyGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customProxyGroups);
}

 final  List<Rule> _customRules;
@override@JsonKey() List<Rule> get customRules {
  if (_customRules is EqualUnmodifiableListView) return _customRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customRules);
}

@override final  int? scriptId;
@override final  String? matchTarget;
@override final  int? order;
@override final  ProfileType? profileType;
@override@JsonKey(fromJson: ProfileOverrides.safeFromJson) final  ProfileOverrides overrides;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.currentGroupName, currentGroupName) || other.currentGroupName == currentGroupName)&&(identical(other.url, url) || other.url == url)&&(identical(other.ageSecretKey, ageSecretKey) || other.ageSecretKey == ageSecretKey)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate)&&(identical(other.autoUpdateDuration, autoUpdateDuration) || other.autoUpdateDuration == autoUpdateDuration)&&(identical(other.subscriptionInfo, subscriptionInfo) || other.subscriptionInfo == subscriptionInfo)&&(identical(other.autoUpdate, autoUpdate) || other.autoUpdate == autoUpdate)&&const DeepCollectionEquality().equals(other.selectedMap, _selectedMap)&&const DeepCollectionEquality().equals(other.unfoldSet, _unfoldSet)&&(identical(other.overwriteType, overwriteType) || other.overwriteType == overwriteType)&&const DeepCollectionEquality().equals(other.proxyChains, _proxyChains)&&const DeepCollectionEquality().equals(other.profileProxies, _profileProxies)&&const DeepCollectionEquality().equals(other.customProxyGroups, _customProxyGroups)&&const DeepCollectionEquality().equals(other.customRules, _customRules)&&(identical(other.scriptId, scriptId) || other.scriptId == scriptId)&&(identical(other.matchTarget, matchTarget) || other.matchTarget == matchTarget)&&(identical(other.order, order) || other.order == order)&&(identical(other.profileType, profileType) || other.profileType == profileType)&&(identical(other.overrides, overrides) || other.overrides == overrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,label,currentGroupName,url,ageSecretKey,lastUpdateDate,autoUpdateDuration,subscriptionInfo,autoUpdate,const DeepCollectionEquality().hash(_selectedMap),const DeepCollectionEquality().hash(_unfoldSet),overwriteType,const DeepCollectionEquality().hash(_proxyChains),const DeepCollectionEquality().hash(_profileProxies),const DeepCollectionEquality().hash(_customProxyGroups),const DeepCollectionEquality().hash(_customRules),scriptId,matchTarget,order,profileType,overrides]);
}

@override
String toString() {
    return 'Profile(id: $id, label: $label, currentGroupName: $currentGroupName, url: $url, ageSecretKey: $ageSecretKey, lastUpdateDate: $lastUpdateDate, autoUpdateDuration: $autoUpdateDuration, subscriptionInfo: $subscriptionInfo, autoUpdate: $autoUpdate, selectedMap: $selectedMap, unfoldSet: $unfoldSet, overwriteType: $overwriteType, proxyChains: $proxyChains, profileProxies: $profileProxies, customProxyGroups: $customProxyGroups, customRules: $customRules, scriptId: $scriptId, matchTarget: $matchTarget, order: $order, profileType: $profileType, overrides: $overrides)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 int id, String label, String? currentGroupName, String url, String ageSecretKey, DateTime? lastUpdateDate, Duration autoUpdateDuration, SubscriptionInfo? subscriptionInfo, bool autoUpdate, Map<String, String> selectedMap, Set<String> unfoldSet, OverwriteType overwriteType, List<ProxyChain> proxyChains, List<ProfileProxy> profileProxies, List<ProxyGroup> customProxyGroups, List<Rule> customRules, int? scriptId, String? matchTarget, int? order, ProfileType? profileType,@JsonKey(fromJson: ProfileOverrides.safeFromJson) ProfileOverrides overrides
});


@override $SubscriptionInfoCopyWith<$Res>? get subscriptionInfo;@override $ProfileOverridesCopyWith<$Res> get overrides;

}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? currentGroupName = freezed,Object? url = null,Object? ageSecretKey = null,Object? lastUpdateDate = freezed,Object? autoUpdateDuration = null,Object? subscriptionInfo = freezed,Object? autoUpdate = null,Object? selectedMap = null,Object? unfoldSet = null,Object? overwriteType = null,Object? proxyChains = null,Object? profileProxies = null,Object? customProxyGroups = null,Object? customRules = null,Object? scriptId = freezed,Object? matchTarget = freezed,Object? order = freezed,Object? profileType = freezed,Object? overrides = null,}) {
  return _then(_Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,currentGroupName: freezed == currentGroupName ? _self.currentGroupName : currentGroupName // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,ageSecretKey: null == ageSecretKey ? _self.ageSecretKey : ageSecretKey // ignore: cast_nullable_to_non_nullable
as String,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,autoUpdateDuration: null == autoUpdateDuration ? _self.autoUpdateDuration : autoUpdateDuration // ignore: cast_nullable_to_non_nullable
as Duration,subscriptionInfo: freezed == subscriptionInfo ? _self.subscriptionInfo : subscriptionInfo // ignore: cast_nullable_to_non_nullable
as SubscriptionInfo?,autoUpdate: null == autoUpdate ? _self.autoUpdate : autoUpdate // ignore: cast_nullable_to_non_nullable
as bool,selectedMap: null == selectedMap ? _self._selectedMap : selectedMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,unfoldSet: null == unfoldSet ? _self._unfoldSet : unfoldSet // ignore: cast_nullable_to_non_nullable
as Set<String>,overwriteType: null == overwriteType ? _self.overwriteType : overwriteType // ignore: cast_nullable_to_non_nullable
as OverwriteType,proxyChains: null == proxyChains ? _self._proxyChains : proxyChains // ignore: cast_nullable_to_non_nullable
as List<ProxyChain>,profileProxies: null == profileProxies ? _self._profileProxies : profileProxies // ignore: cast_nullable_to_non_nullable
as List<ProfileProxy>,customProxyGroups: null == customProxyGroups ? _self._customProxyGroups : customProxyGroups // ignore: cast_nullable_to_non_nullable
as List<ProxyGroup>,customRules: null == customRules ? _self._customRules : customRules // ignore: cast_nullable_to_non_nullable
as List<Rule>,scriptId: freezed == scriptId ? _self.scriptId : scriptId // ignore: cast_nullable_to_non_nullable
as int?,matchTarget: freezed == matchTarget ? _self.matchTarget : matchTarget // ignore: cast_nullable_to_non_nullable
as String?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,profileType: freezed == profileType ? _self.profileType : profileType // ignore: cast_nullable_to_non_nullable
as ProfileType?,overrides: null == overrides ? _self.overrides : overrides // ignore: cast_nullable_to_non_nullable
as ProfileOverrides,
  ));
}

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionInfoCopyWith<$Res>? get subscriptionInfo {
    if (_self.subscriptionInfo == null) {
    return null;
  }

  return $SubscriptionInfoCopyWith<$Res>(_self.subscriptionInfo!, (value) {
    return _then(_self.copyWith(subscriptionInfo: value));
  });
}/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileOverridesCopyWith<$Res> get overrides {
  
  return $ProfileOverridesCopyWith<$Res>(_self.overrides, (value) {
    return _then(_self.copyWith(overrides: value));
  });
}
}

/// @nodoc
mixin _$ProfileRuleLink {

 int? get profileId; int get ruleId; RuleScene? get scene; String? get order;
/// Create a copy of ProfileRuleLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileRuleLinkCopyWith<ProfileRuleLink> get copyWith => _$ProfileRuleLinkCopyWithImpl<ProfileRuleLink>(this as ProfileRuleLink, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileRuleLink;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileRuleLink&&(identical(other.profileId, _this.profileId) || other.profileId == _this.profileId)&&(identical(other.ruleId, _this.ruleId) || other.ruleId == _this.ruleId)&&(identical(other.scene, _this.scene) || other.scene == _this.scene)&&(identical(other.order, _this.order) || other.order == _this.order));
}


@override
int get hashCode {
  final _this = this as ProfileRuleLink;
  return Object.hash(runtimeType,_this.profileId,_this.ruleId,_this.scene,_this.order);
}

@override
String toString() {
  final _this = this as ProfileRuleLink;
  return 'ProfileRuleLink(profileId: ${_this.profileId}, ruleId: ${_this.ruleId}, scene: ${_this.scene}, order: ${_this.order})';
}


}

/// @nodoc
abstract mixin class $ProfileRuleLinkCopyWith<$Res>  {
  factory $ProfileRuleLinkCopyWith(ProfileRuleLink value, $Res Function(ProfileRuleLink) _then) = _$ProfileRuleLinkCopyWithImpl;
@useResult
$Res call({
 int? profileId, int ruleId, RuleScene? scene, String? order
});




}
/// @nodoc
class _$ProfileRuleLinkCopyWithImpl<$Res>
    implements $ProfileRuleLinkCopyWith<$Res> {
  _$ProfileRuleLinkCopyWithImpl(this._self, this._then);

  final ProfileRuleLink _self;
  final $Res Function(ProfileRuleLink) _then;

/// Create a copy of ProfileRuleLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = freezed,Object? ruleId = null,Object? scene = freezed,Object? order = freezed,}) {
  return _then(ProfileRuleLink(
profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as int,scene: freezed == scene ? _self.scene : scene // ignore: cast_nullable_to_non_nullable
as RuleScene?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileRuleLink].
extension ProfileRuleLinkPatterns on ProfileRuleLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileRuleLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileRuleLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileRuleLink value)  $default,){
final _that = this;
switch (_that) {
case _ProfileRuleLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileRuleLink value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileRuleLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? profileId,  int ruleId,  RuleScene? scene,  String? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileRuleLink() when $default != null:
return $default(_that.profileId,_that.ruleId,_that.scene,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? profileId,  int ruleId,  RuleScene? scene,  String? order)  $default,) {final _that = this;
switch (_that) {
case _ProfileRuleLink():
return $default(_that.profileId,_that.ruleId,_that.scene,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? profileId,  int ruleId,  RuleScene? scene,  String? order)?  $default,) {final _that = this;
switch (_that) {
case _ProfileRuleLink() when $default != null:
return $default(_that.profileId,_that.ruleId,_that.scene,_that.order);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileRuleLink implements ProfileRuleLink {
  const _ProfileRuleLink({this.profileId, required this.ruleId, this.scene, this.order});
  

@override final  int? profileId;
@override final  int ruleId;
@override final  RuleScene? scene;
@override final  String? order;

/// Create a copy of ProfileRuleLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileRuleLinkCopyWith<_ProfileRuleLink> get copyWith => __$ProfileRuleLinkCopyWithImpl<_ProfileRuleLink>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileRuleLink&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.scene, scene) || other.scene == scene)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode {
    return Object.hash(runtimeType,profileId,ruleId,scene,order);
}

@override
String toString() {
    return 'ProfileRuleLink(profileId: $profileId, ruleId: $ruleId, scene: $scene, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ProfileRuleLinkCopyWith<$Res> implements $ProfileRuleLinkCopyWith<$Res> {
  factory _$ProfileRuleLinkCopyWith(_ProfileRuleLink value, $Res Function(_ProfileRuleLink) _then) = __$ProfileRuleLinkCopyWithImpl;
@override @useResult
$Res call({
 int? profileId, int ruleId, RuleScene? scene, String? order
});




}
/// @nodoc
class __$ProfileRuleLinkCopyWithImpl<$Res>
    implements _$ProfileRuleLinkCopyWith<$Res> {
  __$ProfileRuleLinkCopyWithImpl(this._self, this._then);

  final _ProfileRuleLink _self;
  final $Res Function(_ProfileRuleLink) _then;

/// Create a copy of ProfileRuleLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = freezed,Object? ruleId = null,Object? scene = freezed,Object? order = freezed,}) {
  return _then(_ProfileRuleLink(
profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as int,scene: freezed == scene ? _self.scene : scene // ignore: cast_nullable_to_non_nullable
as RuleScene?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
