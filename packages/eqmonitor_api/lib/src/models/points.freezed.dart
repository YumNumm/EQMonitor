// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Points {

 String get code; String get name; String get region; String get type; Location get location;@JsonKey(includeIfNull: true) num? get intensity;@JsonKey(includeIfNull: true, name: 'prefecture_code') String? get prefectureCode;@JsonKey(includeIfNull: true, name: 'region_code') String? get regionCode;@JsonKey(includeIfNull: true, name: 'city_code') String? get cityCode;@JsonKey(includeIfNull: true) num? get intensityDiff;
/// Create a copy of Points
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointsCopyWith<Points> get copyWith => _$PointsCopyWithImpl<Points>(this as Points, _$identity);

  /// Serializes this Points to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Points&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.intensityDiff, intensityDiff) || other.intensityDiff == intensityDiff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,region,type,location,intensity,prefectureCode,regionCode,cityCode,intensityDiff);

@override
String toString() {
  return 'Points(code: $code, name: $name, region: $region, type: $type, location: $location, intensity: $intensity, prefectureCode: $prefectureCode, regionCode: $regionCode, cityCode: $cityCode, intensityDiff: $intensityDiff)';
}


}

/// @nodoc
abstract mixin class $PointsCopyWith<$Res>  {
  factory $PointsCopyWith(Points value, $Res Function(Points) _then) = _$PointsCopyWithImpl;
@useResult
$Res call({
 String code, String name, String region, String type, Location location,@JsonKey(includeIfNull: true) num? intensity,@JsonKey(includeIfNull: true, name: 'prefecture_code') String? prefectureCode,@JsonKey(includeIfNull: true, name: 'region_code') String? regionCode,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: true) num? intensityDiff
});


$LocationCopyWith<$Res> get location;

}
/// @nodoc
class _$PointsCopyWithImpl<$Res>
    implements $PointsCopyWith<$Res> {
  _$PointsCopyWithImpl(this._self, this._then);

  final Points _self;
  final $Res Function(Points) _then;

/// Create a copy of Points
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? region = null,Object? type = null,Object? location = null,Object? intensity = freezed,Object? prefectureCode = freezed,Object? regionCode = freezed,Object? cityCode = freezed,Object? intensityDiff = freezed,}) {
  return _then(Points(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as num?,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,intensityDiff: freezed == intensityDiff ? _self.intensityDiff : intensityDiff // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}
/// Create a copy of Points
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res> get location {
  
  return $LocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [Points].
extension PointsPatterns on Points {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Points value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Points() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Points value)  $default,){
final _that = this;
switch (_that) {
case _Points():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Points value)?  $default,){
final _that = this;
switch (_that) {
case _Points() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String region,  String type,  Location location, @JsonKey(includeIfNull: true)  num? intensity, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true)  num? intensityDiff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Points() when $default != null:
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensity,_that.prefectureCode,_that.regionCode,_that.cityCode,_that.intensityDiff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String region,  String type,  Location location, @JsonKey(includeIfNull: true)  num? intensity, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true)  num? intensityDiff)  $default,) {final _that = this;
switch (_that) {
case _Points():
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensity,_that.prefectureCode,_that.regionCode,_that.cityCode,_that.intensityDiff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String region,  String type,  Location location, @JsonKey(includeIfNull: true)  num? intensity, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(includeIfNull: true)  num? intensityDiff)?  $default,) {final _that = this;
switch (_that) {
case _Points() when $default != null:
return $default(_that.code,_that.name,_that.region,_that.type,_that.location,_that.intensity,_that.prefectureCode,_that.regionCode,_that.cityCode,_that.intensityDiff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Points implements Points {
  const _Points({required this.code, required this.name, required this.region, required this.type, required this.location, @JsonKey(includeIfNull: true) required this.intensity, @JsonKey(includeIfNull: true, name: 'prefecture_code') required this.prefectureCode, @JsonKey(includeIfNull: true, name: 'region_code') required this.regionCode, @JsonKey(includeIfNull: true, name: 'city_code') required this.cityCode, @JsonKey(includeIfNull: true) this.intensityDiff = 0});
  factory _Points.fromJson(Map<String, dynamic> json) => _$PointsFromJson(json);

@override final  String code;
@override final  String name;
@override final  String region;
@override final  String type;
@override final  Location location;
@override@JsonKey(includeIfNull: true) final  num? intensity;
@override@JsonKey(includeIfNull: true, name: 'prefecture_code') final  String? prefectureCode;
@override@JsonKey(includeIfNull: true, name: 'region_code') final  String? regionCode;
@override@JsonKey(includeIfNull: true, name: 'city_code') final  String? cityCode;
@override@JsonKey(includeIfNull: true) final  num? intensityDiff;

/// Create a copy of Points
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointsCopyWith<_Points> get copyWith => __$PointsCopyWithImpl<_Points>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Points&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.intensityDiff, intensityDiff) || other.intensityDiff == intensityDiff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,region,type,location,intensity,prefectureCode,regionCode,cityCode,intensityDiff);

@override
String toString() {
  return 'Points(code: $code, name: $name, region: $region, type: $type, location: $location, intensity: $intensity, prefectureCode: $prefectureCode, regionCode: $regionCode, cityCode: $cityCode, intensityDiff: $intensityDiff)';
}


}

/// @nodoc
abstract mixin class _$PointsCopyWith<$Res> implements $PointsCopyWith<$Res> {
  factory _$PointsCopyWith(_Points value, $Res Function(_Points) _then) = __$PointsCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String region, String type, Location location,@JsonKey(includeIfNull: true) num? intensity,@JsonKey(includeIfNull: true, name: 'prefecture_code') String? prefectureCode,@JsonKey(includeIfNull: true, name: 'region_code') String? regionCode,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(includeIfNull: true) num? intensityDiff
});


@override $LocationCopyWith<$Res> get location;

}
/// @nodoc
class __$PointsCopyWithImpl<$Res>
    implements _$PointsCopyWith<$Res> {
  __$PointsCopyWithImpl(this._self, this._then);

  final _Points _self;
  final $Res Function(_Points) _then;

/// Create a copy of Points
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? region = null,Object? type = null,Object? location = null,Object? intensity = freezed,Object? prefectureCode = freezed,Object? regionCode = freezed,Object? cityCode = freezed,Object? intensityDiff = freezed,}) {
  return _then(_Points(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as num?,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,intensityDiff: freezed == intensityDiff ? _self.intensityDiff : intensityDiff // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

/// Create a copy of Points
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res> get location {
  
  return $LocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
