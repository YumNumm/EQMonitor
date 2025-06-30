// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimated_intensity_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EstimatedIntensityPoint implements DiagnosticableTreeMixin {

 String get regionCode; String get cityCode; EarthquakeParameterStationItem get station; double get intensity;
/// Create a copy of EstimatedIntensityPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimatedIntensityPointCopyWith<EstimatedIntensityPoint> get copyWith => _$EstimatedIntensityPointCopyWithImpl<EstimatedIntensityPoint>(this as EstimatedIntensityPoint, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EstimatedIntensityPoint'))
    ..add(DiagnosticsProperty('regionCode', regionCode))..add(DiagnosticsProperty('cityCode', cityCode))..add(DiagnosticsProperty('station', station))..add(DiagnosticsProperty('intensity', intensity));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimatedIntensityPoint&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.station, station) || other.station == station)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,regionCode,cityCode,station,intensity);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EstimatedIntensityPoint(regionCode: $regionCode, cityCode: $cityCode, station: $station, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $EstimatedIntensityPointCopyWith<$Res>  {
  factory $EstimatedIntensityPointCopyWith(EstimatedIntensityPoint value, $Res Function(EstimatedIntensityPoint) _then) = _$EstimatedIntensityPointCopyWithImpl;
@useResult
$Res call({
 String regionCode, String cityCode, EarthquakeParameterStationItem station, double intensity
});




}
/// @nodoc
class _$EstimatedIntensityPointCopyWithImpl<$Res>
    implements $EstimatedIntensityPointCopyWith<$Res> {
  _$EstimatedIntensityPointCopyWithImpl(this._self, this._then);

  final EstimatedIntensityPoint _self;
  final $Res Function(EstimatedIntensityPoint) _then;

/// Create a copy of EstimatedIntensityPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionCode = null,Object? cityCode = null,Object? station = null,Object? intensity = null,}) {
  return _then(_self.copyWith(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String,cityCode: null == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterStationItem,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _EstimatedIntensityPoint with DiagnosticableTreeMixin implements EstimatedIntensityPoint {
  const _EstimatedIntensityPoint({required this.regionCode, required this.cityCode, required this.station, required this.intensity});
  

@override final  String regionCode;
@override final  String cityCode;
@override final  EarthquakeParameterStationItem station;
@override final  double intensity;

/// Create a copy of EstimatedIntensityPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimatedIntensityPointCopyWith<_EstimatedIntensityPoint> get copyWith => __$EstimatedIntensityPointCopyWithImpl<_EstimatedIntensityPoint>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EstimatedIntensityPoint'))
    ..add(DiagnosticsProperty('regionCode', regionCode))..add(DiagnosticsProperty('cityCode', cityCode))..add(DiagnosticsProperty('station', station))..add(DiagnosticsProperty('intensity', intensity));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimatedIntensityPoint&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode)&&(identical(other.station, station) || other.station == station)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,regionCode,cityCode,station,intensity);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EstimatedIntensityPoint(regionCode: $regionCode, cityCode: $cityCode, station: $station, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$EstimatedIntensityPointCopyWith<$Res> implements $EstimatedIntensityPointCopyWith<$Res> {
  factory _$EstimatedIntensityPointCopyWith(_EstimatedIntensityPoint value, $Res Function(_EstimatedIntensityPoint) _then) = __$EstimatedIntensityPointCopyWithImpl;
@override @useResult
$Res call({
 String regionCode, String cityCode, EarthquakeParameterStationItem station, double intensity
});




}
/// @nodoc
class __$EstimatedIntensityPointCopyWithImpl<$Res>
    implements _$EstimatedIntensityPointCopyWith<$Res> {
  __$EstimatedIntensityPointCopyWithImpl(this._self, this._then);

  final _EstimatedIntensityPoint _self;
  final $Res Function(_EstimatedIntensityPoint) _then;

/// Create a copy of EstimatedIntensityPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionCode = null,Object? cityCode = null,Object? station = null,Object? intensity = null,}) {
  return _then(_EstimatedIntensityPoint(
regionCode: null == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String,cityCode: null == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as EarthquakeParameterStationItem,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
