// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeV1Impl _$$EarthquakeV1ImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeV1Impl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeV1Impl(
          arrivalTime: $checkedConvert('arrival_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
          epicenterCode:
              $checkedConvert('epicenter_code', (v) => (v as num?)?.toInt()),
          epicenterDetailCode: $checkedConvert(
              'epicenter_detail_code', (v) => (v as num?)?.toInt()),
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          headline: $checkedConvert('headline', (v) => v as String?),
          intensityCities: $checkedConvert(
              'intensity_cities',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ObservedRegionIntensity.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          intensityPrefectures: $checkedConvert(
              'intensity_prefectures',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ObservedRegionIntensity.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          intensityRegions: $checkedConvert(
              'intensity_regions',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ObservedRegionIntensity.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          intensityStations: $checkedConvert(
              'intensity_stations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ObservedRegionIntensity.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          lpgmIntensityPrefectures: $checkedConvert(
              'lpgm_intensity_prefectures',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ObservedRegionLpgmIntensity.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          lpgmIntensityRegions: $checkedConvert(
              'lpgm_intensity_regions',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ObservedRegionLpgmIntensity.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          lpgmIntenstiyStations: $checkedConvert(
              'lpgm_intenstiy_stations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ObservedRegionLpgmIntensity.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          magnitudeCondition:
              $checkedConvert('magnitude_condition', (v) => v as String?),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
          maxIntensityRegionIds: $checkedConvert(
              'max_intensity_region_ids',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList()),
          maxLpgmIntensity: $checkedConvert('max_lpgm_intensity',
              (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v)),
          originTime: $checkedConvert('origin_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          status: $checkedConvert('status', (v) => v as String),
          text: $checkedConvert('text', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'arrivalTime': 'arrival_time',
        'epicenterCode': 'epicenter_code',
        'epicenterDetailCode': 'epicenter_detail_code',
        'eventId': 'event_id',
        'intensityCities': 'intensity_cities',
        'intensityPrefectures': 'intensity_prefectures',
        'intensityRegions': 'intensity_regions',
        'intensityStations': 'intensity_stations',
        'lpgmIntensityPrefectures': 'lpgm_intensity_prefectures',
        'lpgmIntensityRegions': 'lpgm_intensity_regions',
        'lpgmIntenstiyStations': 'lpgm_intenstiy_stations',
        'magnitudeCondition': 'magnitude_condition',
        'maxIntensity': 'max_intensity',
        'maxIntensityRegionIds': 'max_intensity_region_ids',
        'maxLpgmIntensity': 'max_lpgm_intensity',
        'originTime': 'origin_time'
      },
    );

Map<String, dynamic> _$$EarthquakeV1ImplToJson(_$EarthquakeV1Impl instance) =>
    <String, dynamic>{
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'depth': instance.depth,
      'epicenter_code': instance.epicenterCode,
      'epicenter_detail_code': instance.epicenterDetailCode,
      'event_id': instance.eventId,
      'headline': instance.headline,
      'intensity_cities': instance.intensityCities,
      'intensity_prefectures': instance.intensityPrefectures,
      'intensity_regions': instance.intensityRegions,
      'intensity_stations': instance.intensityStations,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'lpgm_intensity_prefectures': instance.lpgmIntensityPrefectures,
      'lpgm_intensity_regions': instance.lpgmIntensityRegions,
      'lpgm_intenstiy_stations': instance.lpgmIntenstiyStations,
      'magnitude': instance.magnitude,
      'magnitude_condition': instance.magnitudeCondition,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
      'max_intensity_region_ids': instance.maxIntensityRegionIds,
      'max_lpgm_intensity': _$JmaLgIntensityEnumMap[instance.maxLpgmIntensity],
      'origin_time': instance.originTime?.toIso8601String(),
      'status': instance.status,
      'text': instance.text,
    };

const _$JmaIntensityEnumMap = {
  JmaIntensity.one: '1',
  JmaIntensity.two: '2',
  JmaIntensity.three: '3',
  JmaIntensity.four: '4',
  JmaIntensity.fiveLower: '5-',
  JmaIntensity.fiveUpper: '5+',
  JmaIntensity.sixLower: '6-',
  JmaIntensity.sixUpper: '6+',
  JmaIntensity.seven: '7',
  JmaIntensity.fiveUpperNoInput: '!5-',
};

const _$JmaLgIntensityEnumMap = {
  JmaLgIntensity.zero: '0',
  JmaLgIntensity.one: '1',
  JmaLgIntensity.two: '2',
  JmaLgIntensity.three: '3',
  JmaLgIntensity.four: '4',
};

_$EarthquakeV1BaseImpl _$$EarthquakeV1BaseImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeV1BaseImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeV1BaseImpl(
          arrivalTime: $checkedConvert('arrival_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
          epicenterCode:
              $checkedConvert('epicenter_code', (v) => (v as num?)?.toInt()),
          epicenterDetailCode: $checkedConvert(
              'epicenter_detail_code', (v) => (v as num?)?.toInt()),
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          headline: $checkedConvert('headline', (v) => v as String?),
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          magnitudeCondition:
              $checkedConvert('magnitude_condition', (v) => v as String?),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
          maxIntensityRegionIds: $checkedConvert(
              'max_intensity_region_ids',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList()),
          maxLpgmIntensity: $checkedConvert('max_lpgm_intensity',
              (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v)),
          originTime: $checkedConvert('origin_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          status: $checkedConvert('status', (v) => v as String),
          text: $checkedConvert('text', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'arrivalTime': 'arrival_time',
        'epicenterCode': 'epicenter_code',
        'epicenterDetailCode': 'epicenter_detail_code',
        'eventId': 'event_id',
        'magnitudeCondition': 'magnitude_condition',
        'maxIntensity': 'max_intensity',
        'maxIntensityRegionIds': 'max_intensity_region_ids',
        'maxLpgmIntensity': 'max_lpgm_intensity',
        'originTime': 'origin_time'
      },
    );

Map<String, dynamic> _$$EarthquakeV1BaseImplToJson(
        _$EarthquakeV1BaseImpl instance) =>
    <String, dynamic>{
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'depth': instance.depth,
      'epicenter_code': instance.epicenterCode,
      'epicenter_detail_code': instance.epicenterDetailCode,
      'event_id': instance.eventId,
      'headline': instance.headline,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'magnitude': instance.magnitude,
      'magnitude_condition': instance.magnitudeCondition,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
      'max_intensity_region_ids': instance.maxIntensityRegionIds,
      'max_lpgm_intensity': _$JmaLgIntensityEnumMap[instance.maxLpgmIntensity],
      'origin_time': instance.originTime?.toIso8601String(),
      'status': instance.status,
      'text': instance.text,
    };

_$ObservedRegionIntensityImpl _$$ObservedRegionIntensityImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ObservedRegionIntensityImpl',
      json,
      ($checkedConvert) {
        final val = _$ObservedRegionIntensityImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          intensity: $checkedConvert(
              'maxInt', (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'intensity': 'maxInt'},
    );

Map<String, dynamic> _$$ObservedRegionIntensityImplToJson(
        _$ObservedRegionIntensityImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'maxInt': _$JmaIntensityEnumMap[instance.intensity],
    };

_$ObservedRegionLpgmIntensityImpl _$$ObservedRegionLpgmIntensityImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ObservedRegionLpgmIntensityImpl',
      json,
      ($checkedConvert) {
        final val = _$ObservedRegionLpgmIntensityImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          intensity: $checkedConvert(
              'maxInt', (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
          lpgmIntensity: $checkedConvert('maxLgInt',
              (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'intensity': 'maxInt', 'lpgmIntensity': 'maxLgInt'},
    );

Map<String, dynamic> _$$ObservedRegionLpgmIntensityImplToJson(
        _$ObservedRegionLpgmIntensityImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'maxInt': _$JmaIntensityEnumMap[instance.intensity],
      'maxLgInt': _$JmaLgIntensityEnumMap[instance.lpgmIntensity],
    };
