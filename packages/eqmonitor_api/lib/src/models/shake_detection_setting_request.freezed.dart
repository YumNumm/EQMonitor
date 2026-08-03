// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_setting_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionSettingRequest {

@JsonKey(includeIfNull: true, name: 'sub_region_id') String? get subRegionId;@JsonKey(includeIfNull: true, name: 'prefecture_code') String? get prefectureCode;@JsonKey(includeIfNull: true, name: 'city_code') String? get cityCode;@JsonKey(name: 'min_level') ShakeDetectionLevel get minLevel;@JsonKey(name: 'is_current_location') bool get isCurrentLocation;
/// Create a copy of ShakeDetectionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionSettingRequestCopyWith<ShakeDetectionSettingRequest> get copyWith => _$ShakeDetectionSettingRequestCopyWithImpl<ShakeDetectionSettingRequest>(this as ShakeDetectionSettingRequest, _$identity);

  /// Serializes this ShakeDetectionSettingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionSettingRequest&&(identical(other.subRegionId, subRegionId) || other.subRegionId == subRegionId)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subRegionId,prefectureCode,cityCode,minLevel,isCurrentLocation);

@override
String toString() {
  return 'ShakeDetectionSettingRequest(subRegionId: $subRegionId, prefectureCode: $prefectureCode, cityCode: $cityCode, minLevel: $minLevel, isCurrentLocation: $isCurrentLocation)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionSettingRequestCopyWith<$Res>  {
  factory $ShakeDetectionSettingRequestCopyWith(ShakeDetectionSettingRequest value, $Res Function(ShakeDetectionSettingRequest) _then) = _$ShakeDetectionSettingRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: true, name: 'sub_region_id') String? subRegionId,@JsonKey(includeIfNull: true, name: 'prefecture_code') String? prefectureCode,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(name: 'min_level') ShakeDetectionLevel minLevel,@JsonKey(name: 'is_current_location') bool isCurrentLocation
});




}
/// @nodoc
class _$ShakeDetectionSettingRequestCopyWithImpl<$Res>
    implements $ShakeDetectionSettingRequestCopyWith<$Res> {
  _$ShakeDetectionSettingRequestCopyWithImpl(this._self, this._then);

  final ShakeDetectionSettingRequest _self;
  final $Res Function(ShakeDetectionSettingRequest) _then;

/// Create a copy of ShakeDetectionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subRegionId = freezed,Object? prefectureCode = freezed,Object? cityCode = freezed,Object? minLevel = null,Object? isCurrentLocation = null,}) {
  return _then(_self.copyWith(
subRegionId: freezed == subRegionId ? _self.subRegionId : subRegionId // ignore: cast_nullable_to_non_nullable
as String?,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionSettingRequest].
extension ShakeDetectionSettingRequestPatterns on ShakeDetectionSettingRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionSettingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionSettingRequest value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionSettingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: true, name: 'sub_region_id')  String? subRegionId, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel, @JsonKey(name: 'is_current_location')  bool isCurrentLocation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest() when $default != null:
return $default(_that.subRegionId,_that.prefectureCode,_that.cityCode,_that.minLevel,_that.isCurrentLocation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: true, name: 'sub_region_id')  String? subRegionId, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel, @JsonKey(name: 'is_current_location')  bool isCurrentLocation)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest():
return $default(_that.subRegionId,_that.prefectureCode,_that.cityCode,_that.minLevel,_that.isCurrentLocation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: true, name: 'sub_region_id')  String? subRegionId, @JsonKey(includeIfNull: true, name: 'prefecture_code')  String? prefectureCode, @JsonKey(includeIfNull: true, name: 'city_code')  String? cityCode, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel, @JsonKey(name: 'is_current_location')  bool isCurrentLocation)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest() when $default != null:
return $default(_that.subRegionId,_that.prefectureCode,_that.cityCode,_that.minLevel,_that.isCurrentLocation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShakeDetectionSettingRequest implements ShakeDetectionSettingRequest {
  const _ShakeDetectionSettingRequest({@JsonKey(includeIfNull: true, name: 'sub_region_id') required this.subRegionId, @JsonKey(includeIfNull: true, name: 'prefecture_code') required this.prefectureCode, @JsonKey(includeIfNull: true, name: 'city_code') required this.cityCode, @JsonKey(name: 'min_level') required this.minLevel, @JsonKey(name: 'is_current_location') required this.isCurrentLocation});
  factory _ShakeDetectionSettingRequest.fromJson(Map<String, dynamic> json) => _$ShakeDetectionSettingRequestFromJson(json);

@override@JsonKey(includeIfNull: true, name: 'sub_region_id') final  String? subRegionId;
@override@JsonKey(includeIfNull: true, name: 'prefecture_code') final  String? prefectureCode;
@override@JsonKey(includeIfNull: true, name: 'city_code') final  String? cityCode;
@override@JsonKey(name: 'min_level') final  ShakeDetectionLevel minLevel;
@override@JsonKey(name: 'is_current_location') final  bool isCurrentLocation;

/// Create a copy of ShakeDetectionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionSettingRequestCopyWith<_ShakeDetectionSettingRequest> get copyWith => __$ShakeDetectionSettingRequestCopyWithImpl<_ShakeDetectionSettingRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionSettingRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionSettingRequest&&(identical(other.subRegionId, subRegionId) || other.subRegionId == subRegionId)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subRegionId,prefectureCode,cityCode,minLevel,isCurrentLocation);

@override
String toString() {
  return 'ShakeDetectionSettingRequest(subRegionId: $subRegionId, prefectureCode: $prefectureCode, cityCode: $cityCode, minLevel: $minLevel, isCurrentLocation: $isCurrentLocation)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionSettingRequestCopyWith<$Res> implements $ShakeDetectionSettingRequestCopyWith<$Res> {
  factory _$ShakeDetectionSettingRequestCopyWith(_ShakeDetectionSettingRequest value, $Res Function(_ShakeDetectionSettingRequest) _then) = __$ShakeDetectionSettingRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: true, name: 'sub_region_id') String? subRegionId,@JsonKey(includeIfNull: true, name: 'prefecture_code') String? prefectureCode,@JsonKey(includeIfNull: true, name: 'city_code') String? cityCode,@JsonKey(name: 'min_level') ShakeDetectionLevel minLevel,@JsonKey(name: 'is_current_location') bool isCurrentLocation
});




}
/// @nodoc
class __$ShakeDetectionSettingRequestCopyWithImpl<$Res>
    implements _$ShakeDetectionSettingRequestCopyWith<$Res> {
  __$ShakeDetectionSettingRequestCopyWithImpl(this._self, this._then);

  final _ShakeDetectionSettingRequest _self;
  final $Res Function(_ShakeDetectionSettingRequest) _then;

/// Create a copy of ShakeDetectionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subRegionId = freezed,Object? prefectureCode = freezed,Object? cityCode = freezed,Object? minLevel = null,Object? isCurrentLocation = null,}) {
  return _then(_ShakeDetectionSettingRequest(
subRegionId: freezed == subRegionId ? _self.subRegionId : subRegionId // ignore: cast_nullable_to_non_nullable
as String?,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
