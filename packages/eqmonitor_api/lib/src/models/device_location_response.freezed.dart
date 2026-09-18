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

/// 気象庁防災情報XMLコード表 AreaForecastLocalE（地震情報／細分区域）のコード
 String get region;/// 気象庁防災情報XMLコード表 AreaInformationCity（気象・地震・火山情報／市町村等）のコード
@JsonKey(includeIfNull: true) String? get city;/// 気象庁防災情報XMLコード表 AreaTsunami（津波予報区）のコード
@JsonKey(includeIfNull: true) String? get tsunamiForecastRegion;
/// Create a copy of DeviceLocationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceLocationResponseCopyWith<DeviceLocationResponse> get copyWith => _$DeviceLocationResponseCopyWithImpl<DeviceLocationResponse>(this as DeviceLocationResponse, _$identity);

  /// Serializes this DeviceLocationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceLocationResponse&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.tsunamiForecastRegion, tsunamiForecastRegion) || other.tsunamiForecastRegion == tsunamiForecastRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,tsunamiForecastRegion);

@override
String toString() {
  return 'DeviceLocationResponse(region: $region, city: $city, tsunamiForecastRegion: $tsunamiForecastRegion)';
}


}

/// @nodoc
abstract mixin class $DeviceLocationResponseCopyWith<$Res>  {
  factory $DeviceLocationResponseCopyWith(DeviceLocationResponse value, $Res Function(DeviceLocationResponse) _then) = _$DeviceLocationResponseCopyWithImpl;
@useResult
$Res call({
 String region,@JsonKey(includeIfNull: true) String? city,@JsonKey(includeIfNull: true) String? tsunamiForecastRegion
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
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? city = freezed,Object? tsunamiForecastRegion = freezed,}) {
  return _then(DeviceLocationResponse(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegion: freezed == tsunamiForecastRegion ? _self.tsunamiForecastRegion : tsunamiForecastRegion // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String region, @JsonKey(includeIfNull: true)  String? city, @JsonKey(includeIfNull: true)  String? tsunamiForecastRegion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceLocationResponse() when $default != null:
return $default(_that.region,_that.city,_that.tsunamiForecastRegion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String region, @JsonKey(includeIfNull: true)  String? city, @JsonKey(includeIfNull: true)  String? tsunamiForecastRegion)  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationResponse():
return $default(_that.region,_that.city,_that.tsunamiForecastRegion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String region, @JsonKey(includeIfNull: true)  String? city, @JsonKey(includeIfNull: true)  String? tsunamiForecastRegion)?  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationResponse() when $default != null:
return $default(_that.region,_that.city,_that.tsunamiForecastRegion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceLocationResponse implements DeviceLocationResponse {
  const _DeviceLocationResponse({required this.region, @JsonKey(includeIfNull: true) required this.city, @JsonKey(includeIfNull: true) required this.tsunamiForecastRegion});
  factory _DeviceLocationResponse.fromJson(Map<String, dynamic> json) => _$DeviceLocationResponseFromJson(json);

/// 気象庁防災情報XMLコード表 AreaForecastLocalE（地震情報／細分区域）のコード
@override final  String region;
/// 気象庁防災情報XMLコード表 AreaInformationCity（気象・地震・火山情報／市町村等）のコード
@override@JsonKey(includeIfNull: true) final  String? city;
/// 気象庁防災情報XMLコード表 AreaTsunami（津波予報区）のコード
@override@JsonKey(includeIfNull: true) final  String? tsunamiForecastRegion;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceLocationResponse&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.tsunamiForecastRegion, tsunamiForecastRegion) || other.tsunamiForecastRegion == tsunamiForecastRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,tsunamiForecastRegion);

@override
String toString() {
  return 'DeviceLocationResponse(region: $region, city: $city, tsunamiForecastRegion: $tsunamiForecastRegion)';
}


}

/// @nodoc
abstract mixin class _$DeviceLocationResponseCopyWith<$Res> implements $DeviceLocationResponseCopyWith<$Res> {
  factory _$DeviceLocationResponseCopyWith(_DeviceLocationResponse value, $Res Function(_DeviceLocationResponse) _then) = __$DeviceLocationResponseCopyWithImpl;
@override @useResult
$Res call({
 String region,@JsonKey(includeIfNull: true) String? city,@JsonKey(includeIfNull: true) String? tsunamiForecastRegion
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
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? city = freezed,Object? tsunamiForecastRegion = freezed,}) {
  return _then(_DeviceLocationResponse(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegion: freezed == tsunamiForecastRegion ? _self.tsunamiForecastRegion : tsunamiForecastRegion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
