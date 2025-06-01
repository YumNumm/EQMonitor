// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_history_early_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeHistoryEarlyParameter {

 EarthquakeEarlySortType get sort; bool get ascending; double? get magnitudeLte; double? get magnitudeGte; double? get depthLte; double? get depthGte; JmaIntensity? get intensityLte; JmaIntensity? get intensityGte; DateTime? get originTimeLte; DateTime? get originTimeGte;
/// Create a copy of EarthquakeHistoryEarlyParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHistoryEarlyParameterCopyWith<EarthquakeHistoryEarlyParameter> get copyWith => _$EarthquakeHistoryEarlyParameterCopyWithImpl<EarthquakeHistoryEarlyParameter>(this as EarthquakeHistoryEarlyParameter, _$identity);

  /// Serializes this EarthquakeHistoryEarlyParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHistoryEarlyParameter&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.ascending, ascending) || other.ascending == ascending)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sort,ascending,magnitudeLte,magnitudeGte,depthLte,depthGte,intensityLte,intensityGte,originTimeLte,originTimeGte);

@override
String toString() {
  return 'EarthquakeHistoryEarlyParameter(sort: $sort, ascending: $ascending, magnitudeLte: $magnitudeLte, magnitudeGte: $magnitudeGte, depthLte: $depthLte, depthGte: $depthGte, intensityLte: $intensityLte, intensityGte: $intensityGte, originTimeLte: $originTimeLte, originTimeGte: $originTimeGte)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHistoryEarlyParameterCopyWith<$Res>  {
  factory $EarthquakeHistoryEarlyParameterCopyWith(EarthquakeHistoryEarlyParameter value, $Res Function(EarthquakeHistoryEarlyParameter) _then) = _$EarthquakeHistoryEarlyParameterCopyWithImpl;
@useResult
$Res call({
 EarthquakeEarlySortType sort, bool ascending, double? magnitudeLte, double? magnitudeGte, double? depthLte, double? depthGte, JmaIntensity? intensityLte, JmaIntensity? intensityGte, DateTime? originTimeLte, DateTime? originTimeGte
});




}
/// @nodoc
class _$EarthquakeHistoryEarlyParameterCopyWithImpl<$Res>
    implements $EarthquakeHistoryEarlyParameterCopyWith<$Res> {
  _$EarthquakeHistoryEarlyParameterCopyWithImpl(this._self, this._then);

  final EarthquakeHistoryEarlyParameter _self;
  final $Res Function(EarthquakeHistoryEarlyParameter) _then;

/// Create a copy of EarthquakeHistoryEarlyParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sort = null,Object? ascending = null,Object? magnitudeLte = freezed,Object? magnitudeGte = freezed,Object? depthLte = freezed,Object? depthGte = freezed,Object? intensityLte = freezed,Object? intensityGte = freezed,Object? originTimeLte = freezed,Object? originTimeGte = freezed,}) {
  return _then(_self.copyWith(
sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as EarthquakeEarlySortType,ascending: null == ascending ? _self.ascending : ascending // ignore: cast_nullable_to_non_nullable
as bool,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as double?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeHistoryEarlyParameter implements EarthquakeHistoryEarlyParameter {
  const _EarthquakeHistoryEarlyParameter({required this.sort, required this.ascending, this.magnitudeLte, this.magnitudeGte, this.depthLte, this.depthGte, this.intensityLte, this.intensityGte, this.originTimeLte, this.originTimeGte});
  factory _EarthquakeHistoryEarlyParameter.fromJson(Map<String, dynamic> json) => _$EarthquakeHistoryEarlyParameterFromJson(json);

@override final  EarthquakeEarlySortType sort;
@override final  bool ascending;
@override final  double? magnitudeLte;
@override final  double? magnitudeGte;
@override final  double? depthLte;
@override final  double? depthGte;
@override final  JmaIntensity? intensityLte;
@override final  JmaIntensity? intensityGte;
@override final  DateTime? originTimeLte;
@override final  DateTime? originTimeGte;

/// Create a copy of EarthquakeHistoryEarlyParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHistoryEarlyParameterCopyWith<_EarthquakeHistoryEarlyParameter> get copyWith => __$EarthquakeHistoryEarlyParameterCopyWithImpl<_EarthquakeHistoryEarlyParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHistoryEarlyParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHistoryEarlyParameter&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.ascending, ascending) || other.ascending == ascending)&&(identical(other.magnitudeLte, magnitudeLte) || other.magnitudeLte == magnitudeLte)&&(identical(other.magnitudeGte, magnitudeGte) || other.magnitudeGte == magnitudeGte)&&(identical(other.depthLte, depthLte) || other.depthLte == depthLte)&&(identical(other.depthGte, depthGte) || other.depthGte == depthGte)&&(identical(other.intensityLte, intensityLte) || other.intensityLte == intensityLte)&&(identical(other.intensityGte, intensityGte) || other.intensityGte == intensityGte)&&(identical(other.originTimeLte, originTimeLte) || other.originTimeLte == originTimeLte)&&(identical(other.originTimeGte, originTimeGte) || other.originTimeGte == originTimeGte));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sort,ascending,magnitudeLte,magnitudeGte,depthLte,depthGte,intensityLte,intensityGte,originTimeLte,originTimeGte);

@override
String toString() {
  return 'EarthquakeHistoryEarlyParameter(sort: $sort, ascending: $ascending, magnitudeLte: $magnitudeLte, magnitudeGte: $magnitudeGte, depthLte: $depthLte, depthGte: $depthGte, intensityLte: $intensityLte, intensityGte: $intensityGte, originTimeLte: $originTimeLte, originTimeGte: $originTimeGte)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHistoryEarlyParameterCopyWith<$Res> implements $EarthquakeHistoryEarlyParameterCopyWith<$Res> {
  factory _$EarthquakeHistoryEarlyParameterCopyWith(_EarthquakeHistoryEarlyParameter value, $Res Function(_EarthquakeHistoryEarlyParameter) _then) = __$EarthquakeHistoryEarlyParameterCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeEarlySortType sort, bool ascending, double? magnitudeLte, double? magnitudeGte, double? depthLte, double? depthGte, JmaIntensity? intensityLte, JmaIntensity? intensityGte, DateTime? originTimeLte, DateTime? originTimeGte
});




}
/// @nodoc
class __$EarthquakeHistoryEarlyParameterCopyWithImpl<$Res>
    implements _$EarthquakeHistoryEarlyParameterCopyWith<$Res> {
  __$EarthquakeHistoryEarlyParameterCopyWithImpl(this._self, this._then);

  final _EarthquakeHistoryEarlyParameter _self;
  final $Res Function(_EarthquakeHistoryEarlyParameter) _then;

/// Create a copy of EarthquakeHistoryEarlyParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sort = null,Object? ascending = null,Object? magnitudeLte = freezed,Object? magnitudeGte = freezed,Object? depthLte = freezed,Object? depthGte = freezed,Object? intensityLte = freezed,Object? intensityGte = freezed,Object? originTimeLte = freezed,Object? originTimeGte = freezed,}) {
  return _then(_EarthquakeHistoryEarlyParameter(
sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as EarthquakeEarlySortType,ascending: null == ascending ? _self.ascending : ascending // ignore: cast_nullable_to_non_nullable
as bool,magnitudeLte: freezed == magnitudeLte ? _self.magnitudeLte : magnitudeLte // ignore: cast_nullable_to_non_nullable
as double?,magnitudeGte: freezed == magnitudeGte ? _self.magnitudeGte : magnitudeGte // ignore: cast_nullable_to_non_nullable
as double?,depthLte: freezed == depthLte ? _self.depthLte : depthLte // ignore: cast_nullable_to_non_nullable
as double?,depthGte: freezed == depthGte ? _self.depthGte : depthGte // ignore: cast_nullable_to_non_nullable
as double?,intensityLte: freezed == intensityLte ? _self.intensityLte : intensityLte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,intensityGte: freezed == intensityGte ? _self.intensityGte : intensityGte // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,originTimeLte: freezed == originTimeLte ? _self.originTimeLte : originTimeLte // ignore: cast_nullable_to_non_nullable
as DateTime?,originTimeGte: freezed == originTimeGte ? _self.originTimeGte : originTimeGte // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
