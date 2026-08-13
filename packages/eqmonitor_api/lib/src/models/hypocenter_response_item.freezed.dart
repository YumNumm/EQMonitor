// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_response_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HypocenterResponseItem {

@JsonKey(name: 'hypocenter_id') String get hypocenterId;@JsonKey(name: 'origin_time') DateTime get originTime;@JsonKey(name: 'origin_time_precision') HypocenterOriginTimePrecision get originTimePrecision; num get latitude; num get longitude;@JsonKey(includeIfNull: false, name: 'origin_time_second_stderr') num? get originTimeSecondStderr;@JsonKey(includeIfNull: false, name: 'latitude_min_stderr') num? get latitudeMinStderr;@JsonKey(includeIfNull: false, name: 'longitude_min_stderr') num? get longitudeMinStderr;@JsonKey(includeIfNull: false, name: 'depth_km') num? get depthKm;@JsonKey(includeIfNull: false, name: 'depth_is_free') bool? get depthIsFree;@JsonKey(includeIfNull: false, name: 'depth_stderr_km') num? get depthStderrKm;@JsonKey(includeIfNull: false) num? get magnitude;@JsonKey(includeIfNull: false, name: 'magnitude_type') String? get magnitudeType;@JsonKey(includeIfNull: false, name: 'secondary_magnitude') num? get secondaryMagnitude;@JsonKey(includeIfNull: false, name: 'secondary_magnitude_type') String? get secondaryMagnitudeType;@JsonKey(includeIfNull: false, name: 'max_intensity') String? get maxIntensity;@JsonKey(includeIfNull: false, name: 'determination_flag') String? get determinationFlag;@JsonKey(includeIfNull: false, name: 'record_type') String? get recordType;@JsonKey(includeIfNull: false, name: 'travel_time_table') String? get travelTimeTable;@JsonKey(includeIfNull: false, name: 'hypocenter_evaluation') String? get hypocenterEvaluation;@JsonKey(includeIfNull: false, name: 'hypocenter_auxiliary_info') String? get hypocenterAuxiliaryInfo;@JsonKey(includeIfNull: false, name: 'damage_scale') String? get damageScale;@JsonKey(includeIfNull: false, name: 'tsunami_scale') String? get tsunamiScale;@JsonKey(includeIfNull: false, name: 'station_count') int? get stationCount;@JsonKey(includeIfNull: false, name: 'large_area_code') int? get largeAreaCode;@JsonKey(includeIfNull: false, name: 'small_area_code') int? get smallAreaCode;@JsonKey(includeIfNull: false, name: 'epicenter_name') String? get epicenterName;@JsonKey(includeIfNull: false, name: 'earthquake_event_id') String? get earthquakeEventId;
/// Create a copy of HypocenterResponseItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterResponseItemCopyWith<HypocenterResponseItem> get copyWith => _$HypocenterResponseItemCopyWithImpl<HypocenterResponseItem>(this as HypocenterResponseItem, _$identity);

  /// Serializes this HypocenterResponseItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterResponseItem&&(identical(other.hypocenterId, hypocenterId) || other.hypocenterId == hypocenterId)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.originTimeSecondStderr, originTimeSecondStderr) || other.originTimeSecondStderr == originTimeSecondStderr)&&(identical(other.latitudeMinStderr, latitudeMinStderr) || other.latitudeMinStderr == latitudeMinStderr)&&(identical(other.longitudeMinStderr, longitudeMinStderr) || other.longitudeMinStderr == longitudeMinStderr)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.depthIsFree, depthIsFree) || other.depthIsFree == depthIsFree)&&(identical(other.depthStderrKm, depthStderrKm) || other.depthStderrKm == depthStderrKm)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeType, magnitudeType) || other.magnitudeType == magnitudeType)&&(identical(other.secondaryMagnitude, secondaryMagnitude) || other.secondaryMagnitude == secondaryMagnitude)&&(identical(other.secondaryMagnitudeType, secondaryMagnitudeType) || other.secondaryMagnitudeType == secondaryMagnitudeType)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.determinationFlag, determinationFlag) || other.determinationFlag == determinationFlag)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&(identical(other.travelTimeTable, travelTimeTable) || other.travelTimeTable == travelTimeTable)&&(identical(other.hypocenterEvaluation, hypocenterEvaluation) || other.hypocenterEvaluation == hypocenterEvaluation)&&(identical(other.hypocenterAuxiliaryInfo, hypocenterAuxiliaryInfo) || other.hypocenterAuxiliaryInfo == hypocenterAuxiliaryInfo)&&(identical(other.damageScale, damageScale) || other.damageScale == damageScale)&&(identical(other.tsunamiScale, tsunamiScale) || other.tsunamiScale == tsunamiScale)&&(identical(other.stationCount, stationCount) || other.stationCount == stationCount)&&(identical(other.largeAreaCode, largeAreaCode) || other.largeAreaCode == largeAreaCode)&&(identical(other.smallAreaCode, smallAreaCode) || other.smallAreaCode == smallAreaCode)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.earthquakeEventId, earthquakeEventId) || other.earthquakeEventId == earthquakeEventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,hypocenterId,originTime,originTimePrecision,latitude,longitude,originTimeSecondStderr,latitudeMinStderr,longitudeMinStderr,depthKm,depthIsFree,depthStderrKm,magnitude,magnitudeType,secondaryMagnitude,secondaryMagnitudeType,maxIntensity,determinationFlag,recordType,travelTimeTable,hypocenterEvaluation,hypocenterAuxiliaryInfo,damageScale,tsunamiScale,stationCount,largeAreaCode,smallAreaCode,epicenterName,earthquakeEventId]);

