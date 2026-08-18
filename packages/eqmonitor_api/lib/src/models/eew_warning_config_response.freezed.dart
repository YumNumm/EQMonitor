// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_warning_config_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewWarningConfigResponse {

 Target get target;@JsonKey(name: 'current_location_interruption_level') CurrentLocationInterruptionLevel get currentLocationInterruptionLevel;@JsonKey(includeIfNull: true, name: 'nationwide_interruption_level') NationwideInterruptionLevel? get nationwideInterruptionLevel;
/// Create a copy of EewWarningConfigResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningConfigResponseCopyWith<EewWarningConfigResponse> get copyWith => _$EewWarningConfigResponseCopyWithImpl<EewWarningConfigResponse>(this as EewWarningConfigResponse, _$identity);

  /// Serializes this EewWarningConfigResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarningConfigResponse&&(identical(other.target, target) || other.target == target)&&(identical(other.currentLocationInterruptionLevel, currentLocationInterruptionLevel) || other.currentLocationInterruptionLevel == currentLocationInterruptionLevel)&&(identical(other.nationwideInterruptionLevel, nationwideInterruptionLevel) || other.nationwideInterruptionLevel == nationwideInterruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,currentLocationInterruptionLevel,nationwideInterruptionLevel);

@override
String toString() {
  return 'EewWarningConfigResponse(target: $target, currentLocationInterruptionLevel: $currentLocationInterruptionLevel, nationwideInterruptionLevel: $nationwideInterruptionLevel)';
}


}

/// @nodoc
abstract mixin class $EewWarningConfigResponseCopyWith<$Res>  {
  factory $EewWarningConfigResponseCopyWith(EewWarningConfigResponse value, $Res Function(EewWarningConfigResponse) _then) = _$EewWarningConfigResponseCopyWithImpl;
@useResult
$Res call({
 Target target,@JsonKey(name: 'current_location_interruption_level') CurrentLocationInterruptionLevel currentLocationInterruptionLevel,@JsonKey(includeIfNull: true, name: 'nationwide_interruption_level') NationwideInterruptionLevel? nationwideInterruptionLevel
});




}
/// @nodoc
class _$EewWarningConfigResponseCopyWithImpl<$Res>
    implements $EewWarningConfigResponseCopyWith<$Res> {
  _$EewWarningConfigResponseCopyWithImpl(this._self, this._then);

  final EewWarningConfigResponse _self;
  final $Res Function(EewWarningConfigResponse) _then;

/// Create a copy of EewWarningConfigResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = null,Object? currentLocationInterruptionLevel = null,Object? nationwideInterruptionLevel = freezed,}) {
  return _then(EewWarningConfigResponse(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as Target,currentLocationInterruptionLevel: null == currentLocationInterruptionLevel ? _self.currentLocationInterruptionLevel : currentLocationInterruptionLevel // ignore: cast_nullable_to_non_nullable
as CurrentLocationInterruptionLevel,nationwideInterruptionLevel: freezed == nationwideInterruptionLevel ? _self.nationwideInterruptionLevel : nationwideInterruptionLevel // ignore: cast_nullable_to_non_nullable
as NationwideInterruptionLevel?,
  ));
}

}


