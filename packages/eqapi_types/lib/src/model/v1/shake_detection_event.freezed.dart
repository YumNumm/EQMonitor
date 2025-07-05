// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShakeDetectionWebSocketTelegram {

 List<ShakeDetectionEvent> get events;
/// Create a copy of ShakeDetectionWebSocketTelegram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionWebSocketTelegramCopyWith<ShakeDetectionWebSocketTelegram> get copyWith => _$ShakeDetectionWebSocketTelegramCopyWithImpl<ShakeDetectionWebSocketTelegram>(this as ShakeDetectionWebSocketTelegram, _$identity);

  /// Serializes this ShakeDetectionWebSocketTelegram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionWebSocketTelegram&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'ShakeDetectionWebSocketTelegram(events: $events)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionWebSocketTelegramCopyWith<$Res>  {
  factory $ShakeDetectionWebSocketTelegramCopyWith(ShakeDetectionWebSocketTelegram value, $Res Function(ShakeDetectionWebSocketTelegram) _then) = _$ShakeDetectionWebSocketTelegramCopyWithImpl;
@useResult
$Res call({
 List<ShakeDetectionEvent> events
});




}
/// @nodoc
class _$ShakeDetectionWebSocketTelegramCopyWithImpl<$Res>
    implements $ShakeDetectionWebSocketTelegramCopyWith<$Res> {
  _$ShakeDetectionWebSocketTelegramCopyWithImpl(this._self, this._then);

  final ShakeDetectionWebSocketTelegram _self;
  final $Res Function(ShakeDetectionWebSocketTelegram) _then;

/// Create a copy of ShakeDetectionWebSocketTelegram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = null,}) {
  return _then(_self.copyWith(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionEvent>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ShakeDetectionWebSocketTelegram implements ShakeDetectionWebSocketTelegram {
  const _ShakeDetectionWebSocketTelegram({required final  List<ShakeDetectionEvent> events}): _events = events;
  factory _ShakeDetectionWebSocketTelegram.fromJson(Map<String, dynamic> json) => _$ShakeDetectionWebSocketTelegramFromJson(json);

 final  List<ShakeDetectionEvent> _events;
@override List<ShakeDetectionEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of ShakeDetectionWebSocketTelegram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionWebSocketTelegramCopyWith<_ShakeDetectionWebSocketTelegram> get copyWith => __$ShakeDetectionWebSocketTelegramCopyWithImpl<_ShakeDetectionWebSocketTelegram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionWebSocketTelegramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionWebSocketTelegram&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'ShakeDetectionWebSocketTelegram(events: $events)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionWebSocketTelegramCopyWith<$Res> implements $ShakeDetectionWebSocketTelegramCopyWith<$Res> {
  factory _$ShakeDetectionWebSocketTelegramCopyWith(_ShakeDetectionWebSocketTelegram value, $Res Function(_ShakeDetectionWebSocketTelegram) _then) = __$ShakeDetectionWebSocketTelegramCopyWithImpl;
@override @useResult
$Res call({
 List<ShakeDetectionEvent> events
});




}
/// @nodoc
class __$ShakeDetectionWebSocketTelegramCopyWithImpl<$Res>
    implements _$ShakeDetectionWebSocketTelegramCopyWith<$Res> {
  __$ShakeDetectionWebSocketTelegramCopyWithImpl(this._self, this._then);

  final _ShakeDetectionWebSocketTelegram _self;
  final $Res Function(_ShakeDetectionWebSocketTelegram) _then;

/// Create a copy of ShakeDetectionWebSocketTelegram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = null,}) {
  return _then(_ShakeDetectionWebSocketTelegram(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionEvent>,
  ));
}


}


/// @nodoc
mixin _$ShakeDetectionEvent {

@JsonKey(defaultValue: -1) int? get id; String get eventId;@JsonKey(defaultValue: -1) int get serialNo; DateTime get createdAt; DateTime get insertedAt;/// `Unknown`もしくは`Error`の場合、Nullにフォールバックされます
@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity get maxIntensity; List<ShakeDetectionRegion> get regions; ShakeDetectionLatLng get topLeft; ShakeDetectionLatLng get bottomRight; int get pointCount;
/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionEventCopyWith<ShakeDetectionEvent> get copyWith => _$ShakeDetectionEventCopyWithImpl<ShakeDetectionEvent>(this as ShakeDetectionEvent, _$identity);

  /// Serializes this ShakeDetectionEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.insertedAt, insertedAt) || other.insertedAt == insertedAt)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.regions, regions)&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,serialNo,createdAt,insertedAt,maxIntensity,const DeepCollectionEquality().hash(regions),topLeft,bottomRight,pointCount);

@override
String toString() {
  return 'ShakeDetectionEvent(id: $id, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, insertedAt: $insertedAt, maxIntensity: $maxIntensity, regions: $regions, topLeft: $topLeft, bottomRight: $bottomRight, pointCount: $pointCount)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionEventCopyWith<$Res>  {
  factory $ShakeDetectionEventCopyWith(ShakeDetectionEvent value, $Res Function(ShakeDetectionEvent) _then) = _$ShakeDetectionEventCopyWithImpl;
@useResult
$Res call({
@JsonKey(defaultValue: -1) int? id, String eventId,@JsonKey(defaultValue: -1) int serialNo, DateTime createdAt, DateTime insertedAt,@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity maxIntensity, List<ShakeDetectionRegion> regions, ShakeDetectionLatLng topLeft, ShakeDetectionLatLng bottomRight, int pointCount
});


$ShakeDetectionLatLngCopyWith<$Res> get topLeft;$ShakeDetectionLatLngCopyWith<$Res> get bottomRight;

}
/// @nodoc
class _$ShakeDetectionEventCopyWithImpl<$Res>
    implements $ShakeDetectionEventCopyWith<$Res> {
  _$ShakeDetectionEventCopyWithImpl(this._self, this._then);

  final ShakeDetectionEvent _self;
  final $Res Function(ShakeDetectionEvent) _then;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? insertedAt = null,Object? maxIntensity = null,Object? regions = null,Object? topLeft = null,Object? bottomRight = null,Object? pointCount = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,insertedAt: null == insertedAt ? _self.insertedAt : insertedAt // ignore: cast_nullable_to_non_nullable
as DateTime,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionRegion>,topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLatLng,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLatLng,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShakeDetectionLatLngCopyWith<$Res> get topLeft {
  
  return $ShakeDetectionLatLngCopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShakeDetectionLatLngCopyWith<$Res> get bottomRight {
  
  return $ShakeDetectionLatLngCopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ShakeDetectionEvent implements ShakeDetectionEvent {
  const _ShakeDetectionEvent({@JsonKey(defaultValue: -1) required this.id, required this.eventId, @JsonKey(defaultValue: -1) required this.serialNo, required this.createdAt, required this.insertedAt, @JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) required this.maxIntensity, required final  List<ShakeDetectionRegion> regions, required this.topLeft, required this.bottomRight, required this.pointCount}): _regions = regions;
  factory _ShakeDetectionEvent.fromJson(Map<String, dynamic> json) => _$ShakeDetectionEventFromJson(json);

@override@JsonKey(defaultValue: -1) final  int? id;
@override final  String eventId;
@override@JsonKey(defaultValue: -1) final  int serialNo;
@override final  DateTime createdAt;
@override final  DateTime insertedAt;
/// `Unknown`もしくは`Error`の場合、Nullにフォールバックされます
@override@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) final  JmaForecastIntensity maxIntensity;
 final  List<ShakeDetectionRegion> _regions;
@override List<ShakeDetectionRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

@override final  ShakeDetectionLatLng topLeft;
@override final  ShakeDetectionLatLng bottomRight;
@override final  int pointCount;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionEventCopyWith<_ShakeDetectionEvent> get copyWith => __$ShakeDetectionEventCopyWithImpl<_ShakeDetectionEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.insertedAt, insertedAt) || other.insertedAt == insertedAt)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions)&&(identical(other.topLeft, topLeft) || other.topLeft == topLeft)&&(identical(other.bottomRight, bottomRight) || other.bottomRight == bottomRight)&&(identical(other.pointCount, pointCount) || other.pointCount == pointCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,serialNo,createdAt,insertedAt,maxIntensity,const DeepCollectionEquality().hash(_regions),topLeft,bottomRight,pointCount);

@override
String toString() {
  return 'ShakeDetectionEvent(id: $id, eventId: $eventId, serialNo: $serialNo, createdAt: $createdAt, insertedAt: $insertedAt, maxIntensity: $maxIntensity, regions: $regions, topLeft: $topLeft, bottomRight: $bottomRight, pointCount: $pointCount)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionEventCopyWith<$Res> implements $ShakeDetectionEventCopyWith<$Res> {
  factory _$ShakeDetectionEventCopyWith(_ShakeDetectionEvent value, $Res Function(_ShakeDetectionEvent) _then) = __$ShakeDetectionEventCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(defaultValue: -1) int? id, String eventId,@JsonKey(defaultValue: -1) int serialNo, DateTime createdAt, DateTime insertedAt,@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity maxIntensity, List<ShakeDetectionRegion> regions, ShakeDetectionLatLng topLeft, ShakeDetectionLatLng bottomRight, int pointCount
});


@override $ShakeDetectionLatLngCopyWith<$Res> get topLeft;@override $ShakeDetectionLatLngCopyWith<$Res> get bottomRight;

}
/// @nodoc
class __$ShakeDetectionEventCopyWithImpl<$Res>
    implements _$ShakeDetectionEventCopyWith<$Res> {
  __$ShakeDetectionEventCopyWithImpl(this._self, this._then);

  final _ShakeDetectionEvent _self;
  final $Res Function(_ShakeDetectionEvent) _then;

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? eventId = null,Object? serialNo = null,Object? createdAt = null,Object? insertedAt = null,Object? maxIntensity = null,Object? regions = null,Object? topLeft = null,Object? bottomRight = null,Object? pointCount = null,}) {
  return _then(_ShakeDetectionEvent(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,insertedAt: null == insertedAt ? _self.insertedAt : insertedAt // ignore: cast_nullable_to_non_nullable
as DateTime,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionRegion>,topLeft: null == topLeft ? _self.topLeft : topLeft // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLatLng,bottomRight: null == bottomRight ? _self.bottomRight : bottomRight // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLatLng,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShakeDetectionLatLngCopyWith<$Res> get topLeft {
  
  return $ShakeDetectionLatLngCopyWith<$Res>(_self.topLeft, (value) {
    return _then(_self.copyWith(topLeft: value));
  });
}/// Create a copy of ShakeDetectionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShakeDetectionLatLngCopyWith<$Res> get bottomRight {
  
  return $ShakeDetectionLatLngCopyWith<$Res>(_self.bottomRight, (value) {
    return _then(_self.copyWith(bottomRight: value));
  });
}
}


