// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_setting_patch_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiRegionSettingPatchRequest {

@JsonKey(includeIfNull: false, name: 'forecast_region_name') String? get forecastRegionName;@JsonKey(includeIfNull: false, name: 'is_current_location') bool? get isCurrentLocation;@JsonKey(includeIfNull: false, name: 'min_warning_kind') TsunamiWarningKind? get minWarningKind;
/// Create a copy of TsunamiRegionSettingPatchRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionSettingPatchRequestCopyWith<TsunamiRegionSettingPatchRequest> get copyWith => _$TsunamiRegionSettingPatchRequestCopyWithImpl<TsunamiRegionSettingPatchRequest>(this as TsunamiRegionSettingPatchRequest, _$identity);

  /// Serializes this TsunamiRegionSettingPatchRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionSettingPatchRequest&&(identical(other.forecastRegionName, forecastRegionName) || other.forecastRegionName == forecastRegionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forecastRegionName,isCurrentLocation,minWarningKind);

@override
String toString() {
  return 'TsunamiRegionSettingPatchRequest(forecastRegionName: $forecastRegionName, isCurrentLocation: $isCurrentLocation, minWarningKind: $minWarningKind)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionSettingPatchRequestCopyWith<$Res>  {
  factory $TsunamiRegionSettingPatchRequestCopyWith(TsunamiRegionSettingPatchRequest value, $Res Function(TsunamiRegionSettingPatchRequest) _then) = _$TsunamiRegionSettingPatchRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'forecast_region_name') String? forecastRegionName,@JsonKey(includeIfNull: false, name: 'is_current_location') bool? isCurrentLocation,@JsonKey(includeIfNull: false, name: 'min_warning_kind') TsunamiWarningKind? minWarningKind
});




}
/// @nodoc
class _$TsunamiRegionSettingPatchRequestCopyWithImpl<$Res>
    implements $TsunamiRegionSettingPatchRequestCopyWith<$Res> {
  _$TsunamiRegionSettingPatchRequestCopyWithImpl(this._self, this._then);

  final TsunamiRegionSettingPatchRequest _self;
  final $Res Function(TsunamiRegionSettingPatchRequest) _then;

/// Create a copy of TsunamiRegionSettingPatchRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forecastRegionName = freezed,Object? isCurrentLocation = freezed,Object? minWarningKind = freezed,}) {
  return _then(_self.copyWith(
forecastRegionName: freezed == forecastRegionName ? _self.forecastRegionName : forecastRegionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: freezed == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool?,minWarningKind: freezed == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiRegionSettingPatchRequest].
extension TsunamiRegionSettingPatchRequestPatterns on TsunamiRegionSettingPatchRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionSettingPatchRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingPatchRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionSettingPatchRequest value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingPatchRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionSettingPatchRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionSettingPatchRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'forecast_region_name')  String? forecastRegionName, @JsonKey(includeIfNull: false, name: 'is_current_location')  bool? isCurrentLocation, @JsonKey(includeIfNull: false, name: 'min_warning_kind')  TsunamiWarningKind? minWarningKind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingPatchRequest() when $default != null:
return $default(_that.forecastRegionName,_that.isCurrentLocation,_that.minWarningKind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'forecast_region_name')  String? forecastRegionName, @JsonKey(includeIfNull: false, name: 'is_current_location')  bool? isCurrentLocation, @JsonKey(includeIfNull: false, name: 'min_warning_kind')  TsunamiWarningKind? minWarningKind)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingPatchRequest():
return $default(_that.forecastRegionName,_that.isCurrentLocation,_that.minWarningKind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'forecast_region_name')  String? forecastRegionName, @JsonKey(includeIfNull: false, name: 'is_current_location')  bool? isCurrentLocation, @JsonKey(includeIfNull: false, name: 'min_warning_kind')  TsunamiWarningKind? minWarningKind)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionSettingPatchRequest() when $default != null:
return $default(_that.forecastRegionName,_that.isCurrentLocation,_that.minWarningKind);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiRegionSettingPatchRequest implements TsunamiRegionSettingPatchRequest {
  const _TsunamiRegionSettingPatchRequest({@JsonKey(includeIfNull: false, name: 'forecast_region_name') this.forecastRegionName, @JsonKey(includeIfNull: false, name: 'is_current_location') this.isCurrentLocation, @JsonKey(includeIfNull: false, name: 'min_warning_kind') this.minWarningKind});
  factory _TsunamiRegionSettingPatchRequest.fromJson(Map<String, dynamic> json) => _$TsunamiRegionSettingPatchRequestFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'forecast_region_name') final  String? forecastRegionName;
@override@JsonKey(includeIfNull: false, name: 'is_current_location') final  bool? isCurrentLocation;
@override@JsonKey(includeIfNull: false, name: 'min_warning_kind') final  TsunamiWarningKind? minWarningKind;

/// Create a copy of TsunamiRegionSettingPatchRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionSettingPatchRequestCopyWith<_TsunamiRegionSettingPatchRequest> get copyWith => __$TsunamiRegionSettingPatchRequestCopyWithImpl<_TsunamiRegionSettingPatchRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiRegionSettingPatchRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionSettingPatchRequest&&(identical(other.forecastRegionName, forecastRegionName) || other.forecastRegionName == forecastRegionName)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.minWarningKind, minWarningKind) || other.minWarningKind == minWarningKind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forecastRegionName,isCurrentLocation,minWarningKind);

@override
String toString() {
  return 'TsunamiRegionSettingPatchRequest(forecastRegionName: $forecastRegionName, isCurrentLocation: $isCurrentLocation, minWarningKind: $minWarningKind)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionSettingPatchRequestCopyWith<$Res> implements $TsunamiRegionSettingPatchRequestCopyWith<$Res> {
  factory _$TsunamiRegionSettingPatchRequestCopyWith(_TsunamiRegionSettingPatchRequest value, $Res Function(_TsunamiRegionSettingPatchRequest) _then) = __$TsunamiRegionSettingPatchRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'forecast_region_name') String? forecastRegionName,@JsonKey(includeIfNull: false, name: 'is_current_location') bool? isCurrentLocation,@JsonKey(includeIfNull: false, name: 'min_warning_kind') TsunamiWarningKind? minWarningKind
});




}
/// @nodoc
class __$TsunamiRegionSettingPatchRequestCopyWithImpl<$Res>
    implements _$TsunamiRegionSettingPatchRequestCopyWith<$Res> {
  __$TsunamiRegionSettingPatchRequestCopyWithImpl(this._self, this._then);

  final _TsunamiRegionSettingPatchRequest _self;
  final $Res Function(_TsunamiRegionSettingPatchRequest) _then;

/// Create a copy of TsunamiRegionSettingPatchRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forecastRegionName = freezed,Object? isCurrentLocation = freezed,Object? minWarningKind = freezed,}) {
  return _then(_TsunamiRegionSettingPatchRequest(
forecastRegionName: freezed == forecastRegionName ? _self.forecastRegionName : forecastRegionName // ignore: cast_nullable_to_non_nullable
as String?,isCurrentLocation: freezed == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool?,minWarningKind: freezed == minWarningKind ? _self.minWarningKind : minWarningKind // ignore: cast_nullable_to_non_nullable
as TsunamiWarningKind?,
  ));
}


}

// dart format on
