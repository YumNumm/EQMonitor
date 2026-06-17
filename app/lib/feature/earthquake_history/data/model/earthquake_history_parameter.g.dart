// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeHistoryParameter _$EarthquakeHistoryParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeHistoryParameter',
  json,
  ($checkedConvert) {
    final val = _EarthquakeHistoryParameter(
      magnitudeLte: $checkedConvert(
        'magnitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      magnitudeGte: $checkedConvert(
        'magnitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      depthLte: $checkedConvert('depth_lte', (v) => (v as num?)?.toInt()),
      depthGte: $checkedConvert('depth_gte', (v) => (v as num?)?.toInt()),
      intensityLte: $checkedConvert(
        'intensity_lte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      intensityGte: $checkedConvert(
        'intensity_gte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      statuses: $checkedConvert(
        'statuses',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$TelegramStatusEnumMap, e))
            .toList(),
      ),
      epicenterCode: $checkedConvert(
        'epicenter_code',
        (v) => (v as num?)?.toInt(),
      ),
      epicenterName: $checkedConvert('epicenter_name', (v) => v as String?),
      regionSearchType: $checkedConvert(
        'region_search_type',
        (v) => $enumDecodeNullable(_$RegionSearchTypeEnumMap, v),
      ),
      regionCode: $checkedConvert('region_code', (v) => v as String?),
      regionName: $checkedConvert('region_name', (v) => v as String?),
      regionIntensityLte: $checkedConvert(
        'region_intensity_lte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      regionIntensityGte: $checkedConvert(
        'region_intensity_gte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      earthquakeType: $checkedConvert(
        'earthquake_type',
        (v) => $enumDecodeNullable(_$EarthquakeTypeEnumMap, v),
      ),
      originTimeGte: $checkedConvert(
        'origin_time_gte',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      originTimeLte: $checkedConvert(
        'origin_time_lte',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      maxLpgmIntensityGte: $checkedConvert(
        'max_lpgm_intensity_gte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      maxLpgmIntensityLte: $checkedConvert(
        'max_lpgm_intensity_lte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      sortBy: $checkedConvert(
        'sort_by',
        (v) => $enumDecodeNullable(_$EarthquakeSortByEnumMap, v),
      ),
      sortOrder: $checkedConvert(
        'sort_order',
        (v) => $enumDecodeNullable(_$SortOrderEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'magnitudeLte': 'magnitude_lte',
    'magnitudeGte': 'magnitude_gte',
    'depthLte': 'depth_lte',
    'depthGte': 'depth_gte',
    'intensityLte': 'intensity_lte',
    'intensityGte': 'intensity_gte',
    'epicenterCode': 'epicenter_code',
    'epicenterName': 'epicenter_name',
    'regionSearchType': 'region_search_type',
    'regionCode': 'region_code',
    'regionName': 'region_name',
    'regionIntensityLte': 'region_intensity_lte',
    'regionIntensityGte': 'region_intensity_gte',
    'earthquakeType': 'earthquake_type',
    'originTimeGte': 'origin_time_gte',
    'originTimeLte': 'origin_time_lte',
    'maxLpgmIntensityGte': 'max_lpgm_intensity_gte',
    'maxLpgmIntensityLte': 'max_lpgm_intensity_lte',
    'sortBy': 'sort_by',
    'sortOrder': 'sort_order',
  },
);

Map<String, dynamic> _$EarthquakeHistoryParameterToJson(
  _EarthquakeHistoryParameter instance,
) => <String, dynamic>{
  'magnitude_lte': instance.magnitudeLte,
  'magnitude_gte': instance.magnitudeGte,
  'depth_lte': instance.depthLte,
  'depth_gte': instance.depthGte,
  'intensity_lte': _$JmaIntensityEnumMap[instance.intensityLte],
  'intensity_gte': _$JmaIntensityEnumMap[instance.intensityGte],
  'statuses': instance.statuses,
  'epicenter_code': instance.epicenterCode,
  'epicenter_name': instance.epicenterName,
  'region_search_type': _$RegionSearchTypeEnumMap[instance.regionSearchType],
  'region_code': instance.regionCode,
  'region_name': instance.regionName,
  'region_intensity_lte': _$JmaIntensityEnumMap[instance.regionIntensityLte],
  'region_intensity_gte': _$JmaIntensityEnumMap[instance.regionIntensityGte],
  'earthquake_type': _$EarthquakeTypeEnumMap[instance.earthquakeType],
  'origin_time_gte': instance.originTimeGte?.toIso8601String(),
  'origin_time_lte': instance.originTimeLte?.toIso8601String(),
  'max_lpgm_intensity_gte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityGte],
  'max_lpgm_intensity_lte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityLte],
  'sort_by': _$EarthquakeSortByEnumMap[instance.sortBy],
  'sort_order': _$SortOrderEnumMap[instance.sortOrder],
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$RegionSearchTypeEnumMap = {
  RegionSearchType.prefecture: 'prefecture',
  RegionSearchType.city: 'city',
};

const _$EarthquakeTypeEnumMap = {
  EarthquakeType.normal: 'NORMAL',
  EarthquakeType.distant: 'DISTANT',
  EarthquakeType.volcano: 'VOLCANO',
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};

const _$EarthquakeSortByEnumMap = {
  EarthquakeSortBy.eventId: 'eventId',
  EarthquakeSortBy.magnitude: 'magnitude',
  EarthquakeSortBy.maxIntensity: 'maxIntensity',
  EarthquakeSortBy.maxLpgmIntensity: 'maxLpgmIntensity',
  EarthquakeSortBy.depth: 'depth',
  EarthquakeSortBy.originTime: 'originTime',
};

const _$SortOrderEnumMap = {SortOrder.asc: 'asc', SortOrder.desc: 'desc'};
