// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hypocenter_origin_time_precision.dart';

part 'hypocenter_response_item.freezed.dart';
part 'hypocenter_response_item.g.dart';

@Freezed()
abstract class HypocenterResponseItem with _$HypocenterResponseItem {
  const factory HypocenterResponseItem({
    @JsonKey(name: 'hypocenter_id')
    required String hypocenterId,
    @JsonKey(name: 'origin_time')
    required DateTime originTime,
    @JsonKey(name: 'origin_time_precision')
    required HypocenterOriginTimePrecision originTimePrecision,
    required num latitude,
    required num longitude,
    @JsonKey(includeIfNull: false,name: 'origin_time_second_stderr')
    num? originTimeSecondStderr,
    @JsonKey(includeIfNull: false,name: 'latitude_min_stderr')
    num? latitudeMinStderr,
    @JsonKey(includeIfNull: false,name: 'longitude_min_stderr')
    num? longitudeMinStderr,
    @JsonKey(includeIfNull: false,name: 'depth_km')
    num? depthKm,
    @JsonKey(includeIfNull: false,name: 'depth_is_free')
    bool? depthIsFree,
    @JsonKey(includeIfNull: false,name: 'depth_stderr_km')
    num? depthStderrKm,
    @JsonKey(includeIfNull: false)
    num? magnitude,
    @JsonKey(includeIfNull: false,name: 'magnitude_type')
    String? magnitudeType,
    @JsonKey(includeIfNull: false,name: 'secondary_magnitude')
    num? secondaryMagnitude,
    @JsonKey(includeIfNull: false,name: 'secondary_magnitude_type')
    String? secondaryMagnitudeType,
    @JsonKey(includeIfNull: false,name: 'max_intensity')
    String? maxIntensity,
    @JsonKey(includeIfNull: false,name: 'determination_flag')
    String? determinationFlag,
    @JsonKey(includeIfNull: false,name: 'record_type')
    String? recordType,
    @JsonKey(includeIfNull: false,name: 'travel_time_table')
    String? travelTimeTable,
    @JsonKey(includeIfNull: false,name: 'hypocenter_evaluation')
    String? hypocenterEvaluation,
    @JsonKey(includeIfNull: false,name: 'hypocenter_auxiliary_info')
    String? hypocenterAuxiliaryInfo,
    @JsonKey(includeIfNull: false,name: 'damage_scale')
    String? damageScale,
    @JsonKey(includeIfNull: false,name: 'tsunami_scale')
    String? tsunamiScale,
    @JsonKey(includeIfNull: false,name: 'station_count')
    int? stationCount,
    @JsonKey(includeIfNull: false,name: 'large_area_code')
    int? largeAreaCode,
    @JsonKey(includeIfNull: false,name: 'small_area_code')
    int? smallAreaCode,
    @JsonKey(includeIfNull: false,name: 'epicenter_name')
    String? epicenterName,
    @JsonKey(includeIfNull: false,name: 'earthquake_event_id')
    String? earthquakeEventId,
  }) = _HypocenterResponseItem;
  
  factory HypocenterResponseItem.fromJson(Map<String, Object?> json) => _$HypocenterResponseItemFromJson(json);
}
