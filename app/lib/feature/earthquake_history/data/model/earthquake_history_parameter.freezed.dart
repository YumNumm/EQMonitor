// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_history_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeHistoryParameter {

 double? get magnitudeLte; double? get magnitudeGte; int? get depthLte; int? get depthGte; IntensityValue? get intensityLte; IntensityValue? get intensityGte; List<TelegramStatus>? get statuses;
/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterCopyWith<EarthquakeHistoryParameter> get copyWith => _$EarthquakeHistoryParameterCopyWithImpl<EarthquakeHistoryParameter>(this as EarthquakeHistoryParameter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryParameter&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&const DeepCollectionEquality().equals(other.statuses, statuses));
}


@override
int get hashCode => Object.hash(runtimeType,magnitudeLte,magnitudeGte,depthLte,depthGte,intensityLte,intensityGte,const DeepCollectionEquality().hash(statuses));

@override
String toString() {
  return 'EarthquakeHistoryParameter(magnitudeLte: $magnitudeLte, magnitudeGte: $magnitudeGte, depthLte: $depthLte, depthGte: $depthGte, intensityLte: $intensityLte, intensityGte: $intensityGte, statuses: $statuses)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryParameterCopyWith<$Res>  {
  factory $EarthquakeHistoryParameterCopyWith(EarthquakeHistoryParameter value, $Res Function(EarthquakeHistoryParameter) _then) = _$EarthquakeHistoryParameterCopyWithImpl;
@useResult
$Res call({
 double? magnitudeLte, double? magnitudeGte, int? depthLte, int? depthGte, IntensityValue? intensityLte, IntensityValue? intensityGte, List<TelegramStatus>? statuses
});




}
/// @nodoc
class _$EarthquakeHistoryParameterCopyWithImpl<$Res>
    implements $EarthquakeHistoryParameterCopyWith<$Res> {
  _$EarthquakeHistoryParameterCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryParameter _self;
  final $Res Function(EarthquakeHistoryParameter) _then;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? magnitudeLte = freezed,Object? magnitudeGte = freezed,Object? depthLte = freezed,Object? depthGte = freezed,Object? intensityLte = freezed,Object? intensityGte = freezed,Object? statuses = freezed,}) {
  return _then(_self.copyWith(
magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as IntensityValue?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as IntensityValue?,statuses: freezed == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeHistoryParameter].
extension EarthquakeHistoryParameterPatterns on EarthquakeHistoryParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeHistoryParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeHistoryParameter value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeHistoryParameter value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  IntensityValue? intensityLte,  IntensityValue? intensityGte,  List<TelegramStatus>? statuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter() when $default != null:
return $default(_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  IntensityValue? intensityLte,  IntensityValue? intensityGte,  List<TelegramStatus>? statuses)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter():
return $default(_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  IntensityValue? intensityLte,  IntensityValue? intensityGte,  List<TelegramStatus>? statuses)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter() when $default != null:
return $default(_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeHistoryParameter implements EarthquakeHistoryParameter {
  const _EarthquakeHistoryParameter({this.magnitudeLte, this.magnitudeGte, this.depthLte, this.depthGte, this.intensityLte, this.intensityGte, final  List<TelegramStatus>? statuses}): _statuses = statuses;
  

@override final  double? magnitudeLte;
@override final  double? magnitudeGte;
@override final  int? depthLte;
@override final  int? depthGte;
@override final  IntensityValue? intensityLte;
@override final  IntensityValue? intensityGte;
 final  List<TelegramStatus>? _statuses;
@override List<TelegramStatus>? get statuses {
  final value = _statuses;
  if (value == null) return null;
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryParameterCopyWith<_EarthquakeHistoryParameter> get copyWith => __$EarthquakeHistoryParameterCopyWithImpl<_EarthquakeHistoryParameter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryParameter&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&const DeepCollectionEquality().equals(other._statuses, _statuses));
}


@override
int get hashCode => Object.hash(runtimeType,magnitudeLte,magnitudeGte,depthLte,depthGte,intensityLte,intensityGte,const DeepCollectionEquality().hash(_statuses));

@override
String toString() {
  return 'EarthquakeHistoryParameter(magnitudeLte: $magnitudeLte, magnitudeGte: $magnitudeGte, depthLte: $depthLte, depthGte: $depthGte, intensityLte: $intensityLte, intensityGte: $intensityGte, statuses: $statuses)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryParameterCopyWith<$Res> implements $EarthquakeHistoryParameterCopyWith<$Res> {
  factory _$EarthquakeHistoryParameterCopyWith(_EarthquakeHistoryParameter value, $Res Function(_EarthquakeHistoryParameter) _then) = __$EarthquakeHistoryParameterCopyWithImpl;
@override @useResult
$Res call({
 double? magnitudeLte, double? magnitudeGte, int? depthLte, int? depthGte, IntensityValue? intensityLte, IntensityValue? intensityGte, List<TelegramStatus>? statuses
});




}
/// @nodoc
class __$EarthquakeHistoryParameterCopyWithImpl<$Res>
    implements _$EarthquakeHistoryParameterCopyWith<$Res> {
  __$EarthquakeHistoryParameterCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryParameter _self;
  final $Res Function(_EarthquakeHistoryParameter) _then;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? magnitudeLte = freezed,Object? magnitudeGte = freezed,Object? depthLte = freezed,Object? depthGte = freezed,Object? intensityLte = freezed,Object? intensityGte = freezed,Object? statuses = freezed,}) {
  return _then(_EarthquakeHistoryParameter(
magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as IntensityValue?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as IntensityValue?,statuses: freezed == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,
  ));
}


}

// dart format on
