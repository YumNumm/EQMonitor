// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_register_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceRegisterResponse {

 String get deviceId; String get deviceToken; Object? get expiresAt;
/// Create a copy of DeviceRegisterResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceRegisterResponseCopyWith<DeviceRegisterResponse> get copyWith => _$DeviceRegisterResponseCopyWithImpl<DeviceRegisterResponse>(this as DeviceRegisterResponse, _$identity);

  /// Serializes this DeviceRegisterResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceRegisterResponse&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&const DeepCollectionEquality().equals(other.expiresAt, expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,deviceToken,const DeepCollectionEquality().hash(expiresAt));

@override
String toString() {
  return 'DeviceRegisterResponse(deviceId: $deviceId, deviceToken: $deviceToken, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $DeviceRegisterResponseCopyWith<$Res>  {
  factory $DeviceRegisterResponseCopyWith(DeviceRegisterResponse value, $Res Function(DeviceRegisterResponse) _then) = _$DeviceRegisterResponseCopyWithImpl;
@useResult
$Res call({
 String deviceId, String deviceToken, Object? expiresAt
});




}
/// @nodoc
class _$DeviceRegisterResponseCopyWithImpl<$Res>
    implements $DeviceRegisterResponseCopyWith<$Res> {
  _$DeviceRegisterResponseCopyWithImpl(this._self, this._then);

  final DeviceRegisterResponse _self;
  final $Res Function(DeviceRegisterResponse) _then;

/// Create a copy of DeviceRegisterResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? deviceToken = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceToken: null == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt ,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceRegisterResponse].
extension DeviceRegisterResponsePatterns on DeviceRegisterResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceRegisterResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceRegisterResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceRegisterResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeviceRegisterResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceRegisterResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceRegisterResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  String deviceToken,  Object? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceRegisterResponse() when $default != null:
return $default(_that.deviceId,_that.deviceToken,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  String deviceToken,  Object? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceRegisterResponse():
return $default(_that.deviceId,_that.deviceToken,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  String deviceToken,  Object? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceRegisterResponse() when $default != null:
return $default(_that.deviceId,_that.deviceToken,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceRegisterResponse implements DeviceRegisterResponse {
  const _DeviceRegisterResponse({required this.deviceId, required this.deviceToken, required this.expiresAt});
  factory _DeviceRegisterResponse.fromJson(Map<String, dynamic> json) => _$DeviceRegisterResponseFromJson(json);

@override final  String deviceId;
@override final  String deviceToken;
@override final  Object? expiresAt;

/// Create a copy of DeviceRegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceRegisterResponseCopyWith<_DeviceRegisterResponse> get copyWith => __$DeviceRegisterResponseCopyWithImpl<_DeviceRegisterResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceRegisterResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceRegisterResponse&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&const DeepCollectionEquality().equals(other.expiresAt, expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,deviceToken,const DeepCollectionEquality().hash(expiresAt));

@override
String toString() {
  return 'DeviceRegisterResponse(deviceId: $deviceId, deviceToken: $deviceToken, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceRegisterResponseCopyWith<$Res> implements $DeviceRegisterResponseCopyWith<$Res> {
  factory _$DeviceRegisterResponseCopyWith(_DeviceRegisterResponse value, $Res Function(_DeviceRegisterResponse) _then) = __$DeviceRegisterResponseCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String deviceToken, Object? expiresAt
});




}
/// @nodoc
class __$DeviceRegisterResponseCopyWithImpl<$Res>
    implements _$DeviceRegisterResponseCopyWith<$Res> {
  __$DeviceRegisterResponseCopyWithImpl(this._self, this._then);

  final _DeviceRegisterResponse _self;
  final $Res Function(_DeviceRegisterResponse) _then;

/// Create a copy of DeviceRegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? deviceToken = null,Object? expiresAt = freezed,}) {
  return _then(_DeviceRegisterResponse(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceToken: null == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt ,
  ));
}


}

// dart format on