/// @nodoc
mixin _$ShakeDetectionRegion {

 String get name;@JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity get maxIntensity; List<ShakeDetectionPoint> get points;
/// Create a copy of ShakeDetectionRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionRegionCopyWith<ShakeDetectionRegion> get copyWith => _$ShakeDetectionRegionCopyWithImpl<ShakeDetectionRegion>(this as ShakeDetectionRegion, _$identity);

  /// Serializes this ShakeDetectionRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionRegion&&(identical(other.name, name) || other.name == name)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.points, points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,maxIntensity,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'ShakeDetectionRegion(name: $name, maxIntensity: $maxIntensity, points: $points)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionRegionCopyWith<$Res>  {
  factory $ShakeDetectionRegionCopyWith(ShakeDetectionRegion value, $Res Function(ShakeDetectionRegion) _then) = _$ShakeDetectionRegionCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity maxIntensity, List<ShakeDetectionPoint> points
});




}
/// @nodoc
class _$ShakeDetectionRegionCopyWithImpl<$Res>
    implements $ShakeDetectionRegionCopyWith<$Res> {
  _$ShakeDetectionRegionCopyWithImpl(this._self, this._then);

  final ShakeDetectionRegion _self;
  final $Res Function(ShakeDetectionRegion) _then;

/// Create a copy of ShakeDetectionRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? maxIntensity = null,Object? points = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionPoint>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ShakeDetectionRegion implements ShakeDetectionRegion {
  const _ShakeDetectionRegion({required this.name, @JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) required this.maxIntensity, required final  List<ShakeDetectionPoint> points}): _points = points;
  factory _ShakeDetectionRegion.fromJson(Map<String, dynamic> json) => _$ShakeDetectionRegionFromJson(json);

