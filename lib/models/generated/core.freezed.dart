// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../core.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SetupParams {

@JsonKey(name: 'selected-map') Map<String, String> get selectedMap; CoreOptions get options;@JsonKey(name: 'raw-config') String get rawConfig;@JsonKey(name: 'suspend-on-idle') bool get suspendOnIdle;
/// Create a copy of SetupParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupParamsCopyWith<SetupParams> get copyWith => _$SetupParamsCopyWithImpl<SetupParams>(this as SetupParams, _$identity);

  /// Serializes this SetupParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SetupParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupParams&&const DeepCollectionEquality().equals(other.selectedMap, _this.selectedMap)&&(identical(other.options, _this.options) || other.options == _this.options)&&(identical(other.rawConfig, _this.rawConfig) || other.rawConfig == _this.rawConfig)&&(identical(other.suspendOnIdle, _this.suspendOnIdle) || other.suspendOnIdle == _this.suspendOnIdle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SetupParams;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.selectedMap),_this.options,_this.rawConfig,_this.suspendOnIdle);
}

@override
String toString() {
  final _this = this as SetupParams;
  return 'SetupParams(selectedMap: ${_this.selectedMap}, options: ${_this.options}, rawConfig: ${_this.rawConfig}, suspendOnIdle: ${_this.suspendOnIdle})';
}


}

/// @nodoc
abstract mixin class $SetupParamsCopyWith<$Res>  {
  factory $SetupParamsCopyWith(SetupParams value, $Res Function(SetupParams) _then) = _$SetupParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'selected-map') Map<String, String> selectedMap, CoreOptions options,@JsonKey(name: 'raw-config') String rawConfig,@JsonKey(name: 'suspend-on-idle') bool suspendOnIdle
});


$CoreOptionsCopyWith<$Res> get options;

}
/// @nodoc
class _$SetupParamsCopyWithImpl<$Res>
    implements $SetupParamsCopyWith<$Res> {
  _$SetupParamsCopyWithImpl(this._self, this._then);

  final SetupParams _self;
  final $Res Function(SetupParams) _then;

/// Create a copy of SetupParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedMap = null,Object? options = null,Object? rawConfig = null,Object? suspendOnIdle = null,}) {
  return _then(SetupParams(
selectedMap: null == selectedMap ? _self.selectedMap : selectedMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as CoreOptions,rawConfig: null == rawConfig ? _self.rawConfig : rawConfig // ignore: cast_nullable_to_non_nullable
as String,suspendOnIdle: null == suspendOnIdle ? _self.suspendOnIdle : suspendOnIdle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SetupParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoreOptionsCopyWith<$Res> get options {
  
  return $CoreOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}


/// Adds pattern-matching-related methods to [SetupParams].
extension SetupParamsPatterns on SetupParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupParams value)  $default,){
final _that = this;
switch (_that) {
case _SetupParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupParams value)?  $default,){
final _that = this;
switch (_that) {
case _SetupParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'selected-map')  Map<String, String> selectedMap,  CoreOptions options, @JsonKey(name: 'raw-config')  String rawConfig, @JsonKey(name: 'suspend-on-idle')  bool suspendOnIdle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupParams() when $default != null:
return $default(_that.selectedMap,_that.options,_that.rawConfig,_that.suspendOnIdle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'selected-map')  Map<String, String> selectedMap,  CoreOptions options, @JsonKey(name: 'raw-config')  String rawConfig, @JsonKey(name: 'suspend-on-idle')  bool suspendOnIdle)  $default,) {final _that = this;
switch (_that) {
case _SetupParams():
return $default(_that.selectedMap,_that.options,_that.rawConfig,_that.suspendOnIdle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'selected-map')  Map<String, String> selectedMap,  CoreOptions options, @JsonKey(name: 'raw-config')  String rawConfig, @JsonKey(name: 'suspend-on-idle')  bool suspendOnIdle)?  $default,) {final _that = this;
switch (_that) {
case _SetupParams() when $default != null:
return $default(_that.selectedMap,_that.options,_that.rawConfig,_that.suspendOnIdle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SetupParams implements SetupParams {
  const _SetupParams({@JsonKey(name: 'selected-map') required  Map<String, String> selectedMap, required this.options, @JsonKey(name: 'raw-config') this.rawConfig = '', @JsonKey(name: 'suspend-on-idle') this.suspendOnIdle = false}): _selectedMap = selectedMap;
  factory _SetupParams.fromJson(Map<String, dynamic> json) => _$SetupParamsFromJson(json);

 final  Map<String, String> _selectedMap;
@override@JsonKey(name: 'selected-map') Map<String, String> get selectedMap {
  if (_selectedMap is EqualUnmodifiableMapView) return _selectedMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedMap);
}

@override final  CoreOptions options;
@override@JsonKey(name: 'raw-config') final  String rawConfig;
@override@JsonKey(name: 'suspend-on-idle') final  bool suspendOnIdle;

/// Create a copy of SetupParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupParamsCopyWith<_SetupParams> get copyWith => __$SetupParamsCopyWithImpl<_SetupParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetupParamsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupParams&&const DeepCollectionEquality().equals(other.selectedMap, _selectedMap)&&(identical(other.options, options) || other.options == options)&&(identical(other.rawConfig, rawConfig) || other.rawConfig == rawConfig)&&(identical(other.suspendOnIdle, suspendOnIdle) || other.suspendOnIdle == suspendOnIdle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedMap),options,rawConfig,suspendOnIdle);
}

@override
String toString() {
    return 'SetupParams(selectedMap: $selectedMap, options: $options, rawConfig: $rawConfig, suspendOnIdle: $suspendOnIdle)';
}


}

/// @nodoc
abstract mixin class _$SetupParamsCopyWith<$Res> implements $SetupParamsCopyWith<$Res> {
  factory _$SetupParamsCopyWith(_SetupParams value, $Res Function(_SetupParams) _then) = __$SetupParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'selected-map') Map<String, String> selectedMap, CoreOptions options,@JsonKey(name: 'raw-config') String rawConfig,@JsonKey(name: 'suspend-on-idle') bool suspendOnIdle
});


