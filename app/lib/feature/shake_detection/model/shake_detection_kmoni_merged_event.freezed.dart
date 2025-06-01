// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_kmoni_merged_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionKmoniMergedEvent {

 ShakeDetectionEvent get event; List<ShakeDetectionKmoniMergedRegion> get regions;
/// Create a copy of ShakeDetectionKmoniMergedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionKmoniMergedEventCopyWith<ShakeDetectionKmoniMergedEvent> get copyWith => _$ShakeDetectionKmoniMergedEventCopyWithImpl<ShakeDetectionKmoniMergedEvent>(this as ShakeDetectionKmoniMergedEvent, _$identity);

  /// Serializes this ShakeDetectionKmoniMergedEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionKmoniMergedEvent&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other.regions, regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(regions));

@override
String toString() {
  return 'ShakeDetectionKmoniMergedEvent(event: $event, regions: $regions)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionKmoniMergedEventCopyWith<$Res>  {
  factory $ShakeDetectionKmoniMergedEventCopyWith(ShakeDetectionKmoniMergedEvent value, $Res Function(ShakeDetectionKmoniMergedEvent) _then) = _$ShakeDetectionKmoniMergedEventCopyWithImpl;
@useResult
$Res call({
 ShakeDetectionEvent event, List<ShakeDetectionKmoniMergedRegion> regions
});


$ShakeDetectionEventCopyWith<$Res> get event;

}
/// @nodoc
class _$ShakeDetectionKmoniMergedEventCopyWithImpl<$Res>
    implements $ShakeDetectionKmoniMergedEventCopyWith<$Res> {
  _$ShakeDetectionKmoniMergedEventCopyWithImpl(this._self, this._then);

  final ShakeDetectionKmoniMergedEvent _self;
  final $Res Function(ShakeDetectionKmoniMergedEvent) _then;

/// Create a copy of ShakeDetectionKmoniMergedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? regions = null,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as ShakeDetectionEvent,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionKmoniMergedRegion>,
  ));
}
/// Create a copy of ShakeDetectionKmoniMergedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShakeDetectionEventCopyWith<$Res> get event {
  
  return $ShakeDetectionEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ShakeDetectionKmoniMergedEvent implements ShakeDetectionKmoniMergedEvent {
  const _ShakeDetectionKmoniMergedEvent({required this.event, required final  List<ShakeDetectionKmoniMergedRegion> regions}): _regions = regions;
  factory _ShakeDetectionKmoniMergedEvent.fromJson(Map<String, dynamic> json) => _$ShakeDetectionKmoniMergedEventFromJson(json);

@override final  ShakeDetectionEvent event;
 final  List<ShakeDetectionKmoniMergedRegion> _regions;
@override List<ShakeDetectionKmoniMergedRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}


/// Create a copy of ShakeDetectionKmoniMergedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionKmoniMergedEventCopyWith<_ShakeDetectionKmoniMergedEvent> get copyWith => __$ShakeDetectionKmoniMergedEventCopyWithImpl<_ShakeDetectionKmoniMergedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionKmoniMergedEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionKmoniMergedEvent&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other._regions, _regions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(_regions));

@override
String toString() {
  return 'ShakeDetectionKmoniMergedEvent(event: $event, regions: $regions)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionKmoniMergedEventCopyWith<$Res> implements $ShakeDetectionKmoniMergedEventCopyWith<$Res> {
  factory _$ShakeDetectionKmoniMergedEventCopyWith(_ShakeDetectionKmoniMergedEvent value, $Res Function(_ShakeDetectionKmoniMergedEvent) _then) = __$ShakeDetectionKmoniMergedEventCopyWithImpl;
@override @useResult
$Res call({
 ShakeDetectionEvent event, List<ShakeDetectionKmoniMergedRegion> regions
});


@override $ShakeDetectionEventCopyWith<$Res> get event;

}
/// @nodoc
class __$ShakeDetectionKmoniMergedEventCopyWithImpl<$Res>
    implements _$ShakeDetectionKmoniMergedEventCopyWith<$Res> {
  __$ShakeDetectionKmoniMergedEventCopyWithImpl(this._self, this._then);

  final _ShakeDetectionKmoniMergedEvent _self;
  final $Res Function(_ShakeDetectionKmoniMergedEvent) _then;

/// Create a copy of ShakeDetectionKmoniMergedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? regions = null,}) {
  return _then(_ShakeDetectionKmoniMergedEvent(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as ShakeDetectionEvent,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionKmoniMergedRegion>,
  ));
}

/// Create a copy of ShakeDetectionKmoniMergedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShakeDetectionEventCopyWith<$Res> get event {
  
  return $ShakeDetectionEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// @nodoc
mixin _$ShakeDetectionKmoniMergedRegion {

 String get name;@JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity get maxIntensity; List<ShakeDetectionKmoniMergedPoint> get points;
/// Create a copy of ShakeDetectionKmoniMergedRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionKmoniMergedRegionCopyWith<ShakeDetectionKmoniMergedRegion> get copyWith => _$ShakeDetectionKmoniMergedRegionCopyWithImpl<ShakeDetectionKmoniMergedRegion>(this as ShakeDetectionKmoniMergedRegion, _$identity);

  /// Serializes this ShakeDetectionKmoniMergedRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionKmoniMergedRegion&&(identical(other.name, name) || other.name == name)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.points, points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,maxIntensity,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'ShakeDetectionKmoniMergedRegion(name: $name, maxIntensity: $maxIntensity, points: $points)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionKmoniMergedRegionCopyWith<$Res>  {
  factory $ShakeDetectionKmoniMergedRegionCopyWith(ShakeDetectionKmoniMergedRegion value, $Res Function(ShakeDetectionKmoniMergedRegion) _then) = _$ShakeDetectionKmoniMergedRegionCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity maxIntensity, List<ShakeDetectionKmoniMergedPoint> points
});




}
/// @nodoc
class _$ShakeDetectionKmoniMergedRegionCopyWithImpl<$Res>
    implements $ShakeDetectionKmoniMergedRegionCopyWith<$Res> {
  _$ShakeDetectionKmoniMergedRegionCopyWithImpl(this._self, this._then);

  final ShakeDetectionKmoniMergedRegion _self;
  final $Res Function(ShakeDetectionKmoniMergedRegion) _then;

/// Create a copy of ShakeDetectionKmoniMergedRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? maxIntensity = null,Object? points = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionKmoniMergedPoint>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ShakeDetectionKmoniMergedRegion implements ShakeDetectionKmoniMergedRegion {
  const _ShakeDetectionKmoniMergedRegion({required this.name, @JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) required this.maxIntensity, required final  List<ShakeDetectionKmoniMergedPoint> points}): _points = points;
  factory _ShakeDetectionKmoniMergedRegion.fromJson(Map<String, dynamic> json) => _$ShakeDetectionKmoniMergedRegionFromJson(json);

@override final  String name;
@override@JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) final  JmaForecastIntensity maxIntensity;
 final  List<ShakeDetectionKmoniMergedPoint> _points;
@override List<ShakeDetectionKmoniMergedPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of ShakeDetectionKmoniMergedRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionKmoniMergedRegionCopyWith<_ShakeDetectionKmoniMergedRegion> get copyWith => __$ShakeDetectionKmoniMergedRegionCopyWithImpl<_ShakeDetectionKmoniMergedRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionKmoniMergedRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionKmoniMergedRegion&&(identical(other.name, name) || other.name == name)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,maxIntensity,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'ShakeDetectionKmoniMergedRegion(name: $name, maxIntensity: $maxIntensity, points: $points)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionKmoniMergedRegionCopyWith<$Res> implements $ShakeDetectionKmoniMergedRegionCopyWith<$Res> {
  factory _$ShakeDetectionKmoniMergedRegionCopyWith(_ShakeDetectionKmoniMergedRegion value, $Res Function(_ShakeDetectionKmoniMergedRegion) _then) = __$ShakeDetectionKmoniMergedRegionCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity maxIntensity, List<ShakeDetectionKmoniMergedPoint> points
});




}
/// @nodoc
class __$ShakeDetectionKmoniMergedRegionCopyWithImpl<$Res>
    implements _$ShakeDetectionKmoniMergedRegionCopyWith<$Res> {
  __$ShakeDetectionKmoniMergedRegionCopyWithImpl(this._self, this._then);

  final _ShakeDetectionKmoniMergedRegion _self;
  final $Res Function(_ShakeDetectionKmoniMergedRegion) _then;

/// Create a copy of ShakeDetectionKmoniMergedRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? maxIntensity = null,Object? points = null,}) {
  return _then(_ShakeDetectionKmoniMergedRegion(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionKmoniMergedPoint>,
  ));
}


}


