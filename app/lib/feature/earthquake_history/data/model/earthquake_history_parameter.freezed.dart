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

// 基本フィルター
 double? get magnitudeLte; double? get magnitudeGte; int? get depthLte; int? get depthGte; JmaIntensity? get intensityLte; JmaIntensity? get intensityGte; List<TelegramStatus>? get statuses;// 震央地名フィルター
 int? get epicenterCode; String? get epicenterName;// 地域の震度フィルター
 RegionSearchType? get regionSearchType; String? get regionCode; String? get regionName; JmaIntensity? get regionIntensityLte; JmaIntensity? get regionIntensityGte;
/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryParameterCopyWith<EarthquakeHistoryParameter> get copyWith => _$EarthquakeHistoryParameterCopyWithImpl<EarthquakeHistoryParameter>(this as EarthquakeHistoryParameter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryParameter&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&const DeepCollectionEquality().equals(other.statuses, statuses)&&(identical(other.epicenterCode, epicenterCode) || other.epicenterCode == epicenterCode)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.regionSearchType, regionSearchType) || other.regionSearchType == regionSearchType)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.regionIntensityLte, regionIntensityLte) || other.regionIntensityLte == regionIntensityLte)&&(identical(other.regionIntensityGte, regionIntensityGte) || other.regionIntensityGte == regionIntensityGte));
}


@override
int get hashCode => Object.hash(runtimeType,magnitudeLte,magnitudeGte,depthLte,depthGte,intensityLte,intensityGte,const DeepCollectionEquality().hash(statuses),epicenterCode,epicenterName,regionSearchType,regionCode,regionName,regionIntensityLte,regionIntensityGte);

@override
String toString() {
  return 'EarthquakeHistoryParameter(magnitudeLte: $magnitudeLte, magnitudeGte: $magnitudeGte, depthLte: $depthLte, depthGte: $depthGte, intensityLte: $intensityLte, intensityGte: $intensityGte, statuses: $statuses, epicenterCode: $epicenterCode, epicenterName: $epicenterName, regionSearchType: $regionSearchType, regionCode: $regionCode, regionName: $regionName, regionIntensityLte: $regionIntensityLte, regionIntensityGte: $regionIntensityGte)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryParameterCopyWith<$Res>  {
  factory $EarthquakeHistoryParameterCopyWith(EarthquakeHistoryParameter value, $Res Function(EarthquakeHistoryParameter) _then) = _$EarthquakeHistoryParameterCopyWithImpl;
@useResult
$Res call({
 double? magnitudeLte, double? magnitudeGte, int? depthLte, int? depthGte, JmaIntensity? intensityLte, JmaIntensity? intensityGte, List<TelegramStatus>? statuses, int? epicenterCode, String? epicenterName, RegionSearchType? regionSearchType, String? regionCode, String? regionName, JmaIntensity? regionIntensityLte, JmaIntensity? regionIntensityGte
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
@pragma('vm:prefer-inline') @override $Res call({Object? magnitudeLte = freezed,Object? magnitudeGte = freezed,Object? depthLte = freezed,Object? depthGte = freezed,Object? intensityLte = freezed,Object? intensityGte = freezed,Object? statuses = freezed,Object? epicenterCode = freezed,Object? epicenterName = freezed,Object? regionSearchType = freezed,Object? regionCode = freezed,Object? regionName = freezed,Object? regionIntensityLte = freezed,Object? regionIntensityGte = freezed,}) {
  return _then(_self.copyWith(
magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,statuses: freezed == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,epicenterCode: freezed == epicenterCode ? _self.epicenterCode : epicenterCode // ignore: cast_nullable_to_non_nullable
as int?,epicenterName: freezed == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String?,regionSearchType: freezed == regionSearchType ? _self.regionSearchType : regionSearchType // ignore: cast_nullable_to_non_nullable
as RegionSearchType?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,regionIntensityLte: freezed == regionIntensityLte ? _self.regionIntensityLte : regionIntensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,regionIntensityGte: freezed == regionIntensityGte ? _self.regionIntensityGte : regionIntensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  JmaIntensity? intensityLte,  JmaIntensity? intensityGte,  List<TelegramStatus>? statuses,  int? epicenterCode,  String? epicenterName,  RegionSearchType? regionSearchType,  String? regionCode,  String? regionName,  JmaIntensity? regionIntensityLte,  JmaIntensity? regionIntensityGte)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter() when $default != null:
return $default(_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses,_that.epicenterCode,_that.epicenterName,_that.regionSearchType,_that.regionCode,_that.regionName,_that.regionIntensityLte,_that.regionIntensityGte);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  JmaIntensity? intensityLte,  JmaIntensity? intensityGte,  List<TelegramStatus>? statuses,  int? epicenterCode,  String? epicenterName,  RegionSearchType? regionSearchType,  String? regionCode,  String? regionName,  JmaIntensity? regionIntensityLte,  JmaIntensity? regionIntensityGte)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter():
return $default(_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses,_that.epicenterCode,_that.epicenterName,_that.regionSearchType,_that.regionCode,_that.regionName,_that.regionIntensityLte,_that.regionIntensityGte);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? magnitudeLte,  double? magnitudeGte,  int? depthLte,  int? depthGte,  JmaIntensity? intensityLte,  JmaIntensity? intensityGte,  List<TelegramStatus>? statuses,  int? epicenterCode,  String? epicenterName,  RegionSearchType? regionSearchType,  String? regionCode,  String? regionName,  JmaIntensity? regionIntensityLte,  JmaIntensity? regionIntensityGte)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHistoryParameter() when $default != null:
return $default(_that.magnitudeLte,_that.magnitudeGte,_that.depthLte,_that.depthGte,_that.intensityLte,_that.intensityGte,_that.statuses,_that.epicenterCode,_that.epicenterName,_that.regionSearchType,_that.regionCode,_that.regionName,_that.regionIntensityLte,_that.regionIntensityGte);case _:
  return null;

}
}

}

