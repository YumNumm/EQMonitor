// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HypocenterResponseItem _$HypocenterResponseItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_HypocenterResponseItem',
  json,
  ($checkedConvert) {
    final val = _HypocenterResponseItem(
      hypocenterId: $checkedConvert('hypocenter_id', (v) => v as String),
      originTime: $checkedConvert(
        'origin_time',
        (v) => DateTime.parse(v as String),
      ),
      originTimePrecision: $checkedConvert(
        'origin_time_precision',
        (v) => $enumDecode(_$HypocenterOriginTimePrecisionEnumMap, v),
      ),
      latitude: $checkedConvert('latitude', (v) => v as num),
      longitude: $checkedConvert('longitude', (v) => v as num),
      originTimeSecondStderr: $checkedConvert(
        'origin_time_second_stderr',
        (v) => v as num?,
      ),
      latitudeMinStderr: $checkedConvert(
        'latitude_min_stderr',
        (v) => v as num?,
      ),
      longitudeMinStderr: $checkedConvert(
        'longitude_min_stderr',
        (v) => v as num?,
      ),
      depthKm: $checkedConvert('depth_km', (v) => v as num?),
      depthIsFree: $checkedConvert('depth_is_free', (v) => v as bool?),
      depthStderrKm: $checkedConvert('depth_stderr_km', (v) => v as num?),
      magnitude: $checkedConvert('magnitude', (v) => v as num?),
      magnitudeType: $checkedConvert('magnitude_type', (v) => v as String?),
      secondaryMagnitude: $checkedConvert(
        'secondary_magnitude',
        (v) => v as num?,
      ),
      secondaryMagnitudeType: $checkedConvert(
        'secondary_magnitude_type',
        (v) => v as String?,
      ),
      maxIntensity: $checkedConvert('max_intensity', (v) => v as String?),
      determinationFlag: $checkedConvert(
        'determination_flag',
        (v) => v as String?,
      ),
      recordType: $checkedConvert('record_type', (v) => v as String?),
      travelTimeTable: $checkedConvert(
        'travel_time_table',
        (v) => v as String?,
      ),
      hypocenterEvaluation: $checkedConvert(
        'hypocenter_evaluation',
        (v) => v as String?,
      ),
      hypocenterAuxiliaryInfo: $checkedConvert(
        'hypocenter_auxiliary_info',
        (v) => v as String?,
      ),
      damageScale: $checkedConvert('damage_scale', (v) => v as String?),
      tsunamiScale: $checkedConvert('tsunami_scale', (v) => v as String?),
      stationCount: $checkedConvert(
        'station_count',
        (v) => (v as num?)?.toInt(),
      ),
      largeAreaCode: $checkedConvert(
        'large_area_code',
        (v) => (v as num?)?.toInt(),
      ),
      smallAreaCode: $checkedConvert(
        'small_area_code',
        (v) => (v as num?)?.toInt(),
      ),
      epicenterName: $checkedConvert('epicenter_name', (v) => v as String?),
      earthquakeEventId: $checkedConvert(
        'earthquake_event_id',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'hypocenterId': 'hypocenter_id',
    'originTime': 'origin_time',
    'originTimePrecision': 'origin_time_precision',
    'originTimeSecondStderr': 'origin_time_second_stderr',
    'latitudeMinStderr': 'latitude_min_stderr',
    'longitudeMinStderr': 'longitude_min_stderr',
    'depthKm': 'depth_km',
    'depthIsFree': 'depth_is_free',
    'depthStderrKm': 'depth_stderr_km',
    'magnitudeType': 'magnitude_type',
    'secondaryMagnitude': 'secondary_magnitude',
    'secondaryMagnitudeType': 'secondary_magnitude_type',
    'maxIntensity': 'max_intensity',
    'determinationFlag': 'determination_flag',
    'recordType': 'record_type',
    'travelTimeTable': 'travel_time_table',
    'hypocenterEvaluation': 'hypocenter_evaluation',
    'hypocenterAuxiliaryInfo': 'hypocenter_auxiliary_info',
    'damageScale': 'damage_scale',
    'tsunamiScale': 'tsunami_scale',
    'stationCount': 'station_count',
    'largeAreaCode': 'large_area_code',
    'smallAreaCode': 'small_area_code',
    'epicenterName': 'epicenter_name',
    'earthquakeEventId': 'earthquake_event_id',
  },
);

Map<String, dynamic> _$HypocenterResponseItemToJson(
  _HypocenterResponseItem instance,
) => <String, dynamic>{
  'hypocenter_id': instance.hypocenterId,
  'origin_time': instance.originTime.toIso8601String(),
  'origin_time_precision': instance.originTimePrecision,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'origin_time_second_stderr': ?instance.originTimeSecondStderr,
  'latitude_min_stderr': ?instance.latitudeMinStderr,
  'longitude_min_stderr': ?instance.longitudeMinStderr,
  'depth_km': ?instance.depthKm,
  'depth_is_free': ?instance.depthIsFree,
  'depth_stderr_km': ?instance.depthStderrKm,
  'magnitude': ?instance.magnitude,
  'magnitude_type': ?instance.magnitudeType,
  'secondary_magnitude': ?instance.secondaryMagnitude,
  'secondary_magnitude_type': ?instance.secondaryMagnitudeType,
  'max_intensity': ?instance.maxIntensity,
  'determination_flag': ?instance.determinationFlag,
  'record_type': ?instance.recordType,
  'travel_time_table': ?instance.travelTimeTable,
  'hypocenter_evaluation': ?instance.hypocenterEvaluation,
  'hypocenter_auxiliary_info': ?instance.hypocenterAuxiliaryInfo,
  'damage_scale': ?instance.damageScale,
  'tsunami_scale': ?instance.tsunamiScale,
  'station_count': ?instance.stationCount,
  'large_area_code': ?instance.largeAreaCode,
  'small_area_code': ?instance.smallAreaCode,
  'epicenter_name': ?instance.epicenterName,
  'earthquake_event_id': ?instance.earthquakeEventId,
};

const _$HypocenterOriginTimePrecisionEnumMap = {
  HypocenterOriginTimePrecision.centisecond: 'CENTISECOND',
  HypocenterOriginTimePrecision.decisecond: 'DECISECOND',
  HypocenterOriginTimePrecision.second: 'SECOND',
  HypocenterOriginTimePrecision.minute: 'MINUTE',
};
