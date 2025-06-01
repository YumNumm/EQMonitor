// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kmoni_observation_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnalyzedKmoniObservationPoint {

 KyoshinObservationPoint get point;// ここから
 double? get intensityValue;@JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color? get intensityColor; double? get pga;@JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color? get pgaColor;
/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyzedKmoniObservationPointCopyWith<AnalyzedKmoniObservationPoint> get copyWith => _$AnalyzedKmoniObservationPointCopyWithImpl<AnalyzedKmoniObservationPoint>(this as AnalyzedKmoniObservationPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyzedKmoniObservationPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.intensityValue, intensityValue) || other.intensityValue == intensityValue)&&(identical(other.intensityColor, intensityColor) || other.intensityColor == intensityColor)&&(identical(other.pga, pga) || other.pga == pga)&&(identical(other.pgaColor, pgaColor) || other.pgaColor == pgaColor));
}


@override
int get hashCode => Object.hash(runtimeType,point,intensityValue,intensityColor,pga,pgaColor);

@override
String toString() {
  return 'AnalyzedKmoniObservationPoint(point: $point, intensityValue: $intensityValue, intensityColor: $intensityColor, pga: $pga, pgaColor: $pgaColor)';
}


}

/// @nodoc
abstract mixin class $AnalyzedKmoniObservationPointCopyWith<$Res>  {
  factory $AnalyzedKmoniObservationPointCopyWith(AnalyzedKmoniObservationPoint value, $Res Function(AnalyzedKmoniObservationPoint) _then) = _$AnalyzedKmoniObservationPointCopyWithImpl;
@useResult
$Res call({
 KyoshinObservationPoint point, double? intensityValue,@JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color? intensityColor, double? pga,@JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color? pgaColor
});




}
/// @nodoc
class _$AnalyzedKmoniObservationPointCopyWithImpl<$Res>
    implements $AnalyzedKmoniObservationPointCopyWith<$Res> {
  _$AnalyzedKmoniObservationPointCopyWithImpl(this._self, this._then);

  final AnalyzedKmoniObservationPoint _self;
  final $Res Function(AnalyzedKmoniObservationPoint) _then;

/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? point = null,Object? intensityValue = freezed,Object? intensityColor = freezed,Object? pga = freezed,Object? pgaColor = freezed,}) {
  return _then(_self.copyWith(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPoint,intensityValue: freezed == intensityValue ? _self.intensityValue : intensityValue // ignore: cast_nullable_to_non_nullable
as double?,intensityColor: freezed == intensityColor ? _self.intensityColor : intensityColor // ignore: cast_nullable_to_non_nullable
as Color?,pga: freezed == pga ? _self.pga : pga // ignore: cast_nullable_to_non_nullable
as double?,pgaColor: freezed == pgaColor ? _self.pgaColor : pgaColor // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}

}


/// @nodoc


class _AnalyzedKmoniObservationPoint implements AnalyzedKmoniObservationPoint {
  const _AnalyzedKmoniObservationPoint({required this.point, this.intensityValue, @JsonKey(fromJson: colorFromJson, toJson: colorToJson) this.intensityColor, this.pga, @JsonKey(fromJson: colorFromJson, toJson: colorToJson) this.pgaColor});
  

@override final  KyoshinObservationPoint point;
// ここから
@override final  double? intensityValue;
@override@JsonKey(fromJson: colorFromJson, toJson: colorToJson) final  Color? intensityColor;
@override final  double? pga;
@override@JsonKey(fromJson: colorFromJson, toJson: colorToJson) final  Color? pgaColor;

/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyzedKmoniObservationPointCopyWith<_AnalyzedKmoniObservationPoint> get copyWith => __$AnalyzedKmoniObservationPointCopyWithImpl<_AnalyzedKmoniObservationPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyzedKmoniObservationPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.intensityValue, intensityValue) || other.intensityValue == intensityValue)&&(identical(other.intensityColor, intensityColor) || other.intensityColor == intensityColor)&&(identical(other.pga, pga) || other.pga == pga)&&(identical(other.pgaColor, pgaColor) || other.pgaColor == pgaColor));
}


@override
int get hashCode => Object.hash(runtimeType,point,intensityValue,intensityColor,pga,pgaColor);

@override
String toString() {
  return 'AnalyzedKmoniObservationPoint(point: $point, intensityValue: $intensityValue, intensityColor: $intensityColor, pga: $pga, pgaColor: $pgaColor)';
}


}

/// @nodoc
abstract mixin class _$AnalyzedKmoniObservationPointCopyWith<$Res> implements $AnalyzedKmoniObservationPointCopyWith<$Res> {
  factory _$AnalyzedKmoniObservationPointCopyWith(_AnalyzedKmoniObservationPoint value, $Res Function(_AnalyzedKmoniObservationPoint) _then) = __$AnalyzedKmoniObservationPointCopyWithImpl;
@override @useResult
$Res call({
 KyoshinObservationPoint point, double? intensityValue,@JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color? intensityColor, double? pga,@JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color? pgaColor
});




}
/// @nodoc
class __$AnalyzedKmoniObservationPointCopyWithImpl<$Res>
    implements _$AnalyzedKmoniObservationPointCopyWith<$Res> {
  __$AnalyzedKmoniObservationPointCopyWithImpl(this._self, this._then);

  final _AnalyzedKmoniObservationPoint _self;
  final $Res Function(_AnalyzedKmoniObservationPoint) _then;

/// Create a copy of AnalyzedKmoniObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? point = null,Object? intensityValue = freezed,Object? intensityColor = freezed,Object? pga = freezed,Object? pgaColor = freezed,}) {
  return _then(_AnalyzedKmoniObservationPoint(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPoint,intensityValue: freezed == intensityValue ? _self.intensityValue : intensityValue // ignore: cast_nullable_to_non_nullable
as double?,intensityColor: freezed == intensityColor ? _self.intensityColor : intensityColor // ignore: cast_nullable_to_non_nullable
as Color?,pga: freezed == pga ? _self.pga : pga // ignore: cast_nullable_to_non_nullable
as double?,pgaColor: freezed == pgaColor ? _self.pgaColor : pgaColor // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}


}

// dart format on
