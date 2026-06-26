// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_setting_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiRegionSettingResponse {

 String get id;@JsonKey(name: 'forecast_region_code') String get forecastRegionCode;@JsonKey(includeIfNull: true, name: 'forecast_region_name') String? get forecastRegionName;@JsonKey(name: 'is_current_location') bool get isCurrentLocation;@JsonKey(name: 'min_warning_kind') TsunamiWarningKind get minWarningKind;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of TsunamiRegionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionSettingResponseCopyWith<TsunamiRegionSettingResponse> get copyWith => _$TsunamiRegionSettingResponseCopyWithImpl<TsunamiRegionSettingResponse>(this as TsunamiRegionSettingResponse, _$identity);

  /// Serializes this TsunamiRegionSettingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionSettingResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.forecastRegionCode, forecastRegionCode) || other.forecastRegionCode == forecastRegionCode)&&(identical(other.forecastRegionName, forecastRegionName) || other.forecastRegionName == forecastRegionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,forecastRegionCode,forecastRegionName,isCurrentLocation,minWarningKind,createdAt,updatedAt);

@override
String toString() {
  return 'TsunamiRegionSettingResponse(id: $id, forecastRegionCode: $forecastRegionCode, forecastRegionName: $forecastRegionName, isCurrentLocation: $isCurrentLocation, minWarningKind: $minWarningKind, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionSettingResponseCopyWith<$Res>  {
  factory $TsunamiRegionSettingResponseCopyWith(TsunamiRegionSettingResponse value, $Res Function(TsunamiRegionSettingResponse) _then) = _$TsunamiRegionSettingResponseCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'forecast_region_code') String forecastRegionCode,@JsonKey(includeIfNull: true, name: 'forecast_region_name') String? forecastRegionName,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'min_warning_kind') TsunamiWarningKind minWarningKind,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$TsunamiRegionSettingResponseCopyWithImpl<$Res>
    implements $TsunamiRegionSettingResponseCopyWith<$Res> {
  _$TsunamiRegionSettingResponseCopyWithImpl(this._self, this._then);

  final TsunamiRegionSettingResponse _self;
  final $Res Function(TsunamiRegionSettingResponse) _then;

/// Create a copy of TsunamiRegionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? forecastRegionCode = null,Object? forecastRegionName = freezed,Object? isCurrentLocation = null,Object? minWarningKind = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,forecastRegionCode: null == forecastRegionCode ? _self.forecastRegionCode : forecastRegionCode // ignore: cast_nullable_to_non_nullable
as String,forecastRegionName: freezed == forecastRegionName ? _self.forecastRegionName : forecastRegionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minWarningKind: null == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiRegionSettingResponse].
extension TsunamiRegionSettingResponsePatterns on TsunamiRegionSettingResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionSettingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionSettingResponse value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionSettingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'forecast_region_code')  String forecastRegionCode, @JsonKey(includeIfNull: true, name: 'forecast_region_name')  String? forecastRegionName, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingResponse() when $default != null:
return $default(_that.id,_that.forecastRegionCode,_that.forecastRegionName,_that.isCurrentLocation,_that.minWarningKind,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'forecast_region_code')  String forecastRegionCode, @JsonKey(includeIfNull: true, name: 'forecast_region_name')  String? forecastRegionName, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingResponse():
return $default(_that.id,_that.forecastRegionCode,_that.forecastRegionName,_that.isCurrentLocation,_that.minWarningKind,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'forecast_region_code')  String forecastRegionCode, @JsonKey(includeIfNull: true, name: 'forecast_region_name')  String? forecastRegionName, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingResponse() when $default != null:
return $default(_that.id,_that.forecastRegionCode,_that.forecastRegionName,_that.isCurrentLocation,_that.minWarningKind,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiRegionSettingResponse implements TsunamiRegionSettingResponse {
  const _TsunamiRegionSettingResponse({required this.id, @JsonKey(name: 'forecast_region_code') required this.forecastRegionCode, @JsonKey(includeIfNull: true, name: 'forecast_region_name') required this.forecastRegionName, @JsonKey(name: 'is_current_location') required this.isCurrentLocation, @JsonKey(name: 'min_warning_kind') required this.minWarningKind, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _TsunamiRegionSettingResponse.fromJson(Map<String, dynamic> json) => _$TsunamiRegionSettingResponseFromJson(json);

@override final  String id;
@override@JsonKey(name: 'forecast_region_code') final  String forecastRegionCode;
@override@JsonKey(includeIfNull: true, name: 'forecast_region_name') final  String? forecastRegionName;
@override@JsonKey(name: 'is_current_location') final  bool isCurrentLocation;
@override@JsonKey(name: 'min_warning_kind') final  TsunamiWarningKind minWarningKind;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of TsunamiRegionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionSettingResponseCopyWith<_TsunamiRegionSettingResponse> get copyWith => __$TsunamiRegionSettingResponseCopyWithImpl<_TsunamiRegionSettingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiRegionSettingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionSettingResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.forecastRegionCode, forecastRegionCode) || other.forecastRegionCode == forecastRegionCode)&&(identical(other.forecastRegionName, forecastRegionName) || other.forecastRegionName == forecastRegionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,forecastRegionCode,forecastRegionName,isCurrentLocation,minWarningKind,createdAt,updatedAt);

@override
String toString() {
  return 'TsunamiRegionSettingResponse(id: $id, forecastRegionCode: $forecastRegionCode, forecastRegionName: $forecastRegionName, isCurrentLocation: $isCurrentLocation, minWarningKind: $minWarningKind, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionSettingResponseCopyWith<$Res> implements $TsunamiRegionSettingResponseCopyWith<$Res> {
  factory _$TsunamiRegionSettingResponseCopyWith(_TsunamiRegionSettingResponse value, $Res Function(_TsunamiRegionSettingResponse) _then) = __$TsunamiRegionSettingResponseCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'forecast_region_code') String forecastRegionCode,@JsonKey(includeIfNull: true, name: 'forecast_region_name') String? forecastRegionName,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'min_warning_kind') TsunamiWarningKind minWarningKind,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$TsunamiRegionSettingResponseCopyWithImpl<$Res>
    implements _$TsunamiRegionSettingResponseCopyWith<$Res> {
  __$TsunamiRegionSettingResponseCopyWithImpl(this._self, this._then);

  final _TsunamiRegionSettingResponse _self;
  final $Res Function(_TsunamiRegionSettingResponse) _then;

/// Create a copy of TsunamiRegionSettingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? forecastRegionCode = null,Object? forecastRegionName = freezed,Object? isCurrentLocation = null,Object? minWarningKind = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_TsunamiRegionSettingResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,forecastRegionCode: null == forecastRegionCode ? _self.forecastRegionCode : forecastRegionCode // ignore: cast_nullable_to_non_nullable
as String,forecastRegionName: freezed == forecastRegionName ? _self.forecastRegionName : forecastRegionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minWarningKind: null == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