@override $CoreOptionsCopyWith<$Res> get options;

}
/// @nodoc
class __$SetupParamsCopyWithImpl<$Res>
    implements _$SetupParamsCopyWith<$Res> {
  __$SetupParamsCopyWithImpl(this._self, this._then);

  final _SetupParams _self;
  final $Res Function(_SetupParams) _then;

/// Create a copy of SetupParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedMap = null,Object? options = null,Object? rawConfig = null,Object? suspendOnIdle = null,}) {
  return _then(_SetupParams(
selectedMap: null == selectedMap ? _self._selectedMap : selectedMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as CoreOptions,rawConfig: null == rawConfig ? _self.rawConfig : rawConfig // ignore: cast_nullable_to_non_nullable
as String,suspendOnIdle: null == suspendOnIdle ? _self.suspendOnIdle : suspendOnIdle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SetupParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoreOptionsCopyWith<$Res> get options {
  
  return $CoreOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}


/// @nodoc
mixin _$CoreOptions {

@JsonKey(name: 'test-url') String get testUrl;@JsonKey(name: 'delay-test-timeout') int get delayTestTimeout;@JsonKey(name: 'mitm-capture') bool get mitmCapture;
/// Create a copy of CoreOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreOptionsCopyWith<CoreOptions> get copyWith => _$CoreOptionsCopyWithImpl<CoreOptions>(this as CoreOptions, _$identity);

  /// Serializes this CoreOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CoreOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreOptions&&(identical(other.testUrl, _this.testUrl) || other.testUrl == _this.testUrl)&&(identical(other.delayTestTimeout, _this.delayTestTimeout) || other.delayTestTimeout == _this.delayTestTimeout)&&(identical(other.mitmCapture, _this.mitmCapture) || other.mitmCapture == _this.mitmCapture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CoreOptions;
  return Object.hash(runtimeType,_this.testUrl,_this.delayTestTimeout,_this.mitmCapture);
}

@override
String toString() {
  final _this = this as CoreOptions;
  return 'CoreOptions(testUrl: ${_this.testUrl}, delayTestTimeout: ${_this.delayTestTimeout}, mitmCapture: ${_this.mitmCapture})';
}


}

/// @nodoc
abstract mixin class $CoreOptionsCopyWith<$Res>  {
  factory $CoreOptionsCopyWith(CoreOptions value, $Res Function(CoreOptions) _then) = _$CoreOptionsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'test-url') String testUrl,@JsonKey(name: 'delay-test-timeout') int delayTestTimeout,@JsonKey(name: 'mitm-capture') bool mitmCapture
});




}
/// @nodoc
class _$CoreOptionsCopyWithImpl<$Res>
    implements $CoreOptionsCopyWith<$Res> {
  _$CoreOptionsCopyWithImpl(this._self, this._then);

  final CoreOptions _self;
  final $Res Function(CoreOptions) _then;

/// Create a copy of CoreOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? testUrl = null,Object? delayTestTimeout = null,Object? mitmCapture = null,}) {
  return _then(CoreOptions(
testUrl: null == testUrl ? _self.testUrl : testUrl // ignore: cast_nullable_to_non_nullable
as String,delayTestTimeout: null == delayTestTimeout ? _self.delayTestTimeout : delayTestTimeout // ignore: cast_nullable_to_non_nullable
as int,mitmCapture: null == mitmCapture ? _self.mitmCapture : mitmCapture // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CoreOptions].
extension CoreOptionsPatterns on CoreOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoreOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoreOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoreOptions value)  $default,){
final _that = this;
switch (_that) {
case _CoreOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoreOptions value)?  $default,){
final _that = this;
switch (_that) {
case _CoreOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'test-url')  String testUrl, @JsonKey(name: 'delay-test-timeout')  int delayTestTimeout, @JsonKey(name: 'mitm-capture')  bool mitmCapture)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoreOptions() when $default != null:
return $default(_that.testUrl,_that.delayTestTimeout,_that.mitmCapture);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'test-url')  String testUrl, @JsonKey(name: 'delay-test-timeout')  int delayTestTimeout, @JsonKey(name: 'mitm-capture')  bool mitmCapture)  $default,) {final _that = this;
switch (_that) {
case _CoreOptions():
return $default(_that.testUrl,_that.delayTestTimeout,_that.mitmCapture);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'test-url')  String testUrl, @JsonKey(name: 'delay-test-timeout')  int delayTestTimeout, @JsonKey(name: 'mitm-capture')  bool mitmCapture)?  $default,) {final _that = this;
switch (_that) {
case _CoreOptions() when $default != null:
return $default(_that.testUrl,_that.delayTestTimeout,_that.mitmCapture);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoreOptions implements CoreOptions {
  const _CoreOptions({@JsonKey(name: 'test-url') required this.testUrl, @JsonKey(name: 'delay-test-timeout') this.delayTestTimeout = defaultDelayTestTimeout, @JsonKey(name: 'mitm-capture') this.mitmCapture = false});
  factory _CoreOptions.fromJson(Map<String, dynamic> json) => _$CoreOptionsFromJson(json);

@override@JsonKey(name: 'test-url') final  String testUrl;
@override@JsonKey(name: 'delay-test-timeout') final  int delayTestTimeout;
@override@JsonKey(name: 'mitm-capture') final  bool mitmCapture;

/// Create a copy of CoreOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoreOptionsCopyWith<_CoreOptions> get copyWith => __$CoreOptionsCopyWithImpl<_CoreOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoreOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoreOptions&&(identical(other.testUrl, testUrl) || other.testUrl == testUrl)&&(identical(other.delayTestTimeout, delayTestTimeout) || other.delayTestTimeout == delayTestTimeout)&&(identical(other.mitmCapture, mitmCapture) || other.mitmCapture == mitmCapture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,testUrl,delayTestTimeout,mitmCapture);
}

@override
String toString() {
    return 'CoreOptions(testUrl: $testUrl, delayTestTimeout: $delayTestTimeout, mitmCapture: $mitmCapture)';
}


}

/// @nodoc
abstract mixin class _$CoreOptionsCopyWith<$Res> implements $CoreOptionsCopyWith<$Res> {
  factory _$CoreOptionsCopyWith(_CoreOptions value, $Res Function(_CoreOptions) _then) = __$CoreOptionsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'test-url') String testUrl,@JsonKey(name: 'delay-test-timeout') int delayTestTimeout,@JsonKey(name: 'mitm-capture') bool mitmCapture
});




}
/// @nodoc
class __$CoreOptionsCopyWithImpl<$Res>
    implements _$CoreOptionsCopyWith<$Res> {
  __$CoreOptionsCopyWithImpl(this._self, this._then);

  final _CoreOptions _self;
  final $Res Function(_CoreOptions) _then;

/// Create a copy of CoreOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? testUrl = null,Object? delayTestTimeout = null,Object? mitmCapture = null,}) {
  return _then(_CoreOptions(
testUrl: null == testUrl ? _self.testUrl : testUrl // ignore: cast_nullable_to_non_nullable
as String,delayTestTimeout: null == delayTestTimeout ? _self.delayTestTimeout : delayTestTimeout // ignore: cast_nullable_to_non_nullable
as int,mitmCapture: null == mitmCapture ? _self.mitmCapture : mitmCapture // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MitmCertificate {

 String get pem; String get fingerprint; String get subject;@JsonKey(name: 'not-before') DateTime get notBefore;@JsonKey(name: 'not-after') DateTime get notAfter;
/// Create a copy of MitmCertificate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MitmCertificateCopyWith<MitmCertificate> get copyWith => _$MitmCertificateCopyWithImpl<MitmCertificate>(this as MitmCertificate, _$identity);

  /// Serializes this MitmCertificate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MitmCertificate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MitmCertificate&&(identical(other.pem, _this.pem) || other.pem == _this.pem)&&(identical(other.fingerprint, _this.fingerprint) || other.fingerprint == _this.fingerprint)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.notBefore, _this.notBefore) || other.notBefore == _this.notBefore)&&(identical(other.notAfter, _this.notAfter) || other.notAfter == _this.notAfter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MitmCertificate;
  return Object.hash(runtimeType,_this.pem,_this.fingerprint,_this.subject,_this.notBefore,_this.notAfter);
}

@override
String toString() {
  final _this = this as MitmCertificate;
  return 'MitmCertificate(pem: ${_this.pem}, fingerprint: ${_this.fingerprint}, subject: ${_this.subject}, notBefore: ${_this.notBefore}, notAfter: ${_this.notAfter})';
}


}

/// @nodoc
abstract mixin class $MitmCertificateCopyWith<$Res>  {
  factory $MitmCertificateCopyWith(MitmCertificate value, $Res Function(MitmCertificate) _then) = _$MitmCertificateCopyWithImpl;
@useResult
$Res call({
 String pem, String fingerprint, String subject,@JsonKey(name: 'not-before') DateTime notBefore,@JsonKey(name: 'not-after') DateTime notAfter
});




}
/// @nodoc
class _$MitmCertificateCopyWithImpl<$Res>
    implements $MitmCertificateCopyWith<$Res> {
  _$MitmCertificateCopyWithImpl(this._self, this._then);

  final MitmCertificate _self;
  final $Res Function(MitmCertificate) _then;

/// Create a copy of MitmCertificate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pem = null,Object? fingerprint = null,Object? subject = null,Object? notBefore = null,Object? notAfter = null,}) {
  return _then(MitmCertificate(
pem: null == pem ? _self.pem : pem // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,notBefore: null == notBefore ? _self.notBefore : notBefore // ignore: cast_nullable_to_non_nullable
as DateTime,notAfter: null == notAfter ? _self.notAfter : notAfter // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MitmCertificate].
extension MitmCertificatePatterns on MitmCertificate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MitmCertificate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MitmCertificate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MitmCertificate value)  $default,){
final _that = this;
switch (_that) {
case _MitmCertificate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MitmCertificate value)?  $default,){
final _that = this;
switch (_that) {
case _MitmCertificate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pem,  String fingerprint,  String subject, @JsonKey(name: 'not-before')  DateTime notBefore, @JsonKey(name: 'not-after')  DateTime notAfter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MitmCertificate() when $default != null:
return $default(_that.pem,_that.fingerprint,_that.subject,_that.notBefore,_that.notAfter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pem,  String fingerprint,  String subject, @JsonKey(name: 'not-before')  DateTime notBefore, @JsonKey(name: 'not-after')  DateTime notAfter)  $default,) {final _that = this;
switch (_that) {
case _MitmCertificate():
return $default(_that.pem,_that.fingerprint,_that.subject,_that.notBefore,_that.notAfter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pem,  String fingerprint,  String subject, @JsonKey(name: 'not-before')  DateTime notBefore, @JsonKey(name: 'not-after')  DateTime notAfter)?  $default,) {final _that = this;
switch (_that) {
case _MitmCertificate() when $default != null:
return $default(_that.pem,_that.fingerprint,_that.subject,_that.notBefore,_that.notAfter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MitmCertificate implements MitmCertificate {
  const _MitmCertificate({required this.pem, required this.fingerprint, required this.subject, @JsonKey(name: 'not-before') required this.notBefore, @JsonKey(name: 'not-after') required this.notAfter});
  factory _MitmCertificate.fromJson(Map<String, dynamic> json) => _$MitmCertificateFromJson(json);

@override final  String pem;
@override final  String fingerprint;
@override final  String subject;
@override@JsonKey(name: 'not-before') final  DateTime notBefore;
@override@JsonKey(name: 'not-after') final  DateTime notAfter;

/// Create a copy of MitmCertificate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MitmCertificateCopyWith<_MitmCertificate> get copyWith => __$MitmCertificateCopyWithImpl<_MitmCertificate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MitmCertificateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MitmCertificate&&(identical(other.pem, pem) || other.pem == pem)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.notBefore, notBefore) || other.notBefore == notBefore)&&(identical(other.notAfter, notAfter) || other.notAfter == notAfter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,pem,fingerprint,subject,notBefore,notAfter);
}

@override
String toString() {
    return 'MitmCertificate(pem: $pem, fingerprint: $fingerprint, subject: $subject, notBefore: $notBefore, notAfter: $notAfter)';
}


}

/// @nodoc
abstract mixin class _$MitmCertificateCopyWith<$Res> implements $MitmCertificateCopyWith<$Res> {
  factory _$MitmCertificateCopyWith(_MitmCertificate value, $Res Function(_MitmCertificate) _then) = __$MitmCertificateCopyWithImpl;
@override @useResult
$Res call({
 String pem, String fingerprint, String subject,@JsonKey(name: 'not-before') DateTime notBefore,@JsonKey(name: 'not-after') DateTime notAfter
});




}
/// @nodoc
class __$MitmCertificateCopyWithImpl<$Res>
    implements _$MitmCertificateCopyWith<$Res> {
  __$MitmCertificateCopyWithImpl(this._self, this._then);

  final _MitmCertificate _self;
  final $Res Function(_MitmCertificate) _then;

/// Create a copy of MitmCertificate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pem = null,Object? fingerprint = null,Object? subject = null,Object? notBefore = null,Object? notAfter = null,}) {
  return _then(_MitmCertificate(
pem: null == pem ? _self.pem : pem // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,notBefore: null == notBefore ? _self.notBefore : notBefore // ignore: cast_nullable_to_non_nullable
as DateTime,notAfter: null == notAfter ? _self.notAfter : notAfter // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$MitmScriptOutput {

 List<String> get logs; String get result; String get error;
/// Create a copy of MitmScriptOutput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MitmScriptOutputCopyWith<MitmScriptOutput> get copyWith => _$MitmScriptOutputCopyWithImpl<MitmScriptOutput>(this as MitmScriptOutput, _$identity);

  /// Serializes this MitmScriptOutput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MitmScriptOutput;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MitmScriptOutput&&const DeepCollectionEquality().equals(other.logs, _this.logs)&&(identical(other.result, _this.result) || other.result == _this.result)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MitmScriptOutput;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.logs),_this.result,_this.error);
}

@override
String toString() {
  final _this = this as MitmScriptOutput;
  return 'MitmScriptOutput(logs: ${_this.logs}, result: ${_this.result}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $MitmScriptOutputCopyWith<$Res>  {
  factory $MitmScriptOutputCopyWith(MitmScriptOutput value, $Res Function(MitmScriptOutput) _then) = _$MitmScriptOutputCopyWithImpl;
@useResult
$Res call({
 List<String> logs, String result, String error
});




}
/// @nodoc
class _$MitmScriptOutputCopyWithImpl<$Res>
    implements $MitmScriptOutputCopyWith<$Res> {
  _$MitmScriptOutputCopyWithImpl(this._self, this._then);

  final MitmScriptOutput _self;
  final $Res Function(MitmScriptOutput) _then;

/// Create a copy of MitmScriptOutput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? logs = null,Object? result = null,Object? error = null,}) {
  return _then(MitmScriptOutput(
logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as List<String>,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MitmScriptOutput].
extension MitmScriptOutputPatterns on MitmScriptOutput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MitmScriptOutput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MitmScriptOutput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MitmScriptOutput value)  $default,){
final _that = this;
switch (_that) {
case _MitmScriptOutput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MitmScriptOutput value)?  $default,){
final _that = this;
switch (_that) {
case _MitmScriptOutput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> logs,  String result,  String error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MitmScriptOutput() when $default != null:
return $default(_that.logs,_that.result,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> logs,  String result,  String error)  $default,) {final _that = this;
switch (_that) {
case _MitmScriptOutput():
return $default(_that.logs,_that.result,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> logs,  String result,  String error)?  $default,) {final _that = this;
switch (_that) {
case _MitmScriptOutput() when $default != null:
return $default(_that.logs,_that.result,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MitmScriptOutput implements MitmScriptOutput {
  const _MitmScriptOutput({ List<String> logs = const [], this.result = '', this.error = ''}): _logs = logs;
  factory _MitmScriptOutput.fromJson(Map<String, dynamic> json) => _$MitmScriptOutputFromJson(json);

 final  List<String> _logs;
@override@JsonKey() List<String> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override@JsonKey() final  String result;
@override@JsonKey() final  String error;

/// Create a copy of MitmScriptOutput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MitmScriptOutputCopyWith<_MitmScriptOutput> get copyWith => __$MitmScriptOutputCopyWithImpl<_MitmScriptOutput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MitmScriptOutputToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MitmScriptOutput&&const DeepCollectionEquality().equals(other.logs, _logs)&&(identical(other.result, result) || other.result == result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_logs),result,error);
}

@override
String toString() {
    return 'MitmScriptOutput(logs: $logs, result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class _$MitmScriptOutputCopyWith<$Res> implements $MitmScriptOutputCopyWith<$Res> {
  factory _$MitmScriptOutputCopyWith(_MitmScriptOutput value, $Res Function(_MitmScriptOutput) _then) = __$MitmScriptOutputCopyWithImpl;
@override @useResult
$Res call({
 List<String> logs, String result, String error
});




}
/// @nodoc
class __$MitmScriptOutputCopyWithImpl<$Res>
    implements _$MitmScriptOutputCopyWith<$Res> {
  __$MitmScriptOutputCopyWithImpl(this._self, this._then);

  final _MitmScriptOutput _self;
  final $Res Function(_MitmScriptOutput) _then;

/// Create a copy of MitmScriptOutput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logs = null,Object? result = null,Object? error = null,}) {
  return _then(_MitmScriptOutput(
logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<String>,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MitmExchangeSummary {

 int get id; DateTime get start; bool get pending; int get duration; String get method; String get url; int get status;@JsonKey(name: 'request-size') int get requestSize;@JsonKey(name: 'response-size') int get responseSize; String get error;
/// Create a copy of MitmExchangeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MitmExchangeSummaryCopyWith<MitmExchangeSummary> get copyWith => _$MitmExchangeSummaryCopyWithImpl<MitmExchangeSummary>(this as MitmExchangeSummary, _$identity);

  /// Serializes this MitmExchangeSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MitmExchangeSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MitmExchangeSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.start, _this.start) || other.start == _this.start)&&(identical(other.pending, _this.pending) || other.pending == _this.pending)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.requestSize, _this.requestSize) || other.requestSize == _this.requestSize)&&(identical(other.responseSize, _this.responseSize) || other.responseSize == _this.responseSize)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MitmExchangeSummary;
  return Object.hash(runtimeType,_this.id,_this.start,_this.pending,_this.duration,_this.method,_this.url,_this.status,_this.requestSize,_this.responseSize,_this.error);
}

@override
String toString() {
  final _this = this as MitmExchangeSummary;
  return 'MitmExchangeSummary(id: ${_this.id}, start: ${_this.start}, pending: ${_this.pending}, duration: ${_this.duration}, method: ${_this.method}, url: ${_this.url}, status: ${_this.status}, requestSize: ${_this.requestSize}, responseSize: ${_this.responseSize}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $MitmExchangeSummaryCopyWith<$Res>  {
  factory $MitmExchangeSummaryCopyWith(MitmExchangeSummary value, $Res Function(MitmExchangeSummary) _then) = _$MitmExchangeSummaryCopyWithImpl;
@useResult
$Res call({
 int id, DateTime start, bool pending, int duration, String method, String url, int status,@JsonKey(name: 'request-size') int requestSize,@JsonKey(name: 'response-size') int responseSize, String error
});




}
/// @nodoc
class _$MitmExchangeSummaryCopyWithImpl<$Res>
    implements $MitmExchangeSummaryCopyWith<$Res> {
  _$MitmExchangeSummaryCopyWithImpl(this._self, this._then);

  final MitmExchangeSummary _self;
  final $Res Function(MitmExchangeSummary) _then;

/// Create a copy of MitmExchangeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? start = null,Object? pending = null,Object? duration = null,Object? method = null,Object? url = null,Object? status = null,Object? requestSize = null,Object? responseSize = null,Object? error = null,}) {
  return _then(MitmExchangeSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,requestSize: null == requestSize ? _self.requestSize : requestSize // ignore: cast_nullable_to_non_nullable
as int,responseSize: null == responseSize ? _self.responseSize : responseSize // ignore: cast_nullable_to_non_nullable
as int,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MitmExchangeSummary].
extension MitmExchangeSummaryPatterns on MitmExchangeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MitmExchangeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MitmExchangeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MitmExchangeSummary value)  $default,){
final _that = this;
switch (_that) {
case _MitmExchangeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MitmExchangeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MitmExchangeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime start,  bool pending,  int duration,  String method,  String url,  int status, @JsonKey(name: 'request-size')  int requestSize, @JsonKey(name: 'response-size')  int responseSize,  String error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MitmExchangeSummary() when $default != null:
return $default(_that.id,_that.start,_that.pending,_that.duration,_that.method,_that.url,_that.status,_that.requestSize,_that.responseSize,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime start,  bool pending,  int duration,  String method,  String url,  int status, @JsonKey(name: 'request-size')  int requestSize, @JsonKey(name: 'response-size')  int responseSize,  String error)  $default,) {final _that = this;
switch (_that) {
case _MitmExchangeSummary():
return $default(_that.id,_that.start,_that.pending,_that.duration,_that.method,_that.url,_that.status,_that.requestSize,_that.responseSize,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime start,  bool pending,  int duration,  String method,  String url,  int status, @JsonKey(name: 'request-size')  int requestSize, @JsonKey(name: 'response-size')  int responseSize,  String error)?  $default,) {final _that = this;
switch (_that) {
case _MitmExchangeSummary() when $default != null:
return $default(_that.id,_that.start,_that.pending,_that.duration,_that.method,_that.url,_that.status,_that.requestSize,_that.responseSize,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MitmExchangeSummary implements MitmExchangeSummary {
  const _MitmExchangeSummary({required this.id, required this.start, this.pending = false, this.duration = 0, this.method = '', this.url = '', this.status = 0, @JsonKey(name: 'request-size') this.requestSize = 0, @JsonKey(name: 'response-size') this.responseSize = 0, this.error = ''});
  factory _MitmExchangeSummary.fromJson(Map<String, dynamic> json) => _$MitmExchangeSummaryFromJson(json);

@override final  int id;
@override final  DateTime start;
@override@JsonKey() final  bool pending;
@override@JsonKey() final  int duration;
@override@JsonKey() final  String method;
@override@JsonKey() final  String url;
@override@JsonKey() final  int status;
@override@JsonKey(name: 'request-size') final  int requestSize;
@override@JsonKey(name: 'response-size') final  int responseSize;
@override@JsonKey() final  String error;

/// Create a copy of MitmExchangeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MitmExchangeSummaryCopyWith<_MitmExchangeSummary> get copyWith => __$MitmExchangeSummaryCopyWithImpl<_MitmExchangeSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MitmExchangeSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MitmExchangeSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.start, start) || other.start == start)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestSize, requestSize) || other.requestSize == requestSize)&&(identical(other.responseSize, responseSize) || other.responseSize == responseSize)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,start,pending,duration,method,url,status,requestSize,responseSize,error);
}

@override
String toString() {
    return 'MitmExchangeSummary(id: $id, start: $start, pending: $pending, duration: $duration, method: $method, url: $url, status: $status, requestSize: $requestSize, responseSize: $responseSize, error: $error)';
}


}

/// @nodoc
abstract mixin class _$MitmExchangeSummaryCopyWith<$Res> implements $MitmExchangeSummaryCopyWith<$Res> {
  factory _$MitmExchangeSummaryCopyWith(_MitmExchangeSummary value, $Res Function(_MitmExchangeSummary) _then) = __$MitmExchangeSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime start, bool pending, int duration, String method, String url, int status,@JsonKey(name: 'request-size') int requestSize,@JsonKey(name: 'response-size') int responseSize, String error
});




}
/// @nodoc
class __$MitmExchangeSummaryCopyWithImpl<$Res>
    implements _$MitmExchangeSummaryCopyWith<$Res> {
  __$MitmExchangeSummaryCopyWithImpl(this._self, this._then);

  final _MitmExchangeSummary _self;
  final $Res Function(_MitmExchangeSummary) _then;

/// Create a copy of MitmExchangeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? start = null,Object? pending = null,Object? duration = null,Object? method = null,Object? url = null,Object? status = null,Object? requestSize = null,Object? responseSize = null,Object? error = null,}) {
  return _then(_MitmExchangeSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,requestSize: null == requestSize ? _self.requestSize : requestSize // ignore: cast_nullable_to_non_nullable
as int,responseSize: null == responseSize ? _self.responseSize : responseSize // ignore: cast_nullable_to_non_nullable
as int,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MitmExchangeList {

 bool get capturing; DateTime? get since; List<MitmExchangeSummary> get exchanges; bool get closed;
/// Create a copy of MitmExchangeList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MitmExchangeListCopyWith<MitmExchangeList> get copyWith => _$MitmExchangeListCopyWithImpl<MitmExchangeList>(this as MitmExchangeList, _$identity);

  /// Serializes this MitmExchangeList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MitmExchangeList;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MitmExchangeList&&(identical(other.capturing, _this.capturing) || other.capturing == _this.capturing)&&(identical(other.since, _this.since) || other.since == _this.since)&&const DeepCollectionEquality().equals(other.exchanges, _this.exchanges)&&(identical(other.closed, _this.closed) || other.closed == _this.closed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MitmExchangeList;
  return Object.hash(runtimeType,_this.capturing,_this.since,const DeepCollectionEquality().hash(_this.exchanges),_this.closed);
}

@override
String toString() {
  final _this = this as MitmExchangeList;
  return 'MitmExchangeList(capturing: ${_this.capturing}, since: ${_this.since}, exchanges: ${_this.exchanges}, closed: ${_this.closed})';
}


}

/// @nodoc
abstract mixin class $MitmExchangeListCopyWith<$Res>  {
  factory $MitmExchangeListCopyWith(MitmExchangeList value, $Res Function(MitmExchangeList) _then) = _$MitmExchangeListCopyWithImpl;
@useResult
$Res call({
 bool capturing, DateTime? since, List<MitmExchangeSummary> exchanges, bool closed
});




}
/// @nodoc
class _$MitmExchangeListCopyWithImpl<$Res>
    implements $MitmExchangeListCopyWith<$Res> {
  _$MitmExchangeListCopyWithImpl(this._self, this._then);

  final MitmExchangeList _self;
  final $Res Function(MitmExchangeList) _then;

/// Create a copy of MitmExchangeList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? capturing = null,Object? since = freezed,Object? exchanges = null,Object? closed = null,}) {
  return _then(MitmExchangeList(
capturing: null == capturing ? _self.capturing : capturing // ignore: cast_nullable_to_non_nullable
as bool,since: freezed == since ? _self.since : since // ignore: cast_nullable_to_non_nullable
as DateTime?,exchanges: null == exchanges ? _self.exchanges : exchanges // ignore: cast_nullable_to_non_nullable
as List<MitmExchangeSummary>,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MitmExchangeList].
extension MitmExchangeListPatterns on MitmExchangeList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MitmExchangeList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MitmExchangeList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MitmExchangeList value)  $default,){
final _that = this;
switch (_that) {
case _MitmExchangeList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MitmExchangeList value)?  $default,){
final _that = this;
switch (_that) {
case _MitmExchangeList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool capturing,  DateTime? since,  List<MitmExchangeSummary> exchanges,  bool closed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MitmExchangeList() when $default != null:
return $default(_that.capturing,_that.since,_that.exchanges,_that.closed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool capturing,  DateTime? since,  List<MitmExchangeSummary> exchanges,  bool closed)  $default,) {final _that = this;
switch (_that) {
case _MitmExchangeList():
return $default(_that.capturing,_that.since,_that.exchanges,_that.closed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool capturing,  DateTime? since,  List<MitmExchangeSummary> exchanges,  bool closed)?  $default,) {final _that = this;
switch (_that) {
case _MitmExchangeList() when $default != null:
return $default(_that.capturing,_that.since,_that.exchanges,_that.closed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MitmExchangeList implements MitmExchangeList {
  const _MitmExchangeList({this.capturing = false, this.since,  List<MitmExchangeSummary> exchanges = const [], this.closed = false}): _exchanges = exchanges;
  factory _MitmExchangeList.fromJson(Map<String, dynamic> json) => _$MitmExchangeListFromJson(json);

@override@JsonKey() final  bool capturing;
@override final  DateTime? since;
 final  List<MitmExchangeSummary> _exchanges;
@override@JsonKey() List<MitmExchangeSummary> get exchanges {
  if (_exchanges is EqualUnmodifiableListView) return _exchanges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exchanges);
}

@override@JsonKey() final  bool closed;

/// Create a copy of MitmExchangeList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MitmExchangeListCopyWith<_MitmExchangeList> get copyWith => __$MitmExchangeListCopyWithImpl<_MitmExchangeList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MitmExchangeListToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MitmExchangeList&&(identical(other.capturing, capturing) || other.capturing == capturing)&&(identical(other.since, since) || other.since == since)&&const DeepCollectionEquality().equals(other.exchanges, _exchanges)&&(identical(other.closed, closed) || other.closed == closed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,capturing,since,const DeepCollectionEquality().hash(_exchanges),closed);
}

@override
String toString() {
    return 'MitmExchangeList(capturing: $capturing, since: $since, exchanges: $exchanges, closed: $closed)';
}


}

/// @nodoc
abstract mixin class _$MitmExchangeListCopyWith<$Res> implements $MitmExchangeListCopyWith<$Res> {
  factory _$MitmExchangeListCopyWith(_MitmExchangeList value, $Res Function(_MitmExchangeList) _then) = __$MitmExchangeListCopyWithImpl;
@override @useResult
$Res call({
 bool capturing, DateTime? since, List<MitmExchangeSummary> exchanges, bool closed
});




}
/// @nodoc
class __$MitmExchangeListCopyWithImpl<$Res>
    implements _$MitmExchangeListCopyWith<$Res> {
  __$MitmExchangeListCopyWithImpl(this._self, this._then);

  final _MitmExchangeList _self;
  final $Res Function(_MitmExchangeList) _then;

/// Create a copy of MitmExchangeList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? capturing = null,Object? since = freezed,Object? exchanges = null,Object? closed = null,}) {
  return _then(_MitmExchangeList(
capturing: null == capturing ? _self.capturing : capturing // ignore: cast_nullable_to_non_nullable
as bool,since: freezed == since ? _self.since : since // ignore: cast_nullable_to_non_nullable
as DateTime?,exchanges: null == exchanges ? _self._exchanges : exchanges // ignore: cast_nullable_to_non_nullable
as List<MitmExchangeSummary>,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MitmAction {

 String get kind; String get phase; String get detail;
/// Create a copy of MitmAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MitmActionCopyWith<MitmAction> get copyWith => _$MitmActionCopyWithImpl<MitmAction>(this as MitmAction, _$identity);

  /// Serializes this MitmAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MitmAction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MitmAction&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.phase, _this.phase) || other.phase == _this.phase)&&(identical(other.detail, _this.detail) || other.detail == _this.detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MitmAction;
  return Object.hash(runtimeType,_this.kind,_this.phase,_this.detail);
}

@override
String toString() {
  final _this = this as MitmAction;
  return 'MitmAction(kind: ${_this.kind}, phase: ${_this.phase}, detail: ${_this.detail})';
}


}

/// @nodoc
abstract mixin class $MitmActionCopyWith<$Res>  {
  factory $MitmActionCopyWith(MitmAction value, $Res Function(MitmAction) _then) = _$MitmActionCopyWithImpl;
@useResult
$Res call({
 String kind, String phase, String detail
});




}
/// @nodoc
class _$MitmActionCopyWithImpl<$Res>
    implements $MitmActionCopyWith<$Res> {
  _$MitmActionCopyWithImpl(this._self, this._then);

  final MitmAction _self;
  final $Res Function(MitmAction) _then;

/// Create a copy of MitmAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? phase = null,Object? detail = null,}) {
  return _then(MitmAction(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MitmAction].
extension MitmActionPatterns on MitmAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MitmAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MitmAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MitmAction value)  $default,){
final _that = this;
switch (_that) {
case _MitmAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MitmAction value)?  $default,){
final _that = this;
switch (_that) {
case _MitmAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String kind,  String phase,  String detail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MitmAction() when $default != null:
return $default(_that.kind,_that.phase,_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String kind,  String phase,  String detail)  $default,) {final _that = this;
switch (_that) {
case _MitmAction():
return $default(_that.kind,_that.phase,_that.detail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String kind,  String phase,  String detail)?  $default,) {final _that = this;
switch (_that) {
case _MitmAction() when $default != null:
return $default(_that.kind,_that.phase,_that.detail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MitmAction implements MitmAction {
  const _MitmAction({required this.kind, this.phase = '', this.detail = ''});
  factory _MitmAction.fromJson(Map<String, dynamic> json) => _$MitmActionFromJson(json);

@override final  String kind;
@override@JsonKey() final  String phase;
@override@JsonKey() final  String detail;

/// Create a copy of MitmAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MitmActionCopyWith<_MitmAction> get copyWith => __$MitmActionCopyWithImpl<_MitmAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MitmActionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MitmAction&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.detail, detail) || other.detail == detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,kind,phase,detail);
}

@override
String toString() {
    return 'MitmAction(kind: $kind, phase: $phase, detail: $detail)';
}


}

/// @nodoc
abstract mixin class _$MitmActionCopyWith<$Res> implements $MitmActionCopyWith<$Res> {
  factory _$MitmActionCopyWith(_MitmAction value, $Res Function(_MitmAction) _then) = __$MitmActionCopyWithImpl;
@override @useResult
$Res call({
 String kind, String phase, String detail
});




}
/// @nodoc
class __$MitmActionCopyWithImpl<$Res>
    implements _$MitmActionCopyWith<$Res> {
  __$MitmActionCopyWithImpl(this._self, this._then);

  final _MitmAction _self;
  final $Res Function(_MitmAction) _then;

/// Create a copy of MitmAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? phase = null,Object? detail = null,}) {
  return _then(_MitmAction(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MitmExchange {

 int get id; DateTime get start; bool get pending; int get duration; int get ttfb; String get method; String get url;@JsonKey(name: 'original-url') String get originalUrl; String get proto; int get status;@JsonKey(name: 'request-size') int get requestSize;@JsonKey(name: 'response-size') int get responseSize; String get error; String get connection;@JsonKey(name: 'request-header') Map<String, List<String>> get requestHeader;@JsonKey(name: 'response-header') Map<String, List<String>> get responseHeader; List<MitmAction> get actions;
/// Create a copy of MitmExchange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MitmExchangeCopyWith<MitmExchange> get copyWith => _$MitmExchangeCopyWithImpl<MitmExchange>(this as MitmExchange, _$identity);

  /// Serializes this MitmExchange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MitmExchange;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MitmExchange&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.start, _this.start) || other.start == _this.start)&&(identical(other.pending, _this.pending) || other.pending == _this.pending)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.ttfb, _this.ttfb) || other.ttfb == _this.ttfb)&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.originalUrl, _this.originalUrl) || other.originalUrl == _this.originalUrl)&&(identical(other.proto, _this.proto) || other.proto == _this.proto)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.requestSize, _this.requestSize) || other.requestSize == _this.requestSize)&&(identical(other.responseSize, _this.responseSize) || other.responseSize == _this.responseSize)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.connection, _this.connection) || other.connection == _this.connection)&&const DeepCollectionEquality().equals(other.requestHeader, _this.requestHeader)&&const DeepCollectionEquality().equals(other.responseHeader, _this.responseHeader)&&const DeepCollectionEquality().equals(other.actions, _this.actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MitmExchange;
  return Object.hash(runtimeType,_this.id,_this.start,_this.pending,_this.duration,_this.ttfb,_this.method,_this.url,_this.originalUrl,_this.proto,_this.status,_this.requestSize,_this.responseSize,_this.error,_this.connection,const DeepCollectionEquality().hash(_this.requestHeader),const DeepCollectionEquality().hash(_this.responseHeader),const DeepCollectionEquality().hash(_this.actions));
}

@override
String toString() {
  final _this = this as MitmExchange;
  return 'MitmExchange(id: ${_this.id}, start: ${_this.start}, pending: ${_this.pending}, duration: ${_this.duration}, ttfb: ${_this.ttfb}, method: ${_this.method}, url: ${_this.url}, originalUrl: ${_this.originalUrl}, proto: ${_this.proto}, status: ${_this.status}, requestSize: ${_this.requestSize}, responseSize: ${_this.responseSize}, error: ${_this.error}, connection: ${_this.connection}, requestHeader: ${_this.requestHeader}, responseHeader: ${_this.responseHeader}, actions: ${_this.actions})';
}


}

/// @nodoc
abstract mixin class $MitmExchangeCopyWith<$Res>  {
  factory $MitmExchangeCopyWith(MitmExchange value, $Res Function(MitmExchange) _then) = _$MitmExchangeCopyWithImpl;
@useResult
$Res call({
 int id, DateTime start, bool pending, int duration, int ttfb, String method, String url,@JsonKey(name: 'original-url') String originalUrl, String proto, int status,@JsonKey(name: 'request-size') int requestSize,@JsonKey(name: 'response-size') int responseSize, String error, String connection,@JsonKey(name: 'request-header') Map<String, List<String>> requestHeader,@JsonKey(name: 'response-header') Map<String, List<String>> responseHeader, List<MitmAction> actions
});




}
/// @nodoc
class _$MitmExchangeCopyWithImpl<$Res>
    implements $MitmExchangeCopyWith<$Res> {
  _$MitmExchangeCopyWithImpl(this._self, this._then);

  final MitmExchange _self;
  final $Res Function(MitmExchange) _then;

/// Create a copy of MitmExchange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? start = null,Object? pending = null,Object? duration = null,Object? ttfb = null,Object? method = null,Object? url = null,Object? originalUrl = null,Object? proto = null,Object? status = null,Object? requestSize = null,Object? responseSize = null,Object? error = null,Object? connection = null,Object? requestHeader = null,Object? responseHeader = null,Object? actions = null,}) {
  return _then(MitmExchange(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,ttfb: null == ttfb ? _self.ttfb : ttfb // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,originalUrl: null == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String,proto: null == proto ? _self.proto : proto // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,requestSize: null == requestSize ? _self.requestSize : requestSize // ignore: cast_nullable_to_non_nullable
as int,responseSize: null == responseSize ? _self.responseSize : responseSize // ignore: cast_nullable_to_non_nullable
as int,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as String,requestHeader: null == requestHeader ? _self.requestHeader : requestHeader // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,responseHeader: null == responseHeader ? _self.responseHeader : responseHeader // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<MitmAction>,
  ));
}

}


/// Adds pattern-matching-related methods to [MitmExchange].
extension MitmExchangePatterns on MitmExchange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MitmExchange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MitmExchange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MitmExchange value)  $default,){
final _that = this;
switch (_that) {
case _MitmExchange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MitmExchange value)?  $default,){
final _that = this;
switch (_that) {
case _MitmExchange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime start,  bool pending,  int duration,  int ttfb,  String method,  String url, @JsonKey(name: 'original-url')  String originalUrl,  String proto,  int status, @JsonKey(name: 'request-size')  int requestSize, @JsonKey(name: 'response-size')  int responseSize,  String error,  String connection, @JsonKey(name: 'request-header')  Map<String, List<String>> requestHeader, @JsonKey(name: 'response-header')  Map<String, List<String>> responseHeader,  List<MitmAction> actions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MitmExchange() when $default != null:
return $default(_that.id,_that.start,_that.pending,_that.duration,_that.ttfb,_that.method,_that.url,_that.originalUrl,_that.proto,_that.status,_that.requestSize,_that.responseSize,_that.error,_that.connection,_that.requestHeader,_that.responseHeader,_that.actions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime start,  bool pending,  int duration,  int ttfb,  String method,  String url, @JsonKey(name: 'original-url')  String originalUrl,  String proto,  int status, @JsonKey(name: 'request-size')  int requestSize, @JsonKey(name: 'response-size')  int responseSize,  String error,  String connection, @JsonKey(name: 'request-header')  Map<String, List<String>> requestHeader, @JsonKey(name: 'response-header')  Map<String, List<String>> responseHeader,  List<MitmAction> actions)  $default,) {final _that = this;
switch (_that) {
case _MitmExchange():
return $default(_that.id,_that.start,_that.pending,_that.duration,_that.ttfb,_that.method,_that.url,_that.originalUrl,_that.proto,_that.status,_that.requestSize,_that.responseSize,_that.error,_that.connection,_that.requestHeader,_that.responseHeader,_that.actions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime start,  bool pending,  int duration,  int ttfb,  String method,  String url, @JsonKey(name: 'original-url')  String originalUrl,  String proto,  int status, @JsonKey(name: 'request-size')  int requestSize, @JsonKey(name: 'response-size')  int responseSize,  String error,  String connection, @JsonKey(name: 'request-header')  Map<String, List<String>> requestHeader, @JsonKey(name: 'response-header')  Map<String, List<String>> responseHeader,  List<MitmAction> actions)?  $default,) {final _that = this;
switch (_that) {
case _MitmExchange() when $default != null:
return $default(_that.id,_that.start,_that.pending,_that.duration,_that.ttfb,_that.method,_that.url,_that.originalUrl,_that.proto,_that.status,_that.requestSize,_that.responseSize,_that.error,_that.connection,_that.requestHeader,_that.responseHeader,_that.actions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MitmExchange implements MitmExchange {
  const _MitmExchange({required this.id, required this.start, this.pending = false, this.duration = 0, this.ttfb = 0, this.method = '', this.url = '', @JsonKey(name: 'original-url') this.originalUrl = '', this.proto = '', this.status = 0, @JsonKey(name: 'request-size') this.requestSize = 0, @JsonKey(name: 'response-size') this.responseSize = 0, this.error = '', this.connection = '', @JsonKey(name: 'request-header')  Map<String, List<String>> requestHeader = const {}, @JsonKey(name: 'response-header')  Map<String, List<String>> responseHeader = const {},  List<MitmAction> actions = const []}): _requestHeader = requestHeader,_responseHeader = responseHeader,_actions = actions;
  factory _MitmExchange.fromJson(Map<String, dynamic> json) => _$MitmExchangeFromJson(json);

@override final  int id;
@override final  DateTime start;
@override@JsonKey() final  bool pending;
@override@JsonKey() final  int duration;
@override@JsonKey() final  int ttfb;
@override@JsonKey() final  String method;
@override@JsonKey() final  String url;
@override@JsonKey(name: 'original-url') final  String originalUrl;
@override@JsonKey() final  String proto;
@override@JsonKey() final  int status;
@override@JsonKey(name: 'request-size') final  int requestSize;
@override@JsonKey(name: 'response-size') final  int responseSize;
@override@JsonKey() final  String error;
@override@JsonKey() final  String connection;
 final  Map<String, List<String>> _requestHeader;
@override@JsonKey(name: 'request-header') Map<String, List<String>> get requestHeader {
  if (_requestHeader is EqualUnmodifiableMapView) return _requestHeader;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requestHeader);
}

 final  Map<String, List<String>> _responseHeader;
@override@JsonKey(name: 'response-header') Map<String, List<String>> get responseHeader {
  if (_responseHeader is EqualUnmodifiableMapView) return _responseHeader;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_responseHeader);
}

 final  List<MitmAction> _actions;
@override@JsonKey() List<MitmAction> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}


/// Create a copy of MitmExchange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MitmExchangeCopyWith<_MitmExchange> get copyWith => __$MitmExchangeCopyWithImpl<_MitmExchange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MitmExchangeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MitmExchange&&(identical(other.id, id) || other.id == id)&&(identical(other.start, start) || other.start == start)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.ttfb, ttfb) || other.ttfb == ttfb)&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.proto, proto) || other.proto == proto)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestSize, requestSize) || other.requestSize == requestSize)&&(identical(other.responseSize, responseSize) || other.responseSize == responseSize)&&(identical(other.error, error) || other.error == error)&&(identical(other.connection, connection) || other.connection == connection)&&const DeepCollectionEquality().equals(other.requestHeader, _requestHeader)&&const DeepCollectionEquality().equals(other.responseHeader, _responseHeader)&&const DeepCollectionEquality().equals(other.actions, _actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,start,pending,duration,ttfb,method,url,originalUrl,proto,status,requestSize,responseSize,error,connection,const DeepCollectionEquality().hash(_requestHeader),const DeepCollectionEquality().hash(_responseHeader),const DeepCollectionEquality().hash(_actions));
}

@override
String toString() {
    return 'MitmExchange(id: $id, start: $start, pending: $pending, duration: $duration, ttfb: $ttfb, method: $method, url: $url, originalUrl: $originalUrl, proto: $proto, status: $status, requestSize: $requestSize, responseSize: $responseSize, error: $error, connection: $connection, requestHeader: $requestHeader, responseHeader: $responseHeader, actions: $actions)';
}


}

/// @nodoc
abstract mixin class _$MitmExchangeCopyWith<$Res> implements $MitmExchangeCopyWith<$Res> {
  factory _$MitmExchangeCopyWith(_MitmExchange value, $Res Function(_MitmExchange) _then) = __$MitmExchangeCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime start, bool pending, int duration, int ttfb, String method, String url,@JsonKey(name: 'original-url') String originalUrl, String proto, int status,@JsonKey(name: 'request-size') int requestSize,@JsonKey(name: 'response-size') int responseSize, String error, String connection,@JsonKey(name: 'request-header') Map<String, List<String>> requestHeader,@JsonKey(name: 'response-header') Map<String, List<String>> responseHeader, List<MitmAction> actions
});




}
/// @nodoc
class __$MitmExchangeCopyWithImpl<$Res>
    implements _$MitmExchangeCopyWith<$Res> {
  __$MitmExchangeCopyWithImpl(this._self, this._then);

  final _MitmExchange _self;
  final $Res Function(_MitmExchange) _then;

/// Create a copy of MitmExchange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? start = null,Object? pending = null,Object? duration = null,Object? ttfb = null,Object? method = null,Object? url = null,Object? originalUrl = null,Object? proto = null,Object? status = null,Object? requestSize = null,Object? responseSize = null,Object? error = null,Object? connection = null,Object? requestHeader = null,Object? responseHeader = null,Object? actions = null,}) {
  return _then(_MitmExchange(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,ttfb: null == ttfb ? _self.ttfb : ttfb // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,originalUrl: null == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String,proto: null == proto ? _self.proto : proto // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,requestSize: null == requestSize ? _self.requestSize : requestSize // ignore: cast_nullable_to_non_nullable
as int,responseSize: null == responseSize ? _self.responseSize : responseSize // ignore: cast_nullable_to_non_nullable
as int,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as String,requestHeader: null == requestHeader ? _self._requestHeader : requestHeader // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,responseHeader: null == responseHeader ? _self._responseHeader : responseHeader // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<MitmAction>,
  ));
}


}


/// @nodoc
mixin _$MitmBody {

 String get data; bool get truncated; String get encoding;
/// Create a copy of MitmBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MitmBodyCopyWith<MitmBody> get copyWith => _$MitmBodyCopyWithImpl<MitmBody>(this as MitmBody, _$identity);

  /// Serializes this MitmBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MitmBody;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MitmBody&&(identical(other.data, _this.data) || other.data == _this.data)&&(identical(other.truncated, _this.truncated) || other.truncated == _this.truncated)&&(identical(other.encoding, _this.encoding) || other.encoding == _this.encoding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MitmBody;
  return Object.hash(runtimeType,_this.data,_this.truncated,_this.encoding);
}

@override
String toString() {
  final _this = this as MitmBody;
  return 'MitmBody(data: ${_this.data}, truncated: ${_this.truncated}, encoding: ${_this.encoding})';
}


}

/// @nodoc
abstract mixin class $MitmBodyCopyWith<$Res>  {
  factory $MitmBodyCopyWith(MitmBody value, $Res Function(MitmBody) _then) = _$MitmBodyCopyWithImpl;
@useResult
$Res call({
 String data, bool truncated, String encoding
});




}
/// @nodoc
class _$MitmBodyCopyWithImpl<$Res>
    implements $MitmBodyCopyWith<$Res> {
  _$MitmBodyCopyWithImpl(this._self, this._then);

  final MitmBody _self;
  final $Res Function(MitmBody) _then;

/// Create a copy of MitmBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? truncated = null,Object? encoding = null,}) {
  return _then(MitmBody(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,truncated: null == truncated ? _self.truncated : truncated // ignore: cast_nullable_to_non_nullable
as bool,encoding: null == encoding ? _self.encoding : encoding // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MitmBody].
extension MitmBodyPatterns on MitmBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MitmBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MitmBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MitmBody value)  $default,){
final _that = this;
switch (_that) {
case _MitmBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MitmBody value)?  $default,){
final _that = this;
switch (_that) {
case _MitmBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String data,  bool truncated,  String encoding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MitmBody() when $default != null:
return $default(_that.data,_that.truncated,_that.encoding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String data,  bool truncated,  String encoding)  $default,) {final _that = this;
switch (_that) {
case _MitmBody():
return $default(_that.data,_that.truncated,_that.encoding);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String data,  bool truncated,  String encoding)?  $default,) {final _that = this;
switch (_that) {
case _MitmBody() when $default != null:
return $default(_that.data,_that.truncated,_that.encoding);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MitmBody implements MitmBody {
  const _MitmBody({this.data = '', this.truncated = false, this.encoding = ''});
  factory _MitmBody.fromJson(Map<String, dynamic> json) => _$MitmBodyFromJson(json);

@override@JsonKey() final  String data;
@override@JsonKey() final  bool truncated;
@override@JsonKey() final  String encoding;

/// Create a copy of MitmBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MitmBodyCopyWith<_MitmBody> get copyWith => __$MitmBodyCopyWithImpl<_MitmBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MitmBodyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MitmBody&&(identical(other.data, data) || other.data == data)&&(identical(other.truncated, truncated) || other.truncated == truncated)&&(identical(other.encoding, encoding) || other.encoding == encoding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,data,truncated,encoding);
}

@override
String toString() {
    return 'MitmBody(data: $data, truncated: $truncated, encoding: $encoding)';
}


}

/// @nodoc
abstract mixin class _$MitmBodyCopyWith<$Res> implements $MitmBodyCopyWith<$Res> {
  factory _$MitmBodyCopyWith(_MitmBody value, $Res Function(_MitmBody) _then) = __$MitmBodyCopyWithImpl;
@override @useResult
$Res call({
 String data, bool truncated, String encoding
});




}
/// @nodoc
class __$MitmBodyCopyWithImpl<$Res>
    implements _$MitmBodyCopyWith<$Res> {
  __$MitmBodyCopyWithImpl(this._self, this._then);

  final _MitmBody _self;
  final $Res Function(_MitmBody) _then;

/// Create a copy of MitmBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? truncated = null,Object? encoding = null,}) {
  return _then(_MitmBody(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,truncated: null == truncated ? _self.truncated : truncated // ignore: cast_nullable_to_non_nullable
as bool,encoding: null == encoding ? _self.encoding : encoding // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UpdateParams {

@JsonKey(toJson: _tunCoreJson) Tun get tun;@JsonKey(name: 'mixed-port') int get mixedPort;@JsonKey(name: 'allow-lan') bool get allowLan;@JsonKey(name: 'find-process-mode') FindProcessMode get findProcessMode; Mode get mode;@JsonKey(name: 'log-level') LogLevel get logLevel; bool? get ipv6;@JsonKey(name: 'tcp-concurrent') bool? get tcpConcurrent;@JsonKey(name: 'external-controller') String get externalController; String get secret;@JsonKey(name: 'unified-delay') bool? get unifiedDelay;@JsonKey(name: 'geo-auto-update') bool get geoAutoUpdate;@JsonKey(name: 'geo-update-interval') int get geoUpdateInterval;@JsonKey(name: 'geox-url') Map<String, String> get geoXUrl;@JsonKey(name: 'suspend-on-idle') bool get suspendOnIdle; CoreOptions get options; List<String> get authentication;
/// Create a copy of UpdateParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateParamsCopyWith<UpdateParams> get copyWith => _$UpdateParamsCopyWithImpl<UpdateParams>(this as UpdateParams, _$identity);

  /// Serializes this UpdateParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpdateParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateParams&&(identical(other.tun, _this.tun) || other.tun == _this.tun)&&(identical(other.mixedPort, _this.mixedPort) || other.mixedPort == _this.mixedPort)&&(identical(other.allowLan, _this.allowLan) || other.allowLan == _this.allowLan)&&(identical(other.findProcessMode, _this.findProcessMode) || other.findProcessMode == _this.findProcessMode)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.logLevel, _this.logLevel) || other.logLevel == _this.logLevel)&&(identical(other.ipv6, _this.ipv6) || other.ipv6 == _this.ipv6)&&(identical(other.tcpConcurrent, _this.tcpConcurrent) || other.tcpConcurrent == _this.tcpConcurrent)&&(identical(other.externalController, _this.externalController) || other.externalController == _this.externalController)&&(identical(other.secret, _this.secret) || other.secret == _this.secret)&&(identical(other.unifiedDelay, _this.unifiedDelay) || other.unifiedDelay == _this.unifiedDelay)&&(identical(other.geoAutoUpdate, _this.geoAutoUpdate) || other.geoAutoUpdate == _this.geoAutoUpdate)&&(identical(other.geoUpdateInterval, _this.geoUpdateInterval) || other.geoUpdateInterval == _this.geoUpdateInterval)&&const DeepCollectionEquality().equals(other.geoXUrl, _this.geoXUrl)&&(identical(other.suspendOnIdle, _this.suspendOnIdle) || other.suspendOnIdle == _this.suspendOnIdle)&&(identical(other.options, _this.options) || other.options == _this.options)&&const DeepCollectionEquality().equals(other.authentication, _this.authentication));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpdateParams;
  return Object.hash(runtimeType,_this.tun,_this.mixedPort,_this.allowLan,_this.findProcessMode,_this.mode,_this.logLevel,_this.ipv6,_this.tcpConcurrent,_this.externalController,_this.secret,_this.unifiedDelay,_this.geoAutoUpdate,_this.geoUpdateInterval,const DeepCollectionEquality().hash(_this.geoXUrl),_this.suspendOnIdle,_this.options,const DeepCollectionEquality().hash(_this.authentication));
}

@override
String toString() {
  final _this = this as UpdateParams;
  return 'UpdateParams(tun: ${_this.tun}, mixedPort: ${_this.mixedPort}, allowLan: ${_this.allowLan}, findProcessMode: ${_this.findProcessMode}, mode: ${_this.mode}, logLevel: ${_this.logLevel}, ipv6: ${_this.ipv6}, tcpConcurrent: ${_this.tcpConcurrent}, externalController: ${_this.externalController}, secret: ${_this.secret}, unifiedDelay: ${_this.unifiedDelay}, geoAutoUpdate: ${_this.geoAutoUpdate}, geoUpdateInterval: ${_this.geoUpdateInterval}, geoXUrl: ${_this.geoXUrl}, suspendOnIdle: ${_this.suspendOnIdle}, options: ${_this.options}, authentication: ${_this.authentication})';
}


}

/// @nodoc
abstract mixin class $UpdateParamsCopyWith<$Res>  {
  factory $UpdateParamsCopyWith(UpdateParams value, $Res Function(UpdateParams) _then) = _$UpdateParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(toJson: _tunCoreJson) Tun tun,@JsonKey(name: 'mixed-port') int mixedPort,@JsonKey(name: 'allow-lan') bool allowLan,@JsonKey(name: 'find-process-mode') FindProcessMode findProcessMode, Mode mode,@JsonKey(name: 'log-level') LogLevel logLevel, bool? ipv6,@JsonKey(name: 'tcp-concurrent') bool? tcpConcurrent,@JsonKey(name: 'external-controller') String externalController, String secret,@JsonKey(name: 'unified-delay') bool? unifiedDelay,@JsonKey(name: 'geo-auto-update') bool geoAutoUpdate,@JsonKey(name: 'geo-update-interval') int geoUpdateInterval,@JsonKey(name: 'geox-url') Map<String, String> geoXUrl,@JsonKey(name: 'suspend-on-idle') bool suspendOnIdle, CoreOptions options, List<String> authentication
});


$TunCopyWith<$Res> get tun;$CoreOptionsCopyWith<$Res> get options;

}
/// @nodoc
class _$UpdateParamsCopyWithImpl<$Res>
    implements $UpdateParamsCopyWith<$Res> {
  _$UpdateParamsCopyWithImpl(this._self, this._then);

  final UpdateParams _self;
  final $Res Function(UpdateParams) _then;

/// Create a copy of UpdateParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tun = null,Object? mixedPort = null,Object? allowLan = null,Object? findProcessMode = null,Object? mode = null,Object? logLevel = null,Object? ipv6 = freezed,Object? tcpConcurrent = freezed,Object? externalController = null,Object? secret = null,Object? unifiedDelay = freezed,Object? geoAutoUpdate = null,Object? geoUpdateInterval = null,Object? geoXUrl = null,Object? suspendOnIdle = null,Object? options = null,Object? authentication = null,}) {
  return _then(UpdateParams(
tun: null == tun ? _self.tun : tun // ignore: cast_nullable_to_non_nullable
as Tun,mixedPort: null == mixedPort ? _self.mixedPort : mixedPort // ignore: cast_nullable_to_non_nullable
as int,allowLan: null == allowLan ? _self.allowLan : allowLan // ignore: cast_nullable_to_non_nullable
as bool,findProcessMode: null == findProcessMode ? _self.findProcessMode : findProcessMode // ignore: cast_nullable_to_non_nullable
as FindProcessMode,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as Mode,logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as LogLevel,ipv6: freezed == ipv6 ? _self.ipv6 : ipv6 // ignore: cast_nullable_to_non_nullable
as bool?,tcpConcurrent: freezed == tcpConcurrent ? _self.tcpConcurrent : tcpConcurrent // ignore: cast_nullable_to_non_nullable
as bool?,externalController: null == externalController ? _self.externalController : externalController // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,unifiedDelay: freezed == unifiedDelay ? _self.unifiedDelay : unifiedDelay // ignore: cast_nullable_to_non_nullable
as bool?,geoAutoUpdate: null == geoAutoUpdate ? _self.geoAutoUpdate : geoAutoUpdate // ignore: cast_nullable_to_non_nullable
as bool,geoUpdateInterval: null == geoUpdateInterval ? _self.geoUpdateInterval : geoUpdateInterval // ignore: cast_nullable_to_non_nullable
as int,geoXUrl: null == geoXUrl ? _self.geoXUrl : geoXUrl // ignore: cast_nullable_to_non_nullable
as Map<String, String>,suspendOnIdle: null == suspendOnIdle ? _self.suspendOnIdle : suspendOnIdle // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as CoreOptions,authentication: null == authentication ? _self.authentication : authentication // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of UpdateParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TunCopyWith<$Res> get tun {
  
  return $TunCopyWith<$Res>(_self.tun, (value) {
    return _then(_self.copyWith(tun: value));
  });
}/// Create a copy of UpdateParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoreOptionsCopyWith<$Res> get options {
  
  return $CoreOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}


/// Adds pattern-matching-related methods to [UpdateParams].
extension UpdateParamsPatterns on UpdateParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateParams value)  $default,){
final _that = this;
switch (_that) {
case _UpdateParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateParams value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(toJson: _tunCoreJson)  Tun tun, @JsonKey(name: 'mixed-port')  int mixedPort, @JsonKey(name: 'allow-lan')  bool allowLan, @JsonKey(name: 'find-process-mode')  FindProcessMode findProcessMode,  Mode mode, @JsonKey(name: 'log-level')  LogLevel logLevel,  bool? ipv6, @JsonKey(name: 'tcp-concurrent')  bool? tcpConcurrent, @JsonKey(name: 'external-controller')  String externalController,  String secret, @JsonKey(name: 'unified-delay')  bool? unifiedDelay, @JsonKey(name: 'geo-auto-update')  bool geoAutoUpdate, @JsonKey(name: 'geo-update-interval')  int geoUpdateInterval, @JsonKey(name: 'geox-url')  Map<String, String> geoXUrl, @JsonKey(name: 'suspend-on-idle')  bool suspendOnIdle,  CoreOptions options,  List<String> authentication)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateParams() when $default != null:
return $default(_that.tun,_that.mixedPort,_that.allowLan,_that.findProcessMode,_that.mode,_that.logLevel,_that.ipv6,_that.tcpConcurrent,_that.externalController,_that.secret,_that.unifiedDelay,_that.geoAutoUpdate,_that.geoUpdateInterval,_that.geoXUrl,_that.suspendOnIdle,_that.options,_that.authentication);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(toJson: _tunCoreJson)  Tun tun, @JsonKey(name: 'mixed-port')  int mixedPort, @JsonKey(name: 'allow-lan')  bool allowLan, @JsonKey(name: 'find-process-mode')  FindProcessMode findProcessMode,  Mode mode, @JsonKey(name: 'log-level')  LogLevel logLevel,  bool? ipv6, @JsonKey(name: 'tcp-concurrent')  bool? tcpConcurrent, @JsonKey(name: 'external-controller')  String externalController,  String secret, @JsonKey(name: 'unified-delay')  bool? unifiedDelay, @JsonKey(name: 'geo-auto-update')  bool geoAutoUpdate, @JsonKey(name: 'geo-update-interval')  int geoUpdateInterval, @JsonKey(name: 'geox-url')  Map<String, String> geoXUrl, @JsonKey(name: 'suspend-on-idle')  bool suspendOnIdle,  CoreOptions options,  List<String> authentication)  $default,) {final _that = this;
switch (_that) {
case _UpdateParams():
return $default(_that.tun,_that.mixedPort,_that.allowLan,_that.findProcessMode,_that.mode,_that.logLevel,_that.ipv6,_that.tcpConcurrent,_that.externalController,_that.secret,_that.unifiedDelay,_that.geoAutoUpdate,_that.geoUpdateInterval,_that.geoXUrl,_that.suspendOnIdle,_that.options,_that.authentication);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(toJson: _tunCoreJson)  Tun tun, @JsonKey(name: 'mixed-port')  int mixedPort, @JsonKey(name: 'allow-lan')  bool allowLan, @JsonKey(name: 'find-process-mode')  FindProcessMode findProcessMode,  Mode mode, @JsonKey(name: 'log-level')  LogLevel logLevel,  bool? ipv6, @JsonKey(name: 'tcp-concurrent')  bool? tcpConcurrent, @JsonKey(name: 'external-controller')  String externalController,  String secret, @JsonKey(name: 'unified-delay')  bool? unifiedDelay, @JsonKey(name: 'geo-auto-update')  bool geoAutoUpdate, @JsonKey(name: 'geo-update-interval')  int geoUpdateInterval, @JsonKey(name: 'geox-url')  Map<String, String> geoXUrl, @JsonKey(name: 'suspend-on-idle')  bool suspendOnIdle,  CoreOptions options,  List<String> authentication)?  $default,) {final _that = this;
switch (_that) {
case _UpdateParams() when $default != null:
return $default(_that.tun,_that.mixedPort,_that.allowLan,_that.findProcessMode,_that.mode,_that.logLevel,_that.ipv6,_that.tcpConcurrent,_that.externalController,_that.secret,_that.unifiedDelay,_that.geoAutoUpdate,_that.geoUpdateInterval,_that.geoXUrl,_that.suspendOnIdle,_that.options,_that.authentication);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateParams implements UpdateParams {
  const _UpdateParams({@JsonKey(toJson: _tunCoreJson) required this.tun, @JsonKey(name: 'mixed-port') required this.mixedPort, @JsonKey(name: 'allow-lan') required this.allowLan, @JsonKey(name: 'find-process-mode') required this.findProcessMode, required this.mode, @JsonKey(name: 'log-level') required this.logLevel, required this.ipv6, @JsonKey(name: 'tcp-concurrent') required this.tcpConcurrent, @JsonKey(name: 'external-controller') required this.externalController, required this.secret, @JsonKey(name: 'unified-delay') required this.unifiedDelay, @JsonKey(name: 'geo-auto-update') this.geoAutoUpdate = true, @JsonKey(name: 'geo-update-interval') this.geoUpdateInterval = 24, @JsonKey(name: 'geox-url')  Map<String, String> geoXUrl = const {}, @JsonKey(name: 'suspend-on-idle') this.suspendOnIdle = false, this.options = const CoreOptions(testUrl: defaultTestUrl),  List<String> authentication = const []}): _geoXUrl = geoXUrl,_authentication = authentication;
  factory _UpdateParams.fromJson(Map<String, dynamic> json) => _$UpdateParamsFromJson(json);

@override@JsonKey(toJson: _tunCoreJson) final  Tun tun;
@override@JsonKey(name: 'mixed-port') final  int mixedPort;
@override@JsonKey(name: 'allow-lan') final  bool allowLan;
@override@JsonKey(name: 'find-process-mode') final  FindProcessMode findProcessMode;
@override final  Mode mode;
@override@JsonKey(name: 'log-level') final  LogLevel logLevel;
@override final  bool? ipv6;
@override@JsonKey(name: 'tcp-concurrent') final  bool? tcpConcurrent;
@override@JsonKey(name: 'external-controller') final  String externalController;
@override final  String secret;
@override@JsonKey(name: 'unified-delay') final  bool? unifiedDelay;
@override@JsonKey(name: 'geo-auto-update') final  bool geoAutoUpdate;
@override@JsonKey(name: 'geo-update-interval') final  int geoUpdateInterval;
 final  Map<String, String> _geoXUrl;
@override@JsonKey(name: 'geox-url') Map<String, String> get geoXUrl {
  if (_geoXUrl is EqualUnmodifiableMapView) return _geoXUrl;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_geoXUrl);
}

@override@JsonKey(name: 'suspend-on-idle') final  bool suspendOnIdle;
@override@JsonKey() final  CoreOptions options;
 final  List<String> _authentication;
@override@JsonKey() List<String> get authentication {
  if (_authentication is EqualUnmodifiableListView) return _authentication;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authentication);
}


/// Create a copy of UpdateParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateParamsCopyWith<_UpdateParams> get copyWith => __$UpdateParamsCopyWithImpl<_UpdateParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateParamsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateParams&&(identical(other.tun, tun) || other.tun == tun)&&(identical(other.mixedPort, mixedPort) || other.mixedPort == mixedPort)&&(identical(other.allowLan, allowLan) || other.allowLan == allowLan)&&(identical(other.findProcessMode, findProcessMode) || other.findProcessMode == findProcessMode)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.ipv6, ipv6) || other.ipv6 == ipv6)&&(identical(other.tcpConcurrent, tcpConcurrent) || other.tcpConcurrent == tcpConcurrent)&&(identical(other.externalController, externalController) || other.externalController == externalController)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.unifiedDelay, unifiedDelay) || other.unifiedDelay == unifiedDelay)&&(identical(other.geoAutoUpdate, geoAutoUpdate) || other.geoAutoUpdate == geoAutoUpdate)&&(identical(other.geoUpdateInterval, geoUpdateInterval) || other.geoUpdateInterval == geoUpdateInterval)&&const DeepCollectionEquality().equals(other.geoXUrl, _geoXUrl)&&(identical(other.suspendOnIdle, suspendOnIdle) || other.suspendOnIdle == suspendOnIdle)&&(identical(other.options, options) || other.options == options)&&const DeepCollectionEquality().equals(other.authentication, _authentication));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tun,mixedPort,allowLan,findProcessMode,mode,logLevel,ipv6,tcpConcurrent,externalController,secret,unifiedDelay,geoAutoUpdate,geoUpdateInterval,const DeepCollectionEquality().hash(_geoXUrl),suspendOnIdle,options,const DeepCollectionEquality().hash(_authentication));
}

@override
String toString() {
    return 'UpdateParams(tun: $tun, mixedPort: $mixedPort, allowLan: $allowLan, findProcessMode: $findProcessMode, mode: $mode, logLevel: $logLevel, ipv6: $ipv6, tcpConcurrent: $tcpConcurrent, externalController: $externalController, secret: $secret, unifiedDelay: $unifiedDelay, geoAutoUpdate: $geoAutoUpdate, geoUpdateInterval: $geoUpdateInterval, geoXUrl: $geoXUrl, suspendOnIdle: $suspendOnIdle, options: $options, authentication: $authentication)';
}


}

/// @nodoc
abstract mixin class _$UpdateParamsCopyWith<$Res> implements $UpdateParamsCopyWith<$Res> {
  factory _$UpdateParamsCopyWith(_UpdateParams value, $Res Function(_UpdateParams) _then) = __$UpdateParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(toJson: _tunCoreJson) Tun tun,@JsonKey(name: 'mixed-port') int mixedPort,@JsonKey(name: 'allow-lan') bool allowLan,@JsonKey(name: 'find-process-mode') FindProcessMode findProcessMode, Mode mode,@JsonKey(name: 'log-level') LogLevel logLevel, bool? ipv6,@JsonKey(name: 'tcp-concurrent') bool? tcpConcurrent,@JsonKey(name: 'external-controller') String externalController, String secret,@JsonKey(name: 'unified-delay') bool? unifiedDelay,@JsonKey(name: 'geo-auto-update') bool geoAutoUpdate,@JsonKey(name: 'geo-update-interval') int geoUpdateInterval,@JsonKey(name: 'geox-url') Map<String, String> geoXUrl,@JsonKey(name: 'suspend-on-idle') bool suspendOnIdle, CoreOptions options, List<String> authentication
});


@override $TunCopyWith<$Res> get tun;@override $CoreOptionsCopyWith<$Res> get options;

}
/// @nodoc
class __$UpdateParamsCopyWithImpl<$Res>
    implements _$UpdateParamsCopyWith<$Res> {
  __$UpdateParamsCopyWithImpl(this._self, this._then);

  final _UpdateParams _self;
  final $Res Function(_UpdateParams) _then;

/// Create a copy of UpdateParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tun = null,Object? mixedPort = null,Object? allowLan = null,Object? findProcessMode = null,Object? mode = null,Object? logLevel = null,Object? ipv6 = freezed,Object? tcpConcurrent = freezed,Object? externalController = null,Object? secret = null,Object? unifiedDelay = freezed,Object? geoAutoUpdate = null,Object? geoUpdateInterval = null,Object? geoXUrl = null,Object? suspendOnIdle = null,Object? options = null,Object? authentication = null,}) {
  return _then(_UpdateParams(
tun: null == tun ? _self.tun : tun // ignore: cast_nullable_to_non_nullable
as Tun,mixedPort: null == mixedPort ? _self.mixedPort : mixedPort // ignore: cast_nullable_to_non_nullable
as int,allowLan: null == allowLan ? _self.allowLan : allowLan // ignore: cast_nullable_to_non_nullable
as bool,findProcessMode: null == findProcessMode ? _self.findProcessMode : findProcessMode // ignore: cast_nullable_to_non_nullable
as FindProcessMode,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as Mode,logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as LogLevel,ipv6: freezed == ipv6 ? _self.ipv6 : ipv6 // ignore: cast_nullable_to_non_nullable
as bool?,tcpConcurrent: freezed == tcpConcurrent ? _self.tcpConcurrent : tcpConcurrent // ignore: cast_nullable_to_non_nullable
as bool?,externalController: null == externalController ? _self.externalController : externalController // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,unifiedDelay: freezed == unifiedDelay ? _self.unifiedDelay : unifiedDelay // ignore: cast_nullable_to_non_nullable
as bool?,geoAutoUpdate: null == geoAutoUpdate ? _self.geoAutoUpdate : geoAutoUpdate // ignore: cast_nullable_to_non_nullable
as bool,geoUpdateInterval: null == geoUpdateInterval ? _self.geoUpdateInterval : geoUpdateInterval // ignore: cast_nullable_to_non_nullable
as int,geoXUrl: null == geoXUrl ? _self._geoXUrl : geoXUrl // ignore: cast_nullable_to_non_nullable
as Map<String, String>,suspendOnIdle: null == suspendOnIdle ? _self.suspendOnIdle : suspendOnIdle // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as CoreOptions,authentication: null == authentication ? _self._authentication : authentication // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of UpdateParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TunCopyWith<$Res> get tun {
  
  return $TunCopyWith<$Res>(_self.tun, (value) {
    return _then(_self.copyWith(tun: value));
  });
}/// Create a copy of UpdateParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoreOptionsCopyWith<$Res> get options {
  
  return $CoreOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}


/// @nodoc
mixin _$VpnOptions {

 bool get enable; int get port; bool get ipv6; bool get dnsHijacking; AccessControlProps get accessControlProps; bool get allowBypass; bool get systemProxy; List<String> get bypassDomain; String get stack; List<String> get routeAddress; List<String> get excludeSSIDs; List<String> get excludeNetworks;@JsonKey(fromJson: normalizeTunMtu) int get mtu; String get congestionController;
/// Create a copy of VpnOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VpnOptionsCopyWith<VpnOptions> get copyWith => _$VpnOptionsCopyWithImpl<VpnOptions>(this as VpnOptions, _$identity);

  /// Serializes this VpnOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VpnOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VpnOptions&&(identical(other.enable, _this.enable) || other.enable == _this.enable)&&(identical(other.port, _this.port) || other.port == _this.port)&&(identical(other.ipv6, _this.ipv6) || other.ipv6 == _this.ipv6)&&(identical(other.dnsHijacking, _this.dnsHijacking) || other.dnsHijacking == _this.dnsHijacking)&&(identical(other.accessControlProps, _this.accessControlProps) || other.accessControlProps == _this.accessControlProps)&&(identical(other.allowBypass, _this.allowBypass) || other.allowBypass == _this.allowBypass)&&(identical(other.systemProxy, _this.systemProxy) || other.systemProxy == _this.systemProxy)&&const DeepCollectionEquality().equals(other.bypassDomain, _this.bypassDomain)&&(identical(other.stack, _this.stack) || other.stack == _this.stack)&&const DeepCollectionEquality().equals(other.routeAddress, _this.routeAddress)&&const DeepCollectionEquality().equals(other.excludeSSIDs, _this.excludeSSIDs)&&const DeepCollectionEquality().equals(other.excludeNetworks, _this.excludeNetworks)&&(identical(other.mtu, _this.mtu) || other.mtu == _this.mtu)&&(identical(other.congestionController, _this.congestionController) || other.congestionController == _this.congestionController));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VpnOptions;
  return Object.hash(runtimeType,_this.enable,_this.port,_this.ipv6,_this.dnsHijacking,_this.accessControlProps,_this.allowBypass,_this.systemProxy,const DeepCollectionEquality().hash(_this.bypassDomain),_this.stack,const DeepCollectionEquality().hash(_this.routeAddress),const DeepCollectionEquality().hash(_this.excludeSSIDs),const DeepCollectionEquality().hash(_this.excludeNetworks),_this.mtu,_this.congestionController);
}

@override
String toString() {
  final _this = this as VpnOptions;
  return 'VpnOptions(enable: ${_this.enable}, port: ${_this.port}, ipv6: ${_this.ipv6}, dnsHijacking: ${_this.dnsHijacking}, accessControlProps: ${_this.accessControlProps}, allowBypass: ${_this.allowBypass}, systemProxy: ${_this.systemProxy}, bypassDomain: ${_this.bypassDomain}, stack: ${_this.stack}, routeAddress: ${_this.routeAddress}, excludeSSIDs: ${_this.excludeSSIDs}, excludeNetworks: ${_this.excludeNetworks}, mtu: ${_this.mtu}, congestionController: ${_this.congestionController})';
}


}

/// @nodoc
abstract mixin class $VpnOptionsCopyWith<$Res>  {
  factory $VpnOptionsCopyWith(VpnOptions value, $Res Function(VpnOptions) _then) = _$VpnOptionsCopyWithImpl;
@useResult
$Res call({
 bool enable, int port, bool ipv6, bool dnsHijacking, AccessControlProps accessControlProps, bool allowBypass, bool systemProxy, List<String> bypassDomain, String stack, List<String> routeAddress, List<String> excludeSSIDs, List<String> excludeNetworks,@JsonKey(fromJson: normalizeTunMtu) int mtu, String congestionController
});


$AccessControlPropsCopyWith<$Res> get accessControlProps;

}
/// @nodoc
class _$VpnOptionsCopyWithImpl<$Res>
    implements $VpnOptionsCopyWith<$Res> {
  _$VpnOptionsCopyWithImpl(this._self, this._then);

  final VpnOptions _self;
  final $Res Function(VpnOptions) _then;

/// Create a copy of VpnOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enable = null,Object? port = null,Object? ipv6 = null,Object? dnsHijacking = null,Object? accessControlProps = null,Object? allowBypass = null,Object? systemProxy = null,Object? bypassDomain = null,Object? stack = null,Object? routeAddress = null,Object? excludeSSIDs = null,Object? excludeNetworks = null,Object? mtu = null,Object? congestionController = null,}) {
  return _then(VpnOptions(
enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,ipv6: null == ipv6 ? _self.ipv6 : ipv6 // ignore: cast_nullable_to_non_nullable
as bool,dnsHijacking: null == dnsHijacking ? _self.dnsHijacking : dnsHijacking // ignore: cast_nullable_to_non_nullable
as bool,accessControlProps: null == accessControlProps ? _self.accessControlProps : accessControlProps // ignore: cast_nullable_to_non_nullable
as AccessControlProps,allowBypass: null == allowBypass ? _self.allowBypass : allowBypass // ignore: cast_nullable_to_non_nullable
as bool,systemProxy: null == systemProxy ? _self.systemProxy : systemProxy // ignore: cast_nullable_to_non_nullable
as bool,bypassDomain: null == bypassDomain ? _self.bypassDomain : bypassDomain // ignore: cast_nullable_to_non_nullable
as List<String>,stack: null == stack ? _self.stack : stack // ignore: cast_nullable_to_non_nullable
as String,routeAddress: null == routeAddress ? _self.routeAddress : routeAddress // ignore: cast_nullable_to_non_nullable
as List<String>,excludeSSIDs: null == excludeSSIDs ? _self.excludeSSIDs : excludeSSIDs // ignore: cast_nullable_to_non_nullable
as List<String>,excludeNetworks: null == excludeNetworks ? _self.excludeNetworks : excludeNetworks // ignore: cast_nullable_to_non_nullable
as List<String>,mtu: null == mtu ? _self.mtu : mtu // ignore: cast_nullable_to_non_nullable
as int,congestionController: null == congestionController ? _self.congestionController : congestionController // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of VpnOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccessControlPropsCopyWith<$Res> get accessControlProps {
  
  return $AccessControlPropsCopyWith<$Res>(_self.accessControlProps, (value) {
    return _then(_self.copyWith(accessControlProps: value));
  });
}
}


/// Adds pattern-matching-related methods to [VpnOptions].
extension VpnOptionsPatterns on VpnOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VpnOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VpnOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VpnOptions value)  $default,){
final _that = this;
switch (_that) {
case _VpnOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VpnOptions value)?  $default,){
final _that = this;
switch (_that) {
case _VpnOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enable,  int port,  bool ipv6,  bool dnsHijacking,  AccessControlProps accessControlProps,  bool allowBypass,  bool systemProxy,  List<String> bypassDomain,  String stack,  List<String> routeAddress,  List<String> excludeSSIDs,  List<String> excludeNetworks, @JsonKey(fromJson: normalizeTunMtu)  int mtu,  String congestionController)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VpnOptions() when $default != null:
return $default(_that.enable,_that.port,_that.ipv6,_that.dnsHijacking,_that.accessControlProps,_that.allowBypass,_that.systemProxy,_that.bypassDomain,_that.stack,_that.routeAddress,_that.excludeSSIDs,_that.excludeNetworks,_that.mtu,_that.congestionController);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enable,  int port,  bool ipv6,  bool dnsHijacking,  AccessControlProps accessControlProps,  bool allowBypass,  bool systemProxy,  List<String> bypassDomain,  String stack,  List<String> routeAddress,  List<String> excludeSSIDs,  List<String> excludeNetworks, @JsonKey(fromJson: normalizeTunMtu)  int mtu,  String congestionController)  $default,) {final _that = this;
switch (_that) {
case _VpnOptions():
return $default(_that.enable,_that.port,_that.ipv6,_that.dnsHijacking,_that.accessControlProps,_that.allowBypass,_that.systemProxy,_that.bypassDomain,_that.stack,_that.routeAddress,_that.excludeSSIDs,_that.excludeNetworks,_that.mtu,_that.congestionController);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enable,  int port,  bool ipv6,  bool dnsHijacking,  AccessControlProps accessControlProps,  bool allowBypass,  bool systemProxy,  List<String> bypassDomain,  String stack,  List<String> routeAddress,  List<String> excludeSSIDs,  List<String> excludeNetworks, @JsonKey(fromJson: normalizeTunMtu)  int mtu,  String congestionController)?  $default,) {final _that = this;
switch (_that) {
case _VpnOptions() when $default != null:
return $default(_that.enable,_that.port,_that.ipv6,_that.dnsHijacking,_that.accessControlProps,_that.allowBypass,_that.systemProxy,_that.bypassDomain,_that.stack,_that.routeAddress,_that.excludeSSIDs,_that.excludeNetworks,_that.mtu,_that.congestionController);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VpnOptions implements VpnOptions {
  const _VpnOptions({required this.enable, required this.port, required this.ipv6, required this.dnsHijacking, required this.accessControlProps, required this.allowBypass, required this.systemProxy, required  List<String> bypassDomain, required this.stack,  List<String> routeAddress = const [],  List<String> excludeSSIDs = const [],  List<String> excludeNetworks = const [], @JsonKey(fromJson: normalizeTunMtu) this.mtu = defaultTunMtu, this.congestionController = ''}): _bypassDomain = bypassDomain,_routeAddress = routeAddress,_excludeSSIDs = excludeSSIDs,_excludeNetworks = excludeNetworks;
  factory _VpnOptions.fromJson(Map<String, dynamic> json) => _$VpnOptionsFromJson(json);

@override final  bool enable;
@override final  int port;
@override final  bool ipv6;
@override final  bool dnsHijacking;
@override final  AccessControlProps accessControlProps;
@override final  bool allowBypass;
@override final  bool systemProxy;
 final  List<String> _bypassDomain;
@override List<String> get bypassDomain {
  if (_bypassDomain is EqualUnmodifiableListView) return _bypassDomain;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bypassDomain);
}

@override final  String stack;
 final  List<String> _routeAddress;
@override@JsonKey() List<String> get routeAddress {
  if (_routeAddress is EqualUnmodifiableListView) return _routeAddress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routeAddress);
}

 final  List<String> _excludeSSIDs;
@override@JsonKey() List<String> get excludeSSIDs {
  if (_excludeSSIDs is EqualUnmodifiableListView) return _excludeSSIDs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_excludeSSIDs);
}

 final  List<String> _excludeNetworks;
@override@JsonKey() List<String> get excludeNetworks {
  if (_excludeNetworks is EqualUnmodifiableListView) return _excludeNetworks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_excludeNetworks);
}

@override@JsonKey(fromJson: normalizeTunMtu) final  int mtu;
@override@JsonKey() final  String congestionController;

/// Create a copy of VpnOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VpnOptionsCopyWith<_VpnOptions> get copyWith => __$VpnOptionsCopyWithImpl<_VpnOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VpnOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VpnOptions&&(identical(other.enable, enable) || other.enable == enable)&&(identical(other.port, port) || other.port == port)&&(identical(other.ipv6, ipv6) || other.ipv6 == ipv6)&&(identical(other.dnsHijacking, dnsHijacking) || other.dnsHijacking == dnsHijacking)&&(identical(other.accessControlProps, accessControlProps) || other.accessControlProps == accessControlProps)&&(identical(other.allowBypass, allowBypass) || other.allowBypass == allowBypass)&&(identical(other.systemProxy, systemProxy) || other.systemProxy == systemProxy)&&const DeepCollectionEquality().equals(other.bypassDomain, _bypassDomain)&&(identical(other.stack, stack) || other.stack == stack)&&const DeepCollectionEquality().equals(other.routeAddress, _routeAddress)&&const DeepCollectionEquality().equals(other.excludeSSIDs, _excludeSSIDs)&&const DeepCollectionEquality().equals(other.excludeNetworks, _excludeNetworks)&&(identical(other.mtu, mtu) || other.mtu == mtu)&&(identical(other.congestionController, congestionController) || other.congestionController == congestionController));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enable,port,ipv6,dnsHijacking,accessControlProps,allowBypass,systemProxy,const DeepCollectionEquality().hash(_bypassDomain),stack,const DeepCollectionEquality().hash(_routeAddress),const DeepCollectionEquality().hash(_excludeSSIDs),const DeepCollectionEquality().hash(_excludeNetworks),mtu,congestionController);
}

@override
String toString() {
    return 'VpnOptions(enable: $enable, port: $port, ipv6: $ipv6, dnsHijacking: $dnsHijacking, accessControlProps: $accessControlProps, allowBypass: $allowBypass, systemProxy: $systemProxy, bypassDomain: $bypassDomain, stack: $stack, routeAddress: $routeAddress, excludeSSIDs: $excludeSSIDs, excludeNetworks: $excludeNetworks, mtu: $mtu, congestionController: $congestionController)';
}


}

/// @nodoc
abstract mixin class _$VpnOptionsCopyWith<$Res> implements $VpnOptionsCopyWith<$Res> {
  factory _$VpnOptionsCopyWith(_VpnOptions value, $Res Function(_VpnOptions) _then) = __$VpnOptionsCopyWithImpl;
@override @useResult
$Res call({
 bool enable, int port, bool ipv6, bool dnsHijacking, AccessControlProps accessControlProps, bool allowBypass, bool systemProxy, List<String> bypassDomain, String stack, List<String> routeAddress, List<String> excludeSSIDs, List<String> excludeNetworks,@JsonKey(fromJson: normalizeTunMtu) int mtu, String congestionController
});


@override $AccessControlPropsCopyWith<$Res> get accessControlProps;

}
/// @nodoc
class __$VpnOptionsCopyWithImpl<$Res>
    implements _$VpnOptionsCopyWith<$Res> {
  __$VpnOptionsCopyWithImpl(this._self, this._then);

  final _VpnOptions _self;
  final $Res Function(_VpnOptions) _then;

/// Create a copy of VpnOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enable = null,Object? port = null,Object? ipv6 = null,Object? dnsHijacking = null,Object? accessControlProps = null,Object? allowBypass = null,Object? systemProxy = null,Object? bypassDomain = null,Object? stack = null,Object? routeAddress = null,Object? excludeSSIDs = null,Object? excludeNetworks = null,Object? mtu = null,Object? congestionController = null,}) {
  return _then(_VpnOptions(
enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,ipv6: null == ipv6 ? _self.ipv6 : ipv6 // ignore: cast_nullable_to_non_nullable
as bool,dnsHijacking: null == dnsHijacking ? _self.dnsHijacking : dnsHijacking // ignore: cast_nullable_to_non_nullable
as bool,accessControlProps: null == accessControlProps ? _self.accessControlProps : accessControlProps // ignore: cast_nullable_to_non_nullable
as AccessControlProps,allowBypass: null == allowBypass ? _self.allowBypass : allowBypass // ignore: cast_nullable_to_non_nullable
as bool,systemProxy: null == systemProxy ? _self.systemProxy : systemProxy // ignore: cast_nullable_to_non_nullable
as bool,bypassDomain: null == bypassDomain ? _self._bypassDomain : bypassDomain // ignore: cast_nullable_to_non_nullable
as List<String>,stack: null == stack ? _self.stack : stack // ignore: cast_nullable_to_non_nullable
as String,routeAddress: null == routeAddress ? _self._routeAddress : routeAddress // ignore: cast_nullable_to_non_nullable
as List<String>,excludeSSIDs: null == excludeSSIDs ? _self._excludeSSIDs : excludeSSIDs // ignore: cast_nullable_to_non_nullable
as List<String>,excludeNetworks: null == excludeNetworks ? _self._excludeNetworks : excludeNetworks // ignore: cast_nullable_to_non_nullable
as List<String>,mtu: null == mtu ? _self.mtu : mtu // ignore: cast_nullable_to_non_nullable
as int,congestionController: null == congestionController ? _self.congestionController : congestionController // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of VpnOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccessControlPropsCopyWith<$Res> get accessControlProps {
  
  return $AccessControlPropsCopyWith<$Res>(_self.accessControlProps, (value) {
    return _then(_self.copyWith(accessControlProps: value));
  });
}
}


/// @nodoc
mixin _$InitParams {

@JsonKey(name: 'home-dir') String get homeDir; int get version;@JsonKey(name: 'profile-key') String get profileKey;@JsonKey(name: 'config-age-secret-key') String get configAgeSecretKey;@JsonKey(name: 'cloud-domains') List<String> get cloudDomains;
/// Create a copy of InitParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitParamsCopyWith<InitParams> get copyWith => _$InitParamsCopyWithImpl<InitParams>(this as InitParams, _$identity);

  /// Serializes this InitParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InitParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitParams&&(identical(other.homeDir, _this.homeDir) || other.homeDir == _this.homeDir)&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.profileKey, _this.profileKey) || other.profileKey == _this.profileKey)&&(identical(other.configAgeSecretKey, _this.configAgeSecretKey) || other.configAgeSecretKey == _this.configAgeSecretKey)&&const DeepCollectionEquality().equals(other.cloudDomains, _this.cloudDomains));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InitParams;
  return Object.hash(runtimeType,_this.homeDir,_this.version,_this.profileKey,_this.configAgeSecretKey,const DeepCollectionEquality().hash(_this.cloudDomains));
}

@override
String toString() {
  final _this = this as InitParams;
  return 'InitParams(homeDir: ${_this.homeDir}, version: ${_this.version}, profileKey: ${_this.profileKey}, configAgeSecretKey: ${_this.configAgeSecretKey}, cloudDomains: ${_this.cloudDomains})';
}


}

/// @nodoc
abstract mixin class $InitParamsCopyWith<$Res>  {
  factory $InitParamsCopyWith(InitParams value, $Res Function(InitParams) _then) = _$InitParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'home-dir') String homeDir, int version,@JsonKey(name: 'profile-key') String profileKey,@JsonKey(name: 'config-age-secret-key') String configAgeSecretKey,@JsonKey(name: 'cloud-domains') List<String> cloudDomains
});




}
/// @nodoc
class _$InitParamsCopyWithImpl<$Res>
    implements $InitParamsCopyWith<$Res> {
  _$InitParamsCopyWithImpl(this._self, this._then);

  final InitParams _self;
  final $Res Function(InitParams) _then;

/// Create a copy of InitParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? homeDir = null,Object? version = null,Object? profileKey = null,Object? configAgeSecretKey = null,Object? cloudDomains = null,}) {
  return _then(InitParams(
homeDir: null == homeDir ? _self.homeDir : homeDir // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,profileKey: null == profileKey ? _self.profileKey : profileKey // ignore: cast_nullable_to_non_nullable
as String,configAgeSecretKey: null == configAgeSecretKey ? _self.configAgeSecretKey : configAgeSecretKey // ignore: cast_nullable_to_non_nullable
as String,cloudDomains: null == cloudDomains ? _self.cloudDomains : cloudDomains // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [InitParams].
extension InitParamsPatterns on InitParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitParams value)  $default,){
final _that = this;
switch (_that) {
case _InitParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitParams value)?  $default,){
final _that = this;
switch (_that) {
case _InitParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'home-dir')  String homeDir,  int version, @JsonKey(name: 'profile-key')  String profileKey, @JsonKey(name: 'config-age-secret-key')  String configAgeSecretKey, @JsonKey(name: 'cloud-domains')  List<String> cloudDomains)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitParams() when $default != null:
return $default(_that.homeDir,_that.version,_that.profileKey,_that.configAgeSecretKey,_that.cloudDomains);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'home-dir')  String homeDir,  int version, @JsonKey(name: 'profile-key')  String profileKey, @JsonKey(name: 'config-age-secret-key')  String configAgeSecretKey, @JsonKey(name: 'cloud-domains')  List<String> cloudDomains)  $default,) {final _that = this;
switch (_that) {
case _InitParams():
return $default(_that.homeDir,_that.version,_that.profileKey,_that.configAgeSecretKey,_that.cloudDomains);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'home-dir')  String homeDir,  int version, @JsonKey(name: 'profile-key')  String profileKey, @JsonKey(name: 'config-age-secret-key')  String configAgeSecretKey, @JsonKey(name: 'cloud-domains')  List<String> cloudDomains)?  $default,) {final _that = this;
switch (_that) {
case _InitParams() when $default != null:
return $default(_that.homeDir,_that.version,_that.profileKey,_that.configAgeSecretKey,_that.cloudDomains);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitParams implements InitParams {
  const _InitParams({@JsonKey(name: 'home-dir') required this.homeDir, required this.version, @JsonKey(name: 'profile-key') this.profileKey = '', @JsonKey(name: 'config-age-secret-key') this.configAgeSecretKey = '', @JsonKey(name: 'cloud-domains')  List<String> cloudDomains = const []}): _cloudDomains = cloudDomains;
  factory _InitParams.fromJson(Map<String, dynamic> json) => _$InitParamsFromJson(json);

@override@JsonKey(name: 'home-dir') final  String homeDir;
@override final  int version;
@override@JsonKey(name: 'profile-key') final  String profileKey;
@override@JsonKey(name: 'config-age-secret-key') final  String configAgeSecretKey;
 final  List<String> _cloudDomains;
@override@JsonKey(name: 'cloud-domains') List<String> get cloudDomains {
  if (_cloudDomains is EqualUnmodifiableListView) return _cloudDomains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cloudDomains);
}


/// Create a copy of InitParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitParamsCopyWith<_InitParams> get copyWith => __$InitParamsCopyWithImpl<_InitParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitParamsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitParams&&(identical(other.homeDir, homeDir) || other.homeDir == homeDir)&&(identical(other.version, version) || other.version == version)&&(identical(other.profileKey, profileKey) || other.profileKey == profileKey)&&(identical(other.configAgeSecretKey, configAgeSecretKey) || other.configAgeSecretKey == configAgeSecretKey)&&const DeepCollectionEquality().equals(other.cloudDomains, _cloudDomains));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,homeDir,version,profileKey,configAgeSecretKey,const DeepCollectionEquality().hash(_cloudDomains));
}

@override
String toString() {
    return 'InitParams(homeDir: $homeDir, version: $version, profileKey: $profileKey, configAgeSecretKey: $configAgeSecretKey, cloudDomains: $cloudDomains)';
}


}

/// @nodoc
abstract mixin class _$InitParamsCopyWith<$Res> implements $InitParamsCopyWith<$Res> {
  factory _$InitParamsCopyWith(_InitParams value, $Res Function(_InitParams) _then) = __$InitParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'home-dir') String homeDir, int version,@JsonKey(name: 'profile-key') String profileKey,@JsonKey(name: 'config-age-secret-key') String configAgeSecretKey,@JsonKey(name: 'cloud-domains') List<String> cloudDomains
});




}
/// @nodoc
class __$InitParamsCopyWithImpl<$Res>
    implements _$InitParamsCopyWith<$Res> {
  __$InitParamsCopyWithImpl(this._self, this._then);

  final _InitParams _self;
  final $Res Function(_InitParams) _then;

/// Create a copy of InitParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? homeDir = null,Object? version = null,Object? profileKey = null,Object? configAgeSecretKey = null,Object? cloudDomains = null,}) {
  return _then(_InitParams(
homeDir: null == homeDir ? _self.homeDir : homeDir // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,profileKey: null == profileKey ? _self.profileKey : profileKey // ignore: cast_nullable_to_non_nullable
as String,configAgeSecretKey: null == configAgeSecretKey ? _self.configAgeSecretKey : configAgeSecretKey // ignore: cast_nullable_to_non_nullable
as String,cloudDomains: null == cloudDomains ? _self._cloudDomains : cloudDomains // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ChangeProxyParams {

@JsonKey(name: 'group-name') String get groupName;@JsonKey(name: 'proxy-name') String get proxyName;
/// Create a copy of ChangeProxyParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeProxyParamsCopyWith<ChangeProxyParams> get copyWith => _$ChangeProxyParamsCopyWithImpl<ChangeProxyParams>(this as ChangeProxyParams, _$identity);

  /// Serializes this ChangeProxyParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChangeProxyParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeProxyParams&&(identical(other.groupName, _this.groupName) || other.groupName == _this.groupName)&&(identical(other.proxyName, _this.proxyName) || other.proxyName == _this.proxyName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChangeProxyParams;
  return Object.hash(runtimeType,_this.groupName,_this.proxyName);
}

@override
String toString() {
  final _this = this as ChangeProxyParams;
  return 'ChangeProxyParams(groupName: ${_this.groupName}, proxyName: ${_this.proxyName})';
}


}

/// @nodoc
abstract mixin class $ChangeProxyParamsCopyWith<$Res>  {
  factory $ChangeProxyParamsCopyWith(ChangeProxyParams value, $Res Function(ChangeProxyParams) _then) = _$ChangeProxyParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'group-name') String groupName,@JsonKey(name: 'proxy-name') String proxyName
});




}
/// @nodoc
class _$ChangeProxyParamsCopyWithImpl<$Res>
    implements $ChangeProxyParamsCopyWith<$Res> {
  _$ChangeProxyParamsCopyWithImpl(this._self, this._then);

  final ChangeProxyParams _self;
  final $Res Function(ChangeProxyParams) _then;

/// Create a copy of ChangeProxyParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupName = null,Object? proxyName = null,}) {
  return _then(ChangeProxyParams(
groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,proxyName: null == proxyName ? _self.proxyName : proxyName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangeProxyParams].
extension ChangeProxyParamsPatterns on ChangeProxyParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangeProxyParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangeProxyParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangeProxyParams value)  $default,){
final _that = this;
switch (_that) {
case _ChangeProxyParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangeProxyParams value)?  $default,){
final _that = this;
switch (_that) {
case _ChangeProxyParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'group-name')  String groupName, @JsonKey(name: 'proxy-name')  String proxyName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangeProxyParams() when $default != null:
return $default(_that.groupName,_that.proxyName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'group-name')  String groupName, @JsonKey(name: 'proxy-name')  String proxyName)  $default,) {final _that = this;
switch (_that) {
case _ChangeProxyParams():
return $default(_that.groupName,_that.proxyName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'group-name')  String groupName, @JsonKey(name: 'proxy-name')  String proxyName)?  $default,) {final _that = this;
switch (_that) {
case _ChangeProxyParams() when $default != null:
return $default(_that.groupName,_that.proxyName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangeProxyParams implements ChangeProxyParams {
  const _ChangeProxyParams({@JsonKey(name: 'group-name') required this.groupName, @JsonKey(name: 'proxy-name') required this.proxyName});
  factory _ChangeProxyParams.fromJson(Map<String, dynamic> json) => _$ChangeProxyParamsFromJson(json);

@override@JsonKey(name: 'group-name') final  String groupName;
@override@JsonKey(name: 'proxy-name') final  String proxyName;

/// Create a copy of ChangeProxyParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeProxyParamsCopyWith<_ChangeProxyParams> get copyWith => __$ChangeProxyParamsCopyWithImpl<_ChangeProxyParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangeProxyParamsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeProxyParams&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.proxyName, proxyName) || other.proxyName == proxyName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,groupName,proxyName);
}

@override
String toString() {
    return 'ChangeProxyParams(groupName: $groupName, proxyName: $proxyName)';
}


}

/// @nodoc
abstract mixin class _$ChangeProxyParamsCopyWith<$Res> implements $ChangeProxyParamsCopyWith<$Res> {
  factory _$ChangeProxyParamsCopyWith(_ChangeProxyParams value, $Res Function(_ChangeProxyParams) _then) = __$ChangeProxyParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'group-name') String groupName,@JsonKey(name: 'proxy-name') String proxyName
});




}
/// @nodoc
class __$ChangeProxyParamsCopyWithImpl<$Res>
    implements _$ChangeProxyParamsCopyWith<$Res> {
  __$ChangeProxyParamsCopyWithImpl(this._self, this._then);

  final _ChangeProxyParams _self;
  final $Res Function(_ChangeProxyParams) _then;

/// Create a copy of ChangeProxyParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupName = null,Object? proxyName = null,}) {
  return _then(_ChangeProxyParams(
groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,proxyName: null == proxyName ? _self.proxyName : proxyName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChangeProxyResult {

 String get message; bool get changed;
/// Create a copy of ChangeProxyResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeProxyResultCopyWith<ChangeProxyResult> get copyWith => _$ChangeProxyResultCopyWithImpl<ChangeProxyResult>(this as ChangeProxyResult, _$identity);

  /// Serializes this ChangeProxyResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChangeProxyResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeProxyResult&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.changed, _this.changed) || other.changed == _this.changed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChangeProxyResult;
  return Object.hash(runtimeType,_this.message,_this.changed);
}

@override
String toString() {
  final _this = this as ChangeProxyResult;
  return 'ChangeProxyResult(message: ${_this.message}, changed: ${_this.changed})';
}


}

/// @nodoc
abstract mixin class $ChangeProxyResultCopyWith<$Res>  {
  factory $ChangeProxyResultCopyWith(ChangeProxyResult value, $Res Function(ChangeProxyResult) _then) = _$ChangeProxyResultCopyWithImpl;
@useResult
$Res call({
 String message, bool changed
});




}
/// @nodoc
class _$ChangeProxyResultCopyWithImpl<$Res>
    implements $ChangeProxyResultCopyWith<$Res> {
  _$ChangeProxyResultCopyWithImpl(this._self, this._then);

  final ChangeProxyResult _self;
  final $Res Function(ChangeProxyResult) _then;

/// Create a copy of ChangeProxyResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? changed = null,}) {
  return _then(ChangeProxyResult(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,changed: null == changed ? _self.changed : changed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangeProxyResult].
extension ChangeProxyResultPatterns on ChangeProxyResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangeProxyResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangeProxyResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangeProxyResult value)  $default,){
final _that = this;
switch (_that) {
case _ChangeProxyResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangeProxyResult value)?  $default,){
final _that = this;
switch (_that) {
case _ChangeProxyResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  bool changed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangeProxyResult() when $default != null:
return $default(_that.message,_that.changed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  bool changed)  $default,) {final _that = this;
switch (_that) {
case _ChangeProxyResult():
return $default(_that.message,_that.changed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  bool changed)?  $default,) {final _that = this;
switch (_that) {
case _ChangeProxyResult() when $default != null:
return $default(_that.message,_that.changed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangeProxyResult implements ChangeProxyResult {
  const _ChangeProxyResult({this.message = '', this.changed = false});
  factory _ChangeProxyResult.fromJson(Map<String, dynamic> json) => _$ChangeProxyResultFromJson(json);

@override@JsonKey() final  String message;
@override@JsonKey() final  bool changed;

/// Create a copy of ChangeProxyResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeProxyResultCopyWith<_ChangeProxyResult> get copyWith => __$ChangeProxyResultCopyWithImpl<_ChangeProxyResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangeProxyResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeProxyResult&&(identical(other.message, message) || other.message == message)&&(identical(other.changed, changed) || other.changed == changed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,message,changed);
}

@override
String toString() {
    return 'ChangeProxyResult(message: $message, changed: $changed)';
}


}

/// @nodoc
abstract mixin class _$ChangeProxyResultCopyWith<$Res> implements $ChangeProxyResultCopyWith<$Res> {
  factory _$ChangeProxyResultCopyWith(_ChangeProxyResult value, $Res Function(_ChangeProxyResult) _then) = __$ChangeProxyResultCopyWithImpl;
@override @useResult
$Res call({
 String message, bool changed
});




}
/// @nodoc
class __$ChangeProxyResultCopyWithImpl<$Res>
    implements _$ChangeProxyResultCopyWith<$Res> {
  __$ChangeProxyResultCopyWithImpl(this._self, this._then);

  final _ChangeProxyResult _self;
  final $Res Function(_ChangeProxyResult) _then;

/// Create a copy of ChangeProxyResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? changed = null,}) {
  return _then(_ChangeProxyResult(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,changed: null == changed ? _self.changed : changed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UpdateGeoDataParams {

@JsonKey(name: 'geo-type') String get geoType;@JsonKey(name: 'geo-name') String get geoName; String get url;
/// Create a copy of UpdateGeoDataParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateGeoDataParamsCopyWith<UpdateGeoDataParams> get copyWith => _$UpdateGeoDataParamsCopyWithImpl<UpdateGeoDataParams>(this as UpdateGeoDataParams, _$identity);

  /// Serializes this UpdateGeoDataParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpdateGeoDataParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateGeoDataParams&&(identical(other.geoType, _this.geoType) || other.geoType == _this.geoType)&&(identical(other.geoName, _this.geoName) || other.geoName == _this.geoName)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpdateGeoDataParams;
  return Object.hash(runtimeType,_this.geoType,_this.geoName,_this.url);
}

@override
String toString() {
  final _this = this as UpdateGeoDataParams;
  return 'UpdateGeoDataParams(geoType: ${_this.geoType}, geoName: ${_this.geoName}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $UpdateGeoDataParamsCopyWith<$Res>  {
  factory $UpdateGeoDataParamsCopyWith(UpdateGeoDataParams value, $Res Function(UpdateGeoDataParams) _then) = _$UpdateGeoDataParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'geo-type') String geoType,@JsonKey(name: 'geo-name') String geoName, String url
});




}
/// @nodoc
class _$UpdateGeoDataParamsCopyWithImpl<$Res>
    implements $UpdateGeoDataParamsCopyWith<$Res> {
  _$UpdateGeoDataParamsCopyWithImpl(this._self, this._then);

  final UpdateGeoDataParams _self;
  final $Res Function(UpdateGeoDataParams) _then;

/// Create a copy of UpdateGeoDataParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? geoType = null,Object? geoName = null,Object? url = null,}) {
  return _then(UpdateGeoDataParams(
geoType: null == geoType ? _self.geoType : geoType // ignore: cast_nullable_to_non_nullable
as String,geoName: null == geoName ? _self.geoName : geoName // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateGeoDataParams].
extension UpdateGeoDataParamsPatterns on UpdateGeoDataParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateGeoDataParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateGeoDataParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateGeoDataParams value)  $default,){
final _that = this;
switch (_that) {
case _UpdateGeoDataParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateGeoDataParams value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateGeoDataParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'geo-type')  String geoType, @JsonKey(name: 'geo-name')  String geoName,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateGeoDataParams() when $default != null:
return $default(_that.geoType,_that.geoName,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'geo-type')  String geoType, @JsonKey(name: 'geo-name')  String geoName,  String url)  $default,) {final _that = this;
switch (_that) {
case _UpdateGeoDataParams():
return $default(_that.geoType,_that.geoName,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'geo-type')  String geoType, @JsonKey(name: 'geo-name')  String geoName,  String url)?  $default,) {final _that = this;
switch (_that) {
case _UpdateGeoDataParams() when $default != null:
return $default(_that.geoType,_that.geoName,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateGeoDataParams implements UpdateGeoDataParams {
  const _UpdateGeoDataParams({@JsonKey(name: 'geo-type') required this.geoType, @JsonKey(name: 'geo-name') required this.geoName, required this.url});
  factory _UpdateGeoDataParams.fromJson(Map<String, dynamic> json) => _$UpdateGeoDataParamsFromJson(json);

@override@JsonKey(name: 'geo-type') final  String geoType;
@override@JsonKey(name: 'geo-name') final  String geoName;
@override final  String url;

/// Create a copy of UpdateGeoDataParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateGeoDataParamsCopyWith<_UpdateGeoDataParams> get copyWith => __$UpdateGeoDataParamsCopyWithImpl<_UpdateGeoDataParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateGeoDataParamsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateGeoDataParams&&(identical(other.geoType, geoType) || other.geoType == geoType)&&(identical(other.geoName, geoName) || other.geoName == geoName)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,geoType,geoName,url);
}

@override
String toString() {
    return 'UpdateGeoDataParams(geoType: $geoType, geoName: $geoName, url: $url)';
}


}

/// @nodoc
abstract mixin class _$UpdateGeoDataParamsCopyWith<$Res> implements $UpdateGeoDataParamsCopyWith<$Res> {
  factory _$UpdateGeoDataParamsCopyWith(_UpdateGeoDataParams value, $Res Function(_UpdateGeoDataParams) _then) = __$UpdateGeoDataParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'geo-type') String geoType,@JsonKey(name: 'geo-name') String geoName, String url
});




}
/// @nodoc
class __$UpdateGeoDataParamsCopyWithImpl<$Res>
    implements _$UpdateGeoDataParamsCopyWith<$Res> {
  __$UpdateGeoDataParamsCopyWithImpl(this._self, this._then);

  final _UpdateGeoDataParams _self;
  final $Res Function(_UpdateGeoDataParams) _then;

/// Create a copy of UpdateGeoDataParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? geoType = null,Object? geoName = null,Object? url = null,}) {
  return _then(_UpdateGeoDataParams(
geoType: null == geoType ? _self.geoType : geoType // ignore: cast_nullable_to_non_nullable
as String,geoName: null == geoName ? _self.geoName : geoName // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CoreEvent {

 CoreEventType get type; dynamic get data;
/// Create a copy of CoreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreEventCopyWith<CoreEvent> get copyWith => _$CoreEventCopyWithImpl<CoreEvent>(this as CoreEvent, _$identity);

  /// Serializes this CoreEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CoreEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreEvent&&(identical(other.type, _this.type) || other.type == _this.type)&&const DeepCollectionEquality().equals(other.data, _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CoreEvent;
  return Object.hash(runtimeType,_this.type,const DeepCollectionEquality().hash(_this.data));
}

@override
String toString() {
  final _this = this as CoreEvent;
  return 'CoreEvent(type: ${_this.type}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $CoreEventCopyWith<$Res>  {
  factory $CoreEventCopyWith(CoreEvent value, $Res Function(CoreEvent) _then) = _$CoreEventCopyWithImpl;
@useResult
$Res call({
 CoreEventType type, dynamic data
});




}
/// @nodoc
class _$CoreEventCopyWithImpl<$Res>
    implements $CoreEventCopyWith<$Res> {
  _$CoreEventCopyWithImpl(this._self, this._then);

  final CoreEvent _self;
  final $Res Function(CoreEvent) _then;

/// Create a copy of CoreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? data = freezed,}) {
  return _then(CoreEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CoreEventType,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [CoreEvent].
extension CoreEventPatterns on CoreEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoreEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoreEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoreEvent value)  $default,){
final _that = this;
switch (_that) {
case _CoreEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoreEvent value)?  $default,){
final _that = this;
switch (_that) {
case _CoreEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CoreEventType type,  dynamic data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoreEvent() when $default != null:
return $default(_that.type,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CoreEventType type,  dynamic data)  $default,) {final _that = this;
switch (_that) {
case _CoreEvent():
return $default(_that.type,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CoreEventType type,  dynamic data)?  $default,) {final _that = this;
switch (_that) {
case _CoreEvent() when $default != null:
return $default(_that.type,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoreEvent implements CoreEvent {
  const _CoreEvent({required this.type, this.data});
  factory _CoreEvent.fromJson(Map<String, dynamic> json) => _$CoreEventFromJson(json);

@override final  CoreEventType type;
@override final  dynamic data;

/// Create a copy of CoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoreEventCopyWith<_CoreEvent> get copyWith => __$CoreEventCopyWithImpl<_CoreEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoreEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoreEvent&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,const DeepCollectionEquality().hash(data));
}

@override
String toString() {
    return 'CoreEvent(type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CoreEventCopyWith<$Res> implements $CoreEventCopyWith<$Res> {
  factory _$CoreEventCopyWith(_CoreEvent value, $Res Function(_CoreEvent) _then) = __$CoreEventCopyWithImpl;
@override @useResult
$Res call({
 CoreEventType type, dynamic data
});




}
/// @nodoc
class __$CoreEventCopyWithImpl<$Res>
    implements _$CoreEventCopyWith<$Res> {
  __$CoreEventCopyWithImpl(this._self, this._then);

  final _CoreEvent _self;
  final $Res Function(_CoreEvent) _then;

/// Create a copy of CoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? data = freezed,}) {
  return _then(_CoreEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CoreEventType,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$Delay {

 String get name; String get url; int? get value;@JsonKey(unknownEnumValue: DelayFailure.other) DelayFailure? get failure;
/// Create a copy of Delay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DelayCopyWith<Delay> get copyWith => _$DelayCopyWithImpl<Delay>(this as Delay, _$identity);

  /// Serializes this Delay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Delay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Delay&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Delay;
  return Object.hash(runtimeType,_this.name,_this.url,_this.value,_this.failure);
}

@override
String toString() {
  final _this = this as Delay;
  return 'Delay(name: ${_this.name}, url: ${_this.url}, value: ${_this.value}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $DelayCopyWith<$Res>  {
  factory $DelayCopyWith(Delay value, $Res Function(Delay) _then) = _$DelayCopyWithImpl;
@useResult
$Res call({
 String name, String url, int? value,@JsonKey(unknownEnumValue: DelayFailure.other) DelayFailure? failure
});




}
/// @nodoc
class _$DelayCopyWithImpl<$Res>
    implements $DelayCopyWith<$Res> {
  _$DelayCopyWithImpl(this._self, this._then);

  final Delay _self;
  final $Res Function(Delay) _then;

/// Create a copy of Delay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,Object? value = freezed,Object? failure = freezed,}) {
  return _then(Delay(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as DelayFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [Delay].
extension DelayPatterns on Delay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Delay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Delay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Delay value)  $default,){
final _that = this;
switch (_that) {
case _Delay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Delay value)?  $default,){
final _that = this;
switch (_that) {
case _Delay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String url,  int? value, @JsonKey(unknownEnumValue: DelayFailure.other)  DelayFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Delay() when $default != null:
return $default(_that.name,_that.url,_that.value,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String url,  int? value, @JsonKey(unknownEnumValue: DelayFailure.other)  DelayFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _Delay():
return $default(_that.name,_that.url,_that.value,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String url,  int? value, @JsonKey(unknownEnumValue: DelayFailure.other)  DelayFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _Delay() when $default != null:
return $default(_that.name,_that.url,_that.value,_that.failure);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Delay implements Delay {
  const _Delay({required this.name, required this.url, this.value, @JsonKey(unknownEnumValue: DelayFailure.other) this.failure});
  factory _Delay.fromJson(Map<String, dynamic> json) => _$DelayFromJson(json);

@override final  String name;
@override final  String url;
@override final  int? value;
@override@JsonKey(unknownEnumValue: DelayFailure.other) final  DelayFailure? failure;

/// Create a copy of Delay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DelayCopyWith<_Delay> get copyWith => __$DelayCopyWithImpl<_Delay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DelayToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Delay&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.value, value) || other.value == value)&&(identical(other.failure, failure) || other.failure == failure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,url,value,failure);
}

@override
String toString() {
    return 'Delay(name: $name, url: $url, value: $value, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DelayCopyWith<$Res> implements $DelayCopyWith<$Res> {
  factory _$DelayCopyWith(_Delay value, $Res Function(_Delay) _then) = __$DelayCopyWithImpl;
@override @useResult
$Res call({
 String name, String url, int? value,@JsonKey(unknownEnumValue: DelayFailure.other) DelayFailure? failure
});




}
/// @nodoc
class __$DelayCopyWithImpl<$Res>
    implements _$DelayCopyWith<$Res> {
  __$DelayCopyWithImpl(this._self, this._then);

  final _Delay _self;
  final $Res Function(_Delay) _then;

/// Create a copy of Delay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,Object? value = freezed,Object? failure = freezed,}) {
  return _then(_Delay(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as DelayFailure?,
  ));
}


}


/// @nodoc
mixin _$Now {

 String get name; String get value;
/// Create a copy of Now
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NowCopyWith<Now> get copyWith => _$NowCopyWithImpl<Now>(this as Now, _$identity);

  /// Serializes this Now to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Now;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Now&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.value, _this.value) || other.value == _this.value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Now;
  return Object.hash(runtimeType,_this.name,_this.value);
}

@override
String toString() {
  final _this = this as Now;
  return 'Now(name: ${_this.name}, value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $NowCopyWith<$Res>  {
  factory $NowCopyWith(Now value, $Res Function(Now) _then) = _$NowCopyWithImpl;
@useResult
$Res call({
 String name, String value
});




}
/// @nodoc
class _$NowCopyWithImpl<$Res>
    implements $NowCopyWith<$Res> {
  _$NowCopyWithImpl(this._self, this._then);

  final Now _self;
  final $Res Function(Now) _then;

/// Create a copy of Now
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = null,}) {
  return _then(Now(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Now].
extension NowPatterns on Now {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Now value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Now() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Now value)  $default,){
final _that = this;
switch (_that) {
case _Now():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Now value)?  $default,){
final _that = this;
switch (_that) {
case _Now() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Now() when $default != null:
return $default(_that.name,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String value)  $default,) {final _that = this;
switch (_that) {
case _Now():
return $default(_that.name,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String value)?  $default,) {final _that = this;
switch (_that) {
case _Now() when $default != null:
return $default(_that.name,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Now implements Now {
  const _Now({required this.name, required this.value});
  factory _Now.fromJson(Map<String, dynamic> json) => _$NowFromJson(json);

@override final  String name;
@override final  String value;

/// Create a copy of Now
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NowCopyWith<_Now> get copyWith => __$NowCopyWithImpl<_Now>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NowToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Now&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,value);
}

@override
String toString() {
    return 'Now(name: $name, value: $value)';
}


}

/// @nodoc
abstract mixin class _$NowCopyWith<$Res> implements $NowCopyWith<$Res> {
  factory _$NowCopyWith(_Now value, $Res Function(_Now) _then) = __$NowCopyWithImpl;
@override @useResult
$Res call({
 String name, String value
});




}
/// @nodoc
class __$NowCopyWithImpl<$Res>
    implements _$NowCopyWith<$Res> {
  __$NowCopyWithImpl(this._self, this._then);

  final _Now _self;
  final $Res Function(_Now) _then;

/// Create a copy of Now
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? value = null,}) {
  return _then(_Now(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExternalProvider {

 String get name; String get type;@JsonKey(name: 'content-version') String get contentVersion; String? get path; int get count;@JsonKey(name: 'subscription-info', fromJson: subscriptionInfoFormCore) SubscriptionInfo? get subscriptionInfo;@JsonKey(name: 'vehicle-type') String get vehicleType;@JsonKey(name: 'update-at') DateTime get updateAt;
/// Create a copy of ExternalProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExternalProviderCopyWith<ExternalProvider> get copyWith => _$ExternalProviderCopyWithImpl<ExternalProvider>(this as ExternalProvider, _$identity);

  /// Serializes this ExternalProvider to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExternalProvider;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExternalProvider&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.contentVersion, _this.contentVersion) || other.contentVersion == _this.contentVersion)&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.subscriptionInfo, _this.subscriptionInfo) || other.subscriptionInfo == _this.subscriptionInfo)&&(identical(other.vehicleType, _this.vehicleType) || other.vehicleType == _this.vehicleType)&&(identical(other.updateAt, _this.updateAt) || other.updateAt == _this.updateAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExternalProvider;
  return Object.hash(runtimeType,_this.name,_this.type,_this.contentVersion,_this.path,_this.count,_this.subscriptionInfo,_this.vehicleType,_this.updateAt);
}

@override
String toString() {
  final _this = this as ExternalProvider;
  return 'ExternalProvider(name: ${_this.name}, type: ${_this.type}, contentVersion: ${_this.contentVersion}, path: ${_this.path}, count: ${_this.count}, subscriptionInfo: ${_this.subscriptionInfo}, vehicleType: ${_this.vehicleType}, updateAt: ${_this.updateAt})';
}


}

/// @nodoc
abstract mixin class $ExternalProviderCopyWith<$Res>  {
  factory $ExternalProviderCopyWith(ExternalProvider value, $Res Function(ExternalProvider) _then) = _$ExternalProviderCopyWithImpl;
@useResult
$Res call({
 String name, String type,@JsonKey(name: 'content-version') String contentVersion, String? path, int count,@JsonKey(name: 'subscription-info', fromJson: subscriptionInfoFormCore) SubscriptionInfo? subscriptionInfo,@JsonKey(name: 'vehicle-type') String vehicleType,@JsonKey(name: 'update-at') DateTime updateAt
});


$SubscriptionInfoCopyWith<$Res>? get subscriptionInfo;

}
/// @nodoc
class _$ExternalProviderCopyWithImpl<$Res>
    implements $ExternalProviderCopyWith<$Res> {
  _$ExternalProviderCopyWithImpl(this._self, this._then);

  final ExternalProvider _self;
  final $Res Function(ExternalProvider) _then;

/// Create a copy of ExternalProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,Object? contentVersion = null,Object? path = freezed,Object? count = null,Object? subscriptionInfo = freezed,Object? vehicleType = null,Object? updateAt = null,}) {
  return _then(ExternalProvider(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,subscriptionInfo: freezed == subscriptionInfo ? _self.subscriptionInfo : subscriptionInfo // ignore: cast_nullable_to_non_nullable
as SubscriptionInfo?,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String,updateAt: null == updateAt ? _self.updateAt : updateAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ExternalProvider
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
}
}


/// Adds pattern-matching-related methods to [ExternalProvider].
extension ExternalProviderPatterns on ExternalProvider {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExternalProvider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExternalProvider() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExternalProvider value)  $default,){
final _that = this;
switch (_that) {
case _ExternalProvider():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExternalProvider value)?  $default,){
final _that = this;
switch (_that) {
case _ExternalProvider() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String type, @JsonKey(name: 'content-version')  String contentVersion,  String? path,  int count, @JsonKey(name: 'subscription-info', fromJson: subscriptionInfoFormCore)  SubscriptionInfo? subscriptionInfo, @JsonKey(name: 'vehicle-type')  String vehicleType, @JsonKey(name: 'update-at')  DateTime updateAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExternalProvider() when $default != null:
return $default(_that.name,_that.type,_that.contentVersion,_that.path,_that.count,_that.subscriptionInfo,_that.vehicleType,_that.updateAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String type, @JsonKey(name: 'content-version')  String contentVersion,  String? path,  int count, @JsonKey(name: 'subscription-info', fromJson: subscriptionInfoFormCore)  SubscriptionInfo? subscriptionInfo, @JsonKey(name: 'vehicle-type')  String vehicleType, @JsonKey(name: 'update-at')  DateTime updateAt)  $default,) {final _that = this;
switch (_that) {
case _ExternalProvider():
return $default(_that.name,_that.type,_that.contentVersion,_that.path,_that.count,_that.subscriptionInfo,_that.vehicleType,_that.updateAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String type, @JsonKey(name: 'content-version')  String contentVersion,  String? path,  int count, @JsonKey(name: 'subscription-info', fromJson: subscriptionInfoFormCore)  SubscriptionInfo? subscriptionInfo, @JsonKey(name: 'vehicle-type')  String vehicleType, @JsonKey(name: 'update-at')  DateTime updateAt)?  $default,) {final _that = this;
switch (_that) {
case _ExternalProvider() when $default != null:
return $default(_that.name,_that.type,_that.contentVersion,_that.path,_that.count,_that.subscriptionInfo,_that.vehicleType,_that.updateAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExternalProvider implements ExternalProvider {
  const _ExternalProvider({required this.name, required this.type, @JsonKey(name: 'content-version') this.contentVersion = '', this.path, required this.count, @JsonKey(name: 'subscription-info', fromJson: subscriptionInfoFormCore) this.subscriptionInfo, @JsonKey(name: 'vehicle-type') required this.vehicleType, @JsonKey(name: 'update-at') required this.updateAt});
  factory _ExternalProvider.fromJson(Map<String, dynamic> json) => _$ExternalProviderFromJson(json);

@override final  String name;
@override final  String type;
@override@JsonKey(name: 'content-version') final  String contentVersion;
@override final  String? path;
@override final  int count;
@override@JsonKey(name: 'subscription-info', fromJson: subscriptionInfoFormCore) final  SubscriptionInfo? subscriptionInfo;
@override@JsonKey(name: 'vehicle-type') final  String vehicleType;
@override@JsonKey(name: 'update-at') final  DateTime updateAt;

/// Create a copy of ExternalProvider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExternalProviderCopyWith<_ExternalProvider> get copyWith => __$ExternalProviderCopyWithImpl<_ExternalProvider>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExternalProviderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExternalProvider&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.path, path) || other.path == path)&&(identical(other.count, count) || other.count == count)&&(identical(other.subscriptionInfo, subscriptionInfo) || other.subscriptionInfo == subscriptionInfo)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.updateAt, updateAt) || other.updateAt == updateAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,type,contentVersion,path,count,subscriptionInfo,vehicleType,updateAt);
}

@override
String toString() {
    return 'ExternalProvider(name: $name, type: $type, contentVersion: $contentVersion, path: $path, count: $count, subscriptionInfo: $subscriptionInfo, vehicleType: $vehicleType, updateAt: $updateAt)';
}


}

/// @nodoc
abstract mixin class _$ExternalProviderCopyWith<$Res> implements $ExternalProviderCopyWith<$Res> {
  factory _$ExternalProviderCopyWith(_ExternalProvider value, $Res Function(_ExternalProvider) _then) = __$ExternalProviderCopyWithImpl;
@override @useResult
$Res call({
 String name, String type,@JsonKey(name: 'content-version') String contentVersion, String? path, int count,@JsonKey(name: 'subscription-info', fromJson: subscriptionInfoFormCore) SubscriptionInfo? subscriptionInfo,@JsonKey(name: 'vehicle-type') String vehicleType,@JsonKey(name: 'update-at') DateTime updateAt
});


@override $SubscriptionInfoCopyWith<$Res>? get subscriptionInfo;

}
/// @nodoc
class __$ExternalProviderCopyWithImpl<$Res>
    implements _$ExternalProviderCopyWith<$Res> {
  __$ExternalProviderCopyWithImpl(this._self, this._then);

  final _ExternalProvider _self;
  final $Res Function(_ExternalProvider) _then;

/// Create a copy of ExternalProvider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,Object? contentVersion = null,Object? path = freezed,Object? count = null,Object? subscriptionInfo = freezed,Object? vehicleType = null,Object? updateAt = null,}) {
  return _then(_ExternalProvider(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,subscriptionInfo: freezed == subscriptionInfo ? _self.subscriptionInfo : subscriptionInfo // ignore: cast_nullable_to_non_nullable
as SubscriptionInfo?,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String,updateAt: null == updateAt ? _self.updateAt : updateAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ExternalProvider
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
}
}


/// @nodoc
mixin _$CoreMemoryStats {

 int get rss;@JsonKey(name: 'heap-inuse') int get heapInuse;@JsonKey(name: 'heap-idle') int get heapIdle;@JsonKey(name: 'stack-inuse') int get stackInuse;@JsonKey(name: 'runtime-other') int get runtimeOther;
/// Create a copy of CoreMemoryStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreMemoryStatsCopyWith<CoreMemoryStats> get copyWith => _$CoreMemoryStatsCopyWithImpl<CoreMemoryStats>(this as CoreMemoryStats, _$identity);

  /// Serializes this CoreMemoryStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CoreMemoryStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreMemoryStats&&(identical(other.rss, _this.rss) || other.rss == _this.rss)&&(identical(other.heapInuse, _this.heapInuse) || other.heapInuse == _this.heapInuse)&&(identical(other.heapIdle, _this.heapIdle) || other.heapIdle == _this.heapIdle)&&(identical(other.stackInuse, _this.stackInuse) || other.stackInuse == _this.stackInuse)&&(identical(other.runtimeOther, _this.runtimeOther) || other.runtimeOther == _this.runtimeOther));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CoreMemoryStats;
  return Object.hash(runtimeType,_this.rss,_this.heapInuse,_this.heapIdle,_this.stackInuse,_this.runtimeOther);
}

@override
String toString() {
  final _this = this as CoreMemoryStats;
  return 'CoreMemoryStats(rss: ${_this.rss}, heapInuse: ${_this.heapInuse}, heapIdle: ${_this.heapIdle}, stackInuse: ${_this.stackInuse}, runtimeOther: ${_this.runtimeOther})';
}


}

/// @nodoc
abstract mixin class $CoreMemoryStatsCopyWith<$Res>  {
  factory $CoreMemoryStatsCopyWith(CoreMemoryStats value, $Res Function(CoreMemoryStats) _then) = _$CoreMemoryStatsCopyWithImpl;
@useResult
$Res call({
 int rss,@JsonKey(name: 'heap-inuse') int heapInuse,@JsonKey(name: 'heap-idle') int heapIdle,@JsonKey(name: 'stack-inuse') int stackInuse,@JsonKey(name: 'runtime-other') int runtimeOther
});




}
/// @nodoc
class _$CoreMemoryStatsCopyWithImpl<$Res>
    implements $CoreMemoryStatsCopyWith<$Res> {
  _$CoreMemoryStatsCopyWithImpl(this._self, this._then);

  final CoreMemoryStats _self;
  final $Res Function(CoreMemoryStats) _then;

/// Create a copy of CoreMemoryStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rss = null,Object? heapInuse = null,Object? heapIdle = null,Object? stackInuse = null,Object? runtimeOther = null,}) {
  return _then(CoreMemoryStats(
rss: null == rss ? _self.rss : rss // ignore: cast_nullable_to_non_nullable
as int,heapInuse: null == heapInuse ? _self.heapInuse : heapInuse // ignore: cast_nullable_to_non_nullable
as int,heapIdle: null == heapIdle ? _self.heapIdle : heapIdle // ignore: cast_nullable_to_non_nullable
as int,stackInuse: null == stackInuse ? _self.stackInuse : stackInuse // ignore: cast_nullable_to_non_nullable
as int,runtimeOther: null == runtimeOther ? _self.runtimeOther : runtimeOther // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CoreMemoryStats].
extension CoreMemoryStatsPatterns on CoreMemoryStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoreMemoryStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoreMemoryStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoreMemoryStats value)  $default,){
final _that = this;
switch (_that) {
case _CoreMemoryStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoreMemoryStats value)?  $default,){
final _that = this;
switch (_that) {
case _CoreMemoryStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rss, @JsonKey(name: 'heap-inuse')  int heapInuse, @JsonKey(name: 'heap-idle')  int heapIdle, @JsonKey(name: 'stack-inuse')  int stackInuse, @JsonKey(name: 'runtime-other')  int runtimeOther)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoreMemoryStats() when $default != null:
return $default(_that.rss,_that.heapInuse,_that.heapIdle,_that.stackInuse,_that.runtimeOther);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rss, @JsonKey(name: 'heap-inuse')  int heapInuse, @JsonKey(name: 'heap-idle')  int heapIdle, @JsonKey(name: 'stack-inuse')  int stackInuse, @JsonKey(name: 'runtime-other')  int runtimeOther)  $default,) {final _that = this;
switch (_that) {
case _CoreMemoryStats():
return $default(_that.rss,_that.heapInuse,_that.heapIdle,_that.stackInuse,_that.runtimeOther);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rss, @JsonKey(name: 'heap-inuse')  int heapInuse, @JsonKey(name: 'heap-idle')  int heapIdle, @JsonKey(name: 'stack-inuse')  int stackInuse, @JsonKey(name: 'runtime-other')  int runtimeOther)?  $default,) {final _that = this;
switch (_that) {
case _CoreMemoryStats() when $default != null:
return $default(_that.rss,_that.heapInuse,_that.heapIdle,_that.stackInuse,_that.runtimeOther);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoreMemoryStats implements CoreMemoryStats {
  const _CoreMemoryStats({this.rss = 0, @JsonKey(name: 'heap-inuse') this.heapInuse = 0, @JsonKey(name: 'heap-idle') this.heapIdle = 0, @JsonKey(name: 'stack-inuse') this.stackInuse = 0, @JsonKey(name: 'runtime-other') this.runtimeOther = 0});
  factory _CoreMemoryStats.fromJson(Map<String, dynamic> json) => _$CoreMemoryStatsFromJson(json);

@override@JsonKey() final  int rss;
@override@JsonKey(name: 'heap-inuse') final  int heapInuse;
@override@JsonKey(name: 'heap-idle') final  int heapIdle;
@override@JsonKey(name: 'stack-inuse') final  int stackInuse;
@override@JsonKey(name: 'runtime-other') final  int runtimeOther;

/// Create a copy of CoreMemoryStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoreMemoryStatsCopyWith<_CoreMemoryStats> get copyWith => __$CoreMemoryStatsCopyWithImpl<_CoreMemoryStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoreMemoryStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoreMemoryStats&&(identical(other.rss, rss) || other.rss == rss)&&(identical(other.heapInuse, heapInuse) || other.heapInuse == heapInuse)&&(identical(other.heapIdle, heapIdle) || other.heapIdle == heapIdle)&&(identical(other.stackInuse, stackInuse) || other.stackInuse == stackInuse)&&(identical(other.runtimeOther, runtimeOther) || other.runtimeOther == runtimeOther));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,rss,heapInuse,heapIdle,stackInuse,runtimeOther);
}

@override
String toString() {
    return 'CoreMemoryStats(rss: $rss, heapInuse: $heapInuse, heapIdle: $heapIdle, stackInuse: $stackInuse, runtimeOther: $runtimeOther)';
}


}

/// @nodoc
abstract mixin class _$CoreMemoryStatsCopyWith<$Res> implements $CoreMemoryStatsCopyWith<$Res> {
  factory _$CoreMemoryStatsCopyWith(_CoreMemoryStats value, $Res Function(_CoreMemoryStats) _then) = __$CoreMemoryStatsCopyWithImpl;
@override @useResult
$Res call({
 int rss,@JsonKey(name: 'heap-inuse') int heapInuse,@JsonKey(name: 'heap-idle') int heapIdle,@JsonKey(name: 'stack-inuse') int stackInuse,@JsonKey(name: 'runtime-other') int runtimeOther
});




}
/// @nodoc
class __$CoreMemoryStatsCopyWithImpl<$Res>
    implements _$CoreMemoryStatsCopyWith<$Res> {
  __$CoreMemoryStatsCopyWithImpl(this._self, this._then);

  final _CoreMemoryStats _self;
  final $Res Function(_CoreMemoryStats) _then;

/// Create a copy of CoreMemoryStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rss = null,Object? heapInuse = null,Object? heapIdle = null,Object? stackInuse = null,Object? runtimeOther = null,}) {
  return _then(_CoreMemoryStats(
rss: null == rss ? _self.rss : rss // ignore: cast_nullable_to_non_nullable
as int,heapInuse: null == heapInuse ? _self.heapInuse : heapInuse // ignore: cast_nullable_to_non_nullable
as int,heapIdle: null == heapIdle ? _self.heapIdle : heapIdle // ignore: cast_nullable_to_non_nullable
as int,stackInuse: null == stackInuse ? _self.stackInuse : stackInuse // ignore: cast_nullable_to_non_nullable
as int,runtimeOther: null == runtimeOther ? _self.runtimeOther : runtimeOther // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
