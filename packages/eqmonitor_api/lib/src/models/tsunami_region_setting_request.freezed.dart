// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_setting_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiRegionSettingRequest {

@JsonKey(name: 'forecast_region_code') String get forecastRegionCode;@JsonKey(name: 'is_current_location') bool get isCurrentLocation;@JsonKey(name: 'min_warning_kind') TsunamiWarningKind get minWarningKind;@JsonKey(includeIfNull: false, name: 'forecast_region_name') String? get forecastRegionName;
/// Create a copy of TsunamiRegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionSettingRequestCopyWith<TsunamiRegionSettingRequest> get copyWith => _$TsunamiRegionSettingRequestCopyWithImpl<TsunamiRegionSettingRequest>(this as TsunamiRegionSettingRequest, _$identity);

  /// Serializes this TsunamiRegionSettingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionSettingRequest&&(identical(other.forecastRegionCode, forecastRegionCode) || other.forecastRegionCode == forecastRegionCode)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind)&&(identical(other.forecastRegionName, forecastRegionName) || other.forecastRegionName == forecastRegionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forecastRegionCode,isCurrentLocation,minWarningKind,forecastRegionName);

@override
String toString() {
  return 'TsunamiRegionSettingRequest(forecastRegionCode: $forecastRegionCode, isCurrentLocation: $isCurrentLocation, minWarningKind: $minWarningKind, forecastRegionName: $forecastRegionName)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionSettingRequestCopyWith<$Res>  {
  factory $TsunamiRegionSettingRequestCopyWith(TsunamiRegionSettingRequest value, $Res Function(TsunamiRegionSettingRequest) _then) = _$TsunamiRegionSettingRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'forecast_region_code') String forecastRegionCode,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'min_warning_kind') TsunamiWarningKind minWarningKind,@JsonKey(includeIfNull: false, name: 'forecast_region_name') String? forecastRegionName
});




}
/// @nodoc
class _$TsunamiRegionSettingRequestCopyWithImpl<$Res>
    implements $TsunamiRegionSettingRequestCopyWith<$Res> {
  _$TsunamiRegionSettingRequestCopyWithImpl(this._self, this._then);

  final TsunamiRegionSettingRequest _self;
  final $Res Function(TsunamiRegionSettingRequest) _then;

/// Create a copy of TsunamiRegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forecastRegionCode = null,Object? isCurrentLocation = null,Object? minWarningKind = null,Object? forecastRegionName = freezed,}) {
  return _then(TsunamiRegionSettingRequest(
forecastRegionCode: null == forecastRegionCode ? _self.forecastRegionCode : forecastRegionCode // ignore: cast_nullable_to_non_nullable
as String,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minWarningKind: null == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,forecastRegionName: freezed == forecastRegionName ? _self.forecastRegionName : forecastRegionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiRegionSettingRequest].
extension TsunamiRegionSettingRequestPatterns on TsunamiRegionSettingRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionSettingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionSettingRequest value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionSettingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'forecast_region_code')  String forecastRegionCode, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind, @JsonKey(includeIfNull: false, name: 'forecast_region_name')  String? forecastRegionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingRequest() when $default != null:
return $default(_that.forecastRegionCode,_that.isCurrentLocation,_that.minWarningKind,_that.forecastRegionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'forecast_region_code')  String forecastRegionCode, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind, @JsonKey(includeIfNull: false, name: 'forecast_region_name')  String? forecastRegionName)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingRequest():
return $default(_that.forecastRegionCode,_that.isCurrentLocation,_that.minWarningKind,_that.forecastRegionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'forecast_region_code')  String forecastRegionCode, @JsonKey(name: 'is_current_location')  bool isCurrentLocation, @JsonKey(name: 'min_warning_kind')  TsunamiWarningKind minWarningKind, @JsonKey(includeIfNull: false, name: 'forecast_region_name')  String? forecastRegionName)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingRequest() when $default != null:
return $default(_that.forecastRegionCode,_that.isCurrentLocation,_that.minWarningKind,_that.forecastRegionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiRegionSettingRequest implements TsunamiRegionSettingRequest {
  const _TsunamiRegionSettingRequest({@JsonKey(name: 'forecast_region_code') required this.forecastRegionCode, @JsonKey(name: 'is_current_location') required this.isCurrentLocation, @JsonKey(name: 'min_warning_kind') required this.minWarningKind, @JsonKey(includeIfNull: false, name: 'forecast_region_name') this.forecastRegionName});
  factory _TsunamiRegionSettingRequest.fromJson(Map<String, dynamic> json) => _$TsunamiRegionSettingRequestFromJson(json);

@override@JsonKey(name: 'forecast_region_code') final  String forecastRegionCode;
@override@JsonKey(name: 'is_current_location') final  bool isCurrentLocation;
@override@JsonKey(name: 'min_warning_kind') final  TsunamiWarningKind minWarningKind;
@override@JsonKey(includeIfNull: false, name: 'forecast_region_name') final  String? forecastRegionName;

/// Create a copy of TsunamiRegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionSettingRequestCopyWith<_TsunamiRegionSettingRequest> get copyWith => __$TsunamiRegionSettingRequestCopyWithImpl<_TsunamiRegionSettingRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiRegionSettingRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionSettingRequest&&(identical(other.forecastRegionCode, forecastRegionCode) || other.forecastRegionCode == forecastRegionCode)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind)&&(identical(other.forecastRegionName, forecastRegionName) || other.forecastRegionName == forecastRegionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forecastRegionCode,isCurrentLocation,minWarningKind,forecastRegionName);

@override
String toString() {
  return 'TsunamiRegionSettingRequest(forecastRegionCode: $forecastRegionCode, isCurrentLocation: $isCurrentLocation, minWarningKind: $minWarningKind, forecastRegionName: $forecastRegionName)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionSettingRequestCopyWith<$Res> implements $TsunamiRegionSettingRequestCopyWith<$Res> {
  factory _$TsunamiRegionSettingRequestCopyWith(_TsunamiRegionSettingRequest value, $Res Function(_TsunamiRegionSettingRequest) _then) = __$TsunamiRegionSettingRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'forecast_region_code') String forecastRegionCode,@JsonKey(name: 'is_current_location') bool isCurrentLocation,@JsonKey(name: 'min_warning_kind') TsunamiWarningKind minWarningKind,@JsonKey(includeIfNull: false, name: 'forecast_region_name') String? forecastRegionName
});




}
/// @nodoc
class __$TsunamiRegionSettingRequestCopyWithImpl<$Res>
    implements _$TsunamiRegionSettingRequestCopyWith<$Res> {
  __$TsunamiRegionSettingRequestCopyWithImpl(this._self, this._then);

  final _TsunamiRegionSettingRequest _self;
  final $Res Function(_TsunamiRegionSettingRequest) _then;

/// Create a copy of TsunamiRegionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forecastRegionCode = null,Object? isCurrentLocation = null,Object? minWarningKind = null,Object? forecastRegionName = freezed,}) {
  return _then(_TsunamiRegionSettingRequest(
forecastRegionCode: null == forecastRegionCode ? _self.forecastRegionCode : forecastRegionCode // ignore: cast_nullable_to_non_nullable
as String,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,minWarningKind: null == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind,forecastRegionName: freezed == forecastRegionName ? _self.forecastRegionName : forecastRegionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
