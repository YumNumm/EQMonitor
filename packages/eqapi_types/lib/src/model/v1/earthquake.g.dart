// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeV1 _$EarthquakeV1FromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeV1',
  json,
  ($checkedConvert) {
    final val = _EarthquakeV1(
      eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
      status: $checkedConvert('status', (v) => v as String),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
      epicenterCode: $checkedConvert(
        'epicenter_code',
        (v) => (v as num?)?.toInt(),
      ),
      epicenterDetailCode: $checkedConvert(
        'epicenter_detail_code',
        (v) => (v as num?)?.toInt(),
      ),
      headline: $checkedConvert('headline', (v) => v as String?),
      intensityCities: $checkedConvert(
        'intensity_cities',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) =>
                  ObservedRegionIntensity.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      intensityPrefectures: $checkedConvert(
        'intensity_prefectures',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) =>
                  ObservedRegionIntensity.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      intensityRegions: $checkedConvert(
        'intensity_regions',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) =>
                  ObservedRegionIntensity.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      intensityStations: $checkedConvert(
        'intensity_stations',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) =>
                  ObservedRegionIntensity.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
      longitude: $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
      lpgmIntensityPrefectures: $checkedConvert(
        'lpgm_intensity_prefectures',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => ObservedRegionLpgmIntensity.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      lpgmIntensityRegions: $checkedConvert(
        'lpgm_intensity_regions',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => ObservedRegionLpgmIntensity.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      lpgmIntenstiyStations: $checkedConvert(
        'lpgm_intenstiy_stations',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => ObservedRegionLpgmIntensity.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      magnitude: $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
      magnitudeCondition: $checkedConvert(
        'magnitude_condition',
        (v) => v as String?,
      ),
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      maxIntensityRegionIds: $checkedConvert(
        'max_intensity_region_ids',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      text: $checkedConvert('text', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'arrivalTime': 'arrival_time',
    'epicenterCode': 'epicenter_code',
    'epicenterDetailCode': 'epicenter_detail_code',
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
    'originTime': 'origin_time',
  },
);

Map<String, dynamic> _$EarthquakeV1ToJson(_EarthquakeV1 instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'status': instance.status,
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'depth': instance.depth,
      'epicenter_code': instance.epicenterCode,
      'epicenter_detail_code': instance.epicenterDetailCode,
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

_EarthquakeV1Base _$EarthquakeV1BaseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeV1Base',
  json,
  ($checkedConvert) {
    final val = _EarthquakeV1Base(
      eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
      status: $checkedConvert('status', (v) => v as String),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
      epicenterCode: $checkedConvert(
        'epicenter_code',
        (v) => (v as num?)?.toInt(),
      ),
      epicenterDetailCode: $checkedConvert(
        'epicenter_detail_code',
        (v) => (v as num?)?.toInt(),
      ),
      headline: $checkedConvert('headline', (v) => v as String?),
      latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
      longitude: $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
      magnitude: $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
      magnitudeCondition: $checkedConvert(
        'magnitude_condition',
        (v) => v as String?,
      ),
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      maxIntensityRegionIds: $checkedConvert(
        'max_intensity_region_ids',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      text: $checkedConvert('text', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'arrivalTime': 'arrival_time',
    'epicenterCode': 'epicenter_code',
    'epicenterDetailCode': 'epicenter_detail_code',
    'magnitudeCondition': 'magnitude_condition',
    'maxIntensity': 'max_intensity',
    'maxIntensityRegionIds': 'max_intensity_region_ids',
    'maxLpgmIntensity': 'max_lpgm_intensity',
    'originTime': 'origin_time',
  },
);

Map<String, dynamic> _$EarthquakeV1BaseToJson(_EarthquakeV1Base instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'status': instance.status,
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'depth': instance.depth,
      'epicenter_code': instance.epicenterCode,
      'epicenter_detail_code': instance.epicenterDetailCode,
      'headline': instance.headline,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'magnitude': instance.magnitude,
      'magnitude_condition': instance.magnitudeCondition,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
      'max_intensity_region_ids': instance.maxIntensityRegionIds,
      'max_lpgm_intensity': _$JmaLgIntensityEnumMap[instance.maxLpgmIntensity],
      'origin_time': instance.originTime?.toIso8601String(),
      'text': instance.text,
    };

_ObservedRegionIntensity _$ObservedRegionIntensityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ObservedRegionIntensity', json, ($checkedConvert) {
  final val = _ObservedRegionIntensity(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    intensity: $checkedConvert(
      'maxInt',
      (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
    ),
  );
  return val;
}, fieldKeyMap: const {'intensity': 'maxInt'});

Map<String, dynamic> _$ObservedRegionIntensityToJson(
  _ObservedRegionIntensity instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'maxInt': _$JmaIntensityEnumMap[instance.intensity],
};

_ObservedRegionLpgmIntensity _$ObservedRegionLpgmIntensityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ObservedRegionLpgmIntensity',
  json,
  ($checkedConvert) {
    final val = _ObservedRegionLpgmIntensity(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      intensity: $checkedConvert(
        'maxInt',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      lpgmIntensity: $checkedConvert(
        'maxLgInt',
        (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'intensity': 'maxInt', 'lpgmIntensity': 'maxLgInt'},
);

Map<String, dynamic> _$ObservedRegionLpgmIntensityToJson(
  _ObservedRegionLpgmIntensity instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'maxInt': _$JmaIntensityEnumMap[instance.intensity],
  'maxLgInt': _$JmaLgIntensityEnumMap[instance.lpgmIntensity],
};
