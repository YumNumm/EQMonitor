// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_early_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeEarlyEvent {

 String get id; String get name; double? get lat; double? get lon; double? get depth; double? get magnitude; DateTime get originTime; OriginTimePrecision get originTimePrecision; JmaForecastIntensity? get maxIntensity; bool get maxIntensityIsEarly; List<EarthquakeEarlyRegion> get regions; List<EarthquakeEarlyCity> get cities;
/// Create a copy of EarthquakeEarlyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeEarlyEventCopyWith<EarthquakeEarlyEvent> get copyWith => _$EarthquakeEarlyEventCopyWithImpl<EarthquakeEarlyEvent>(this as EarthquakeEarlyEvent, _$identity);

  /// Serializes this EarthquakeEarlyEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeEarlyEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxIntensityIsEarly, maxIntensityIsEarly) || other.maxIntensityIsEarly == maxIntensityIsEarly)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.cities, cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lat,lon,depth,magnitude,originTime,originTimePrecision,maxIntensity,maxIntensityIsEarly,const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'EarthquakeEarlyEvent(id: $id, name: $name, lat: $lat, lon: $lon, depth: $depth, magnitude: $magnitude, originTime: $originTime, originTimePrecision: $originTimePrecision, maxIntensity: $maxIntensity, maxIntensityIsEarly: $maxIntensityIsEarly, regions: $regions, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $EarthquakeEarlyEventCopyWith<$Res>  {
  factory $EarthquakeEarlyEventCopyWith(EarthquakeEarlyEvent value, $Res Function(EarthquakeEarlyEvent) _then) = _$EarthquakeEarlyEventCopyWithImpl;
@useResult
$Res call({
 String id, String name, double? lat, double? lon, double? depth, double? magnitude, DateTime originTime, OriginTimePrecision originTimePrecision, JmaForecastIntensity? maxIntensity, bool maxIntensityIsEarly, List<EarthquakeEarlyRegion> regions, List<EarthquakeEarlyCity> cities
});




}
/// @nodoc
class _$EarthquakeEarlyEventCopyWithImpl<$Res>
    implements $EarthquakeEarlyEventCopyWith<$Res> {
  _$EarthquakeEarlyEventCopyWithImpl(this._self, this._then);

  final EarthquakeEarlyEvent _self;
  final $Res Function(EarthquakeEarlyEvent) _then;

/// Create a copy of EarthquakeEarlyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? lat = freezed,Object? lon = freezed,Object? depth = freezed,Object? magnitude = freezed,Object? originTime = null,Object? originTimePrecision = null,Object? maxIntensity = freezed,Object? maxIntensityIsEarly = null,Object? regions = null,Object? cities = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lon: freezed == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,maxIntensityIsEarly: null == maxIntensityIsEarly ? _self.maxIntensityIsEarly : maxIntensityIsEarly // ignore: cast_nullable_to_non_nullable
as bool,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeEarlyRegion>,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeEarlyCity>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeEarlyEvent implements EarthquakeEarlyEvent {
  const _EarthquakeEarlyEvent({required this.id, required this.name, required this.lat, required this.lon, required this.depth, required this.magnitude, required this.originTime, required this.originTimePrecision, required this.maxIntensity, required this.maxIntensityIsEarly, required final  List<EarthquakeEarlyRegion> regions, required final  List<EarthquakeEarlyCity> cities}): _regions = regions,_cities = cities;
  factory _EarthquakeEarlyEvent.fromJson(Map<String, dynamic> json) => _$EarthquakeEarlyEventFromJson(json);

@override final  String id;
@override final  String name;
@override final  double? lat;
@override final  double? lon;
@override final  double? depth;
@override final  double? magnitude;
@override final  DateTime originTime;
@override final  OriginTimePrecision originTimePrecision;
@override final  JmaForecastIntensity? maxIntensity;
@override final  bool maxIntensityIsEarly;
 final  List<EarthquakeEarlyRegion> _regions;
@override List<EarthquakeEarlyRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<EarthquakeEarlyCity> _cities;
@override List<EarthquakeEarlyCity> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of EarthquakeEarlyEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeEarlyEventCopyWith<_EarthquakeEarlyEvent> get copyWith => __$EarthquakeEarlyEventCopyWithImpl<_EarthquakeEarlyEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeEarlyEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeEarlyEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxIntensityIsEarly, maxIntensityIsEarly) || other.maxIntensityIsEarly == maxIntensityIsEarly)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._cities, _cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lat,lon,depth,magnitude,originTime,originTimePrecision,maxIntensity,maxIntensityIsEarly,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'EarthquakeEarlyEvent(id: $id, name: $name, lat: $lat, lon: $lon, depth: $depth, magnitude: $magnitude, originTime: $originTime, originTimePrecision: $originTimePrecision, maxIntensity: $maxIntensity, maxIntensityIsEarly: $maxIntensityIsEarly, regions: $regions, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeEarlyEventCopyWith<$Res> implements $EarthquakeEarlyEventCopyWith<$Res> {
  factory _$EarthquakeEarlyEventCopyWith(_EarthquakeEarlyEvent value, $Res Function(_EarthquakeEarlyEvent) _then) = __$EarthquakeEarlyEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double? lat, double? lon, double? depth, double? magnitude, DateTime originTime, OriginTimePrecision originTimePrecision, JmaForecastIntensity? maxIntensity, bool maxIntensityIsEarly, List<EarthquakeEarlyRegion> regions, List<EarthquakeEarlyCity> cities
});




}
/// @nodoc
class __$EarthquakeEarlyEventCopyWithImpl<$Res>
    implements _$EarthquakeEarlyEventCopyWith<$Res> {
  __$EarthquakeEarlyEventCopyWithImpl(this._self, this._then);

  final _EarthquakeEarlyEvent _self;
  final $Res Function(_EarthquakeEarlyEvent) _then;

/// Create a copy of EarthquakeEarlyEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? lat = freezed,Object? lon = freezed,Object? depth = freezed,Object? magnitude = freezed,Object? originTime = null,Object? originTimePrecision = null,Object? maxIntensity = freezed,Object? maxIntensityIsEarly = null,Object? regions = null,Object? cities = null,}) {
  return _then(_EarthquakeEarlyEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lon: freezed == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as OriginTimePrecision,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity?,maxIntensityIsEarly: null == maxIntensityIsEarly ? _self.maxIntensityIsEarly : maxIntensityIsEarly // ignore: cast_nullable_to_non_nullable
as bool,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EarthquakeEarlyRegion>,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<EarthquakeEarlyCity>,
  ));
}


}


