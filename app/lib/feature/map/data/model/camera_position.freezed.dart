// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapCameraPosition {

/// カメラの中心座標
 LatLng get target;/// ズームレベル
 double get zoom;/// カメラの傾き (0-60)
 double get tilt;/// カメラの向き (0-360)
 double get bearing;
/// Create a copy of MapCameraPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapCameraPositionCopyWith<MapCameraPosition> get copyWith => _$MapCameraPositionCopyWithImpl<MapCameraPosition>(this as MapCameraPosition, _$identity);

  /// Serializes this MapCameraPosition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapCameraPosition&&(identical(other.target, target) || other.target == target)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.tilt, tilt) || other.tilt == tilt)&&(identical(other.bearing, bearing) || other.bearing == bearing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,zoom,tilt,bearing);

@override
String toString() {
  return 'MapCameraPosition(target: $target, zoom: $zoom, tilt: $tilt, bearing: $bearing)';
}


}

/// @nodoc
abstract mixin class $MapCameraPositionCopyWith<$Res>  {
  factory $MapCameraPositionCopyWith(MapCameraPosition value, $Res Function(MapCameraPosition) _then) = _$MapCameraPositionCopyWithImpl;
@useResult
$Res call({
 LatLng target, double zoom, double tilt, double bearing
});




}
/// @nodoc
class _$MapCameraPositionCopyWithImpl<$Res>
    implements $MapCameraPositionCopyWith<$Res> {
  _$MapCameraPositionCopyWithImpl(this._self, this._then);

  final MapCameraPosition _self;
  final $Res Function(MapCameraPosition) _then;

/// Create a copy of MapCameraPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = null,Object? zoom = null,Object? tilt = null,Object? bearing = null,}) {
  return _then(_self.copyWith(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as LatLng,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,tilt: null == tilt ? _self.tilt : tilt // ignore: cast_nullable_to_non_nullable
as double,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MapCameraPosition extends MapCameraPosition {
  const _MapCameraPosition({required this.target, this.zoom = 5.0, this.tilt = 0.0, this.bearing = 0.0}): super._();
  factory _MapCameraPosition.fromJson(Map<String, dynamic> json) => _$MapCameraPositionFromJson(json);

/// カメラの中心座標
@override final  LatLng target;
/// ズームレベル
@override@JsonKey() final  double zoom;
/// カメラの傾き (0-60)
@override@JsonKey() final  double tilt;
/// カメラの向き (0-360)
@override@JsonKey() final  double bearing;

/// Create a copy of MapCameraPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapCameraPositionCopyWith<_MapCameraPosition> get copyWith => __$MapCameraPositionCopyWithImpl<_MapCameraPosition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapCameraPositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapCameraPosition&&(identical(other.target, target) || other.target == target)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.tilt, tilt) || other.tilt == tilt)&&(identical(other.bearing, bearing) || other.bearing == bearing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,zoom,tilt,bearing);

@override
String toString() {
  return 'MapCameraPosition(target: $target, zoom: $zoom, tilt: $tilt, bearing: $bearing)';
}


}

/// @nodoc
abstract mixin class _$MapCameraPositionCopyWith<$Res> implements $MapCameraPositionCopyWith<$Res> {
  factory _$MapCameraPositionCopyWith(_MapCameraPosition value, $Res Function(_MapCameraPosition) _then) = __$MapCameraPositionCopyWithImpl;
@override @useResult
$Res call({
 LatLng target, double zoom, double tilt, double bearing
});




}
/// @nodoc
class __$MapCameraPositionCopyWithImpl<$Res>
    implements _$MapCameraPositionCopyWith<$Res> {
  __$MapCameraPositionCopyWithImpl(this._self, this._then);

  final _MapCameraPosition _self;
  final $Res Function(_MapCameraPosition) _then;

/// Create a copy of MapCameraPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = null,Object? zoom = null,Object? tilt = null,Object? bearing = null,}) {
  return _then(_MapCameraPosition(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as LatLng,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,tilt: null == tilt ? _self.tilt : tilt // ignore: cast_nullable_to_non_nullable
as double,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
