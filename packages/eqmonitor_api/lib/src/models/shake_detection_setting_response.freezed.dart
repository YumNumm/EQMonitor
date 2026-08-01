// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_setting_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionSettingResponse {

 String get id;@JsonKey(includeIfNull: true, name: 'sub_region_id') String? get subRegionId;@JsonKey(includeIfNull: true, name: 'prefecture_code') String? get prefectureCode;@JsonKey(includeIfNull: true, name: 'city_code') String? get cityCode;@JsonKey(name: 'min_level') ShakeDetectionLevel get minLevel;@JsonKey(name: 'is_current_location') bool get isCurrentLocation;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of ShakeDetectionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionSettingResponseCopyWith<ShakeDetectionSettingResponse> get copyWith => _$ShakeDetectionSettingResponseCopyWithImpl<ShakeDetectionSettingResponse>(this as ShakeDetectionSettingResponse, _$identity);

  /// Serializes this ShakeDetectionSettingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionSettingResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.subRegionId, subRegionId) || other.subRegionId == subRegionId)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subRegionId,prefectureCode,cityCode,minLevel,isCurrentLocation,createdAt,updatedAt);

@override
String toString() {
  return 'ShakeDetectionSettingResponse(id: $id, subRegionId: $subRegionId, prefectureCode: $prefectureCode, cityCode: $cityCode, minLevel: $minLevel, isCurrentLocation: $isCurrentLocation, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionSettingResponseCopyWith<$Res>  {
  factory $ShakeDetectionSettingResponseCopyWith(ShakeDetectionSettingResponse value, $Res Function(ShakeDetectionSettingResponse) _then) = _$ShakeDetectionSettingResponseCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(includeIfNull: true, name: 'sub_region_id') String? subRegionId,@JsonKey(includeIfNull: true, name: 'prefecture_code') String? prefectureCode,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(name: 'min_level') ShakeDetectionLevel minLevel,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$ShakeDetectionSettingResponseCopyWithImpl<$Res>
    implements $ShakeDetectionSettingResponseCopyWith<$Res> {
  _$ShakeDetectionSettingResponseCopyWithImpl(this._self, this._then);

  final ShakeDetectionSettingResponse _self;
  final $Res Function(ShakeDetectionSettingResponse) _then;

/// Create a copy of ShakeDetectionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subRegionId = freezed,Object? prefectureCode = freezed,Object? cityCode = freezed,Object? minLevel = null,Object? isCurrentLocation = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subRegionId: freezed == subRegionId ? _self.subRegionId : subRegionId // ignore: cast_nullable_to_non_nullable
as String?,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionSettingResponse].
extension ShakeDetectionSettingResponsePatterns on ShakeDetectionSettingResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionSettingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionSettingResponse value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionSettingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(includeIfNull: true, name: 'sub_region_id')  String? subRegionId, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingResponse() when $default != null:
return $default(_that.id,_that.subRegionId,_that.prefectureCode,_that.cityCode,_that.minLevel,_that.isCurrentLocation,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(includeIfNull: true, name: 'sub_region_id')  String? subRegionId, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingResponse():
return $default(_that.id,_that.subRegionId,_that.prefectureCode,_that.cityCode,_that.minLevel,_that.isCurrentLocation,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(includeIfNull: true, name: 'sub_region_id')  String? subRegionId, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingResponse() when $default != null:
return $default(_that.id,_that.subRegionId,_that.prefectureCode,_that.cityCode,_that.minLevel,_that.isCurrentLocation,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShakeDetectionSettingResponse implements ShakeDetectionSettingResponse {
  const _ShakeDetectionSettingResponse({required this.id, @JsonKey(includeIfNull: true, name: 'sub_region_id') required this.subRegionId, @JsonKey(includeIfNull: true, name: 'prefecture_code') required this.prefectureCode, @JsonKey(includeIfNull: true, name: 'city_code') required this.cityCode, @JsonKey(name: 'min_level') required this.minLevel, @JsonKey(name: 'is_current_location') required this.isCurrentLocation, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _ShakeDetectionSettingResponse.fromJson(Map<String, dynamic> json) => _$ShakeDetectionSettingResponseFromJson(json);

@override final  String id;
@override@JsonKey(includeIfNull: true, name: 'sub_region_id') final  String? subRegionId;
@override@JsonKey(includeIfNull: true, name: 'prefecture_code') final  String? prefectureCode;
@override@JsonKey(includeIfNull: true, name: 'city_code') final  String? cityCode;
@override@JsonKey(name: 'min_level') final  ShakeDetectionLevel minLevel;
@override@JsonKey(name: 'is_current_location') final  bool isCurrentLocation;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of ShakeDetectionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionSettingResponseCopyWith<_ShakeDetectionSettingResponse> get copyWith => __$ShakeDetectionSettingResponseCopyWithImpl<_ShakeDetectionSettingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionSettingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionSettingResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.subRegionId, subRegionId) || other.subRegionId == subRegionId)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subRegionId,prefectureCode,cityCode,minLevel,isCurrentLocation,createdAt,updatedAt);

@override
String toString() {
  return 'ShakeDetectionSettingResponse(id: $id, subRegionId: $subRegionId, prefectureCode: $prefectureCode, cityCode: $cityCode, minLevel: $minLevel, isCurrentLocation: $isCurrentLocation, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionSettingResponseCopyWith<$Res> implements $ShakeDetectionSettingResponseCopyWith<$Res> {
  factory _$ShakeDetectionSettingResponseCopyWith(_ShakeDetectionSettingResponse value, $Res Function(_ShakeDetectionSettingResponse) _then) = __$ShakeDetectionSettingResponseCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(includeIfNull: true, name: 'sub_region_id') String? subRegionId,@JsonKey(includeIfNull: true, name: 'prefecture_code') String? prefectureCode,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(name: 'min_level') ShakeDetectionLevel minLevel,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$ShakeDetectionSettingResponseCopyWithImpl<$Res>
    implements _$ShakeDetectionSettingResponseCopyWith<$Res> {
  __$ShakeDetectionSettingResponseCopyWithImpl(this._self, this._then);

  final _ShakeDetectionSettingResponse _self;
  final $Res Function(_ShakeDetectionSettingResponse) _then;

/// Create a copy of ShakeDetectionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subRegionId = freezed,Object? prefectureCode = freezed,Object? cityCode = freezed,Object? minLevel = null,Object? isCurrentLocation = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ShakeDetectionSettingResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subRegionId: freezed == subRegionId ? _self.subRegionId : subRegionId // ignore: cast_nullable_to_non_nullable
as String?,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