/// @nodoc


class _EarthquakeHistoryParameter extends EarthquakeHistoryParameter {
  const _EarthquakeHistoryParameter({this.magnitudeLte, this.magnitudeGte, this.depthLte, this.depthGte, this.intensityLte, this.intensityGte, final  List<TelegramStatus>? statuses, this.epicenterCode, this.epicenterName, this.regionSearchType, this.regionCode, this.regionName, this.regionIntensityLte, this.regionIntensityGte}): _statuses = statuses,super._();
  

// 基本フィルター
@override final  double? magnitudeLte;
@override final  double? magnitudeGte;
@override final  int? depthLte;
@override final  int? depthGte;
@override final  JmaIntensity? intensityLte;
@override final  JmaIntensity? intensityGte;
 final  List<TelegramStatus>? _statuses;
@override List<TelegramStatus>? get statuses {
  final value = _statuses;
  if (value == null) return null;
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// 震央地名フィルター
@override final  int? epicenterCode;
@override final  String? epicenterName;
// 地域の震度フィルター
@override final  RegionSearchType? regionSearchType;
@override final  String? regionCode;
@override final  String? regionName;
@override final  JmaIntensity? regionIntensityLte;
@override final  JmaIntensity? regionIntensityGte;

/// Create a copy of EarthquakeHistoryParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryParameterCopyWith<_EarthquakeHistoryParameter> get copyWith => __$EarthquakeHistoryParameterCopyWithImpl<_EarthquakeHistoryParameter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryParameter&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&(identical(other.epicenterCode, epicenterCode) || other.epicenterCode == epicenterCode)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.regionSearchType, regionSearchType) || other.regionSearchType == regionSearchType)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.regionIntensityLte, regionIntensityLte) || other.regionIntensityLte == regionIntensityLte)&&(identical(other.regionIntensityGte, regionIntensityGte) || other.regionIntensityGte == regionIntensityGte));
}


@override
int get hashCode => Object.hash(runtimeType,magnitudeLte,magnitudeGte,depthLte,depthGte,intensityLte,intensityGte,const DeepCollectionEquality().hash(_statuses),epicenterCode,epicenterName,regionSearchType,regionCode,regionName,regionIntensityLte,regionIntensityGte);

@override
String toString() {
  return 'EarthquakeHistoryParameter(magnitudeLte: $magnitudeLte, magnitudeGte: $magnitudeGte, depthLte: $depthLte, depthGte: $depthGte, intensityLte: $intensityLte, intensityGte: $intensityGte, statuses: $statuses, epicenterCode: $epicenterCode, epicenterName: $epicenterName, regionSearchType: $regionSearchType, regionCode: $regionCode, regionName: $regionName, regionIntensityLte: $regionIntensityLte, regionIntensityGte: $regionIntensityGte)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryParameterCopyWith<$Res> implements $EarthquakeHistoryParameterCopyWith<$Res> {
  factory _$EarthquakeHistoryParameterCopyWith(_EarthquakeHistoryParameter value, $Res Function(_EarthquakeHistoryParameter) _then) = __$EarthquakeHistoryParameterCopyWithImpl;
@override @useResult
$Res call({
 double? magnitudeLte, double? magnitudeGte, int? depthLte, int? depthGte, JmaIntensity? intensityLte, JmaIntensity? intensityGte, List<TelegramStatus>? statuses, int? epicenterCode, String? epicenterName, RegionSearchType? regionSearchType, String? regionCode, String? regionName, JmaIntensity? regionIntensityLte, JmaIntensity? regionIntensityGte
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
@override @pragma('vm:prefer-inline') $Res call({Object? magnitudeLte = freezed,Object? magnitudeGte = freezed,Object? depthLte = freezed,Object? depthGte = freezed,Object? intensityLte = freezed,Object? intensityGte = freezed,Object? statuses = freezed,Object? epicenterCode = freezed,Object? epicenterName = freezed,Object? regionSearchType = freezed,Object? regionCode = freezed,Object? regionName = freezed,Object? regionIntensityLte = freezed,Object? regionIntensityGte = freezed,}) {
  return _then(_EarthquakeHistoryParameter(
magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as int?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as int?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,statuses: freezed == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TelegramStatus>?,epicenterCode: freezed == epicenterCode ? _self.epicenterCode : epicenterCode // ignore: cast_nullable_to_non_nullable
as int?,epicenterName: freezed == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String?,regionSearchType: freezed == regionSearchType ? _self.regionSearchType : regionSearchType // ignore: cast_nullable_to_non_nullable
as RegionSearchType?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,regionIntensityLte: freezed == regionIntensityLte ? _self.regionIntensityLte : regionIntensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,regionIntensityGte: freezed == regionIntensityGte ? _self.regionIntensityGte : regionIntensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}


}

// dart format on
