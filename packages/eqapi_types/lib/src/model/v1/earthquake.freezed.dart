// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeV1 {

 int get eventId; String get status; DateTime? get arrivalTime; int? get depth; int? get epicenterCode; int? get epicenterDetailCode; String? get headline; List<ObservedRegionIntensity>? get intensityCities; List<ObservedRegionIntensity>? get intensityPrefectures; List<ObservedRegionIntensity>? get intensityRegions; List<ObservedRegionIntensity>? get intensityStations; double? get latitude; double? get longitude; List<ObservedRegionLpgmIntensity>? get lpgmIntensityPrefectures; List<ObservedRegionLpgmIntensity>? get lpgmIntensityRegions; List<ObservedRegionLpgmIntensity>? get lpgmIntenstiyStations; double? get magnitude; String? get magnitudeCondition; JmaIntensity? get maxIntensity; List<int>? get maxIntensityRegionIds; JmaLgIntensity? get maxLpgmIntensity; DateTime? get originTime; String? get text;
/// Create a copy of EarthquakeV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeV1CopyWith<EarthquakeV1> get copyWith => _$EarthquakeV1CopyWithImpl<EarthquakeV1>(this as EarthquakeV1, _$identity);

  /// Serializes this EarthquakeV1 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeV1&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.epicenterCode, epicenterCode) || other.epicenterCode == epicenterCode)&&(identical(other.epicenterDetailCode, epicenterDetailCode) || other.epicenterDetailCode == epicenterDetailCode)&&(identical(other.headline, headline) || other.headline == headline)&&const DeepCollectionEquality().equals(other.intensityCities, intensityCities)&&const DeepCollectionEquality().equals(other.intensityPrefectures, intensityPrefectures)&&const DeepCollectionEquality().equals(other.intensityRegions, intensityRegions)&&const DeepCollectionEquality().equals(other.intensityStations, intensityStations)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.lpgmIntensityPrefectures, lpgmIntensityPrefectures)&&const DeepCollectionEquality().equals(other.lpgmIntensityRegions, lpgmIntensityRegions)&&const DeepCollectionEquality().equals(other.lpgmIntenstiyStations, lpgmIntenstiyStations)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeCondition, magnitudeCondition) || other.magnitudeCondition == magnitudeCondition)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.maxIntensityRegionIds, maxIntensityRegionIds)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,eventId,status,arrivalTime,depth,epicenterCode,epicenterDetailCode,headline,const DeepCollectionEquality().hash(intensityCities),const DeepCollectionEquality().hash(intensityPrefectures),const DeepCollectionEquality().hash(intensityRegions),const DeepCollectionEquality().hash(intensityStations),latitude,longitude,const DeepCollectionEquality().hash(lpgmIntensityPrefectures),const DeepCollectionEquality().hash(lpgmIntensityRegions),const DeepCollectionEquality().hash(lpgmIntenstiyStations),magnitude,magnitudeCondition,maxIntensity,const DeepCollectionEquality().hash(maxIntensityRegionIds),maxLpgmIntensity,originTime,text]);

@override
String toString() {
  return 'EarthquakeV1(eventId: $eventId, status: $status, arrivalTime: $arrivalTime, depth: $depth, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, headline: $headline, intensityCities: $intensityCities, intensityPrefectures: $intensityPrefectures, intensityRegions: $intensityRegions, intensityStations: $intensityStations, latitude: $latitude, longitude: $longitude, lpgmIntensityPrefectures: $lpgmIntensityPrefectures, lpgmIntensityRegions: $lpgmIntensityRegions, lpgmIntenstiyStations: $lpgmIntenstiyStations, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxIntensityRegionIds: $maxIntensityRegionIds, maxLpgmIntensity: $maxLpgmIntensity, originTime: $originTime, text: $text)';
}


}