@override final  String name;
@override@JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) final  JmaForecastIntensity maxIntensity;
 final  List<ShakeDetectionPoint> _points;
@override List<ShakeDetectionPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of ShakeDetectionRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionRegionCopyWith<_ShakeDetectionRegion> get copyWith => __$ShakeDetectionRegionCopyWithImpl<_ShakeDetectionRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionRegion&&(identical(other.name, name) || other.name == name)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,maxIntensity,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'ShakeDetectionRegion(name: $name, maxIntensity: $maxIntensity, points: $points)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionRegionCopyWith<$Res> implements $ShakeDetectionRegionCopyWith<$Res> {
  factory _$ShakeDetectionRegionCopyWith(_ShakeDetectionRegion value, $Res Function(_ShakeDetectionRegion) _then) = __$ShakeDetectionRegionCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'maxIntensity', unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity maxIntensity, List<ShakeDetectionPoint> points
});




}
/// @nodoc
class __$ShakeDetectionRegionCopyWithImpl<$Res>
    implements _$ShakeDetectionRegionCopyWith<$Res> {
  __$ShakeDetectionRegionCopyWithImpl(this._self, this._then);

  final _ShakeDetectionRegion _self;
  final $Res Function(_ShakeDetectionRegion) _then;

/// Create a copy of ShakeDetectionRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? maxIntensity = null,Object? points = null,}) {
  return _then(_ShakeDetectionRegion(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<ShakeDetectionPoint>,
  ));
}


}


