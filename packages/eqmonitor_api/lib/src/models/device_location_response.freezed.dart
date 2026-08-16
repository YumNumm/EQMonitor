// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_location_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceLocationResponse {

@JsonKey(name: 'region_id') String get regionId;@JsonKey(includeIfNull: true, name: 'city_code') String? get cityCode;@JsonKey(includeIfNull: true, name: 'tsunami_forecast_region_code') String? get tsunamiForecastRegionCode;
/// Create a copy of DeviceLocationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceLocationResponseCopyWith<DeviceLocationResponse> get copyWith => _$DeviceLocationResponseCopyWithImpl<DeviceLocationResponse>(this as DeviceLocationResponse, _$identity);

  /// Serializes this DeviceLocationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceLocationResponse&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.tsunamiForecastRegionCode, tsunamiForecastRegionCode) || other.tsunamiForecastRegionCode == tsunamiForecastRegionCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,cityCode,tsunamiForecastRegionCode);

@override
String toString() {
  return 'DeviceLocationResponse(regionId: $regionId, cityCode: $cityCode, tsunamiForecastRegionCode: $tsunamiForecastRegionCode)';
}


}

/// @nodoc
abstract mixin class $DeviceLocationResponseCopyWith<$Res>  {
  factory $DeviceLocationResponseCopyWith(DeviceLocationResponse value, $Res Function(DeviceLocationResponse) _then) = _$DeviceLocationResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'region_id') String regionId,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: true, name: 'tsunami_forecast_region_code') String? tsunamiForecastRegionCode
});




}
/// @nodoc
class _$DeviceLocationResponseCopyWithImpl<$Res>
    implements $DeviceLocationResponseCopyWith<$Res> {
  _$DeviceLocationResponseCopyWithImpl(this._self, this._then);

  final DeviceLocationResponse _self;
  final $Res Function(DeviceLocationResponse) _then;

/// Create a copy of DeviceLocationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? cityCode = freezed,Object? tsunamiForecastRegionCode = freezed,}) {
  return _then(DeviceLocationResponse(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as String,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegionCode: freezed == tsunamiForecastRegionCode ? _self.tsunamiForecastRegionCode : tsunamiForecastRegionCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceLocationResponse].
extension DeviceLocationResponsePatterns on DeviceLocationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceLocationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceLocationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceLocationResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceLocationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'region_id')  String regionId, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'tsunami_forecast_region_code')  String? tsunamiForecastRegionCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceLocationResponse() when $default != null:
return $default(_that.regionId,_that.cityCode,_that.tsunamiForecastRegionCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'region_id')  String regionId, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'tsunami_forecast_region_code')  String? tsunamiForecastRegionCode)  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationResponse():
return $default(_that.regionId,_that.cityCode,_that.tsunamiForecastRegionCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'region_id')  String regionId, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true, name: 'tsunami_forecast_region_code')  String? tsunamiForecastRegionCode)?  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationResponse() when $default != null:
return $default(_that.regionId,_that.cityCode,_that.tsunamiForecastRegionCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceLocationResponse implements DeviceLocationResponse {
  const _DeviceLocationResponse({@JsonKey(name: 'region_id') required this.regionId, @JsonKey(includeIfNull: true, name: 'city_code') required this.cityCode, @JsonKey(includeIfNull: true, name: 'tsunami_forecast_region_code') required this.tsunamiForecastRegionCode});
  factory _DeviceLocationResponse.fromJson(Map<String, dynamic> json) => _$DeviceLocationResponseFromJson(json);

@override@JsonKey(name: 'region_id') final  String regionId;
@override@JsonKey(includeIfNull: true, name: 'city_code') final  String? cityCode;
@override@JsonKey(includeIfNull: true, name: 'tsunami_forecast_region_code') final  String? tsunamiForecastRegionCode;

/// Create a copy of DeviceLocationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceLocationResponseCopyWith<_DeviceLocationResponse> get copyWith => __$DeviceLocationResponseCopyWithImpl<_DeviceLocationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceLocationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceLocationResponse&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.tsunamiForecastRegionCode, tsunamiForecastRegionCode) || other.tsunamiForecastRegionCode == tsunamiForecastRegionCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,cityCode,tsunamiForecastRegionCode);

@override
String toString() {
  return 'DeviceLocationResponse(regionId: $regionId, cityCode: $cityCode, tsunamiForecastRegionCode: $tsunamiForecastRegionCode)';
}


}

/// @nodoc
abstract mixin class _$DeviceLocationResponseCopyWith<$Res> implements $DeviceLocationResponseCopyWith<$Res> {
  factory _$DeviceLocationResponseCopyWith(_DeviceLocationResponse value, $Res Function(_DeviceLocationResponse) _then) = __$DeviceLocationResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'region_id') String regionId,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: true, name: 'tsunami_forecast_region_code') String? tsunamiForecastRegionCode
});




}
/// @nodoc
class __$DeviceLocationResponseCopyWithImpl<$Res>
    implements _$DeviceLocationResponseCopyWith<$Res> {
  __$DeviceLocationResponseCopyWithImpl(this._self, this._then);

  final _DeviceLocationResponse _self;
  final $Res Function(_DeviceLocationResponse) _then;

/// Create a copy of DeviceLocationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? cityCode = freezed,Object? tsunamiForecastRegionCode = freezed,}) {
  return _then(_DeviceLocationResponse(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as String,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegionCode: freezed == tsunamiForecastRegionCode ? _self.tsunamiForecastRegionCode : tsunamiForecastRegionCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
