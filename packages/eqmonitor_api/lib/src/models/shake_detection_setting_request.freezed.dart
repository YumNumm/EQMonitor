// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_setting_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionSettingRequest {

@JsonKey(name: 'target_type') ShakeDetectionTargetType get targetType;@JsonKey(includeIfNull: true, name: 'region_code') String? get regionCode; bool get enabled;@JsonKey(name: 'min_level') ShakeDetectionLevel get minLevel;
/// Create a copy of ShakeDetectionSettingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionSettingRequestCopyWith<ShakeDetectionSettingRequest> get copyWith => _$ShakeDetectionSettingRequestCopyWithImpl<ShakeDetectionSettingRequest>(this as ShakeDetectionSettingRequest, _$identity);

  /// Serializes this ShakeDetectionSettingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionSettingRequest&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetType,regionCode,enabled,minLevel);

@override
String toString() {
  return 'ShakeDetectionSettingRequest(targetType: $targetType, regionCode: $regionCode, enabled: $enabled, minLevel: $minLevel)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionSettingRequestCopyWith<$Res>  {
  factory $ShakeDetectionSettingRequestCopyWith(ShakeDetectionSettingRequest value, $Res Function(ShakeDetectionSettingRequest) _then) = _$ShakeDetectionSettingRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'target_type') ShakeDetectionTargetType targetType,@JsonKey(includeIfNull: true, name: 'region_code') String? regionCode, bool enabled,@JsonKey(name: 'min_level') ShakeDetectionLevel minLevel
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
@pragma('vm:prefer-inline') @override $Res call({Object? targetType = null,Object? regionCode = freezed,Object? enabled = null,Object? minLevel = null,}) {
  return _then(ShakeDetectionSettingRequest(
targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as ShakeDetectionTargetType,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'target_type')  ShakeDetectionTargetType targetType, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode,  bool enabled, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest() when $default != null:
return $default(_that.targetType,_that.regionCode,_that.enabled,_that.minLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'target_type')  ShakeDetectionTargetType targetType, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode,  bool enabled, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest():
return $default(_that.targetType,_that.regionCode,_that.enabled,_that.minLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'target_type')  ShakeDetectionTargetType targetType, @JsonKey(includeIfNull: true, name: 'region_code')  String? regionCode,  bool enabled, @JsonKey(name: 'min_level')  ShakeDetectionLevel minLevel)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSettingRequest() when $default != null:
return $default(_that.targetType,_that.regionCode,_that.enabled,_that.minLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShakeDetectionSettingRequest implements ShakeDetectionSettingRequest {
  const _ShakeDetectionSettingRequest({@JsonKey(name: 'target_type') required this.targetType, @JsonKey(includeIfNull: true, name: 'region_code') required this.regionCode, required this.enabled, @JsonKey(name: 'min_level') required this.minLevel});
  factory _ShakeDetectionSettingRequest.fromJson(Map<String, dynamic> json) => _$ShakeDetectionSettingRequestFromJson(json);

@override@JsonKey(name: 'target_type') final  ShakeDetectionTargetType targetType;
@override@JsonKey(includeIfNull: true, name: 'region_code') final  String? regionCode;
@override final  bool enabled;
@override@JsonKey(name: 'min_level') final  ShakeDetectionLevel minLevel;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionSettingRequest&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetType,regionCode,enabled,minLevel);

@override
String toString() {
  return 'ShakeDetectionSettingRequest(targetType: $targetType, regionCode: $regionCode, enabled: $enabled, minLevel: $minLevel)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionSettingRequestCopyWith<$Res> implements $ShakeDetectionSettingRequestCopyWith<$Res> {
  factory _$ShakeDetectionSettingRequestCopyWith(_ShakeDetectionSettingRequest value, $Res Function(_ShakeDetectionSettingRequest) _then) = __$ShakeDetectionSettingRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'target_type') ShakeDetectionTargetType targetType,@JsonKey(includeIfNull: true, name: 'region_code') String? regionCode, bool enabled,@JsonKey(name: 'min_level') ShakeDetectionLevel minLevel
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
@override @pragma('vm:prefer-inline') $Res call({Object? targetType = null,Object? regionCode = freezed,Object? enabled = null,Object? minLevel = null,}) {
  return _then(_ShakeDetectionSettingRequest(
targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as ShakeDetectionTargetType,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,
  ));
}


}

// dart format on