/// Adds pattern-matching-related methods to [EewWarningConfigResponse].
extension EewWarningConfigResponsePatterns on EewWarningConfigResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarningConfigResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarningConfigResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarningConfigResponse value)  $default,){
final _that = this;
switch (_that) {
case _EewWarningConfigResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarningConfigResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarningConfigResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Target target, @JsonKey(name: 'current_location_interruption_level')  CurrentLocationInterruptionLevel currentLocationInterruptionLevel, @JsonKey(includeIfNull: true, name: 'nationwide_interruption_level')  NationwideInterruptionLevel? nationwideInterruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarningConfigResponse() when $default != null:
return $default(_that.target,_that.currentLocationInterruptionLevel,_that.nationwideInterruptionLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Target target, @JsonKey(name: 'current_location_interruption_level')  CurrentLocationInterruptionLevel currentLocationInterruptionLevel, @JsonKey(includeIfNull: true, name: 'nationwide_interruption_level')  NationwideInterruptionLevel? nationwideInterruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _EewWarningConfigResponse():
return $default(_that.target,_that.currentLocationInterruptionLevel,_that.nationwideInterruptionLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Target target, @JsonKey(name: 'current_location_interruption_level')  CurrentLocationInterruptionLevel currentLocationInterruptionLevel, @JsonKey(includeIfNull: true, name: 'nationwide_interruption_level')  NationwideInterruptionLevel? nationwideInterruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _EewWarningConfigResponse() when $default != null:
return $default(_that.target,_that.currentLocationInterruptionLevel,_that.nationwideInterruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewWarningConfigResponse implements EewWarningConfigResponse {
  const _EewWarningConfigResponse({required this.target, @JsonKey(name: 'current_location_interruption_level') required this.currentLocationInterruptionLevel, @JsonKey(includeIfNull: true, name: 'nationwide_interruption_level') required this.nationwideInterruptionLevel});
  factory _EewWarningConfigResponse.fromJson(Map<String, dynamic> json) => _$EewWarningConfigResponseFromJson(json);

@override final  Target target;
@override@JsonKey(name: 'current_location_interruption_level') final  CurrentLocationInterruptionLevel currentLocationInterruptionLevel;
@override@JsonKey(includeIfNull: true, name: 'nationwide_interruption_level') final  NationwideInterruptionLevel? nationwideInterruptionLevel;

/// Create a copy of EewWarningConfigResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningConfigResponseCopyWith<_EewWarningConfigResponse> get copyWith => __$EewWarningConfigResponseCopyWithImpl<_EewWarningConfigResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewWarningConfigResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarningConfigResponse&&(identical(other.target, target) || other.target == target)&&(identical(other.currentLocationInterruptionLevel, currentLocationInterruptionLevel) || other.currentLocationInterruptionLevel == currentLocationInterruptionLevel)&&(identical(other.nationwideInterruptionLevel, nationwideInterruptionLevel) || other.nationwideInterruptionLevel == nationwideInterruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,currentLocationInterruptionLevel,nationwideInterruptionLevel);

@override
String toString() {
  return 'EewWarningConfigResponse(target: $target, currentLocationInterruptionLevel: $currentLocationInterruptionLevel, nationwideInterruptionLevel: $nationwideInterruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$EewWarningConfigResponseCopyWith<$Res> implements $EewWarningConfigResponseCopyWith<$Res> {
  factory _$EewWarningConfigResponseCopyWith(_EewWarningConfigResponse value, $Res Function(_EewWarningConfigResponse) _then) = __$EewWarningConfigResponseCopyWithImpl;
@override @useResult
$Res call({
 Target target,@JsonKey(name: 'current_location_interruption_level') CurrentLocationInterruptionLevel currentLocationInterruptionLevel,@JsonKey(includeIfNull: true, name: 'nationwide_interruption_level') NationwideInterruptionLevel? nationwideInterruptionLevel
});




}
/// @nodoc
class __$EewWarningConfigResponseCopyWithImpl<$Res>
    implements _$EewWarningConfigResponseCopyWith<$Res> {
  __$EewWarningConfigResponseCopyWithImpl(this._self, this._then);

  final _EewWarningConfigResponse _self;
  final $Res Function(_EewWarningConfigResponse) _then;

/// Create a copy of EewWarningConfigResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = null,Object? currentLocationInterruptionLevel = null,Object? nationwideInterruptionLevel = freezed,}) {
  return _then(_EewWarningConfigResponse(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as Target,currentLocationInterruptionLevel: null == currentLocationInterruptionLevel ? _self.currentLocationInterruptionLevel : currentLocationInterruptionLevel // ignore: cast_nullable_to_non_nullable
as CurrentLocationInterruptionLevel,nationwideInterruptionLevel: freezed == nationwideInterruptionLevel ? _self.nationwideInterruptionLevel : nationwideInterruptionLevel // ignore: cast_nullable_to_non_nullable
as NationwideInterruptionLevel?,
  ));
}


}

// dart format on
