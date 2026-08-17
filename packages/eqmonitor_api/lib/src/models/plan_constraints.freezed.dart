// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_constraints.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanConstraints {

@JsonKey(name: 'is_pro') bool get isPro;@JsonKey(name: 'max_regions') num get maxRegions;@JsonKey(name: 'eew_warning_nationwide') bool get eewWarningNationwide;@JsonKey(name: 'shake_detection') bool get shakeDetection;@JsonKey(name: 'overrides_allowed') bool get overridesAllowed;@JsonKey(name: 'earthquake_default_interruption_level') String get earthquakeDefaultInterruptionLevel;@JsonKey(name: 'eew_default_interruption_level') String get eewDefaultInterruptionLevel;
/// Create a copy of PlanConstraints
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanConstraintsCopyWith<PlanConstraints> get copyWith => _$PlanConstraintsCopyWithImpl<PlanConstraints>(this as PlanConstraints, _$identity);

  /// Serializes this PlanConstraints to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanConstraints&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.maxRegions, maxRegions) || other.maxRegions == maxRegions)&&(identical(other.eewWarningNationwide, eewWarningNationwide) || other.eewWarningNationwide == eewWarningNationwide)&&(identical(other.shakeDetection, shakeDetection) || other.shakeDetection == shakeDetection)&&(identical(other.overridesAllowed, overridesAllowed) || other.overridesAllowed == overridesAllowed)&&(identical(other.earthquakeDefaultInterruptionLevel, earthquakeDefaultInterruptionLevel) || other.earthquakeDefaultInterruptionLevel == earthquakeDefaultInterruptionLevel)&&(identical(other.eewDefaultInterruptionLevel, eewDefaultInterruptionLevel) || other.eewDefaultInterruptionLevel == eewDefaultInterruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isPro,maxRegions,eewWarningNationwide,shakeDetection,overridesAllowed,earthquakeDefaultInterruptionLevel,eewDefaultInterruptionLevel);

@override
String toString() {
  return 'PlanConstraints(isPro: $isPro, maxRegions: $maxRegions, eewWarningNationwide: $eewWarningNationwide, shakeDetection: $shakeDetection, overridesAllowed: $overridesAllowed, earthquakeDefaultInterruptionLevel: $earthquakeDefaultInterruptionLevel, eewDefaultInterruptionLevel: $eewDefaultInterruptionLevel)';
}


}

