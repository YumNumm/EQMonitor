// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_location_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceLocationRequest {

@JsonKey(name: 'region_id') String get regionId;@JsonKey(includeIfNull: false, name: 'city_code') String? get cityCode;@JsonKey(includeIfNull: false, name: 'tsunami_forecast_region_code') String? get tsunamiForecastRegionCode;
/// Create a copy of DeviceLocationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceLocationRequestCopyWith<DeviceLocationRequest> get copyWith => _$DeviceLocationRequestCopyWithImpl<DeviceLocationRequest>(this as DeviceLocationRequest, _$identity);

  /// Serializes this DeviceLocationRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceLocationRequest&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.tsunamiForecastRegionCode, tsunamiForecastRegionCode) || other.tsunamiForecastRegionCode == tsunamiForecastRegionCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,cityCode,tsunamiForecastRegionCode);

@override
String toString() {
  return 'DeviceLocationRequest(regionId: $regionId, cityCode: $cityCode, tsunamiForecastRegionCode: $tsunamiForecastRegionCode)';
}


}

/// @nodoc
abstract mixin class $DeviceLocationRequestCopyWith<$Res>  {
  factory $DeviceLocationRequestCopyWith(DeviceLocationRequest value, $Res Function(DeviceLocationRequest) _then) = _$DeviceLocationRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'region_id') String regionId,@JsonKey(includeIfNull: false, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: false, name: 'tsunami_forecast_region_code') String? tsunamiForecastRegionCode
});




}
/// @nodoc
class _$DeviceLocationRequestCopyWithImpl<$Res>
    implements $DeviceLocationRequestCopyWith<$Res> {
  _$DeviceLocationRequestCopyWithImpl(this._self, this._then);

  final DeviceLocationRequest _self;
  final $Res Function(DeviceLocationRequest) _then;

/// Create a copy of DeviceLocationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionId = null,Object? cityCode = freezed,Object? tsunamiForecastRegionCode = freezed,}) {
  return _then(_self.copyWith(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as String,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegionCode: freezed == tsunamiForecastRegionCode ? _self.tsunamiForecastRegionCode : tsunamiForecastRegionCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceLocationRequest].
extension DeviceLocationRequestPatterns on DeviceLocationRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceLocationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceLocationRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceLocationRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceLocationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceLocationRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'region_id')  String regionId, @JsonKey(includeIfNull: false, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: false, name: 'tsunami_forecast_region_code')  String? tsunamiForecastRegionCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceLocationRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'region_id')  String regionId, @JsonKey(includeIfNull: false, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: false, name: 'tsunami_forecast_region_code')  String? tsunamiForecastRegionCode)  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'region_id')  String regionId, @JsonKey(includeIfNull: false, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: false, name: 'tsunami_forecast_region_code')  String? tsunamiForecastRegionCode)?  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationRequest() when $default != null:
return $default(_that.regionId,_that.cityCode,_that.tsunamiForecastRegionCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceLocationRequest implements DeviceLocationRequest {
  const _DeviceLocationRequest({@JsonKey(name: 'region_id') required this.regionId, @JsonKey(includeIfNull: false, name: 'city_code') this.cityCode, @JsonKey(includeIfNull: false, name: 'tsunami_forecast_region_code') this.tsunamiForecastRegionCode});
  factory _DeviceLocationRequest.fromJson(Map<String, dynamic> json) => _$DeviceLocationRequestFromJson(json);

@override@JsonKey(name: 'region_id') final  String regionId;
@override@JsonKey(includeIfNull: false, name: 'city_code') final  String? cityCode;
@override@JsonKey(includeIfNull: false, name: 'tsunami_forecast_region_code') final  String? tsunamiForecastRegionCode;

/// Create a copy of DeviceLocationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceLocationRequestCopyWith<_DeviceLocationRequest> get copyWith => __$DeviceLocationRequestCopyWithImpl<_DeviceLocationRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceLocationRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceLocationRequest&&(identical(other.regionId, regionId) || other.regionId == regionId)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.tsunamiForecastRegionCode, tsunamiForecastRegionCode) || other.tsunamiForecastRegionCode == tsunamiForecastRegionCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,regionId,cityCode,tsunamiForecastRegionCode);

@override
String toString() {
  return 'DeviceLocationRequest(regionId: $regionId, cityCode: $cityCode, tsunamiForecastRegionCode: $tsunamiForecastRegionCode)';
}


}

/// @nodoc
abstract mixin class _$DeviceLocationRequestCopyWith<$Res> implements $DeviceLocationRequestCopyWith<$Res> {
  factory _$DeviceLocationRequestCopyWith(_DeviceLocationRequest value, $Res Function(_DeviceLocationRequest) _then) = __$DeviceLocationRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'region_id') String regionId,@JsonKey(includeIfNull: false, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: false, name: 'tsunami_forecast_region_code') String? tsunamiForecastRegionCode
});




}
/// @nodoc
class __$DeviceLocationRequestCopyWithImpl<$Res>
    implements _$DeviceLocationRequestCopyWith<$Res> {
  __$DeviceLocationRequestCopyWithImpl(this._self, this._then);

  final _DeviceLocationRequest _self;
  final $Res Function(_DeviceLocationRequest) _then;

/// Create a copy of DeviceLocationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionId = null,Object? cityCode = freezed,Object? tsunamiForecastRegionCode = freezed,}) {
  return _then(_DeviceLocationRequest(
regionId: null == regionId ? _self.regionId : regionId // ignore: cast_nullable_to_non_nullable
as String,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegionCode: freezed == tsunamiForecastRegionCode ? _self.tsunamiForecastRegionCode : tsunamiForecastRegionCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
