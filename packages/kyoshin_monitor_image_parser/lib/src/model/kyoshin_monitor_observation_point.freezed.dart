// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_monitor_observation_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinMonitorObservationPoint {

 String get code; int get x; int get y;
/// Create a copy of KyoshinMonitorObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationPointCopyWith<KyoshinMonitorObservationPoint> get copyWith => _$KyoshinMonitorObservationPointCopyWithImpl<KyoshinMonitorObservationPoint>(this as KyoshinMonitorObservationPoint, _$identity);

  /// Serializes this KyoshinMonitorObservationPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorObservationPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,x,y);

@override
String toString() {
  return 'KyoshinMonitorObservationPoint(code: $code, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorObservationPointCopyWith<$Res>  {
  factory $KyoshinMonitorObservationPointCopyWith(KyoshinMonitorObservationPoint value, $Res Function(KyoshinMonitorObservationPoint) _then) = _$KyoshinMonitorObservationPointCopyWithImpl;
@useResult
$Res call({
 String code, int x, int y
});




}
/// @nodoc
class _$KyoshinMonitorObservationPointCopyWithImpl<$Res>
    implements $KyoshinMonitorObservationPointCopyWith<$Res> {
  _$KyoshinMonitorObservationPointCopyWithImpl(this._self, this._then);

  final KyoshinMonitorObservationPoint _self;
  final $Res Function(KyoshinMonitorObservationPoint) _then;

/// Create a copy of KyoshinMonitorObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorObservationPoint implements KyoshinMonitorObservationPoint {
  const _KyoshinMonitorObservationPoint({required this.code, required this.x, required this.y});
  factory _KyoshinMonitorObservationPoint.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorObservationPointFromJson(json);

@override final  String code;
@override final  int x;
@override final  int y;

/// Create a copy of KyoshinMonitorObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorObservationPointCopyWith<_KyoshinMonitorObservationPoint> get copyWith => __$KyoshinMonitorObservationPointCopyWithImpl<_KyoshinMonitorObservationPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorObservationPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorObservationPoint&&(identical(other.code, code) || other.code == code)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,x,y);

@override
String toString() {
  return 'KyoshinMonitorObservationPoint(code: $code, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorObservationPointCopyWith<$Res> implements $KyoshinMonitorObservationPointCopyWith<$Res> {
  factory _$KyoshinMonitorObservationPointCopyWith(_KyoshinMonitorObservationPoint value, $Res Function(_KyoshinMonitorObservationPoint) _then) = __$KyoshinMonitorObservationPointCopyWithImpl;
@override @useResult
$Res call({
 String code, int x, int y
});




}
/// @nodoc
class __$KyoshinMonitorObservationPointCopyWithImpl<$Res>
    implements _$KyoshinMonitorObservationPointCopyWith<$Res> {
  __$KyoshinMonitorObservationPointCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorObservationPoint _self;
  final $Res Function(_KyoshinMonitorObservationPoint) _then;

/// Create a copy of KyoshinMonitorObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? x = null,Object? y = null,}) {
  return _then(_KyoshinMonitorObservationPoint(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$KyoshinMonitorObservationAnalyzedPoint {

 KyoshinMonitorObservationPoint get point; double get scale; int get r; int get g; int get b;
/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationAnalyzedPointCopyWith<KyoshinMonitorObservationAnalyzedPoint> get copyWith => _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<KyoshinMonitorObservationAnalyzedPoint>(this as KyoshinMonitorObservationAnalyzedPoint, _$identity);

  /// Serializes this KyoshinMonitorObservationAnalyzedPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinMonitorObservationAnalyzedPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,point,scale,r,g,b);

@override
String toString() {
  return 'KyoshinMonitorObservationAnalyzedPoint(point: $point, scale: $scale, r: $r, g: $g, b: $b)';
}


}

/// @nodoc
abstract mixin class $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res>  {
  factory $KyoshinMonitorObservationAnalyzedPointCopyWith(KyoshinMonitorObservationAnalyzedPoint value, $Res Function(KyoshinMonitorObservationAnalyzedPoint) _then) = _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl;
@useResult
$Res call({
 KyoshinMonitorObservationPoint point, double scale, int r, int g, int b
});


$KyoshinMonitorObservationPointCopyWith<$Res> get point;

}
/// @nodoc
class _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<$Res>
    implements $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  _$KyoshinMonitorObservationAnalyzedPointCopyWithImpl(this._self, this._then);

  final KyoshinMonitorObservationAnalyzedPoint _self;
  final $Res Function(KyoshinMonitorObservationAnalyzedPoint) _then;

/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? point = null,Object? scale = null,Object? r = null,Object? g = null,Object? b = null,}) {
  return _then(_self.copyWith(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorObservationPoint,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationPointCopyWith<$Res> get point {
  
  return $KyoshinMonitorObservationPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _KyoshinMonitorObservationAnalyzedPoint extends KyoshinMonitorObservationAnalyzedPoint {
  const _KyoshinMonitorObservationAnalyzedPoint({required this.point, required this.scale, required this.r, required this.g, required this.b}): super._();
  factory _KyoshinMonitorObservationAnalyzedPoint.fromJson(Map<String, dynamic> json) => _$KyoshinMonitorObservationAnalyzedPointFromJson(json);

@override final  KyoshinMonitorObservationPoint point;
@override final  double scale;
@override final  int r;
@override final  int g;
@override final  int b;

/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinMonitorObservationAnalyzedPointCopyWith<_KyoshinMonitorObservationAnalyzedPoint> get copyWith => __$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<_KyoshinMonitorObservationAnalyzedPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinMonitorObservationAnalyzedPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinMonitorObservationAnalyzedPoint&&(identical(other.point, point) || other.point == point)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,point,scale,r,g,b);

@override
String toString() {
  return 'KyoshinMonitorObservationAnalyzedPoint(point: $point, scale: $scale, r: $r, g: $g, b: $b)';
}


}

/// @nodoc
abstract mixin class _$KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> implements $KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  factory _$KyoshinMonitorObservationAnalyzedPointCopyWith(_KyoshinMonitorObservationAnalyzedPoint value, $Res Function(_KyoshinMonitorObservationAnalyzedPoint) _then) = __$KyoshinMonitorObservationAnalyzedPointCopyWithImpl;
@override @useResult
$Res call({
 KyoshinMonitorObservationPoint point, double scale, int r, int g, int b
});


@override $KyoshinMonitorObservationPointCopyWith<$Res> get point;

}
/// @nodoc
class __$KyoshinMonitorObservationAnalyzedPointCopyWithImpl<$Res>
    implements _$KyoshinMonitorObservationAnalyzedPointCopyWith<$Res> {
  __$KyoshinMonitorObservationAnalyzedPointCopyWithImpl(this._self, this._then);

  final _KyoshinMonitorObservationAnalyzedPoint _self;
  final $Res Function(_KyoshinMonitorObservationAnalyzedPoint) _then;

/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? point = null,Object? scale = null,Object? r = null,Object? g = null,Object? b = null,}) {
  return _then(_KyoshinMonitorObservationAnalyzedPoint(
point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorObservationPoint,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of KyoshinMonitorObservationAnalyzedPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinMonitorObservationPointCopyWith<$Res> get point {
  
  return $KyoshinMonitorObservationPointCopyWith<$Res>(_self.point, (value) {
    return _then(_self.copyWith(point: value));
  });
}
}

// dart format on
