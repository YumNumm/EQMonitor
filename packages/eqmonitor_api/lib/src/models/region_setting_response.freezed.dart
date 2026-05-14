// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_setting_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionSettingResponse {

@JsonKey(name: 'region_id') num get regionId;@JsonKey(includeIfNull: true, name: 'region_name') String? get regionName;@JsonKey(includeIfNull: true, name: 'city_code') String? get cityCode;@JsonKey(includeIfNull: true, name: 'city_name') String? get cityName;@JsonKey(name: 'is_current_location') bool get isCurrentLocation;@JsonKey(name: 'min_jma_intensity') JmaIntensity get minJmaIntensity;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of RegionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionSettingResponseCopyWith<RegionSettingResponse> get copyWith => _$RegionSettingResponseCopyWithImpl<RegionSettingResponse>(this as RegionSettingResponse, _$identity);

  /// Serializes this RegionSettingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionSettingResponse&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,regionName,cityCode,cityName,isCurrentLocation,minJmaIntensity,createdAt,updatedAt);

@override
String toString() {
  return 'RegionSettingResponse(regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RegionSettingResponseCopyWith<$Res>  {
  factory $RegionSettingResponseCopyWith(RegionSettingResponse value, $Res Function(RegionSettingResponse) _then) = _$RegionSettingResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'region_id') num regionId,@JsonKey(includeIfNull: true, name: 'region_name') String? regionName,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: true, name: 'city_name') String? cityName,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'min_jma_intensity') JmaIntensity minJmaIntensity,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$RegionSettingResponseCopyWithImpl<$Res>
    implements $RegionSettingResponseCopyWith<$Res> {
  _$RegionSettingResponseCopyWithImpl(this._self, this._then);

  final RegionSettingResponse _self;
  final $Res Function(RegionSettingResponse) _then;

/// Create a copy of RegionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? isCurrentLocation = null,Object? minJmaIntensity = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as num,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionSettingResponse].
extension RegionSettingResponsePatterns on RegionSettingResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionSettingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionSettingResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionSettingResponse value)  $default,){
final _that = this;
switch (_that) {
case _RegionSettingResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionSettingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RegionSettingResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'region_id')  num regionId, @JsonKey(includeIfNull: true, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'city_name')  String? cityName, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_jma_intensity')  JmaIntensity minJmaIntensity, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionSettingResponse() when $default != null:
return $default(_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.isCurrentLocation,_that.minJmaIntensity,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'region_id')  num regionId, @JsonKey(includeIfNull: true, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'city_name')  String? cityName, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_jma_intensity')  JmaIntensity minJmaIntensity, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RegionSettingResponse():
return $default(_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.isCurrentLocation,_that.minJmaIntensity,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'region_id')  num regionId, @JsonKey(includeIfNull: true, name: 'region_name')  String? regionName, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'city_name')  String? cityName, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_jma_intensity')  JmaIntensity minJmaIntensity, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RegionSettingResponse() when $default != null:
return $default(_that.regionId,_that.regionName,_that.cityCode,_that.cityName,_that.isCurrentLocation,_that.minJmaIntensity,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionSettingResponse implements RegionSettingResponse {
  const _RegionSettingResponse({@JsonKey(name: 'region_id') required this.regionId, @JsonKey(includeIfNull: true, name: 'region_name') required this.regionName, @JsonKey(includeIfNull: true, name: 'city_code') required this.cityCode, @JsonKey(includeIfNull: true, name: 'city_name') required this.cityName, @JsonKey(name: 'is_current_location') required this.isCurrentLocation, @JsonKey(name: 'min_jma_intensity') required this.minJmaIntensity, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _RegionSettingResponse.fromJson(Map<String, dynamic> json) => _$RegionSettingResponseFromJson(json);

@override@JsonKey(name: 'region_id') final  num regionId;
@override@JsonKey(includeIfNull: true, name: 'region_name') final  String? regionName;
@override@JsonKey(includeIfNull: true, name: 'city_code') final  String? cityCode;
@override@JsonKey(includeIfNull: true, name: 'city_name') final  String? cityName;
@override@JsonKey(name: 'is_current_location') final  bool isCurrentLocation;
@override@JsonKey(name: 'min_jma_intensity') final  JmaIntensity minJmaIntensity;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of RegionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionSettingResponseCopyWith<_RegionSettingResponse> get copyWith => __$RegionSettingResponseCopyWithImpl<_RegionSettingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionSettingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionSettingResponse&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minJmaIntensity, minJmaIntensity) || other.minJmaIntensity == minJmaIntensity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,regionName,cityCode,cityName,isCurrentLocation,minJmaIntensity,createdAt,updatedAt);

@override
String toString() {
  return 'RegionSettingResponse(regionId: $regionId, regionName: $regionName, cityCode: $cityCode, cityName: $cityName, isCurrentLocation: $isCurrentLocation, minJmaIntensity: $minJmaIntensity, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RegionSettingResponseCopyWith<$Res> implements $RegionSettingResponseCopyWith<$Res> {
  factory _$RegionSettingResponseCopyWith(_RegionSettingResponse value, $Res Function(_RegionSettingResponse) _then) = __$RegionSettingResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'region_id') num regionId,@JsonKey(includeIfNull: true, name: 'region_name') String? regionName,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: true, name: 'city_name') String? cityName,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'min_jma_intensity') JmaIntensity minJmaIntensity,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$RegionSettingResponseCopyWithImpl<$Res>
    implements _$RegionSettingResponseCopyWith<$Res> {
  __$RegionSettingResponseCopyWithImpl(this._self, this._then);

  final _RegionSettingResponse _self;
  final $Res Function(_RegionSettingResponse) _then;

/// Create a copy of RegionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? regionName = freezed,Object? cityCode = freezed,Object? cityName = freezed,Object? isCurrentLocation = null,Object? minJmaIntensity = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RegionSettingResponse(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as num,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minJmaIntensity: null == minJmaIntensity ? _self.minJmaIntensity : minJmaIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
