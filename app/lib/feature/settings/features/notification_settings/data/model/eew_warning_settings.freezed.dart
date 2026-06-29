// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_warning_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EewWarningSettings {

 EewWarningTarget get target; InterruptionLevel? get nationwideInterruptionLevel;
/// Create a copy of EewWarningSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningSettingsCopyWith<EewWarningSettings> get copyWith => _$EewWarningSettingsCopyWithImpl<EewWarningSettings>(this as EewWarningSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarningSettings&&(identical(other.target, target) || other.target == target)&&(identical(other.nationwideInterruptionLevel, nationwideInterruptionLevel) || other.nationwideInterruptionLevel == nationwideInterruptionLevel));
}


@override
int get hashCode => Object.hash(runtimeType,target,nationwideInterruptionLevel);

@override
String toString() {
  return 'EewWarningSettings(target: $target, nationwideInterruptionLevel: $nationwideInterruptionLevel)';
}


}

/// @nodoc
abstract mixin class $EewWarningSettingsCopyWith<$Res>  {
  factory $EewWarningSettingsCopyWith(EewWarningSettings value, $Res Function(EewWarningSettings) _then) = _$EewWarningSettingsCopyWithImpl;
@useResult
$Res call({
 EewWarningTarget target, InterruptionLevel? nationwideInterruptionLevel
});




}
/// @nodoc
class _$EewWarningSettingsCopyWithImpl<$Res>
    implements $EewWarningSettingsCopyWith<$Res> {
  _$EewWarningSettingsCopyWithImpl(this._self, this._then);

  final EewWarningSettings _self;
  final $Res Function(EewWarningSettings) _then;

/// Create a copy of EewWarningSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = null,Object? nationwideInterruptionLevel = freezed,}) {
  return _then(_self.copyWith(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as EewWarningTarget,nationwideInterruptionLevel: freezed == nationwideInterruptionLevel ? _self.nationwideInterruptionLevel : nationwideInterruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel?,
  ));
}

}


/// Adds pattern-matching-related methods to [EewWarningSettings].
extension EewWarningSettingsPatterns on EewWarningSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarningSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarningSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarningSettings value)  $default,){
final _that = this;
switch (_that) {
case _EewWarningSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarningSettings value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarningSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EewWarningTarget target,  InterruptionLevel? nationwideInterruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarningSettings() when $default != null:
return $default(_that.target,_that.nationwideInterruptionLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EewWarningTarget target,  InterruptionLevel? nationwideInterruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _EewWarningSettings():
return $default(_that.target,_that.nationwideInterruptionLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EewWarningTarget target,  InterruptionLevel? nationwideInterruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _EewWarningSettings() when $default != null:
return $default(_that.target,_that.nationwideInterruptionLevel);case _:
  return null;

}
}

}

/// @nodoc


class _EewWarningSettings implements EewWarningSettings {
  const _EewWarningSettings({required this.target, required this.nationwideInterruptionLevel});
  

@override final  EewWarningTarget target;
@override final  InterruptionLevel? nationwideInterruptionLevel;

/// Create a copy of EewWarningSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningSettingsCopyWith<_EewWarningSettings> get copyWith => __$EewWarningSettingsCopyWithImpl<_EewWarningSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarningSettings&&(identical(other.target, target) || other.target == target)&&(identical(other.nationwideInterruptionLevel, nationwideInterruptionLevel) || other.nationwideInterruptionLevel == nationwideInterruptionLevel));
}


@override
int get hashCode => Object.hash(runtimeType,target,nationwideInterruptionLevel);

@override
String toString() {
  return 'EewWarningSettings(target: $target, nationwideInterruptionLevel: $nationwideInterruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$EewWarningSettingsCopyWith<$Res> implements $EewWarningSettingsCopyWith<$Res> {
  factory _$EewWarningSettingsCopyWith(_EewWarningSettings value, $Res Function(_EewWarningSettings) _then) = __$EewWarningSettingsCopyWithImpl;
@override @useResult
$Res call({
 EewWarningTarget target, InterruptionLevel? nationwideInterruptionLevel
});




}
/// @nodoc
class __$EewWarningSettingsCopyWithImpl<$Res>
    implements _$EewWarningSettingsCopyWith<$Res> {
  __$EewWarningSettingsCopyWithImpl(this._self, this._then);

  final _EewWarningSettings _self;
  final $Res Function(_EewWarningSettings) _then;

/// Create a copy of EewWarningSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = null,Object? nationwideInterruptionLevel = freezed,}) {
  return _then(_EewWarningSettings(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as EewWarningTarget,nationwideInterruptionLevel: freezed == nationwideInterruptionLevel ? _self.nationwideInterruptionLevel : nationwideInterruptionLevel // ignore: cast_nullable_to_non_nullable
as InterruptionLevel?,
  ));
}


}

// dart format on
