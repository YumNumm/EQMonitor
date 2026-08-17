// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_warning_config_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewWarningConfigRequest {

@JsonKey(includeIfNull: false) Target? get target;@JsonKey(includeIfNull: false, name: 'current_location_interruption_level') CurrentLocationInterruptionLevel? get currentLocationInterruptionLevel;@JsonKey(includeIfNull: false, name: 'nationwide_interruption_level') NationwideInterruptionLevel? get nationwideInterruptionLevel;
/// Create a copy of EewWarningConfigRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningConfigRequestCopyWith<EewWarningConfigRequest> get copyWith => _$EewWarningConfigRequestCopyWithImpl<EewWarningConfigRequest>(this as EewWarningConfigRequest, _$identity);

  /// Serializes this EewWarningConfigRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarningConfigRequest&&(identical(other.target, target) || other.target == target)&&(identical(other.currentLocationInterruptionLevel, currentLocationInterruptionLevel) || other.currentLocationInterruptionLevel == currentLocationInterruptionLevel)&&(identical(other.nationwideInterruptionLevel, nationwideInterruptionLevel) || other.nationwideInterruptionLevel == nationwideInterruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,currentLocationInterruptionLevel,nationwideInterruptionLevel);

@override
String toString() {
  return 'EewWarningConfigRequest(target: $target, currentLocationInterruptionLevel: $currentLocationInterruptionLevel, nationwideInterruptionLevel: $nationwideInterruptionLevel)';
}


}

/// @nodoc
abstract mixin class $EewWarningConfigRequestCopyWith<$Res>  {
  factory $EewWarningConfigRequestCopyWith(EewWarningConfigRequest value, $Res Function(EewWarningConfigRequest) _then) = _$EewWarningConfigRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) Target? target,@JsonKey(includeIfNull: false, name: 'current_location_interruption_level') CurrentLocationInterruptionLevel? currentLocationInterruptionLevel,@JsonKey(includeIfNull: false, name: 'nationwide_interruption_level') NationwideInterruptionLevel? nationwideInterruptionLevel
});




}
/// @nodoc
class _$EewWarningConfigRequestCopyWithImpl<$Res>
    implements $EewWarningConfigRequestCopyWith<$Res> {
  _$EewWarningConfigRequestCopyWithImpl(this._self, this._then);

  final EewWarningConfigRequest _self;
  final $Res Function(EewWarningConfigRequest) _then;

/// Create a copy of EewWarningConfigRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = freezed,Object? currentLocationInterruptionLevel = freezed,Object? nationwideInterruptionLevel = freezed,}) {
  return _then(_self.copyWith(
target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as Target?,currentLocationInterruptionLevel: freezed == currentLocationInterruptionLevel ? _self.currentLocationInterruptionLevel : currentLocationInterruptionLevel // ignore: cast_nullable_to_non_nullable
as CurrentLocationInterruptionLevel?,nationwideInterruptionLevel: freezed == nationwideInterruptionLevel ? _self.nationwideInterruptionLevel : nationwideInterruptionLevel // ignore: cast_nullable_to_non_nullable
as NationwideInterruptionLevel?,
  ));
}

}


