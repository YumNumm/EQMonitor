// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'headless_api_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeadlessApiIdentity {

 String get userAgent; String get version; String get platform; String get deviceId;
/// Create a copy of HeadlessApiIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadlessApiIdentityCopyWith<HeadlessApiIdentity> get copyWith => _$HeadlessApiIdentityCopyWithImpl<HeadlessApiIdentity>(this as HeadlessApiIdentity, _$identity);

  /// Serializes this HeadlessApiIdentity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadlessApiIdentity&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.version, version) || other.version == version)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userAgent,version,platform,deviceId);

@override
String toString() {
  return 'HeadlessApiIdentity(userAgent: $userAgent, version: $version, platform: $platform, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $HeadlessApiIdentityCopyWith<$Res>  {
  factory $HeadlessApiIdentityCopyWith(HeadlessApiIdentity value, $Res Function(HeadlessApiIdentity) _then) = _$HeadlessApiIdentityCopyWithImpl;
@useResult
$Res call({
 String userAgent, String version, String platform, String deviceId
});




}
/// @nodoc
class _$HeadlessApiIdentityCopyWithImpl<$Res>
    implements $HeadlessApiIdentityCopyWith<$Res> {
  _$HeadlessApiIdentityCopyWithImpl(this._self, this._then);

  final HeadlessApiIdentity _self;
  final $Res Function(HeadlessApiIdentity) _then;

/// Create a copy of HeadlessApiIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userAgent = null,Object? version = null,Object? platform = null,Object? deviceId = null,}) {
  return _then(HeadlessApiIdentity(
userAgent: null == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadlessApiIdentity].
extension HeadlessApiIdentityPatterns on HeadlessApiIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadlessApiIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadlessApiIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadlessApiIdentity value)  $default,){
final _that = this;
switch (_that) {
case _HeadlessApiIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadlessApiIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _HeadlessApiIdentity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userAgent,  String version,  String platform,  String deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadlessApiIdentity() when $default != null:
return $default(_that.userAgent,_that.version,_that.platform,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userAgent,  String version,  String platform,  String deviceId)  $default,) {final _that = this;
switch (_that) {
case _HeadlessApiIdentity():
return $default(_that.userAgent,_that.version,_that.platform,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userAgent,  String version,  String platform,  String deviceId)?  $default,) {final _that = this;
switch (_that) {
case _HeadlessApiIdentity() when $default != null:
return $default(_that.userAgent,_that.version,_that.platform,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadlessApiIdentity implements HeadlessApiIdentity {
  const _HeadlessApiIdentity({required this.userAgent, required this.version, required this.platform, required this.deviceId});
  factory _HeadlessApiIdentity.fromJson(Map<String, dynamic> json) => _$HeadlessApiIdentityFromJson(json);

@override final  String userAgent;
@override final  String version;
@override final  String platform;
@override final  String deviceId;

/// Create a copy of HeadlessApiIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadlessApiIdentityCopyWith<_HeadlessApiIdentity> get copyWith => __$HeadlessApiIdentityCopyWithImpl<_HeadlessApiIdentity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeadlessApiIdentityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadlessApiIdentity&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.version, version) || other.version == version)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userAgent,version,platform,deviceId);

@override
String toString() {
  return 'HeadlessApiIdentity(userAgent: $userAgent, version: $version, platform: $platform, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$HeadlessApiIdentityCopyWith<$Res> implements $HeadlessApiIdentityCopyWith<$Res> {
  factory _$HeadlessApiIdentityCopyWith(_HeadlessApiIdentity value, $Res Function(_HeadlessApiIdentity) _then) = __$HeadlessApiIdentityCopyWithImpl;
@override @useResult
$Res call({
 String userAgent, String version, String platform, String deviceId
});




}
/// @nodoc
class __$HeadlessApiIdentityCopyWithImpl<$Res>
    implements _$HeadlessApiIdentityCopyWith<$Res> {
  __$HeadlessApiIdentityCopyWithImpl(this._self, this._then);

  final _HeadlessApiIdentity _self;
  final $Res Function(_HeadlessApiIdentity) _then;

/// Create a copy of HeadlessApiIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userAgent = null,Object? version = null,Object? platform = null,Object? deviceId = null,}) {
  return _then(_HeadlessApiIdentity(
userAgent: null == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