/// @nodoc
mixin _$ShakeDetectionKmoniMergedPoint {

@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity get intensity; String get code;@JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson) KyoshinObservationPoint get point;
/// Create a copy of ShakeDetectionKmoniMergedPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionKmoniMergedPointCopyWith<ShakeDetectionKmoniMergedPoint> get copyWith => _$ShakeDetectionKmoniMergedPointCopyWithImpl<ShakeDetectionKmoniMergedPoint>(this as ShakeDetectionKmoniMergedPoint, _$identity);

  /// Serializes this ShakeDetectionKmoniMergedPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionKmoniMergedPoint&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.code, code) || other.code == code)&&(identical(other.point, point) || other.point == point));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,code,point);

@override
String toString() {
  return 'ShakeDetectionKmoniMergedPoint(intensity: $intensity, code: $code, point: $point)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionKmoniMergedPointCopyWith<$Res>  {
  factory $ShakeDetectionKmoniMergedPointCopyWith(ShakeDetectionKmoniMergedPoint value, $Res Function(ShakeDetectionKmoniMergedPoint) _then) = _$ShakeDetectionKmoniMergedPointCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity intensity, String code,@JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson) KyoshinObservationPoint point
});




}
/// @nodoc
class _$ShakeDetectionKmoniMergedPointCopyWithImpl<$Res>
    implements $ShakeDetectionKmoniMergedPointCopyWith<$Res> {
  _$ShakeDetectionKmoniMergedPointCopyWithImpl(this._self, this._then);

  final ShakeDetectionKmoniMergedPoint _self;
  final $Res Function(ShakeDetectionKmoniMergedPoint) _then;

/// Create a copy of ShakeDetectionKmoniMergedPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intensity = null,Object? code = null,Object? point = null,}) {
  return _then(_self.copyWith(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPoint,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ShakeDetectionKmoniMergedPoint implements ShakeDetectionKmoniMergedPoint {
  const _ShakeDetectionKmoniMergedPoint({@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) required this.intensity, required this.code, @JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson) required this.point});
  factory _ShakeDetectionKmoniMergedPoint.fromJson(Map<String, dynamic> json) => _$ShakeDetectionKmoniMergedPointFromJson(json);

@override@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) final  JmaForecastIntensity intensity;
@override final  String code;
@override@JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson) final  KyoshinObservationPoint point;

/// Create a copy of ShakeDetectionKmoniMergedPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionKmoniMergedPointCopyWith<_ShakeDetectionKmoniMergedPoint> get copyWith => __$ShakeDetectionKmoniMergedPointCopyWithImpl<_ShakeDetectionKmoniMergedPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionKmoniMergedPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionKmoniMergedPoint&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.code, code) || other.code == code)&&(identical(other.point, point) || other.point == point));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,code,point);

@override
String toString() {
  return 'ShakeDetectionKmoniMergedPoint(intensity: $intensity, code: $code, point: $point)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionKmoniMergedPointCopyWith<$Res> implements $ShakeDetectionKmoniMergedPointCopyWith<$Res> {
  factory _$ShakeDetectionKmoniMergedPointCopyWith(_ShakeDetectionKmoniMergedPoint value, $Res Function(_ShakeDetectionKmoniMergedPoint) _then) = __$ShakeDetectionKmoniMergedPointCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity intensity, String code,@JsonKey(fromJson: KyoshinObservationPoint.fromJson, toJson: _pointToJson) KyoshinObservationPoint point
});




}
/// @nodoc
class __$ShakeDetectionKmoniMergedPointCopyWithImpl<$Res>
    implements _$ShakeDetectionKmoniMergedPointCopyWith<$Res> {
  __$ShakeDetectionKmoniMergedPointCopyWithImpl(this._self, this._then);

  final _ShakeDetectionKmoniMergedPoint _self;
  final $Res Function(_ShakeDetectionKmoniMergedPoint) _then;

/// Create a copy of ShakeDetectionKmoniMergedPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intensity = null,Object? code = null,Object? point = null,}) {
  return _then(_ShakeDetectionKmoniMergedPoint(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,point: null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPoint,
  ));
}


}

// dart format on