/// Adds pattern-matching-related methods to [EewWarningConfigRequest].
extension EewWarningConfigRequestPatterns on EewWarningConfigRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarningConfigRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarningConfigRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarningConfigRequest value)  $default,){
final _that = this;
switch (_that) {
case _EewWarningConfigRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarningConfigRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarningConfigRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  Target? target, @JsonKey(includeIfNull: false, name: 'current_location_interruption_level')  CurrentLocationInterruptionLevel? currentLocationInterruptionLevel, @JsonKey(includeIfNull: false, name: 'nationwide_interruption_level')  NationwideInterruptionLevel? nationwideInterruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarningConfigRequest() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  Target? target, @JsonKey(includeIfNull: false, name: 'current_location_interruption_level')  CurrentLocationInterruptionLevel? currentLocationInterruptionLevel, @JsonKey(includeIfNull: false, name: 'nationwide_interruption_level')  NationwideInterruptionLevel? nationwideInterruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _EewWarningConfigRequest():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  Target? target, @JsonKey(includeIfNull: false, name: 'current_location_interruption_level')  CurrentLocationInterruptionLevel? currentLocationInterruptionLevel, @JsonKey(includeIfNull: false, name: 'nationwide_interruption_level')  NationwideInterruptionLevel? nationwideInterruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _EewWarningConfigRequest() when $default != null:
return $default(_that.target,_that.currentLocationInterruptionLevel,_that.nationwideInterruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewWarningConfigRequest implements EewWarningConfigRequest {
  const _EewWarningConfigRequest({@JsonKey(includeIfNull: false) this.target, @JsonKey(includeIfNull: false, name: 'current_location_interruption_level') this.currentLocationInterruptionLevel, @JsonKey(includeIfNull: false, name: 'nationwide_interruption_level') this.nationwideInterruptionLevel});
  factory _EewWarningConfigRequest.fromJson(Map<String, dynamic> json) => _$EewWarningConfigRequestFromJson(json);

@override@JsonKey(includeIfNull: false) final  Target? target;
@override@JsonKey(includeIfNull: false, name: 'current_location_interruption_level') final  CurrentLocationInterruptionLevel? currentLocationInterruptionLevel;
@override@JsonKey(includeIfNull: false, name: 'nationwide_interruption_level') final  NationwideInterruptionLevel? nationwideInterruptionLevel;

/// Create a copy of EewWarningConfigRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningConfigRequestCopyWith<_EewWarningConfigRequest> get copyWith => __$EewWarningConfigRequestCopyWithImpl<_EewWarningConfigRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewWarningConfigRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarningConfigRequest&&(identical(other.target, target) || other.target == target)&&(identical(other.currentLocationInterruptionLevel, currentLocationInterruptionLevel) || other.currentLocationInterruptionLevel == currentLocationInterruptionLevel)&&(identical(other.nationwideInterruptionLevel, nationwideInterruptionLevel) || other.nationwideInterruptionLevel == nationwideInterruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,currentLocationInterruptionLevel,nationwideInterruptionLevel);

@override
String toString() {
  return 'EewWarningConfigRequest(target: $target, currentLocationInterruptionLevel: $currentLocationInterruptionLevel, nationwideInterruptionLevel: $nationwideInterruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$EewWarningConfigRequestCopyWith<$Res> implements $EewWarningConfigRequestCopyWith<$Res> {
  factory _$EewWarningConfigRequestCopyWith(_EewWarningConfigRequest value, $Res Function(_EewWarningConfigRequest) _then) = __$EewWarningConfigRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) Target? target,@JsonKey(includeIfNull: false, name: 'current_location_interruption_level') CurrentLocationInterruptionLevel? currentLocationInterruptionLevel,@JsonKey(includeIfNull: false, name: 'nationwide_interruption_level') NationwideInterruptionLevel? nationwideInterruptionLevel
});




}
/// @nodoc
class __$EewWarningConfigRequestCopyWithImpl<$Res>
    implements _$EewWarningConfigRequestCopyWith<$Res> {
  __$EewWarningConfigRequestCopyWithImpl(this._self, this._then);

  final _EewWarningConfigRequest _self;
  final $Res Function(_EewWarningConfigRequest) _then;

/// Create a copy of EewWarningConfigRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = freezed,Object? currentLocationInterruptionLevel = freezed,Object? nationwideInterruptionLevel = freezed,}) {
  return _then(_EewWarningConfigRequest(
target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as Target?,currentLocationInterruptionLevel: freezed == currentLocationInterruptionLevel ? _self.currentLocationInterruptionLevel : currentLocationInterruptionLevel // ignore: cast_nullable_to_non_nullable
as CurrentLocationInterruptionLevel?,nationwideInterruptionLevel: freezed == nationwideInterruptionLevel ? _self.nationwideInterruptionLevel : nationwideInterruptionLevel // ignore: cast_nullable_to_non_nullable
as NationwideInterruptionLevel?,
  ));
}


}

// dart format on