/// @nodoc
abstract mixin class $PlanConstraintsCopyWith<$Res>  {
  factory $PlanConstraintsCopyWith(PlanConstraints value, $Res Function(PlanConstraints) _then) = _$PlanConstraintsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_pro') bool isPro,@JsonKey(name: 'max_regions') num maxRegions,@JsonKey(name: 'eew_warning_nationwide') bool eewWarningNationwide,@JsonKey(name: 'shake_detection') bool shakeDetection,@JsonKey(name: 'overrides_allowed') bool overridesAllowed,@JsonKey(name: 'earthquake_default_interruption_level') String earthquakeDefaultInterruptionLevel,@JsonKey(name: 'eew_default_interruption_level') String eewDefaultInterruptionLevel
});




}
/// @nodoc
class _$PlanConstraintsCopyWithImpl<$Res>
    implements $PlanConstraintsCopyWith<$Res> {
  _$PlanConstraintsCopyWithImpl(this._self, this._then);

  final PlanConstraints _self;
  final $Res Function(PlanConstraints) _then;

/// Create a copy of PlanConstraints
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPro = null,Object? maxRegions = null,Object? eewWarningNationwide = null,Object? shakeDetection = null,Object? overridesAllowed = null,Object? earthquakeDefaultInterruptionLevel = null,Object? eewDefaultInterruptionLevel = null,}) {
  return _then(PlanConstraints(
isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,maxRegions: null == maxRegions ? _self.maxRegions : maxRegions // ignore: cast_nullable_to_non_nullable
as num,eewWarningNationwide: null == eewWarningNationwide ? _self.eewWarningNationwide : eewWarningNationwide // ignore: cast_nullable_to_non_nullable
as bool,shakeDetection: null == shakeDetection ? _self.shakeDetection : shakeDetection // ignore: cast_nullable_to_non_nullable
as bool,overridesAllowed: null == overridesAllowed ? _self.overridesAllowed : overridesAllowed // ignore: cast_nullable_to_non_nullable
as bool,earthquakeDefaultInterruptionLevel: null == earthquakeDefaultInterruptionLevel ? _self.earthquakeDefaultInterruptionLevel : earthquakeDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as String,eewDefaultInterruptionLevel: null == eewDefaultInterruptionLevel ? _self.eewDefaultInterruptionLevel : eewDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanConstraints].
extension PlanConstraintsPatterns on PlanConstraints {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanConstraints value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanConstraints() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanConstraints value)  $default,){
final _that = this;
switch (_that) {
case _PlanConstraints():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanConstraints value)?  $default,){
final _that = this;
switch (_that) {
case _PlanConstraints() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_pro')  bool isPro, @JsonKey(name: 'max_regions')  num maxRegions, @JsonKey(name: 'eew_warning_nationwide')  bool eewWarningNationwide, @JsonKey(name: 'shake_detection')  bool shakeDetection, @JsonKey(name: 'overrides_allowed')  bool overridesAllowed, @JsonKey(name: 'earthquake_default_interruption_level')  String earthquakeDefaultInterruptionLevel, @JsonKey(name: 'eew_default_interruption_level')  String eewDefaultInterruptionLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanConstraints() when $default != null:
return $default(_that.isPro,_that.maxRegions,_that.eewWarningNationwide,_that.shakeDetection,_that.overridesAllowed,_that.earthquakeDefaultInterruptionLevel,_that.eewDefaultInterruptionLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_pro')  bool isPro, @JsonKey(name: 'max_regions')  num maxRegions, @JsonKey(name: 'eew_warning_nationwide')  bool eewWarningNationwide, @JsonKey(name: 'shake_detection')  bool shakeDetection, @JsonKey(name: 'overrides_allowed')  bool overridesAllowed, @JsonKey(name: 'earthquake_default_interruption_level')  String earthquakeDefaultInterruptionLevel, @JsonKey(name: 'eew_default_interruption_level')  String eewDefaultInterruptionLevel)  $default,) {final _that = this;
switch (_that) {
case _PlanConstraints():
return $default(_that.isPro,_that.maxRegions,_that.eewWarningNationwide,_that.shakeDetection,_that.overridesAllowed,_that.earthquakeDefaultInterruptionLevel,_that.eewDefaultInterruptionLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_pro')  bool isPro, @JsonKey(name: 'max_regions')  num maxRegions, @JsonKey(name: 'eew_warning_nationwide')  bool eewWarningNationwide, @JsonKey(name: 'shake_detection')  bool shakeDetection, @JsonKey(name: 'overrides_allowed')  bool overridesAllowed, @JsonKey(name: 'earthquake_default_interruption_level')  String earthquakeDefaultInterruptionLevel, @JsonKey(name: 'eew_default_interruption_level')  String eewDefaultInterruptionLevel)?  $default,) {final _that = this;
switch (_that) {
case _PlanConstraints() when $default != null:
return $default(_that.isPro,_that.maxRegions,_that.eewWarningNationwide,_that.shakeDetection,_that.overridesAllowed,_that.earthquakeDefaultInterruptionLevel,_that.eewDefaultInterruptionLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanConstraints implements PlanConstraints {
  const _PlanConstraints({@JsonKey(name: 'is_pro') required this.isPro, @JsonKey(name: 'max_regions') required this.maxRegions, @JsonKey(name: 'eew_warning_nationwide') required this.eewWarningNationwide, @JsonKey(name: 'shake_detection') required this.shakeDetection, @JsonKey(name: 'overrides_allowed') required this.overridesAllowed, @JsonKey(name: 'earthquake_default_interruption_level') required this.earthquakeDefaultInterruptionLevel, @JsonKey(name: 'eew_default_interruption_level') required this.eewDefaultInterruptionLevel});
  factory _PlanConstraints.fromJson(Map<String, dynamic> json) => _$PlanConstraintsFromJson(json);

@override@JsonKey(name: 'is_pro') final  bool isPro;
@override@JsonKey(name: 'max_regions') final  num maxRegions;
@override@JsonKey(name: 'eew_warning_nationwide') final  bool eewWarningNationwide;
@override@JsonKey(name: 'shake_detection') final  bool shakeDetection;
@override@JsonKey(name: 'overrides_allowed') final  bool overridesAllowed;
@override@JsonKey(name: 'earthquake_default_interruption_level') final  String earthquakeDefaultInterruptionLevel;
@override@JsonKey(name: 'eew_default_interruption_level') final  String eewDefaultInterruptionLevel;

/// Create a copy of PlanConstraints
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanConstraintsCopyWith<_PlanConstraints> get copyWith => __$PlanConstraintsCopyWithImpl<_PlanConstraints>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanConstraintsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanConstraints&&(identical(other.isPro, isPro) || other.isPro == isPro)&&(identical(other.maxRegions, maxRegions) || other.maxRegions == maxRegions)&&(identical(other.eewWarningNationwide, eewWarningNationwide) || other.eewWarningNationwide == eewWarningNationwide)&&(identical(other.shakeDetection, shakeDetection) || other.shakeDetection == shakeDetection)&&(identical(other.overridesAllowed, overridesAllowed) || other.overridesAllowed == overridesAllowed)&&(identical(other.earthquakeDefaultInterruptionLevel, earthquakeDefaultInterruptionLevel) || other.earthquakeDefaultInterruptionLevel == earthquakeDefaultInterruptionLevel)&&(identical(other.eewDefaultInterruptionLevel, eewDefaultInterruptionLevel) || other.eewDefaultInterruptionLevel == eewDefaultInterruptionLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isPro,maxRegions,eewWarningNationwide,shakeDetection,overridesAllowed,earthquakeDefaultInterruptionLevel,eewDefaultInterruptionLevel);

@override
String toString() {
  return 'PlanConstraints(isPro: $isPro, maxRegions: $maxRegions, eewWarningNationwide: $eewWarningNationwide, shakeDetection: $shakeDetection, overridesAllowed: $overridesAllowed, earthquakeDefaultInterruptionLevel: $earthquakeDefaultInterruptionLevel, eewDefaultInterruptionLevel: $eewDefaultInterruptionLevel)';
}


}

/// @nodoc
abstract mixin class _$PlanConstraintsCopyWith<$Res> implements $PlanConstraintsCopyWith<$Res> {
  factory _$PlanConstraintsCopyWith(_PlanConstraints value, $Res Function(_PlanConstraints) _then) = __$PlanConstraintsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_pro') bool isPro,@JsonKey(name: 'max_regions') num maxRegions,@JsonKey(name: 'eew_warning_nationwide') bool eewWarningNationwide,@JsonKey(name: 'shake_detection') bool shakeDetection,@JsonKey(name: 'overrides_allowed') bool overridesAllowed,@JsonKey(name: 'earthquake_default_interruption_level') String earthquakeDefaultInterruptionLevel,@JsonKey(name: 'eew_default_interruption_level') String eewDefaultInterruptionLevel
});




}
/// @nodoc
class __$PlanConstraintsCopyWithImpl<$Res>
    implements _$PlanConstraintsCopyWith<$Res> {
  __$PlanConstraintsCopyWithImpl(this._self, this._then);

  final _PlanConstraints _self;
  final $Res Function(_PlanConstraints) _then;

/// Create a copy of PlanConstraints
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPro = null,Object? maxRegions = null,Object? eewWarningNationwide = null,Object? shakeDetection = null,Object? overridesAllowed = null,Object? earthquakeDefaultInterruptionLevel = null,Object? eewDefaultInterruptionLevel = null,}) {
  return _then(_PlanConstraints(
isPro: null == isPro ? _self.isPro : isPro // ignore: cast_nullable_to_non_nullable
as bool,maxRegions: null == maxRegions ? _self.maxRegions : maxRegions // ignore: cast_nullable_to_non_nullable
as num,eewWarningNationwide: null == eewWarningNationwide ? _self.eewWarningNationwide : eewWarningNationwide // ignore: cast_nullable_to_non_nullable
as bool,shakeDetection: null == shakeDetection ? _self.shakeDetection : shakeDetection // ignore: cast_nullable_to_non_nullable
as bool,overridesAllowed: null == overridesAllowed ? _self.overridesAllowed : overridesAllowed // ignore: cast_nullable_to_non_nullable
as bool,earthquakeDefaultInterruptionLevel: null == earthquakeDefaultInterruptionLevel ? _self.earthquakeDefaultInterruptionLevel : earthquakeDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as String,eewDefaultInterruptionLevel: null == eewDefaultInterruptionLevel ? _self.eewDefaultInterruptionLevel : eewDefaultInterruptionLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
