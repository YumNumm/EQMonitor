// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_location_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceLocationRequest {

/// 気象庁防災情報XMLコード表 AreaForecastLocalE（地震情報／細分区域）のコード
 String get region;/// 気象庁防災情報XMLコード表 AreaInformationCity（気象・地震・火山情報／市町村等）のコード
@JsonKey(includeIfNull: false) String? get city;/// 気象庁防災情報XMLコード表 AreaTsunami（津波予報区）のコード
@JsonKey(includeIfNull: false) String? get tsunamiForecastRegion;
/// Create a copy of DeviceLocationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceLocationRequestCopyWith<DeviceLocationRequest> get copyWith => _$DeviceLocationRequestCopyWithImpl<DeviceLocationRequest>(this as DeviceLocationRequest, _$identity);

  /// Serializes this DeviceLocationRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceLocationRequest&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.tsunamiForecastRegion, tsunamiForecastRegion) || other.tsunamiForecastRegion == tsunamiForecastRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,tsunamiForecastRegion);

@override
String toString() {
  return 'DeviceLocationRequest(region: $region, city: $city, tsunamiForecastRegion: $tsunamiForecastRegion)';
}


}

/// @nodoc
abstract mixin class $DeviceLocationRequestCopyWith<$Res>  {
  factory $DeviceLocationRequestCopyWith(DeviceLocationRequest value, $Res Function(DeviceLocationRequest) _then) = _$DeviceLocationRequestCopyWithImpl;
@useResult
$Res call({
 String region,@JsonKey(includeIfNull: false) String? city,@JsonKey(includeIfNull: false) String? tsunamiForecastRegion
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
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? city = freezed,Object? tsunamiForecastRegion = freezed,}) {
  return _then(DeviceLocationRequest(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegion: freezed == tsunamiForecastRegion ? _self.tsunamiForecastRegion : tsunamiForecastRegion // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String region, @JsonKey(includeIfNull: false)  String? city, @JsonKey(includeIfNull: false)  String? tsunamiForecastRegion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceLocationRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String region, @JsonKey(includeIfNull: false)  String? city, @JsonKey(includeIfNull: false)  String? tsunamiForecastRegion)  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String region, @JsonKey(includeIfNull: false)  String? city, @JsonKey(includeIfNull: false)  String? tsunamiForecastRegion)?  $default,) {final _that = this;
switch (_that) {
case _DeviceLocationRequest() when $default != null:
return $default(_that.region,_that.city,_that.tsunamiForecastRegion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceLocationRequest implements DeviceLocationRequest {
  const _DeviceLocationRequest({required this.region, @JsonKey(includeIfNull: false) this.city, @JsonKey(includeIfNull: false) this.tsunamiForecastRegion});
  factory _DeviceLocationRequest.fromJson(Map<String, dynamic> json) => _$DeviceLocationRequestFromJson(json);

/// 気象庁防災情報XMLコード表 AreaForecastLocalE（地震情報／細分区域）のコード
@override final  String region;
/// 気象庁防災情報XMLコード表 AreaInformationCity（気象・地震・火山情報／市町村等）のコード
@override@JsonKey(includeIfNull: false) final  String? city;
/// 気象庁防災情報XMLコード表 AreaTsunami（津波予報区）のコード
@override@JsonKey(includeIfNull: false) final  String? tsunamiForecastRegion;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceLocationRequest&&(identical(other.region, region) || other.region == region)&&(identical(other.city, city) || other.city == city)&&(identical(other.tsunamiForecastRegion, tsunamiForecastRegion) || other.tsunamiForecastRegion == tsunamiForecastRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,city,tsunamiForecastRegion);

@override
String toString() {
  return 'DeviceLocationRequest(region: $region, city: $city, tsunamiForecastRegion: $tsunamiForecastRegion)';
}


}

/// @nodoc
abstract mixin class _$DeviceLocationRequestCopyWith<$Res> implements $DeviceLocationRequestCopyWith<$Res> {
  factory _$DeviceLocationRequestCopyWith(_DeviceLocationRequest value, $Res Function(_DeviceLocationRequest) _then) = __$DeviceLocationRequestCopyWithImpl;
@override @useResult
$Res call({
 String region,@JsonKey(includeIfNull: false) String? city,@JsonKey(includeIfNull: false) String? tsunamiForecastRegion
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
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? city = freezed,Object? tsunamiForecastRegion = freezed,}) {
  return _then(_DeviceLocationRequest(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,tsunamiForecastRegion: freezed == tsunamiForecastRegion ? _self.tsunamiForecastRegion : tsunamiForecastRegion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