/// @nodoc
mixin _$ShakeDetectionPoint {

@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity get intensity; String get code;
/// Create a copy of ShakeDetectionPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionPointCopyWith<ShakeDetectionPoint> get copyWith => _$ShakeDetectionPointCopyWithImpl<ShakeDetectionPoint>(this as ShakeDetectionPoint, _$identity);

  /// Serializes this ShakeDetectionPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionPoint&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,code);

@override
String toString() {
  return 'ShakeDetectionPoint(intensity: $intensity, code: $code)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionPointCopyWith<$Res>  {
  factory $ShakeDetectionPointCopyWith(ShakeDetectionPoint value, $Res Function(ShakeDetectionPoint) _then) = _$ShakeDetectionPointCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity intensity, String code
});




}
/// @nodoc
class _$ShakeDetectionPointCopyWithImpl<$Res>
    implements $ShakeDetectionPointCopyWith<$Res> {
  _$ShakeDetectionPointCopyWithImpl(this._self, this._then);

  final ShakeDetectionPoint _self;
  final $Res Function(ShakeDetectionPoint) _then;

/// Create a copy of ShakeDetectionPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intensity = null,Object? code = null,}) {
  return _then(_self.copyWith(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ShakeDetectionPoint implements ShakeDetectionPoint {
  const _ShakeDetectionPoint({@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) required this.intensity, required this.code});
  factory _ShakeDetectionPoint.fromJson(Map<String, dynamic> json) => _$ShakeDetectionPointFromJson(json);

@override@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) final  JmaForecastIntensity intensity;
@override final  String code;

/// Create a copy of ShakeDetectionPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionPointCopyWith<_ShakeDetectionPoint> get copyWith => __$ShakeDetectionPointCopyWithImpl<_ShakeDetectionPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionPoint&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intensity,code);

@override
String toString() {
  return 'ShakeDetectionPoint(intensity: $intensity, code: $code)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionPointCopyWith<$Res> implements $ShakeDetectionPointCopyWith<$Res> {
  factory _$ShakeDetectionPointCopyWith(_ShakeDetectionPoint value, $Res Function(_ShakeDetectionPoint) _then) = __$ShakeDetectionPointCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: JmaForecastIntensity.unknown, defaultValue: JmaForecastIntensity.unknown) JmaForecastIntensity intensity, String code
});




}
/// @nodoc
class __$ShakeDetectionPointCopyWithImpl<$Res>
    implements _$ShakeDetectionPointCopyWith<$Res> {
  __$ShakeDetectionPointCopyWithImpl(this._self, this._then);

  final _ShakeDetectionPoint _self;
  final $Res Function(_ShakeDetectionPoint) _then;

/// Create a copy of ShakeDetectionPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intensity = null,Object? code = null,}) {
  return _then(_ShakeDetectionPoint(
intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ShakeDetectionLatLng {

 double get latitude; double get longitude;
/// Create a copy of ShakeDetectionLatLng
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionLatLngCopyWith<ShakeDetectionLatLng> get copyWith => _$ShakeDetectionLatLngCopyWithImpl<ShakeDetectionLatLng>(this as ShakeDetectionLatLng, _$identity);

  /// Serializes this ShakeDetectionLatLng to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionLatLng&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'ShakeDetectionLatLng(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionLatLngCopyWith<$Res>  {
  factory $ShakeDetectionLatLngCopyWith(ShakeDetectionLatLng value, $Res Function(ShakeDetectionLatLng) _then) = _$ShakeDetectionLatLngCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$ShakeDetectionLatLngCopyWithImpl<$Res>
    implements $ShakeDetectionLatLngCopyWith<$Res> {
  _$ShakeDetectionLatLngCopyWithImpl(this._self, this._then);

  final ShakeDetectionLatLng _self;
  final $Res Function(ShakeDetectionLatLng) _then;

/// Create a copy of ShakeDetectionLatLng
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ShakeDetectionLatLng implements ShakeDetectionLatLng {
  const _ShakeDetectionLatLng({required this.latitude, required this.longitude});
  factory _ShakeDetectionLatLng.fromJson(Map<String, dynamic> json) => _$ShakeDetectionLatLngFromJson(json);

@override final  double latitude;
@override final  double longitude;

/// Create a copy of ShakeDetectionLatLng
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionLatLngCopyWith<_ShakeDetectionLatLng> get copyWith => __$ShakeDetectionLatLngCopyWithImpl<_ShakeDetectionLatLng>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShakeDetectionLatLngToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionLatLng&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'ShakeDetectionLatLng(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionLatLngCopyWith<$Res> implements $ShakeDetectionLatLngCopyWith<$Res> {
  factory _$ShakeDetectionLatLngCopyWith(_ShakeDetectionLatLng value, $Res Function(_ShakeDetectionLatLng) _then) = __$ShakeDetectionLatLngCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class __$ShakeDetectionLatLngCopyWithImpl<$Res>
    implements _$ShakeDetectionLatLngCopyWith<$Res> {
  __$ShakeDetectionLatLngCopyWithImpl(this._self, this._then);

  final _ShakeDetectionLatLng _self;
  final $Res Function(_ShakeDetectionLatLng) _then;

/// Create a copy of ShakeDetectionLatLng
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_ShakeDetectionLatLng(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