/// @nodoc
mixin _$EarthquakeEarlyRegion {

 String get name; String get code; JmaForecastIntensity get maxIntensity;
/// Create a copy of EarthquakeEarlyRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeEarlyRegionCopyWith<EarthquakeEarlyRegion> get copyWith => _$EarthquakeEarlyRegionCopyWithImpl<EarthquakeEarlyRegion>(this as EarthquakeEarlyRegion, _$identity);

  /// Serializes this EarthquakeEarlyRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeEarlyRegion&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,maxIntensity);

@override
String toString() {
  return 'EarthquakeEarlyRegion(name: $name, code: $code, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class $EarthquakeEarlyRegionCopyWith<$Res>  {
  factory $EarthquakeEarlyRegionCopyWith(EarthquakeEarlyRegion value, $Res Function(EarthquakeEarlyRegion) _then) = _$EarthquakeEarlyRegionCopyWithImpl;
@useResult
$Res call({
 String name, String code, JmaForecastIntensity maxIntensity
});




}
/// @nodoc
class _$EarthquakeEarlyRegionCopyWithImpl<$Res>
    implements $EarthquakeEarlyRegionCopyWith<$Res> {
  _$EarthquakeEarlyRegionCopyWithImpl(this._self, this._then);

  final EarthquakeEarlyRegion _self;
  final $Res Function(EarthquakeEarlyRegion) _then;

/// Create a copy of EarthquakeEarlyRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? code = null,Object? maxIntensity = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeEarlyRegion implements EarthquakeEarlyRegion {
  const _EarthquakeEarlyRegion({required this.name, required this.code, required this.maxIntensity});
  factory _EarthquakeEarlyRegion.fromJson(Map<String, dynamic> json) => _$EarthquakeEarlyRegionFromJson(json);

@override final  String name;
@override final  String code;
@override final  JmaForecastIntensity maxIntensity;

/// Create a copy of EarthquakeEarlyRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeEarlyRegionCopyWith<_EarthquakeEarlyRegion> get copyWith => __$EarthquakeEarlyRegionCopyWithImpl<_EarthquakeEarlyRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeEarlyRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeEarlyRegion&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,maxIntensity);

@override
String toString() {
  return 'EarthquakeEarlyRegion(name: $name, code: $code, maxIntensity: $maxIntensity)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeEarlyRegionCopyWith<$Res> implements $EarthquakeEarlyRegionCopyWith<$Res> {
  factory _$EarthquakeEarlyRegionCopyWith(_EarthquakeEarlyRegion value, $Res Function(_EarthquakeEarlyRegion) _then) = __$EarthquakeEarlyRegionCopyWithImpl;
@override @useResult
$Res call({
 String name, String code, JmaForecastIntensity maxIntensity
});




}
/// @nodoc
class __$EarthquakeEarlyRegionCopyWithImpl<$Res>
    implements _$EarthquakeEarlyRegionCopyWith<$Res> {
  __$EarthquakeEarlyRegionCopyWithImpl(this._self, this._then);

  final _EarthquakeEarlyRegion _self;
  final $Res Function(_EarthquakeEarlyRegion) _then;

/// Create a copy of EarthquakeEarlyRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? code = null,Object? maxIntensity = null,}) {
  return _then(_EarthquakeEarlyRegion(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,
  ));
}


}


/// @nodoc
mixin _$EarthquakeEarlyCity {

 String get name; String? get code; JmaForecastIntensity get maxIntensity; List<EarthquakeEarlyObservationPoint> get observationPoints;
/// Create a copy of EarthquakeEarlyCity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeEarlyCityCopyWith<EarthquakeEarlyCity> get copyWith => _$EarthquakeEarlyCityCopyWithImpl<EarthquakeEarlyCity>(this as EarthquakeEarlyCity, _$identity);

  /// Serializes this EarthquakeEarlyCity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeEarlyCity&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.observationPoints, observationPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,maxIntensity,const DeepCollectionEquality().hash(observationPoints));

@override
String toString() {
  return 'EarthquakeEarlyCity(name: $name, code: $code, maxIntensity: $maxIntensity, observationPoints: $observationPoints)';
}


}

/// @nodoc
abstract mixin class $EarthquakeEarlyCityCopyWith<$Res>  {
  factory $EarthquakeEarlyCityCopyWith(EarthquakeEarlyCity value, $Res Function(EarthquakeEarlyCity) _then) = _$EarthquakeEarlyCityCopyWithImpl;
@useResult
$Res call({
 String name, String? code, JmaForecastIntensity maxIntensity, List<EarthquakeEarlyObservationPoint> observationPoints
});




}
/// @nodoc
class _$EarthquakeEarlyCityCopyWithImpl<$Res>
    implements $EarthquakeEarlyCityCopyWith<$Res> {
  _$EarthquakeEarlyCityCopyWithImpl(this._self, this._then);

  final EarthquakeEarlyCity _self;
  final $Res Function(EarthquakeEarlyCity) _then;

/// Create a copy of EarthquakeEarlyCity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? code = freezed,Object? maxIntensity = null,Object? observationPoints = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,observationPoints: null == observationPoints ? _self.observationPoints : observationPoints // ignore: cast_nullable_to_non_nullable
as List<EarthquakeEarlyObservationPoint>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeEarlyCity implements EarthquakeEarlyCity {
  const _EarthquakeEarlyCity({required this.name, required this.code, required this.maxIntensity, required final  List<EarthquakeEarlyObservationPoint> observationPoints}): _observationPoints = observationPoints;
  factory _EarthquakeEarlyCity.fromJson(Map<String, dynamic> json) => _$EarthquakeEarlyCityFromJson(json);

@override final  String name;
@override final  String? code;
@override final  JmaForecastIntensity maxIntensity;
 final  List<EarthquakeEarlyObservationPoint> _observationPoints;
@override List<EarthquakeEarlyObservationPoint> get observationPoints {
  if (_observationPoints is EqualUnmodifiableListView) return _observationPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observationPoints);
}


/// Create a copy of EarthquakeEarlyCity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeEarlyCityCopyWith<_EarthquakeEarlyCity> get copyWith => __$EarthquakeEarlyCityCopyWithImpl<_EarthquakeEarlyCity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeEarlyCityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeEarlyCity&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._observationPoints, _observationPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,maxIntensity,const DeepCollectionEquality().hash(_observationPoints));

@override
String toString() {
  return 'EarthquakeEarlyCity(name: $name, code: $code, maxIntensity: $maxIntensity, observationPoints: $observationPoints)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeEarlyCityCopyWith<$Res> implements $EarthquakeEarlyCityCopyWith<$Res> {
  factory _$EarthquakeEarlyCityCopyWith(_EarthquakeEarlyCity value, $Res Function(_EarthquakeEarlyCity) _then) = __$EarthquakeEarlyCityCopyWithImpl;
@override @useResult
$Res call({
 String name, String? code, JmaForecastIntensity maxIntensity, List<EarthquakeEarlyObservationPoint> observationPoints
});




}
/// @nodoc
class __$EarthquakeEarlyCityCopyWithImpl<$Res>
    implements _$EarthquakeEarlyCityCopyWith<$Res> {
  __$EarthquakeEarlyCityCopyWithImpl(this._self, this._then);

  final _EarthquakeEarlyCity _self;
  final $Res Function(_EarthquakeEarlyCity) _then;

/// Create a copy of EarthquakeEarlyCity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? code = freezed,Object? maxIntensity = null,Object? observationPoints = null,}) {
  return _then(_EarthquakeEarlyCity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,observationPoints: null == observationPoints ? _self._observationPoints : observationPoints // ignore: cast_nullable_to_non_nullable
as List<EarthquakeEarlyObservationPoint>,
  ));
}


}


