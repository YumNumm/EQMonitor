// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_me_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceMeResponse {

 String get id; DeviceType get type; DeviceLocale get locale; DeviceRegistrationType get registrationType;@JsonKey(includeIfNull: true) String? get userId; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of DeviceMeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceMeResponseCopyWith<DeviceMeResponse> get copyWith => _$DeviceMeResponseCopyWithImpl<DeviceMeResponse>(this as DeviceMeResponse, _$identity);

  /// Serializes this DeviceMeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceMeResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.registrationType, registrationType) || other.registrationType == registrationType)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,locale,registrationType,userId,createdAt,updatedAt);

@override
String toString() {
  return 'DeviceMeResponse(id: $id, type: $type, locale: $locale, registrationType: $registrationType, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DeviceMeResponseCopyWith<$Res>  {
  factory $DeviceMeResponseCopyWith(DeviceMeResponse value, $Res Function(DeviceMeResponse) _then) = _$DeviceMeResponseCopyWithImpl;
@useResult
$Res call({
 String id, DeviceType type, DeviceLocale locale, DeviceRegistrationType registrationType,@JsonKey(includeIfNull: true) String? userId, DateTime createdAt, DateTime updatedAt
});


$DeviceRegistrationTypeCopyWith<$Res> get registrationType;

}
/// @nodoc
class _$DeviceMeResponseCopyWithImpl<$Res>
    implements $DeviceMeResponseCopyWith<$Res> {
  _$DeviceMeResponseCopyWithImpl(this._self, this._then);

  final DeviceMeResponse _self;
  final $Res Function(DeviceMeResponse) _then;

/// Create a copy of DeviceMeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? locale = null,Object? registrationType = null,Object? userId = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as DeviceLocale,registrationType: null == registrationType ? _self.registrationType : registrationType // ignore: cast_nullable_to_non_nullable
as DeviceRegistrationType,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of DeviceMeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceRegistrationTypeCopyWith<$Res> get registrationType {
  
  return $DeviceRegistrationTypeCopyWith<$Res>(_self.registrationType, (value) {
    return _then(_self.copyWith(registrationType: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeviceMeResponse].
extension DeviceMeResponsePatterns on DeviceMeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceMeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceMeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceMeResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeviceMeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceMeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceMeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DeviceType type,  DeviceLocale locale,  DeviceRegistrationType registrationType, @JsonKey(includeIfNull: true)  String? userId,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceMeResponse() when $default != null:
return $default(_that.id,_that.type,_that.locale,_that.registrationType,_that.userId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DeviceType type,  DeviceLocale locale,  DeviceRegistrationType registrationType, @JsonKey(includeIfNull: true)  String? userId,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceMeResponse():
return $default(_that.id,_that.type,_that.locale,_that.registrationType,_that.userId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DeviceType type,  DeviceLocale locale,  DeviceRegistrationType registrationType, @JsonKey(includeIfNull: true)  String? userId,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceMeResponse() when $default != null:
return $default(_that.id,_that.type,_that.locale,_that.registrationType,_that.userId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceMeResponse implements DeviceMeResponse {
  const _DeviceMeResponse({required this.id, required this.type, required this.locale, required this.registrationType, @JsonKey(includeIfNull: true) required this.userId, required this.createdAt, required this.updatedAt});
  factory _DeviceMeResponse.fromJson(Map<String, dynamic> json) => _$DeviceMeResponseFromJson(json);

@override final  String id;
@override final  DeviceType type;
@override final  DeviceLocale locale;
@override final  DeviceRegistrationType registrationType;
@override@JsonKey(includeIfNull: true) final  String? userId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of DeviceMeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceMeResponseCopyWith<_DeviceMeResponse> get copyWith => __$DeviceMeResponseCopyWithImpl<_DeviceMeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceMeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceMeResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.registrationType, registrationType) || other.registrationType == registrationType)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,locale,registrationType,userId,createdAt,updatedAt);

@override
String toString() {
  return 'DeviceMeResponse(id: $id, type: $type, locale: $locale, registrationType: $registrationType, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceMeResponseCopyWith<$Res> implements $DeviceMeResponseCopyWith<$Res> {
  factory _$DeviceMeResponseCopyWith(_DeviceMeResponse value, $Res Function(_DeviceMeResponse) _then) = __$DeviceMeResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, DeviceType type, DeviceLocale locale, DeviceRegistrationType registrationType,@JsonKey(includeIfNull: true) String? userId, DateTime createdAt, DateTime updatedAt
});


@override $DeviceRegistrationTypeCopyWith<$Res> get registrationType;

}
/// @nodoc
class __$DeviceMeResponseCopyWithImpl<$Res>
    implements _$DeviceMeResponseCopyWith<$Res> {
  __$DeviceMeResponseCopyWithImpl(this._self, this._then);

  final _DeviceMeResponse _self;
  final $Res Function(_DeviceMeResponse) _then;

/// Create a copy of DeviceMeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? locale = null,Object? registrationType = null,Object? userId = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_DeviceMeResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as DeviceLocale,registrationType: null == registrationType ? _self.registrationType : registrationType // ignore: cast_nullable_to_non_nullable
as DeviceRegistrationType,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of DeviceMeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceRegistrationTypeCopyWith<$Res> get registrationType {
  
  return $DeviceRegistrationTypeCopyWith<$Res>(_self.registrationType, (value) {
    return _then(_self.copyWith(registrationType: value));
  });
}
}

// dart format on