/// @nodoc
abstract mixin class $EarthquakeV1CopyWith<$Res>  {
  factory $EarthquakeV1CopyWith(EarthquakeV1 value, $Res Function(EarthquakeV1) _then) = _$EarthquakeV1CopyWithImpl;
@useResult
$Res call({
 int eventId, String status, DateTime? arrivalTime, int? depth, int? epicenterCode, int? epicenterDetailCode, String? headline, List<ObservedRegionIntensity>? intensityCities, List<ObservedRegionIntensity>? intensityPrefectures, List<ObservedRegionIntensity>? intensityRegions, List<ObservedRegionIntensity>? intensityStations, double? latitude, double? longitude, List<ObservedRegionLpgmIntensity>? lpgmIntensityPrefectures, List<ObservedRegionLpgmIntensity>? lpgmIntensityRegions, List<ObservedRegionLpgmIntensity>? lpgmIntenstiyStations, double? magnitude, String? magnitudeCondition, JmaIntensity? maxIntensity, List<int>? maxIntensityRegionIds, JmaLgIntensity? maxLpgmIntensity, DateTime? originTime, String? text
});




}
/// @nodoc
class _$EarthquakeV1CopyWithImpl<$Res>
    implements $EarthquakeV1CopyWith<$Res> {
  _$EarthquakeV1CopyWithImpl(this._self, this._then);

  final EarthquakeV1 _self;
  final $Res Function(EarthquakeV1) _then;

/// Create a copy of EarthquakeV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? arrivalTime = freezed,Object? depth = freezed,Object? epicenterCode = freezed,Object? epicenterDetailCode = freezed,Object? headline = freezed,Object? intensityCities = freezed,Object? intensityPrefectures = freezed,Object? intensityRegions = freezed,Object? intensityStations = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? lpgmIntensityPrefectures = freezed,Object? lpgmIntensityRegions = freezed,Object? lpgmIntenstiyStations = freezed,Object? magnitude = freezed,Object? magnitudeCondition = freezed,Object? maxIntensity = freezed,Object? maxIntensityRegionIds = freezed,Object? maxLpgmIntensity = freezed,Object? originTime = freezed,Object? text = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,epicenterCode: freezed == epicenterCode ? _self.epicenterCode : epicenterCode // ignore: cast_nullable_to_non_nullable
as int?,epicenterDetailCode: freezed == epicenterDetailCode ? _self.epicenterDetailCode : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
as int?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,intensityCities: freezed == intensityCities ? _self.intensityCities : intensityCities // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionIntensity>?,intensityPrefectures: freezed == intensityPrefectures ? _self.intensityPrefectures : intensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionIntensity>?,intensityRegions: freezed == intensityRegions ? _self.intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionIntensity>?,intensityStations: freezed == intensityStations ? _self.intensityStations : intensityStations // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionIntensity>?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,lpgmIntensityPrefectures: freezed == lpgmIntensityPrefectures ? _self.lpgmIntensityPrefectures : lpgmIntensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionLpgmIntensity>?,lpgmIntensityRegions: freezed == lpgmIntensityRegions ? _self.lpgmIntensityRegions : lpgmIntensityRegions // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionLpgmIntensity>?,lpgmIntenstiyStations: freezed == lpgmIntenstiyStations ? _self.lpgmIntenstiyStations : lpgmIntenstiyStations // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionLpgmIntensity>?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,magnitudeCondition: freezed == magnitudeCondition ? _self.magnitudeCondition : magnitudeCondition // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxIntensityRegionIds: freezed == maxIntensityRegionIds ? _self.maxIntensityRegionIds : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
as List<int>?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeV1 implements EarthquakeV1 {
  const _EarthquakeV1({required this.eventId, required this.status, this.arrivalTime, this.depth, this.epicenterCode, this.epicenterDetailCode, this.headline, final  List<ObservedRegionIntensity>? intensityCities, final  List<ObservedRegionIntensity>? intensityPrefectures, final  List<ObservedRegionIntensity>? intensityRegions, final  List<ObservedRegionIntensity>? intensityStations, this.latitude, this.longitude, final  List<ObservedRegionLpgmIntensity>? lpgmIntensityPrefectures, final  List<ObservedRegionLpgmIntensity>? lpgmIntensityRegions, final  List<ObservedRegionLpgmIntensity>? lpgmIntenstiyStations, this.magnitude, this.magnitudeCondition, this.maxIntensity, final  List<int>? maxIntensityRegionIds, this.maxLpgmIntensity, this.originTime, this.text}): _intensityCities = intensityCities,_intensityPrefectures = intensityPrefectures,_intensityRegions = intensityRegions,_intensityStations = intensityStations,_lpgmIntensityPrefectures = lpgmIntensityPrefectures,_lpgmIntensityRegions = lpgmIntensityRegions,_lpgmIntenstiyStations = lpgmIntenstiyStations,_maxIntensityRegionIds = maxIntensityRegionIds;
  factory _EarthquakeV1.fromJson(Map<String, dynamic> json) => _$EarthquakeV1FromJson(json);

@override final  int eventId;
@override final  String status;
@override final  DateTime? arrivalTime;
@override final  int? depth;
@override final  int? epicenterCode;
@override final  int? epicenterDetailCode;
@override final  String? headline;
 final  List<ObservedRegionIntensity>? _intensityCities;
@override List<ObservedRegionIntensity>? get intensityCities {
  final value = _intensityCities;
  if (value == null) return null;
  if (_intensityCities is EqualUnmodifiableListView) return _intensityCities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ObservedRegionIntensity>? _intensityPrefectures;
@override List<ObservedRegionIntensity>? get intensityPrefectures {
  final value = _intensityPrefectures;
  if (value == null) return null;
  if (_intensityPrefectures is EqualUnmodifiableListView) return _intensityPrefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ObservedRegionIntensity>? _intensityRegions;
@override List<ObservedRegionIntensity>? get intensityRegions {
  final value = _intensityRegions;
  if (value == null) return null;
  if (_intensityRegions is EqualUnmodifiableListView) return _intensityRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ObservedRegionIntensity>? _intensityStations;
@override List<ObservedRegionIntensity>? get intensityStations {
  final value = _intensityStations;
  if (value == null) return null;
  if (_intensityStations is EqualUnmodifiableListView) return _intensityStations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  double? latitude;
@override final  double? longitude;
 final  List<ObservedRegionLpgmIntensity>? _lpgmIntensityPrefectures;
@override List<ObservedRegionLpgmIntensity>? get lpgmIntensityPrefectures {
  final value = _lpgmIntensityPrefectures;
  if (value == null) return null;
  if (_lpgmIntensityPrefectures is EqualUnmodifiableListView) return _lpgmIntensityPrefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ObservedRegionLpgmIntensity>? _lpgmIntensityRegions;
@override List<ObservedRegionLpgmIntensity>? get lpgmIntensityRegions {
  final value = _lpgmIntensityRegions;
  if (value == null) return null;
  if (_lpgmIntensityRegions is EqualUnmodifiableListView) return _lpgmIntensityRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ObservedRegionLpgmIntensity>? _lpgmIntenstiyStations;
@override List<ObservedRegionLpgmIntensity>? get lpgmIntenstiyStations {
  final value = _lpgmIntenstiyStations;
  if (value == null) return null;
  if (_lpgmIntenstiyStations is EqualUnmodifiableListView) return _lpgmIntenstiyStations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  double? magnitude;
@override final  String? magnitudeCondition;
@override final  JmaIntensity? maxIntensity;
 final  List<int>? _maxIntensityRegionIds;
@override List<int>? get maxIntensityRegionIds {
  final value = _maxIntensityRegionIds;
  if (value == null) return null;
  if (_maxIntensityRegionIds is EqualUnmodifiableListView) return _maxIntensityRegionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  JmaLgIntensity? maxLpgmIntensity;
@override final  DateTime? originTime;
@override final  String? text;

/// Create a copy of EarthquakeV1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeV1CopyWith<_EarthquakeV1> get copyWith => __$EarthquakeV1CopyWithImpl<_EarthquakeV1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeV1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeV1&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.epicenterCode, epicenterCode) || other.epicenterCode == epicenterCode)&&(identical(other.epicenterDetailCode, epicenterDetailCode) || other.epicenterDetailCode == epicenterDetailCode)&&(identical(other.headline, headline) || other.headline == headline)&&const DeepCollectionEquality().equals(other._intensityCities, _intensityCities)&&const DeepCollectionEquality().equals(other._intensityPrefectures, _intensityPrefectures)&&const DeepCollectionEquality().equals(other._intensityRegions, _intensityRegions)&&const DeepCollectionEquality().equals(other._intensityStations, _intensityStations)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other._lpgmIntensityPrefectures, _lpgmIntensityPrefectures)&&const DeepCollectionEquality().equals(other._lpgmIntensityRegions, _lpgmIntensityRegions)&&const DeepCollectionEquality().equals(other._lpgmIntenstiyStations, _lpgmIntenstiyStations)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeCondition, magnitudeCondition) || other.magnitudeCondition == magnitudeCondition)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._maxIntensityRegionIds, _maxIntensityRegionIds)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,eventId,status,arrivalTime,depth,epicenterCode,epicenterDetailCode,headline,const DeepCollectionEquality().hash(_intensityCities),const DeepCollectionEquality().hash(_intensityPrefectures),const DeepCollectionEquality().hash(_intensityRegions),const DeepCollectionEquality().hash(_intensityStations),latitude,longitude,const DeepCollectionEquality().hash(_lpgmIntensityPrefectures),const DeepCollectionEquality().hash(_lpgmIntensityRegions),const DeepCollectionEquality().hash(_lpgmIntenstiyStations),magnitude,magnitudeCondition,maxIntensity,const DeepCollectionEquality().hash(_maxIntensityRegionIds),maxLpgmIntensity,originTime,text]);

@override
String toString() {
  return 'EarthquakeV1(eventId: $eventId, status: $status, arrivalTime: $arrivalTime, depth: $depth, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, headline: $headline, intensityCities: $intensityCities, intensityPrefectures: $intensityPrefectures, intensityRegions: $intensityRegions, intensityStations: $intensityStations, latitude: $latitude, longitude: $longitude, lpgmIntensityPrefectures: $lpgmIntensityPrefectures, lpgmIntensityRegions: $lpgmIntensityRegions, lpgmIntenstiyStations: $lpgmIntenstiyStations, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxIntensityRegionIds: $maxIntensityRegionIds, maxLpgmIntensity: $maxLpgmIntensity, originTime: $originTime, text: $text)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeV1CopyWith<$Res> implements $EarthquakeV1CopyWith<$Res> {
  factory _$EarthquakeV1CopyWith(_EarthquakeV1 value, $Res Function(_EarthquakeV1) _then) = __$EarthquakeV1CopyWithImpl;
@override @useResult
$Res call({
 int eventId, String status, DateTime? arrivalTime, int? depth, int? epicenterCode, int? epicenterDetailCode, String? headline, List<ObservedRegionIntensity>? intensityCities, List<ObservedRegionIntensity>? intensityPrefectures, List<ObservedRegionIntensity>? intensityRegions, List<ObservedRegionIntensity>? intensityStations, double? latitude, double? longitude, List<ObservedRegionLpgmIntensity>? lpgmIntensityPrefectures, List<ObservedRegionLpgmIntensity>? lpgmIntensityRegions, List<ObservedRegionLpgmIntensity>? lpgmIntenstiyStations, double? magnitude, String? magnitudeCondition, JmaIntensity? maxIntensity, List<int>? maxIntensityRegionIds, JmaLgIntensity? maxLpgmIntensity, DateTime? originTime, String? text
});




}
/// @nodoc
class __$EarthquakeV1CopyWithImpl<$Res>
    implements _$EarthquakeV1CopyWith<$Res> {
  __$EarthquakeV1CopyWithImpl(this._self, this._then);

  final _EarthquakeV1 _self;
  final $Res Function(_EarthquakeV1) _then;

/// Create a copy of EarthquakeV1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? arrivalTime = freezed,Object? depth = freezed,Object? epicenterCode = freezed,Object? epicenterDetailCode = freezed,Object? headline = freezed,Object? intensityCities = freezed,Object? intensityPrefectures = freezed,Object? intensityRegions = freezed,Object? intensityStations = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? lpgmIntensityPrefectures = freezed,Object? lpgmIntensityRegions = freezed,Object? lpgmIntenstiyStations = freezed,Object? magnitude = freezed,Object? magnitudeCondition = freezed,Object? maxIntensity = freezed,Object? maxIntensityRegionIds = freezed,Object? maxLpgmIntensity = freezed,Object? originTime = freezed,Object? text = freezed,}) {
  return _then(_EarthquakeV1(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,epicenterCode: freezed == epicenterCode ? _self.epicenterCode : epicenterCode // ignore: cast_nullable_to_non_nullable
as int?,epicenterDetailCode: freezed == epicenterDetailCode ? _self.epicenterDetailCode : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
as int?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,intensityCities: freezed == intensityCities ? _self._intensityCities : intensityCities // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionIntensity>?,intensityPrefectures: freezed == intensityPrefectures ? _self._intensityPrefectures : intensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionIntensity>?,intensityRegions: freezed == intensityRegions ? _self._intensityRegions : intensityRegions // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionIntensity>?,intensityStations: freezed == intensityStations ? _self._intensityStations : intensityStations // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionIntensity>?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,lpgmIntensityPrefectures: freezed == lpgmIntensityPrefectures ? _self._lpgmIntensityPrefectures : lpgmIntensityPrefectures // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionLpgmIntensity>?,lpgmIntensityRegions: freezed == lpgmIntensityRegions ? _self._lpgmIntensityRegions : lpgmIntensityRegions // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionLpgmIntensity>?,lpgmIntenstiyStations: freezed == lpgmIntenstiyStations ? _self._lpgmIntenstiyStations : lpgmIntenstiyStations // ignore: cast_nullable_to_non_nullable
as List<ObservedRegionLpgmIntensity>?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,magnitudeCondition: freezed == magnitudeCondition ? _self.magnitudeCondition : magnitudeCondition // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxIntensityRegionIds: freezed == maxIntensityRegionIds ? _self._maxIntensityRegionIds : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
as List<int>?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EarthquakeV1Base {

 int get eventId; String get status; DateTime? get arrivalTime; int? get depth; int? get epicenterCode; int? get epicenterDetailCode; String? get headline; double? get latitude; double? get longitude; double? get magnitude; String? get magnitudeCondition; JmaIntensity? get maxIntensity; List<int>? get maxIntensityRegionIds; JmaLgIntensity? get maxLpgmIntensity; DateTime? get originTime; String? get text;
/// Create a copy of EarthquakeV1Base
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeV1BaseCopyWith<EarthquakeV1Base> get copyWith => _$EarthquakeV1BaseCopyWithImpl<EarthquakeV1Base>(this as EarthquakeV1Base, _$identity);

  /// Serializes this EarthquakeV1Base to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeV1Base&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.epicenterCode, epicenterCode) || other.epicenterCode == epicenterCode)&&(identical(other.epicenterDetailCode, epicenterDetailCode) || other.epicenterDetailCode == epicenterDetailCode)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeCondition, magnitudeCondition) || other.magnitudeCondition == magnitudeCondition)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.maxIntensityRegionIds, maxIntensityRegionIds)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,arrivalTime,depth,epicenterCode,epicenterDetailCode,headline,latitude,longitude,magnitude,magnitudeCondition,maxIntensity,const DeepCollectionEquality().hash(maxIntensityRegionIds),maxLpgmIntensity,originTime,text);

@override
String toString() {
  return 'EarthquakeV1Base(eventId: $eventId, status: $status, arrivalTime: $arrivalTime, depth: $depth, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, headline: $headline, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxIntensityRegionIds: $maxIntensityRegionIds, maxLpgmIntensity: $maxLpgmIntensity, originTime: $originTime, text: $text)';
}


}

/// @nodoc
abstract mixin class $EarthquakeV1BaseCopyWith<$Res>  {
  factory $EarthquakeV1BaseCopyWith(EarthquakeV1Base value, $Res Function(EarthquakeV1Base) _then) = _$EarthquakeV1BaseCopyWithImpl;
@useResult
$Res call({
 int eventId, String status, DateTime? arrivalTime, int? depth, int? epicenterCode, int? epicenterDetailCode, String? headline, double? latitude, double? longitude, double? magnitude, String? magnitudeCondition, JmaIntensity? maxIntensity, List<int>? maxIntensityRegionIds, JmaLgIntensity? maxLpgmIntensity, DateTime? originTime, String? text
});




}
/// @nodoc
class _$EarthquakeV1BaseCopyWithImpl<$Res>
    implements $EarthquakeV1BaseCopyWith<$Res> {
  _$EarthquakeV1BaseCopyWithImpl(this._self, this._then);

  final EarthquakeV1Base _self;
  final $Res Function(EarthquakeV1Base) _then;

/// Create a copy of EarthquakeV1Base
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? arrivalTime = freezed,Object? depth = freezed,Object? epicenterCode = freezed,Object? epicenterDetailCode = freezed,Object? headline = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? magnitude = freezed,Object? magnitudeCondition = freezed,Object? maxIntensity = freezed,Object? maxIntensityRegionIds = freezed,Object? maxLpgmIntensity = freezed,Object? originTime = freezed,Object? text = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,epicenterCode: freezed == epicenterCode ? _self.epicenterCode : epicenterCode // ignore: cast_nullable_to_non_nullable
as int?,epicenterDetailCode: freezed == epicenterDetailCode ? _self.epicenterDetailCode : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
as int?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,magnitudeCondition: freezed == magnitudeCondition ? _self.magnitudeCondition : magnitudeCondition // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxIntensityRegionIds: freezed == maxIntensityRegionIds ? _self.maxIntensityRegionIds : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
as List<int>?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeV1Base implements EarthquakeV1Base {
  const _EarthquakeV1Base({required this.eventId, required this.status, this.arrivalTime, this.depth, this.epicenterCode, this.epicenterDetailCode, this.headline, this.latitude, this.longitude, this.magnitude, this.magnitudeCondition, this.maxIntensity, final  List<int>? maxIntensityRegionIds, this.maxLpgmIntensity, this.originTime, this.text}): _maxIntensityRegionIds = maxIntensityRegionIds;
  factory _EarthquakeV1Base.fromJson(Map<String, dynamic> json) => _$EarthquakeV1BaseFromJson(json);

@override final  int eventId;
@override final  String status;
@override final  DateTime? arrivalTime;
@override final  int? depth;
@override final  int? epicenterCode;
@override final  int? epicenterDetailCode;
@override final  String? headline;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? magnitude;
@override final  String? magnitudeCondition;
@override final  JmaIntensity? maxIntensity;
 final  List<int>? _maxIntensityRegionIds;
@override List<int>? get maxIntensityRegionIds {
  final value = _maxIntensityRegionIds;
  if (value == null) return null;
  if (_maxIntensityRegionIds is EqualUnmodifiableListView) return _maxIntensityRegionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  JmaLgIntensity? maxLpgmIntensity;
@override final  DateTime? originTime;
@override final  String? text;

/// Create a copy of EarthquakeV1Base
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeV1BaseCopyWith<_EarthquakeV1Base> get copyWith => __$EarthquakeV1BaseCopyWithImpl<_EarthquakeV1Base>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeV1BaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeV1Base&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.epicenterCode, epicenterCode) || other.epicenterCode == epicenterCode)&&(identical(other.epicenterDetailCode, epicenterDetailCode) || other.epicenterDetailCode == epicenterDetailCode)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeCondition, magnitudeCondition) || other.magnitudeCondition == magnitudeCondition)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._maxIntensityRegionIds, _maxIntensityRegionIds)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,status,arrivalTime,depth,epicenterCode,epicenterDetailCode,headline,latitude,longitude,magnitude,magnitudeCondition,maxIntensity,const DeepCollectionEquality().hash(_maxIntensityRegionIds),maxLpgmIntensity,originTime,text);

@override
String toString() {
  return 'EarthquakeV1Base(eventId: $eventId, status: $status, arrivalTime: $arrivalTime, depth: $depth, epicenterCode: $epicenterCode, epicenterDetailCode: $epicenterDetailCode, headline: $headline, latitude: $latitude, longitude: $longitude, magnitude: $magnitude, magnitudeCondition: $magnitudeCondition, maxIntensity: $maxIntensity, maxIntensityRegionIds: $maxIntensityRegionIds, maxLpgmIntensity: $maxLpgmIntensity, originTime: $originTime, text: $text)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeV1BaseCopyWith<$Res> implements $EarthquakeV1BaseCopyWith<$Res> {
  factory _$EarthquakeV1BaseCopyWith(_EarthquakeV1Base value, $Res Function(_EarthquakeV1Base) _then) = __$EarthquakeV1BaseCopyWithImpl;
@override @useResult
$Res call({
 int eventId, String status, DateTime? arrivalTime, int? depth, int? epicenterCode, int? epicenterDetailCode, String? headline, double? latitude, double? longitude, double? magnitude, String? magnitudeCondition, JmaIntensity? maxIntensity, List<int>? maxIntensityRegionIds, JmaLgIntensity? maxLpgmIntensity, DateTime? originTime, String? text
});




}
/// @nodoc
class __$EarthquakeV1BaseCopyWithImpl<$Res>
    implements _$EarthquakeV1BaseCopyWith<$Res> {
  __$EarthquakeV1BaseCopyWithImpl(this._self, this._then);

  final _EarthquakeV1Base _self;
  final $Res Function(_EarthquakeV1Base) _then;

/// Create a copy of EarthquakeV1Base
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? arrivalTime = freezed,Object? depth = freezed,Object? epicenterCode = freezed,Object? epicenterDetailCode = freezed,Object? headline = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? magnitude = freezed,Object? magnitudeCondition = freezed,Object? maxIntensity = freezed,Object? maxIntensityRegionIds = freezed,Object? maxLpgmIntensity = freezed,Object? originTime = freezed,Object? text = freezed,}) {
  return _then(_EarthquakeV1Base(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,epicenterCode: freezed == epicenterCode ? _self.epicenterCode : epicenterCode // ignore: cast_nullable_to_non_nullable
as int?,epicenterDetailCode: freezed == epicenterDetailCode ? _self.epicenterDetailCode : epicenterDetailCode // ignore: cast_nullable_to_non_nullable
as int?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,magnitudeCondition: freezed == magnitudeCondition ? _self.magnitudeCondition : magnitudeCondition // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,maxIntensityRegionIds: freezed == maxIntensityRegionIds ? _self._maxIntensityRegionIds : maxIntensityRegionIds // ignore: cast_nullable_to_non_nullable
as List<int>?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ObservedRegionIntensity {

 String get code; String get name;@JsonKey(name: 'maxInt') JmaIntensity? get intensity;
/// Create a copy of ObservedRegionIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservedRegionIntensityCopyWith<ObservedRegionIntensity> get copyWith => _$ObservedRegionIntensityCopyWithImpl<ObservedRegionIntensity>(this as ObservedRegionIntensity, _$identity);

  /// Serializes this ObservedRegionIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservedRegionIntensity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity);

@override
String toString() {
  return 'ObservedRegionIntensity(code: $code, name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $ObservedRegionIntensityCopyWith<$Res>  {
  factory $ObservedRegionIntensityCopyWith(ObservedRegionIntensity value, $Res Function(ObservedRegionIntensity) _then) = _$ObservedRegionIntensityCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(name: 'maxInt') JmaIntensity? intensity
});




}
/// @nodoc
class _$ObservedRegionIntensityCopyWithImpl<$Res>
    implements $ObservedRegionIntensityCopyWith<$Res> {
  _$ObservedRegionIntensityCopyWithImpl(this._self, this._then);

  final ObservedRegionIntensity _self;
  final $Res Function(ObservedRegionIntensity) _then;

/// Create a copy of ObservedRegionIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ObservedRegionIntensity implements ObservedRegionIntensity {
  const _ObservedRegionIntensity({required this.code, required this.name, @JsonKey(name: 'maxInt') required this.intensity});
  factory _ObservedRegionIntensity.fromJson(Map<String, dynamic> json) => _$ObservedRegionIntensityFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(name: 'maxInt') final  JmaIntensity? intensity;

/// Create a copy of ObservedRegionIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservedRegionIntensityCopyWith<_ObservedRegionIntensity> get copyWith => __$ObservedRegionIntensityCopyWithImpl<_ObservedRegionIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ObservedRegionIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservedRegionIntensity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity);

@override
String toString() {
  return 'ObservedRegionIntensity(code: $code, name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$ObservedRegionIntensityCopyWith<$Res> implements $ObservedRegionIntensityCopyWith<$Res> {
  factory _$ObservedRegionIntensityCopyWith(_ObservedRegionIntensity value, $Res Function(_ObservedRegionIntensity) _then) = __$ObservedRegionIntensityCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(name: 'maxInt') JmaIntensity? intensity
});




}
/// @nodoc
class __$ObservedRegionIntensityCopyWithImpl<$Res>
    implements _$ObservedRegionIntensityCopyWith<$Res> {
  __$ObservedRegionIntensityCopyWithImpl(this._self, this._then);

  final _ObservedRegionIntensity _self;
  final $Res Function(_ObservedRegionIntensity) _then;

/// Create a copy of ObservedRegionIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,}) {
  return _then(_ObservedRegionIntensity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}


}


/// @nodoc
mixin _$ObservedRegionLpgmIntensity {

 String get code; String get name;@JsonKey(name: 'maxInt') JmaIntensity? get intensity;@JsonKey(name: 'maxLgInt') JmaLgIntensity? get lpgmIntensity;
/// Create a copy of ObservedRegionLpgmIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservedRegionLpgmIntensityCopyWith<ObservedRegionLpgmIntensity> get copyWith => _$ObservedRegionLpgmIntensityCopyWithImpl<ObservedRegionLpgmIntensity>(this as ObservedRegionLpgmIntensity, _$identity);

  /// Serializes this ObservedRegionLpgmIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservedRegionLpgmIntensity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'ObservedRegionLpgmIntensity(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $ObservedRegionLpgmIntensityCopyWith<$Res>  {
  factory $ObservedRegionLpgmIntensityCopyWith(ObservedRegionLpgmIntensity value, $Res Function(ObservedRegionLpgmIntensity) _then) = _$ObservedRegionLpgmIntensityCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(name: 'maxInt') JmaIntensity? intensity,@JsonKey(name: 'maxLgInt') JmaLgIntensity? lpgmIntensity
});




}
/// @nodoc
class _$ObservedRegionLpgmIntensityCopyWithImpl<$Res>
    implements $ObservedRegionLpgmIntensityCopyWith<$Res> {
  _$ObservedRegionLpgmIntensityCopyWithImpl(this._self, this._then);

  final ObservedRegionLpgmIntensity _self;
  final $Res Function(ObservedRegionLpgmIntensity) _then;

/// Create a copy of ObservedRegionLpgmIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ObservedRegionLpgmIntensity implements ObservedRegionLpgmIntensity {
  const _ObservedRegionLpgmIntensity({required this.code, required this.name, @JsonKey(name: 'maxInt') required this.intensity, @JsonKey(name: 'maxLgInt') required this.lpgmIntensity});
  factory _ObservedRegionLpgmIntensity.fromJson(Map<String, dynamic> json) => _$ObservedRegionLpgmIntensityFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey(name: 'maxInt') final  JmaIntensity? intensity;
@override@JsonKey(name: 'maxLgInt') final  JmaLgIntensity? lpgmIntensity;

/// Create a copy of ObservedRegionLpgmIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservedRegionLpgmIntensityCopyWith<_ObservedRegionLpgmIntensity> get copyWith => __$ObservedRegionLpgmIntensityCopyWithImpl<_ObservedRegionLpgmIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ObservedRegionLpgmIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservedRegionLpgmIntensity&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'ObservedRegionLpgmIntensity(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$ObservedRegionLpgmIntensityCopyWith<$Res> implements $ObservedRegionLpgmIntensityCopyWith<$Res> {
  factory _$ObservedRegionLpgmIntensityCopyWith(_ObservedRegionLpgmIntensity value, $Res Function(_ObservedRegionLpgmIntensity) _then) = __$ObservedRegionLpgmIntensityCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(name: 'maxInt') JmaIntensity? intensity,@JsonKey(name: 'maxLgInt') JmaLgIntensity? lpgmIntensity
});




}
/// @nodoc
class __$ObservedRegionLpgmIntensityCopyWithImpl<$Res>
    implements _$ObservedRegionLpgmIntensityCopyWith<$Res> {
  __$ObservedRegionLpgmIntensityCopyWithImpl(this._self, this._then);

  final _ObservedRegionLpgmIntensity _self;
  final $Res Function(_ObservedRegionLpgmIntensity) _then;

/// Create a copy of ObservedRegionLpgmIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_ObservedRegionLpgmIntensity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLgIntensity?,
  ));
}


}

// dart format on