@override
String toString() {
  return 'HypocenterResponseItem(hypocenterId: $hypocenterId, originTime: $originTime, originTimePrecision: $originTimePrecision, latitude: $latitude, longitude: $longitude, originTimeSecondStderr: $originTimeSecondStderr, latitudeMinStderr: $latitudeMinStderr, longitudeMinStderr: $longitudeMinStderr, depthKm: $depthKm, depthIsFree: $depthIsFree, depthStderrKm: $depthStderrKm, magnitude: $magnitude, magnitudeType: $magnitudeType, secondaryMagnitude: $secondaryMagnitude, secondaryMagnitudeType: $secondaryMagnitudeType, maxIntensity: $maxIntensity, determinationFlag: $determinationFlag, recordType: $recordType, travelTimeTable: $travelTimeTable, hypocenterEvaluation: $hypocenterEvaluation, hypocenterAuxiliaryInfo: $hypocenterAuxiliaryInfo, damageScale: $damageScale, tsunamiScale: $tsunamiScale, stationCount: $stationCount, largeAreaCode: $largeAreaCode, smallAreaCode: $smallAreaCode, epicenterName: $epicenterName, earthquakeEventId: $earthquakeEventId)';
}


}

/// @nodoc
abstract mixin class $HypocenterResponseItemCopyWith<$Res>  {
  factory $HypocenterResponseItemCopyWith(HypocenterResponseItem value, $Res Function(HypocenterResponseItem) _then) = _$HypocenterResponseItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'hypocenter_id') String hypocenterId,@JsonKey(name: 'origin_time') DateTime originTime,@JsonKey(name: 'origin_time_precision') HypocenterOriginTimePrecision originTimePrecision, num latitude, num longitude,@JsonKey(includeIfNull: false, name: 'origin_time_second_stderr') num? originTimeSecondStderr,@JsonKey(includeIfNull: false, name: 'latitude_min_stderr') num? latitudeMinStderr,@JsonKey(includeIfNull: false, name: 'longitude_min_stderr') num? longitudeMinStderr,@JsonKey(includeIfNull: false, name: 'depth_km') num? depthKm,@JsonKey(includeIfNull: false, name: 'depth_is_free') bool? depthIsFree,@JsonKey(includeIfNull: false, name: 'depth_stderr_km') num? depthStderrKm,@JsonKey(includeIfNull: false) num? magnitude,@JsonKey(includeIfNull: false, name: 'magnitude_type') String? magnitudeType,@JsonKey(includeIfNull: false, name: 'secondary_magnitude') num? secondaryMagnitude,@JsonKey(includeIfNull: false, name: 'secondary_magnitude_type') String? secondaryMagnitudeType,@JsonKey(includeIfNull: false, name: 'max_intensity') String? maxIntensity,@JsonKey(includeIfNull: false, name: 'determination_flag') String? determinationFlag,@JsonKey(includeIfNull: false, name: 'record_type') String? recordType,@JsonKey(includeIfNull: false, name: 'travel_time_table') String? travelTimeTable,@JsonKey(includeIfNull: false, name: 'hypocenter_evaluation') String? hypocenterEvaluation,@JsonKey(includeIfNull: false, name: 'hypocenter_auxiliary_info') String? hypocenterAuxiliaryInfo,@JsonKey(includeIfNull: false, name: 'damage_scale') String? damageScale,@JsonKey(includeIfNull: false, name: 'tsunami_scale') String? tsunamiScale,@JsonKey(includeIfNull: false, name: 'station_count') int? stationCount,@JsonKey(includeIfNull: false, name: 'large_area_code') int? largeAreaCode,@JsonKey(includeIfNull: false, name: 'small_area_code') int? smallAreaCode,@JsonKey(includeIfNull: false, name: 'epicenter_name') String? epicenterName,@JsonKey(includeIfNull: false, name: 'earthquake_event_id') String? earthquakeEventId
});




}
/// @nodoc
class _$HypocenterResponseItemCopyWithImpl<$Res>
    implements $HypocenterResponseItemCopyWith<$Res> {
  _$HypocenterResponseItemCopyWithImpl(this._self, this._then);

  final HypocenterResponseItem _self;
  final $Res Function(HypocenterResponseItem) _then;

/// Create a copy of HypocenterResponseItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hypocenterId = null,Object? originTime = null,Object? originTimePrecision = null,Object? latitude = null,Object? longitude = null,Object? originTimeSecondStderr = freezed,Object? latitudeMinStderr = freezed,Object? longitudeMinStderr = freezed,Object? depthKm = freezed,Object? depthIsFree = freezed,Object? depthStderrKm = freezed,Object? magnitude = freezed,Object? magnitudeType = freezed,Object? secondaryMagnitude = freezed,Object? secondaryMagnitudeType = freezed,Object? maxIntensity = freezed,Object? determinationFlag = freezed,Object? recordType = freezed,Object? travelTimeTable = freezed,Object? hypocenterEvaluation = freezed,Object? hypocenterAuxiliaryInfo = freezed,Object? damageScale = freezed,Object? tsunamiScale = freezed,Object? stationCount = freezed,Object? largeAreaCode = freezed,Object? smallAreaCode = freezed,Object? epicenterName = freezed,Object? earthquakeEventId = freezed,}) {
  return _then(HypocenterResponseItem(
hypocenterId: null == hypocenterId ? _self.hypocenterId : hypocenterId // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as HypocenterOriginTimePrecision,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,originTimeSecondStderr: freezed == originTimeSecondStderr ? _self.originTimeSecondStderr : originTimeSecondStderr // ignore: cast_nullable_to_non_nullable
as num?,latitudeMinStderr: freezed == latitudeMinStderr ? _self.latitudeMinStderr : latitudeMinStderr // ignore: cast_nullable_to_non_nullable
as num?,longitudeMinStderr: freezed == longitudeMinStderr ? _self.longitudeMinStderr : longitudeMinStderr // ignore: cast_nullable_to_non_nullable
as num?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as num?,depthIsFree: freezed == depthIsFree ? _self.depthIsFree : depthIsFree // ignore: cast_nullable_to_non_nullable
as bool?,depthStderrKm: freezed == depthStderrKm ? _self.depthStderrKm : depthStderrKm // ignore: cast_nullable_to_non_nullable
as num?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,magnitudeType: freezed == magnitudeType ? _self.magnitudeType : magnitudeType // ignore: cast_nullable_to_non_nullable
as String?,secondaryMagnitude: freezed == secondaryMagnitude ? _self.secondaryMagnitude : secondaryMagnitude // ignore: cast_nullable_to_non_nullable
as num?,secondaryMagnitudeType: freezed == secondaryMagnitudeType ? _self.secondaryMagnitudeType : secondaryMagnitudeType // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String?,determinationFlag: freezed == determinationFlag ? _self.determinationFlag : determinationFlag // ignore: cast_nullable_to_non_nullable
as String?,recordType: freezed == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as String?,travelTimeTable: freezed == travelTimeTable ? _self.travelTimeTable : travelTimeTable // ignore: cast_nullable_to_non_nullable
as String?,hypocenterEvaluation: freezed == hypocenterEvaluation ? _self.hypocenterEvaluation : hypocenterEvaluation // ignore: cast_nullable_to_non_nullable
as String?,hypocenterAuxiliaryInfo: freezed == hypocenterAuxiliaryInfo ? _self.hypocenterAuxiliaryInfo : hypocenterAuxiliaryInfo // ignore: cast_nullable_to_non_nullable
as String?,damageScale: freezed == damageScale ? _self.damageScale : damageScale // ignore: cast_nullable_to_non_nullable
as String?,tsunamiScale: freezed == tsunamiScale ? _self.tsunamiScale : tsunamiScale // ignore: cast_nullable_to_non_nullable
as String?,stationCount: freezed == stationCount ? _self.stationCount : stationCount // ignore: cast_nullable_to_non_nullable
as int?,largeAreaCode: freezed == largeAreaCode ? _self.largeAreaCode : largeAreaCode // ignore: cast_nullable_to_non_nullable
as int?,smallAreaCode: freezed == smallAreaCode ? _self.smallAreaCode : smallAreaCode // ignore: cast_nullable_to_non_nullable
as int?,epicenterName: freezed == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String?,earthquakeEventId: freezed == earthquakeEventId ? _self.earthquakeEventId : earthquakeEventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HypocenterResponseItem].
extension HypocenterResponseItemPatterns on HypocenterResponseItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterResponseItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterResponseItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterResponseItem value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterResponseItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterResponseItem value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterResponseItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'hypocenter_id')  String hypocenterId, @JsonKey(name: 'origin_time')  DateTime originTime, @JsonKey(name: 'origin_time_precision')  HypocenterOriginTimePrecision originTimePrecision,  num latitude,  num longitude, @JsonKey(includeIfNull: false, name: 'origin_time_second_stderr')  num? originTimeSecondStderr, @JsonKey(includeIfNull: false, name: 'latitude_min_stderr')  num? latitudeMinStderr, @JsonKey(includeIfNull: false, name: 'longitude_min_stderr')  num? longitudeMinStderr, @JsonKey(includeIfNull: false, name: 'depth_km')  num? depthKm, @JsonKey(includeIfNull: false, name: 'depth_is_free')  bool? depthIsFree, @JsonKey(includeIfNull: false, name: 'depth_stderr_km')  num? depthStderrKm, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false, name: 'magnitude_type')  String? magnitudeType, @JsonKey(includeIfNull: false, name: 'secondary_magnitude')  num? secondaryMagnitude, @JsonKey(includeIfNull: false, name: 'secondary_magnitude_type')  String? secondaryMagnitudeType, @JsonKey(includeIfNull: false, name: 'max_intensity')  String? maxIntensity, @JsonKey(includeIfNull: false, name: 'determination_flag')  String? determinationFlag, @JsonKey(includeIfNull: false, name: 'record_type')  String? recordType, @JsonKey(includeIfNull: false, name: 'travel_time_table')  String? travelTimeTable, @JsonKey(includeIfNull: false, name: 'hypocenter_evaluation')  String? hypocenterEvaluation, @JsonKey(includeIfNull: false, name: 'hypocenter_auxiliary_info')  String? hypocenterAuxiliaryInfo, @JsonKey(includeIfNull: false, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: false, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: false, name: 'station_count')  int? stationCount, @JsonKey(includeIfNull: false, name: 'large_area_code')  int? largeAreaCode, @JsonKey(includeIfNull: false, name: 'small_area_code')  int? smallAreaCode, @JsonKey(includeIfNull: false, name: 'epicenter_name')  String? epicenterName, @JsonKey(includeIfNull: false, name: 'earthquake_event_id')  String? earthquakeEventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterResponseItem() when $default != null:
return $default(_that.hypocenterId,_that.originTime,_that.originTimePrecision,_that.latitude,_that.longitude,_that.originTimeSecondStderr,_that.latitudeMinStderr,_that.longitudeMinStderr,_that.depthKm,_that.depthIsFree,_that.depthStderrKm,_that.magnitude,_that.magnitudeType,_that.secondaryMagnitude,_that.secondaryMagnitudeType,_that.maxIntensity,_that.determinationFlag,_that.recordType,_that.travelTimeTable,_that.hypocenterEvaluation,_that.hypocenterAuxiliaryInfo,_that.damageScale,_that.tsunamiScale,_that.stationCount,_that.largeAreaCode,_that.smallAreaCode,_that.epicenterName,_that.earthquakeEventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'hypocenter_id')  String hypocenterId, @JsonKey(name: 'origin_time')  DateTime originTime, @JsonKey(name: 'origin_time_precision')  HypocenterOriginTimePrecision originTimePrecision,  num latitude,  num longitude, @JsonKey(includeIfNull: false, name: 'origin_time_second_stderr')  num? originTimeSecondStderr, @JsonKey(includeIfNull: false, name: 'latitude_min_stderr')  num? latitudeMinStderr, @JsonKey(includeIfNull: false, name: 'longitude_min_stderr')  num? longitudeMinStderr, @JsonKey(includeIfNull: false, name: 'depth_km')  num? depthKm, @JsonKey(includeIfNull: false, name: 'depth_is_free')  bool? depthIsFree, @JsonKey(includeIfNull: false, name: 'depth_stderr_km')  num? depthStderrKm, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false, name: 'magnitude_type')  String? magnitudeType, @JsonKey(includeIfNull: false, name: 'secondary_magnitude')  num? secondaryMagnitude, @JsonKey(includeIfNull: false, name: 'secondary_magnitude_type')  String? secondaryMagnitudeType, @JsonKey(includeIfNull: false, name: 'max_intensity')  String? maxIntensity, @JsonKey(includeIfNull: false, name: 'determination_flag')  String? determinationFlag, @JsonKey(includeIfNull: false, name: 'record_type')  String? recordType, @JsonKey(includeIfNull: false, name: 'travel_time_table')  String? travelTimeTable, @JsonKey(includeIfNull: false, name: 'hypocenter_evaluation')  String? hypocenterEvaluation, @JsonKey(includeIfNull: false, name: 'hypocenter_auxiliary_info')  String? hypocenterAuxiliaryInfo, @JsonKey(includeIfNull: false, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: false, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: false, name: 'station_count')  int? stationCount, @JsonKey(includeIfNull: false, name: 'large_area_code')  int? largeAreaCode, @JsonKey(includeIfNull: false, name: 'small_area_code')  int? smallAreaCode, @JsonKey(includeIfNull: false, name: 'epicenter_name')  String? epicenterName, @JsonKey(includeIfNull: false, name: 'earthquake_event_id')  String? earthquakeEventId)  $default,) {final _that = this;
switch (_that) {
case _HypocenterResponseItem():
return $default(_that.hypocenterId,_that.originTime,_that.originTimePrecision,_that.latitude,_that.longitude,_that.originTimeSecondStderr,_that.latitudeMinStderr,_that.longitudeMinStderr,_that.depthKm,_that.depthIsFree,_that.depthStderrKm,_that.magnitude,_that.magnitudeType,_that.secondaryMagnitude,_that.secondaryMagnitudeType,_that.maxIntensity,_that.determinationFlag,_that.recordType,_that.travelTimeTable,_that.hypocenterEvaluation,_that.hypocenterAuxiliaryInfo,_that.damageScale,_that.tsunamiScale,_that.stationCount,_that.largeAreaCode,_that.smallAreaCode,_that.epicenterName,_that.earthquakeEventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'hypocenter_id')  String hypocenterId, @JsonKey(name: 'origin_time')  DateTime originTime, @JsonKey(name: 'origin_time_precision')  HypocenterOriginTimePrecision originTimePrecision,  num latitude,  num longitude, @JsonKey(includeIfNull: false, name: 'origin_time_second_stderr')  num? originTimeSecondStderr, @JsonKey(includeIfNull: false, name: 'latitude_min_stderr')  num? latitudeMinStderr, @JsonKey(includeIfNull: false, name: 'longitude_min_stderr')  num? longitudeMinStderr, @JsonKey(includeIfNull: false, name: 'depth_km')  num? depthKm, @JsonKey(includeIfNull: false, name: 'depth_is_free')  bool? depthIsFree, @JsonKey(includeIfNull: false, name: 'depth_stderr_km')  num? depthStderrKm, @JsonKey(includeIfNull: false)  num? magnitude, @JsonKey(includeIfNull: false, name: 'magnitude_type')  String? magnitudeType, @JsonKey(includeIfNull: false, name: 'secondary_magnitude')  num? secondaryMagnitude, @JsonKey(includeIfNull: false, name: 'secondary_magnitude_type')  String? secondaryMagnitudeType, @JsonKey(includeIfNull: false, name: 'max_intensity')  String? maxIntensity, @JsonKey(includeIfNull: false, name: 'determination_flag')  String? determinationFlag, @JsonKey(includeIfNull: false, name: 'record_type')  String? recordType, @JsonKey(includeIfNull: false, name: 'travel_time_table')  String? travelTimeTable, @JsonKey(includeIfNull: false, name: 'hypocenter_evaluation')  String? hypocenterEvaluation, @JsonKey(includeIfNull: false, name: 'hypocenter_auxiliary_info')  String? hypocenterAuxiliaryInfo, @JsonKey(includeIfNull: false, name: 'damage_scale')  String? damageScale, @JsonKey(includeIfNull: false, name: 'tsunami_scale')  String? tsunamiScale, @JsonKey(includeIfNull: false, name: 'station_count')  int? stationCount, @JsonKey(includeIfNull: false, name: 'large_area_code')  int? largeAreaCode, @JsonKey(includeIfNull: false, name: 'small_area_code')  int? smallAreaCode, @JsonKey(includeIfNull: false, name: 'epicenter_name')  String? epicenterName, @JsonKey(includeIfNull: false, name: 'earthquake_event_id')  String? earthquakeEventId)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterResponseItem() when $default != null:
return $default(_that.hypocenterId,_that.originTime,_that.originTimePrecision,_that.latitude,_that.longitude,_that.originTimeSecondStderr,_that.latitudeMinStderr,_that.longitudeMinStderr,_that.depthKm,_that.depthIsFree,_that.depthStderrKm,_that.magnitude,_that.magnitudeType,_that.secondaryMagnitude,_that.secondaryMagnitudeType,_that.maxIntensity,_that.determinationFlag,_that.recordType,_that.travelTimeTable,_that.hypocenterEvaluation,_that.hypocenterAuxiliaryInfo,_that.damageScale,_that.tsunamiScale,_that.stationCount,_that.largeAreaCode,_that.smallAreaCode,_that.epicenterName,_that.earthquakeEventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterResponseItem implements HypocenterResponseItem {
  const _HypocenterResponseItem({@JsonKey(name: 'hypocenter_id') required this.hypocenterId, @JsonKey(name: 'origin_time') required this.originTime, @JsonKey(name: 'origin_time_precision') required this.originTimePrecision, required this.latitude, required this.longitude, @JsonKey(includeIfNull: false, name: 'origin_time_second_stderr') this.originTimeSecondStderr, @JsonKey(includeIfNull: false, name: 'latitude_min_stderr') this.latitudeMinStderr, @JsonKey(includeIfNull: false, name: 'longitude_min_stderr') this.longitudeMinStderr, @JsonKey(includeIfNull: false, name: 'depth_km') this.depthKm, @JsonKey(includeIfNull: false, name: 'depth_is_free') this.depthIsFree, @JsonKey(includeIfNull: false, name: 'depth_stderr_km') this.depthStderrKm, @JsonKey(includeIfNull: false) this.magnitude, @JsonKey(includeIfNull: false, name: 'magnitude_type') this.magnitudeType, @JsonKey(includeIfNull: false, name: 'secondary_magnitude') this.secondaryMagnitude, @JsonKey(includeIfNull: false, name: 'secondary_magnitude_type') this.secondaryMagnitudeType, @JsonKey(includeIfNull: false, name: 'max_intensity') this.maxIntensity, @JsonKey(includeIfNull: false, name: 'determination_flag') this.determinationFlag, @JsonKey(includeIfNull: false, name: 'record_type') this.recordType, @JsonKey(includeIfNull: false, name: 'travel_time_table') this.travelTimeTable, @JsonKey(includeIfNull: false, name: 'hypocenter_evaluation') this.hypocenterEvaluation, @JsonKey(includeIfNull: false, name: 'hypocenter_auxiliary_info') this.hypocenterAuxiliaryInfo, @JsonKey(includeIfNull: false, name: 'damage_scale') this.damageScale, @JsonKey(includeIfNull: false, name: 'tsunami_scale') this.tsunamiScale, @JsonKey(includeIfNull: false, name: 'station_count') this.stationCount, @JsonKey(includeIfNull: false, name: 'large_area_code') this.largeAreaCode, @JsonKey(includeIfNull: false, name: 'small_area_code') this.smallAreaCode, @JsonKey(includeIfNull: false, name: 'epicenter_name') this.epicenterName, @JsonKey(includeIfNull: false, name: 'earthquake_event_id') this.earthquakeEventId});
  factory _HypocenterResponseItem.fromJson(Map<String, dynamic> json) => _$HypocenterResponseItemFromJson(json);

@override@JsonKey(name: 'hypocenter_id') final  String hypocenterId;
@override@JsonKey(name: 'origin_time') final  DateTime originTime;
@override@JsonKey(name: 'origin_time_precision') final  HypocenterOriginTimePrecision originTimePrecision;
@override final  num latitude;
@override final  num longitude;
@override@JsonKey(includeIfNull: false, name: 'origin_time_second_stderr') final  num? originTimeSecondStderr;
@override@JsonKey(includeIfNull: false, name: 'latitude_min_stderr') final  num? latitudeMinStderr;
@override@JsonKey(includeIfNull: false, name: 'longitude_min_stderr') final  num? longitudeMinStderr;
@override@JsonKey(includeIfNull: false, name: 'depth_km') final  num? depthKm;
@override@JsonKey(includeIfNull: false, name: 'depth_is_free') final  bool? depthIsFree;
@override@JsonKey(includeIfNull: false, name: 'depth_stderr_km') final  num? depthStderrKm;
@override@JsonKey(includeIfNull: false) final  num? magnitude;
@override@JsonKey(includeIfNull: false, name: 'magnitude_type') final  String? magnitudeType;
@override@JsonKey(includeIfNull: false, name: 'secondary_magnitude') final  num? secondaryMagnitude;
@override@JsonKey(includeIfNull: false, name: 'secondary_magnitude_type') final  String? secondaryMagnitudeType;
@override@JsonKey(includeIfNull: false, name: 'max_intensity') final  String? maxIntensity;
@override@JsonKey(includeIfNull: false, name: 'determination_flag') final  String? determinationFlag;
@override@JsonKey(includeIfNull: false, name: 'record_type') final  String? recordType;
@override@JsonKey(includeIfNull: false, name: 'travel_time_table') final  String? travelTimeTable;
@override@JsonKey(includeIfNull: false, name: 'hypocenter_evaluation') final  String? hypocenterEvaluation;
@override@JsonKey(includeIfNull: false, name: 'hypocenter_auxiliary_info') final  String? hypocenterAuxiliaryInfo;
@override@JsonKey(includeIfNull: false, name: 'damage_scale') final  String? damageScale;
@override@JsonKey(includeIfNull: false, name: 'tsunami_scale') final  String? tsunamiScale;
@override@JsonKey(includeIfNull: false, name: 'station_count') final  int? stationCount;
@override@JsonKey(includeIfNull: false, name: 'large_area_code') final  int? largeAreaCode;
@override@JsonKey(includeIfNull: false, name: 'small_area_code') final  int? smallAreaCode;
@override@JsonKey(includeIfNull: false, name: 'epicenter_name') final  String? epicenterName;
@override@JsonKey(includeIfNull: false, name: 'earthquake_event_id') final  String? earthquakeEventId;

/// Create a copy of HypocenterResponseItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterResponseItemCopyWith<_HypocenterResponseItem> get copyWith => __$HypocenterResponseItemCopyWithImpl<_HypocenterResponseItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterResponseItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterResponseItem&&(identical(other.hypocenterId, hypocenterId) || other.hypocenterId == hypocenterId)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.originTimePrecision, originTimePrecision) || other.originTimePrecision == originTimePrecision)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.originTimeSecondStderr, originTimeSecondStderr) || other.originTimeSecondStderr == originTimeSecondStderr)&&(identical(other.latitudeMinStderr, latitudeMinStderr) || other.latitudeMinStderr == latitudeMinStderr)&&(identical(other.longitudeMinStderr, longitudeMinStderr) || other.longitudeMinStderr == longitudeMinStderr)&&(identical(other.depthKm, depthKm) || other.depthKm == depthKm)&&(identical(other.depthIsFree, depthIsFree) || other.depthIsFree == depthIsFree)&&(identical(other.depthStderrKm, depthStderrKm) || other.depthStderrKm == depthStderrKm)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.magnitudeType, magnitudeType) || other.magnitudeType == magnitudeType)&&(identical(other.secondaryMagnitude, secondaryMagnitude) || other.secondaryMagnitude == secondaryMagnitude)&&(identical(other.secondaryMagnitudeType, secondaryMagnitudeType) || other.secondaryMagnitudeType == secondaryMagnitudeType)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.determinationFlag, determinationFlag) || other.determinationFlag == determinationFlag)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&(identical(other.travelTimeTable, travelTimeTable) || other.travelTimeTable == travelTimeTable)&&(identical(other.hypocenterEvaluation, hypocenterEvaluation) || other.hypocenterEvaluation == hypocenterEvaluation)&&(identical(other.hypocenterAuxiliaryInfo, hypocenterAuxiliaryInfo) || other.hypocenterAuxiliaryInfo == hypocenterAuxiliaryInfo)&&(identical(other.damageScale, damageScale) || other.damageScale == damageScale)&&(identical(other.tsunamiScale, tsunamiScale) || other.tsunamiScale == tsunamiScale)&&(identical(other.stationCount, stationCount) || other.stationCount == stationCount)&&(identical(other.largeAreaCode, largeAreaCode) || other.largeAreaCode == largeAreaCode)&&(identical(other.smallAreaCode, smallAreaCode) || other.smallAreaCode == smallAreaCode)&&(identical(other.epicenterName, epicenterName) || other.epicenterName == epicenterName)&&(identical(other.earthquakeEventId, earthquakeEventId) || other.earthquakeEventId == earthquakeEventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,hypocenterId,originTime,originTimePrecision,latitude,longitude,originTimeSecondStderr,latitudeMinStderr,longitudeMinStderr,depthKm,depthIsFree,depthStderrKm,magnitude,magnitudeType,secondaryMagnitude,secondaryMagnitudeType,maxIntensity,determinationFlag,recordType,travelTimeTable,hypocenterEvaluation,hypocenterAuxiliaryInfo,damageScale,tsunamiScale,stationCount,largeAreaCode,smallAreaCode,epicenterName,earthquakeEventId]);

@override
String toString() {
  return 'HypocenterResponseItem(hypocenterId: $hypocenterId, originTime: $originTime, originTimePrecision: $originTimePrecision, latitude: $latitude, longitude: $longitude, originTimeSecondStderr: $originTimeSecondStderr, latitudeMinStderr: $latitudeMinStderr, longitudeMinStderr: $longitudeMinStderr, depthKm: $depthKm, depthIsFree: $depthIsFree, depthStderrKm: $depthStderrKm, magnitude: $magnitude, magnitudeType: $magnitudeType, secondaryMagnitude: $secondaryMagnitude, secondaryMagnitudeType: $secondaryMagnitudeType, maxIntensity: $maxIntensity, determinationFlag: $determinationFlag, recordType: $recordType, travelTimeTable: $travelTimeTable, hypocenterEvaluation: $hypocenterEvaluation, hypocenterAuxiliaryInfo: $hypocenterAuxiliaryInfo, damageScale: $damageScale, tsunamiScale: $tsunamiScale, stationCount: $stationCount, largeAreaCode: $largeAreaCode, smallAreaCode: $smallAreaCode, epicenterName: $epicenterName, earthquakeEventId: $earthquakeEventId)';
}


}

/// @nodoc
abstract mixin class _$HypocenterResponseItemCopyWith<$Res> implements $HypocenterResponseItemCopyWith<$Res> {
  factory _$HypocenterResponseItemCopyWith(_HypocenterResponseItem value, $Res Function(_HypocenterResponseItem) _then) = __$HypocenterResponseItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'hypocenter_id') String hypocenterId,@JsonKey(name: 'origin_time') DateTime originTime,@JsonKey(name: 'origin_time_precision') HypocenterOriginTimePrecision originTimePrecision, num latitude, num longitude,@JsonKey(includeIfNull: false, name: 'origin_time_second_stderr') num? originTimeSecondStderr,@JsonKey(includeIfNull: false, name: 'latitude_min_stderr') num? latitudeMinStderr,@JsonKey(includeIfNull: false, name: 'longitude_min_stderr') num? longitudeMinStderr,@JsonKey(includeIfNull: false, name: 'depth_km') num? depthKm,@JsonKey(includeIfNull: false, name: 'depth_is_free') bool? depthIsFree,@JsonKey(includeIfNull: false, name: 'depth_stderr_km') num? depthStderrKm,@JsonKey(includeIfNull: false) num? magnitude,@JsonKey(includeIfNull: false, name: 'magnitude_type') String? magnitudeType,@JsonKey(includeIfNull: false, name: 'secondary_magnitude') num? secondaryMagnitude,@JsonKey(includeIfNull: false, name: 'secondary_magnitude_type') String? secondaryMagnitudeType,@JsonKey(includeIfNull: false, name: 'max_intensity') String? maxIntensity,@JsonKey(includeIfNull: false, name: 'determination_flag') String? determinationFlag,@JsonKey(includeIfNull: false, name: 'record_type') String? recordType,@JsonKey(includeIfNull: false, name: 'travel_time_table') String? travelTimeTable,@JsonKey(includeIfNull: false, name: 'hypocenter_evaluation') String? hypocenterEvaluation,@JsonKey(includeIfNull: false, name: 'hypocenter_auxiliary_info') String? hypocenterAuxiliaryInfo,@JsonKey(includeIfNull: false, name: 'damage_scale') String? damageScale,@JsonKey(includeIfNull: false, name: 'tsunami_scale') String? tsunamiScale,@JsonKey(includeIfNull: false, name: 'station_count') int? stationCount,@JsonKey(includeIfNull: false, name: 'large_area_code') int? largeAreaCode,@JsonKey(includeIfNull: false, name: 'small_area_code') int? smallAreaCode,@JsonKey(includeIfNull: false, name: 'epicenter_name') String? epicenterName,@JsonKey(includeIfNull: false, name: 'earthquake_event_id') String? earthquakeEventId
});




}
/// @nodoc
class __$HypocenterResponseItemCopyWithImpl<$Res>
    implements _$HypocenterResponseItemCopyWith<$Res> {
  __$HypocenterResponseItemCopyWithImpl(this._self, this._then);

  final _HypocenterResponseItem _self;
  final $Res Function(_HypocenterResponseItem) _then;

/// Create a copy of HypocenterResponseItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hypocenterId = null,Object? originTime = null,Object? originTimePrecision = null,Object? latitude = null,Object? longitude = null,Object? originTimeSecondStderr = freezed,Object? latitudeMinStderr = freezed,Object? longitudeMinStderr = freezed,Object? depthKm = freezed,Object? depthIsFree = freezed,Object? depthStderrKm = freezed,Object? magnitude = freezed,Object? magnitudeType = freezed,Object? secondaryMagnitude = freezed,Object? secondaryMagnitudeType = freezed,Object? maxIntensity = freezed,Object? determinationFlag = freezed,Object? recordType = freezed,Object? travelTimeTable = freezed,Object? hypocenterEvaluation = freezed,Object? hypocenterAuxiliaryInfo = freezed,Object? damageScale = freezed,Object? tsunamiScale = freezed,Object? stationCount = freezed,Object? largeAreaCode = freezed,Object? smallAreaCode = freezed,Object? epicenterName = freezed,Object? earthquakeEventId = freezed,}) {
  return _then(_HypocenterResponseItem(
hypocenterId: null == hypocenterId ? _self.hypocenterId : hypocenterId // ignore: cast_nullable_to_non_nullable
as String,originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,originTimePrecision: null == originTimePrecision ? _self.originTimePrecision : originTimePrecision // ignore: cast_nullable_to_non_nullable
as HypocenterOriginTimePrecision,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as num,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as num,originTimeSecondStderr: freezed == originTimeSecondStderr ? _self.originTimeSecondStderr : originTimeSecondStderr // ignore: cast_nullable_to_non_nullable
as num?,latitudeMinStderr: freezed == latitudeMinStderr ? _self.latitudeMinStderr : latitudeMinStderr // ignore: cast_nullable_to_non_nullable
as num?,longitudeMinStderr: freezed == longitudeMinStderr ? _self.longitudeMinStderr : longitudeMinStderr // ignore: cast_nullable_to_non_nullable
as num?,depthKm: freezed == depthKm ? _self.depthKm : depthKm // ignore: cast_nullable_to_non_nullable
as num?,depthIsFree: freezed == depthIsFree ? _self.depthIsFree : depthIsFree // ignore: cast_nullable_to_non_nullable
as bool?,depthStderrKm: freezed == depthStderrKm ? _self.depthStderrKm : depthStderrKm // ignore: cast_nullable_to_non_nullable
as num?,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,magnitudeType: freezed == magnitudeType ? _self.magnitudeType : magnitudeType // ignore: cast_nullable_to_non_nullable
as String?,secondaryMagnitude: freezed == secondaryMagnitude ? _self.secondaryMagnitude : secondaryMagnitude // ignore: cast_nullable_to_non_nullable
as num?,secondaryMagnitudeType: freezed == secondaryMagnitudeType ? _self.secondaryMagnitudeType : secondaryMagnitudeType // ignore: cast_nullable_to_non_nullable
as String?,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String?,determinationFlag: freezed == determinationFlag ? _self.determinationFlag : determinationFlag // ignore: cast_nullable_to_non_nullable
as String?,recordType: freezed == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as String?,travelTimeTable: freezed == travelTimeTable ? _self.travelTimeTable : travelTimeTable // ignore: cast_nullable_to_non_nullable
as String?,hypocenterEvaluation: freezed == hypocenterEvaluation ? _self.hypocenterEvaluation : hypocenterEvaluation // ignore: cast_nullable_to_non_nullable
as String?,hypocenterAuxiliaryInfo: freezed == hypocenterAuxiliaryInfo ? _self.hypocenterAuxiliaryInfo : hypocenterAuxiliaryInfo // ignore: cast_nullable_to_non_nullable
as String?,damageScale: freezed == damageScale ? _self.damageScale : damageScale // ignore: cast_nullable_to_non_nullable
as String?,tsunamiScale: freezed == tsunamiScale ? _self.tsunamiScale : tsunamiScale // ignore: cast_nullable_to_non_nullable
as String?,stationCount: freezed == stationCount ? _self.stationCount : stationCount // ignore: cast_nullable_to_non_nullable
as int?,largeAreaCode: freezed == largeAreaCode ? _self.largeAreaCode : largeAreaCode // ignore: cast_nullable_to_non_nullable
as int?,smallAreaCode: freezed == smallAreaCode ? _self.smallAreaCode : smallAreaCode // ignore: cast_nullable_to_non_nullable
as int?,epicenterName: freezed == epicenterName ? _self.epicenterName : epicenterName // ignore: cast_nullable_to_non_nullable
as String?,earthquakeEventId: freezed == earthquakeEventId ? _self.earthquakeEventId : earthquakeEventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
