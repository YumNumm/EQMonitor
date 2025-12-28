// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_search_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarthquakeSearchParameter {

 EarthquakeSearchType get type; String get code; String get name; double? get magnitudeLte; double? get magnitudeGte; int? get depthLte; int? get depthGte; IntensityValue? get intensityLte; IntensityValue? get intensityGte; List<TelegramStatus>? get statuses;
/// Create a copy of EarthquakeSearchParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeSearchParameterCopyWith<EarthquakeSearchParameter> get copyWith => _$EarthquakeSearchParameterCopyWithImpl<EarthquakeSearchParameter>(this as EarthquakeSearchParameter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeSearchParameter&&(identical(other.type, type) || other.type == type)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&const DeepCollectionEquality().equals(other.statuses, statuses));
}


@override
int get hashCode => Object.hash(runtimeType,type,code,name,magnitudeLte,magnitudeGte,depthLte,depthGte,intensityLte,intensityGte,const DeepCollectionEquality().hash(statuses));

@override
String toString() {
  return 'EarthquakeSearchParameter(type: $type, code: $code, name: $name, magnitudeLte: $magnitudeLte, magnitudeGte: $magnitudeGte, depthLte: $depthLte, depthGte: $depthGte, intensityLte: $intensityLte, intensityGte: $intensityGte, statuses: $statuses)';
}


}

/// @nodoc
abstract mixin class $EarthquakeSearchParameterCopyWith<$Res>  {
  factory $EarthquakeSearchParameterCopyWith(EarthquakeSearchParameter value, $Res Function(EarthquakeSearchParameter) _then) = _$EarthquakeSearchParameterCopyWithImpl;
@useResult
$Res call({
 EarthquakeSearchType type, String code, String name, double? magnitudeLte, double? magnitudeGte, int? depthLte, int? depthGte, IntensityValue? intensityLte, IntensityValue? intensityGte, List<TelegramStatus>? statuses
});




}
/// @nodoc
class _$EarthquakeSearchParameterCopyWithImpl<$Res>
    implements $EarthquakeSearchParameterCopyWith<$Res> {
  _$EarthquakeSearchParameterCopyWithImpl(this._self, this._then);

  final EarthquakeSearchParameter _self;
  final $Res Function(EarthquakeSearchParameter) _then;

/// Create a copy of EarthquakeSearchParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? code = null,Object? name = null,Object? magnitudeLte = freezed,Object? magnitudeGte = freezed,Object? depthLte = freezed,Object? depthGte = freezed,Object? intensityLte = freezed,Object? intensityGte = freezed,Object? statuses = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeSearchType,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [EarthquakeSearchParameter].
extension EarthquakeSearchParameterPatterns on EarthquakeSearchParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeSearchParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeSearchParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeSearchParameter value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeSearchParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeSearchParameter value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeSearchParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeSearchType type,  String code,  String name,  double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  IntensityValue? intensityLte,  IntensityValue? intensityGte,  List<TelegramStatus>? statuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeSearchParameter() when $default != null:
return $default(_that.type,_that.code,_that.name,_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeSearchType type,  String code,  String name,  double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  IntensityValue? intensityLte,  IntensityValue? intensityGte,  List<TelegramStatus>? statuses)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSearchParameter():
return $default(_that.type,_that.code,_that.name,_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeSearchType type,  String code,  String name,  double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  IntensityValue? intensityLte,  IntensityValue? intensityGte,  List<TelegramStatus>? statuses)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeSearchParameter() when $default != null:
return $default(_that.type,_that.code,_that.name,_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeSearchParameter implements EarthquakeSearchParameter {
  const _EarthquakeSearchParameter({required this.type, required this.code, required this.name, this.magnitudeLte, this.magnitudeGte, this.depthLte, this.depthGte, this.intensityLte, this.intensityGte, final  List<TelegramStatus>? statuses}): _statuses = statuses;
  

@override final  EarthquakeSearchType type;
@override final  String code;
@override final  String name;
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


/// Create a copy of EarthquakeSearchParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeSearchParameterCopyWith<_EarthquakeSearchParameter> get copyWith => __$EarthquakeSearchParameterCopyWithImpl<_EarthquakeSearchParameter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeSearchParameter&&(identical(other.type, type) || other.type == type)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&const DeepCollectionEquality().equals(other._statuses, _statuses));
}


@override
int get hashCode => Object.hash(runtimeType,type,code,name,magnitudeLte,magnitudeGte,depthLte,depthGte,intensityLte,intensityGte,const DeepCollectionEquality().hash(_statuses));

@override
String toString() {
  return 'EarthquakeSearchParameter(type: $type, code: $code, name: $name, magnitudeLte: $magnitudeLte, magnitudeGte: $magnitudeGte, depthLte: $depthLte, depthGte: $depthGte, intensityLte: $intensityLte, intensityGte: $intensityGte, statuses: $statuses)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeSearchParameterCopyWith<$Res> implements $EarthquakeSearchParameterCopyWith<$Res> {
  factory _$EarthquakeSearchParameterCopyWith(_EarthquakeSearchParameter value, $Res Function(_EarthquakeSearchParameter) _then) = __$EarthquakeSearchParameterCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeSearchType type, String code, String name, double? magnitudeLte, double? magnitudeGte, int? depthLte, int? depthGte, IntensityValue? intensityLte, IntensityValue? intensityGte, List<TelegramStatus>? statuses
});




}
/// @nodoc
class __$EarthquakeSearchParameterCopyWithImpl<$Res>
    implements _$EarthquakeSearchParameterCopyWith<$Res> {
  __$EarthquakeSearchParameterCopyWithImpl(this._self, this._then);

  final _EarthquakeSearchParameter _self;
  final $Res Function(_EarthquakeSearchParameter) _then;

/// Create a copy of EarthquakeSearchParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? code = null,Object? name = null,Object? magnitudeLte = freezed,Object? magnitudeGte = freezed,Object? depthLte = freezed,Object? depthGte = freezed,Object? intensityLte = freezed,Object? intensityGte = freezed,Object? statuses = freezed,}) {
  return _then(_EarthquakeSearchParameter(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeSearchType,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
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