/// @nodoc
mixin _$EarthquakeEarlyObservationPoint {

 String get name; double get lat; double get lon; JmaForecastIntensity get intensity;
/// Create a copy of EarthquakeEarlyObservationPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeEarlyObservationPointCopyWith<EarthquakeEarlyObservationPoint> get copyWith => _$EarthquakeEarlyObservationPointCopyWithImpl<EarthquakeEarlyObservationPoint>(this as EarthquakeEarlyObservationPoint, _$identity);

  /// Serializes this EarthquakeEarlyObservationPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeEarlyObservationPoint&&(identical(other.name, name) || other.name == name)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,lat,lon,intensity);

@override
String toString() {
  return 'EarthquakeEarlyObservationPoint(name: $name, lat: $lat, lon: $lon, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $EarthquakeEarlyObservationPointCopyWith<$Res>  {
  factory $EarthquakeEarlyObservationPointCopyWith(EarthquakeEarlyObservationPoint value, $Res Function(EarthquakeEarlyObservationPoint) _then) = _$EarthquakeEarlyObservationPointCopyWithImpl;
@useResult
$Res call({
 String name, double lat, double lon, JmaForecastIntensity intensity
});




}
/// @nodoc
class _$EarthquakeEarlyObservationPointCopyWithImpl<$Res>
    implements $EarthquakeEarlyObservationPointCopyWith<$Res> {
  _$EarthquakeEarlyObservationPointCopyWithImpl(this._self, this._then);

  final EarthquakeEarlyObservationPoint _self;
  final $Res Function(EarthquakeEarlyObservationPoint) _then;

/// Create a copy of EarthquakeEarlyObservationPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? lat = null,Object? lon = null,Object? intensity = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeEarlyObservationPoint implements EarthquakeEarlyObservationPoint {
  const _EarthquakeEarlyObservationPoint({required this.name, required this.lat, required this.lon, required this.intensity});
  factory _EarthquakeEarlyObservationPoint.fromJson(Map<String, dynamic> json) => _$EarthquakeEarlyObservationPointFromJson(json);

@override final  String name;
@override final  double lat;
@override final  double lon;
@override final  JmaForecastIntensity intensity;

/// Create a copy of EarthquakeEarlyObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeEarlyObservationPointCopyWith<_EarthquakeEarlyObservationPoint> get copyWith => __$EarthquakeEarlyObservationPointCopyWithImpl<_EarthquakeEarlyObservationPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeEarlyObservationPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeEarlyObservationPoint&&(identical(other.name, name) || other.name == name)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,lat,lon,intensity);

@override
String toString() {
  return 'EarthquakeEarlyObservationPoint(name: $name, lat: $lat, lon: $lon, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeEarlyObservationPointCopyWith<$Res> implements $EarthquakeEarlyObservationPointCopyWith<$Res> {
  factory _$EarthquakeEarlyObservationPointCopyWith(_EarthquakeEarlyObservationPoint value, $Res Function(_EarthquakeEarlyObservationPoint) _then) = __$EarthquakeEarlyObservationPointCopyWithImpl;
@override @useResult
$Res call({
 String name, double lat, double lon, JmaForecastIntensity intensity
});




}
/// @nodoc
class __$EarthquakeEarlyObservationPointCopyWithImpl<$Res>
    implements _$EarthquakeEarlyObservationPointCopyWith<$Res> {
  __$EarthquakeEarlyObservationPointCopyWithImpl(this._self, this._then);

  final _EarthquakeEarlyObservationPoint _self;
  final $Res Function(_EarthquakeEarlyObservationPoint) _then;

/// Create a copy of EarthquakeEarlyObservationPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? lat = null,Object? lon = null,Object? intensity = null,}) {
  return _then(_EarthquakeEarlyObservationPoint(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaForecastIntensity,
  ));
}


}

// dart format on
