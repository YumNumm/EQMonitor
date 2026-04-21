// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registered_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisteredDevice {

 String get id; DevicePlatform get platform; String? get userId; DeviceLocale get locale; String get createdAtIso; String get updatedAtIso;
/// Create a copy of RegisteredDevice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisteredDeviceCopyWith<RegisteredDevice> get copyWith => _$RegisteredDeviceCopyWithImpl<RegisteredDevice>(this as RegisteredDevice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisteredDevice&&(identical(other.id, id) || other.id == id)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.createdAtIso, createdAtIso) || other.createdAtIso == createdAtIso)&&(identical(other.updatedAtIso, updatedAtIso) || other.updatedAtIso == updatedAtIso));
}


@override
int get hashCode => Object.hash(runtimeType,id,platform,userId,locale,createdAtIso,updatedAtIso);

@override
String toString() {
  return 'RegisteredDevice(id: $id, platform: $platform, userId: $userId, locale: $locale, createdAtIso: $createdAtIso, updatedAtIso: $updatedAtIso)';
}


}

/// @nodoc
abstract mixin class $RegisteredDeviceCopyWith<$Res>  {
  factory $RegisteredDeviceCopyWith(RegisteredDevice value, $Res Function(RegisteredDevice) _then) = _$RegisteredDeviceCopyWithImpl;
@useResult
$Res call({
 String id, DevicePlatform platform, String? userId, DeviceLocale locale, String createdAtIso, String updatedAtIso
});




}
/// @nodoc
class _$RegisteredDeviceCopyWithImpl<$Res>
    implements $RegisteredDeviceCopyWith<$Res> {
  _$RegisteredDeviceCopyWithImpl(this._self, this._then);

  final RegisteredDevice _self;
  final $Res Function(RegisteredDevice) _then;

/// Create a copy of RegisteredDevice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? platform = null,Object? userId = freezed,Object? locale = null,Object? createdAtIso = null,Object? updatedAtIso = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as DevicePlatform,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as DeviceLocale,createdAtIso: null == createdAtIso ? _self.createdAtIso : createdAtIso // ignore: cast_nullable_to_non_nullable
as String,updatedAtIso: null == updatedAtIso ? _self.updatedAtIso : updatedAtIso // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisteredDevice].
extension RegisteredDevicePatterns on RegisteredDevice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisteredDevice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisteredDevice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisteredDevice value)  $default,){
final _that = this;
switch (_that) {
case _RegisteredDevice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisteredDevice value)?  $default,){
final _that = this;
switch (_that) {
case _RegisteredDevice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DevicePlatform platform,  String? userId,  DeviceLocale locale,  String createdAtIso,  String updatedAtIso)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisteredDevice() when $default != null:
return $default(_that.id,_that.platform,_that.userId,_that.locale,_that.createdAtIso,_that.updatedAtIso);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DevicePlatform platform,  String? userId,  DeviceLocale locale,  String createdAtIso,  String updatedAtIso)  $default,) {final _that = this;
switch (_that) {
case _RegisteredDevice():
return $default(_that.id,_that.platform,_that.userId,_that.locale,_that.createdAtIso,_that.updatedAtIso);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DevicePlatform platform,  String? userId,  DeviceLocale locale,  String createdAtIso,  String updatedAtIso)?  $default,) {final _that = this;
switch (_that) {
case _RegisteredDevice() when $default != null:
return $default(_that.id,_that.platform,_that.userId,_that.locale,_that.createdAtIso,_that.updatedAtIso);case _:
  return null;

}
}

}

/// @nodoc


class _RegisteredDevice implements RegisteredDevice {
  const _RegisteredDevice({required this.id, required this.platform, required this.userId, required this.locale, required this.createdAtIso, required this.updatedAtIso});
  

@override final  String id;
@override final  DevicePlatform platform;
@override final  String? userId;
@override final  DeviceLocale locale;
@override final  String createdAtIso;
@override final  String updatedAtIso;

/// Create a copy of RegisteredDevice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisteredDeviceCopyWith<_RegisteredDevice> get copyWith => __$RegisteredDeviceCopyWithImpl<_RegisteredDevice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisteredDevice&&(identical(other.id, id) || other.id == id)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.createdAtIso, createdAtIso) || other.createdAtIso == createdAtIso)&&(identical(other.updatedAtIso, updatedAtIso) || other.updatedAtIso == updatedAtIso));
}


@override
int get hashCode => Object.hash(runtimeType,id,platform,userId,locale,createdAtIso,updatedAtIso);

@override
String toString() {
  return 'RegisteredDevice(id: $id, platform: $platform, userId: $userId, locale: $locale, createdAtIso: $createdAtIso, updatedAtIso: $updatedAtIso)';
}


}

/// @nodoc
abstract mixin class _$RegisteredDeviceCopyWith<$Res> implements $RegisteredDeviceCopyWith<$Res> {
  factory _$RegisteredDeviceCopyWith(_RegisteredDevice value, $Res Function(_RegisteredDevice) _then) = __$RegisteredDeviceCopyWithImpl;
@override @useResult
$Res call({
 String id, DevicePlatform platform, String? userId, DeviceLocale locale, String createdAtIso, String updatedAtIso
});




}
/// @nodoc
class __$RegisteredDeviceCopyWithImpl<$Res>
    implements _$RegisteredDeviceCopyWith<$Res> {
  __$RegisteredDeviceCopyWithImpl(this._self, this._then);

  final _RegisteredDevice _self;
  final $Res Function(_RegisteredDevice) _then;

/// Create a copy of RegisteredDevice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? platform = null,Object? userId = freezed,Object? locale = null,Object? createdAtIso = null,Object? updatedAtIso = null,}) {
  return _then(_RegisteredDevice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as DevicePlatform,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as DeviceLocale,createdAtIso: null == createdAtIso ? _self.createdAtIso : createdAtIso // ignore: cast_nullable_to_non_nullable
as String,updatedAtIso: null == updatedAtIso ? _self.updatedAtIso : updatedAtIso // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
