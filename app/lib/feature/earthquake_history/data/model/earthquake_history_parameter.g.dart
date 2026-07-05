// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakeHistoryParameterAll _$EarthquakeHistoryParameterAllFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeHistoryParameterAll',
  json,
  ($checkedConvert) {
    final val = EarthquakeHistoryParameterAll(
      sortBy: $checkedConvert(
        'sort_by',
        (v) => $enumDecode(_$EarthquakeSortByEnumMap, v),
      ),
      sortOrder: $checkedConvert(
        'sort_order',
        (v) => $enumDecode(_$SortOrderEnumMap, v),
      ),
      magnitudeGte: $checkedConvert(
        'magnitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      magnitudeLte: $checkedConvert(
        'magnitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      depthGte: $checkedConvert('depth_gte', (v) => (v as num?)?.toInt()),
      depthLte: $checkedConvert('depth_lte', (v) => (v as num?)?.toInt()),
      intensityGte: $checkedConvert(
        'intensity_gte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      intensityLte: $checkedConvert(
        'intensity_lte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      statuses: $checkedConvert(
        'statuses',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$TelegramStatusEnumMap, e))
            .toList(),
      ),
      epicenterCodes: $checkedConvert(
        'epicenter_codes',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
      ),
      earthquakeType: $checkedConvert(
        'earthquake_type',
        (v) => $enumDecodeNullable(_$EarthquakeTypeEnumMap, v),
      ),
      datasource: $checkedConvert(
        'datasource',
        (v) => $enumDecodeNullable(_$EarthquakeDataSourceEnumMap, v),
      ),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, e))
            .toList(),
      ),
      originTimeGte: $checkedConvert(
        'origin_time_gte',
        (v) => v == null ? null : Date.fromJson(v),
      ),
      originTimeLte: $checkedConvert(
        'origin_time_lte',
        (v) => v == null ? null : Date.fromJson(v),
      ),
      maxLpgmIntensityGte: $checkedConvert(
        'max_lpgm_intensity_gte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      maxLpgmIntensityLte: $checkedConvert(
        'max_lpgm_intensity_lte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      latitudeGte: $checkedConvert(
        'latitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      latitudeLte: $checkedConvert(
        'latitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      longitudeGte: $checkedConvert(
        'longitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      longitudeLte: $checkedConvert(
        'longitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'sortBy': 'sort_by',
    'sortOrder': 'sort_order',
    'magnitudeGte': 'magnitude_gte',
    'magnitudeLte': 'magnitude_lte',
    'depthGte': 'depth_gte',
    'depthLte': 'depth_lte',
    'intensityGte': 'intensity_gte',
    'intensityLte': 'intensity_lte',
    'epicenterCodes': 'epicenter_codes',
    'earthquakeType': 'earthquake_type',
    'telegramTypes': 'telegram_types',
    'originTimeGte': 'origin_time_gte',
    'originTimeLte': 'origin_time_lte',
    'maxLpgmIntensityGte': 'max_lpgm_intensity_gte',
    'maxLpgmIntensityLte': 'max_lpgm_intensity_lte',
    'latitudeGte': 'latitude_gte',
    'latitudeLte': 'latitude_lte',
    'longitudeGte': 'longitude_gte',
    'longitudeLte': 'longitude_lte',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakeHistoryParameterAllToJson(
  EarthquakeHistoryParameterAll instance,
) => <String, dynamic>{
  'sort_by': _$EarthquakeSortByEnumMap[instance.sortBy]!,
  'sort_order': _$SortOrderEnumMap[instance.sortOrder]!,
  'magnitude_gte': instance.magnitudeGte,
  'magnitude_lte': instance.magnitudeLte,
  'depth_gte': instance.depthGte,
  'depth_lte': instance.depthLte,
  'intensity_gte': _$JmaIntensityEnumMap[instance.intensityGte],
  'intensity_lte': _$JmaIntensityEnumMap[instance.intensityLte],
  'statuses': instance.statuses
      ?.map((e) => _$TelegramStatusEnumMap[e]!)
      .toList(),
  'epicenter_codes': instance.epicenterCodes,
  'earthquake_type': _$EarthquakeTypeEnumMap[instance.earthquakeType],
  'datasource': _$EarthquakeDataSourceEnumMap[instance.datasource],
  'telegram_types': instance.telegramTypes
      ?.map((e) => _$EarthquakeTelegramTypeEnumMap[e]!)
      .toList(),
  'origin_time_gte': instance.originTimeGte,
  'origin_time_lte': instance.originTimeLte,
  'max_lpgm_intensity_gte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityGte],
  'max_lpgm_intensity_lte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityLte],
  'latitude_gte': instance.latitudeGte,
  'latitude_lte': instance.latitudeLte,
  'longitude_gte': instance.longitudeGte,
  'longitude_lte': instance.longitudeLte,
  'runtimeType': instance.$type,
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

const _$EarthquakeTypeEnumMap = {
  EarthquakeType.normal: 'NORMAL',
  EarthquakeType.distant: 'DISTANT',
  EarthquakeType.volcano: 'VOLCANO',
};

const _$EarthquakeDataSourceEnumMap = {
  EarthquakeDataSource.jmaIntensityDatabase: 'JMA_INTENSITY_DATABASE',
  EarthquakeDataSource.jmaDisasterInformationXml:
      'JMA_DISASTER_INFORMATION_XML',
};

const _$EarthquakeTelegramTypeEnumMap = {
  EarthquakeTelegramType.vxse51: 'vxse51',
  EarthquakeTelegramType.vxse52: 'vxse52',
  EarthquakeTelegramType.vxse53: 'vxse53',
  EarthquakeTelegramType.vxse61: 'vxse61',
  EarthquakeTelegramType.vxse62: 'vxse62',
  EarthquakeTelegramType.vxse45Forecast: 'vxse45Forecast',
  EarthquakeTelegramType.vxse45Warning: 'vxse45Warning',
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};

EarthquakeHistoryParameterPrefecture
_$EarthquakeHistoryParameterPrefectureFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'EarthquakeHistoryParameterPrefecture',
      json,
      ($checkedConvert) {
        final val = EarthquakeHistoryParameterPrefecture(
          sortBy: $checkedConvert(
            'sort_by',
            (v) => $enumDecode(_$EarthquakeSortByEnumMap, v),
          ),
          sortOrder: $checkedConvert(
            'sort_order',
            (v) => $enumDecode(_$SortOrderEnumMap, v),
          ),
          prefectureCode: $checkedConvert(
            'prefecture_code',
            (v) => v as String,
          ),
          limit: $checkedConvert('limit', (v) => (v as num?)?.toInt()),
          cursor: $checkedConvert('cursor', (v) => v as String?),
          magnitudeGte: $checkedConvert(
            'magnitude_gte',
            (v) => (v as num?)?.toDouble(),
          ),
          magnitudeLte: $checkedConvert(
            'magnitude_lte',
            (v) => (v as num?)?.toDouble(),
          ),
          depthGte: $checkedConvert('depth_gte', (v) => (v as num?)?.toInt()),
          depthLte: $checkedConvert('depth_lte', (v) => (v as num?)?.toInt()),
          intensityGte: $checkedConvert(
            'intensity_gte',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          intensityLte: $checkedConvert(
            'intensity_lte',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          statuses: $checkedConvert(
            'statuses',
            (v) => (v as List<dynamic>?)
                ?.map((e) => $enumDecode(_$TelegramStatusEnumMap, e))
                .toList(),
          ),
          epicenterCodes: $checkedConvert(
            'epicenter_codes',
            (v) =>
                (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
          ),
          earthquakeType: $checkedConvert(
            'earthquake_type',
            (v) => $enumDecodeNullable(_$EarthquakeTypeEnumMap, v),
          ),
          datasource: $checkedConvert(
            'datasource',
            (v) => $enumDecodeNullable(_$EarthquakeDataSourceEnumMap, v),
          ),
          telegramTypes: $checkedConvert(
            'telegram_types',
            (v) => (v as List<dynamic>?)
                ?.map((e) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, e))
                .toList(),
          ),
          originTimeGte: $checkedConvert(
            'origin_time_gte',
            (v) => v == null ? null : Date.fromJson(v),
          ),
          originTimeLte: $checkedConvert(
            'origin_time_lte',
            (v) => v == null ? null : Date.fromJson(v),
          ),
          maxLpgmIntensityGte: $checkedConvert(
            'max_lpgm_intensity_gte',
            (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
          ),
          maxLpgmIntensityLte: $checkedConvert(
            'max_lpgm_intensity_lte',
            (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
          ),
          latitudeGte: $checkedConvert(
            'latitude_gte',
            (v) => (v as num?)?.toDouble(),
          ),
          latitudeLte: $checkedConvert(
            'latitude_lte',
            (v) => (v as num?)?.toDouble(),
          ),
          longitudeGte: $checkedConvert(
            'longitude_gte',
            (v) => (v as num?)?.toDouble(),
          ),
          longitudeLte: $checkedConvert(
            'longitude_lte',
            (v) => (v as num?)?.toDouble(),
          ),
          $type: $checkedConvert('runtimeType', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'sortBy': 'sort_by',
        'sortOrder': 'sort_order',
        'prefectureCode': 'prefecture_code',
        'magnitudeGte': 'magnitude_gte',
        'magnitudeLte': 'magnitude_lte',
        'depthGte': 'depth_gte',
        'depthLte': 'depth_lte',
        'intensityGte': 'intensity_gte',
        'intensityLte': 'intensity_lte',
        'epicenterCodes': 'epicenter_codes',
        'earthquakeType': 'earthquake_type',
        'telegramTypes': 'telegram_types',
        'originTimeGte': 'origin_time_gte',
        'originTimeLte': 'origin_time_lte',
        'maxLpgmIntensityGte': 'max_lpgm_intensity_gte',
        'maxLpgmIntensityLte': 'max_lpgm_intensity_lte',
        'latitudeGte': 'latitude_gte',
        'latitudeLte': 'latitude_lte',
        'longitudeGte': 'longitude_gte',
        'longitudeLte': 'longitude_lte',
        r'$type': 'runtimeType',
      },
    );

Map<String, dynamic> _$EarthquakeHistoryParameterPrefectureToJson(
  EarthquakeHistoryParameterPrefecture instance,
) => <String, dynamic>{
  'sort_by': _$EarthquakeSortByEnumMap[instance.sortBy]!,
  'sort_order': _$SortOrderEnumMap[instance.sortOrder]!,
  'prefecture_code': instance.prefectureCode,
  'limit': instance.limit,
  'cursor': instance.cursor,
  'magnitude_gte': instance.magnitudeGte,
  'magnitude_lte': instance.magnitudeLte,
  'depth_gte': instance.depthGte,
  'depth_lte': instance.depthLte,
  'intensity_gte': _$JmaIntensityEnumMap[instance.intensityGte],
  'intensity_lte': _$JmaIntensityEnumMap[instance.intensityLte],
  'statuses': instance.statuses
      ?.map((e) => _$TelegramStatusEnumMap[e]!)
      .toList(),
  'epicenter_codes': instance.epicenterCodes,
  'earthquake_type': _$EarthquakeTypeEnumMap[instance.earthquakeType],
  'datasource': _$EarthquakeDataSourceEnumMap[instance.datasource],
  'telegram_types': instance.telegramTypes
      ?.map((e) => _$EarthquakeTelegramTypeEnumMap[e]!)
      .toList(),
  'origin_time_gte': instance.originTimeGte,
  'origin_time_lte': instance.originTimeLte,
  'max_lpgm_intensity_gte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityGte],
  'max_lpgm_intensity_lte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityLte],
  'latitude_gte': instance.latitudeGte,
  'latitude_lte': instance.latitudeLte,
  'longitude_gte': instance.longitudeGte,
  'longitude_lte': instance.longitudeLte,
  'runtimeType': instance.$type,
};

EarthquakeHistoryParameterRegion _$EarthquakeHistoryParameterRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeHistoryParameterRegion',
  json,
  ($checkedConvert) {
    final val = EarthquakeHistoryParameterRegion(
      sortBy: $checkedConvert(
        'sort_by',
        (v) => $enumDecode(_$EarthquakeSortByEnumMap, v),
      ),
      sortOrder: $checkedConvert(
        'sort_order',
        (v) => $enumDecode(_$SortOrderEnumMap, v),
      ),
      regionCode: $checkedConvert('region_code', (v) => v as String),
      limit: $checkedConvert('limit', (v) => (v as num?)?.toInt()),
      cursor: $checkedConvert('cursor', (v) => v as String?),
      magnitudeGte: $checkedConvert(
        'magnitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      magnitudeLte: $checkedConvert(
        'magnitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      depthGte: $checkedConvert('depth_gte', (v) => (v as num?)?.toInt()),
      depthLte: $checkedConvert('depth_lte', (v) => (v as num?)?.toInt()),
      intensityGte: $checkedConvert(
        'intensity_gte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      intensityLte: $checkedConvert(
        'intensity_lte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      statuses: $checkedConvert(
        'statuses',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$TelegramStatusEnumMap, e))
            .toList(),
      ),
      epicenterCodes: $checkedConvert(
        'epicenter_codes',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
      ),
      earthquakeType: $checkedConvert(
        'earthquake_type',
        (v) => $enumDecodeNullable(_$EarthquakeTypeEnumMap, v),
      ),
      datasource: $checkedConvert(
        'datasource',
        (v) => $enumDecodeNullable(_$EarthquakeDataSourceEnumMap, v),
      ),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, e))
            .toList(),
      ),
      originTimeGte: $checkedConvert(
        'origin_time_gte',
        (v) => v == null ? null : Date.fromJson(v),
      ),
      originTimeLte: $checkedConvert(
        'origin_time_lte',
        (v) => v == null ? null : Date.fromJson(v),
      ),
      maxLpgmIntensityGte: $checkedConvert(
        'max_lpgm_intensity_gte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      maxLpgmIntensityLte: $checkedConvert(
        'max_lpgm_intensity_lte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      latitudeGte: $checkedConvert(
        'latitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      latitudeLte: $checkedConvert(
        'latitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      longitudeGte: $checkedConvert(
        'longitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      longitudeLte: $checkedConvert(
        'longitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'sortBy': 'sort_by',
    'sortOrder': 'sort_order',
    'regionCode': 'region_code',
    'magnitudeGte': 'magnitude_gte',
    'magnitudeLte': 'magnitude_lte',
    'depthGte': 'depth_gte',
    'depthLte': 'depth_lte',
    'intensityGte': 'intensity_gte',
    'intensityLte': 'intensity_lte',
    'epicenterCodes': 'epicenter_codes',
    'earthquakeType': 'earthquake_type',
    'telegramTypes': 'telegram_types',
    'originTimeGte': 'origin_time_gte',
    'originTimeLte': 'origin_time_lte',
    'maxLpgmIntensityGte': 'max_lpgm_intensity_gte',
    'maxLpgmIntensityLte': 'max_lpgm_intensity_lte',
    'latitudeGte': 'latitude_gte',
    'latitudeLte': 'latitude_lte',
    'longitudeGte': 'longitude_gte',
    'longitudeLte': 'longitude_lte',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakeHistoryParameterRegionToJson(
  EarthquakeHistoryParameterRegion instance,
) => <String, dynamic>{
  'sort_by': _$EarthquakeSortByEnumMap[instance.sortBy]!,
  'sort_order': _$SortOrderEnumMap[instance.sortOrder]!,
  'region_code': instance.regionCode,
  'limit': instance.limit,
  'cursor': instance.cursor,
  'magnitude_gte': instance.magnitudeGte,
  'magnitude_lte': instance.magnitudeLte,
  'depth_gte': instance.depthGte,
  'depth_lte': instance.depthLte,
  'intensity_gte': _$JmaIntensityEnumMap[instance.intensityGte],
  'intensity_lte': _$JmaIntensityEnumMap[instance.intensityLte],
  'statuses': instance.statuses
      ?.map((e) => _$TelegramStatusEnumMap[e]!)
      .toList(),
  'epicenter_codes': instance.epicenterCodes,
  'earthquake_type': _$EarthquakeTypeEnumMap[instance.earthquakeType],
  'datasource': _$EarthquakeDataSourceEnumMap[instance.datasource],
  'telegram_types': instance.telegramTypes
      ?.map((e) => _$EarthquakeTelegramTypeEnumMap[e]!)
      .toList(),
  'origin_time_gte': instance.originTimeGte,
  'origin_time_lte': instance.originTimeLte,
  'max_lpgm_intensity_gte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityGte],
  'max_lpgm_intensity_lte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityLte],
  'latitude_gte': instance.latitudeGte,
  'latitude_lte': instance.latitudeLte,
  'longitude_gte': instance.longitudeGte,
  'longitude_lte': instance.longitudeLte,
  'runtimeType': instance.$type,
};

EarthquakeHistoryParameterCity _$EarthquakeHistoryParameterCityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeHistoryParameterCity',
  json,
  ($checkedConvert) {
    final val = EarthquakeHistoryParameterCity(
      sortBy: $checkedConvert(
        'sort_by',
        (v) => $enumDecode(_$EarthquakeSortByEnumMap, v),
      ),
      sortOrder: $checkedConvert(
        'sort_order',
        (v) => $enumDecode(_$SortOrderEnumMap, v),
      ),
      cityCode: $checkedConvert('city_code', (v) => v as String),
      limit: $checkedConvert('limit', (v) => (v as num?)?.toInt()),
      cursor: $checkedConvert('cursor', (v) => v as String?),
      magnitudeGte: $checkedConvert(
        'magnitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      magnitudeLte: $checkedConvert(
        'magnitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      depthGte: $checkedConvert('depth_gte', (v) => (v as num?)?.toInt()),
      depthLte: $checkedConvert('depth_lte', (v) => (v as num?)?.toInt()),
      intensityGte: $checkedConvert(
        'intensity_gte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      intensityLte: $checkedConvert(
        'intensity_lte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      statuses: $checkedConvert(
        'statuses',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$TelegramStatusEnumMap, e))
            .toList(),
      ),
      epicenterCodes: $checkedConvert(
        'epicenter_codes',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
      ),
      earthquakeType: $checkedConvert(
        'earthquake_type',
        (v) => $enumDecodeNullable(_$EarthquakeTypeEnumMap, v),
      ),
      datasource: $checkedConvert(
        'datasource',
        (v) => $enumDecodeNullable(_$EarthquakeDataSourceEnumMap, v),
      ),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, e))
            .toList(),
      ),
      originTimeGte: $checkedConvert(
        'origin_time_gte',
        (v) => v == null ? null : Date.fromJson(v),
      ),
      originTimeLte: $checkedConvert(
        'origin_time_lte',
        (v) => v == null ? null : Date.fromJson(v),
      ),
      maxLpgmIntensityGte: $checkedConvert(
        'max_lpgm_intensity_gte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      maxLpgmIntensityLte: $checkedConvert(
        'max_lpgm_intensity_lte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      latitudeGte: $checkedConvert(
        'latitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      latitudeLte: $checkedConvert(
        'latitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      longitudeGte: $checkedConvert(
        'longitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      longitudeLte: $checkedConvert(
        'longitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'sortBy': 'sort_by',
    'sortOrder': 'sort_order',
    'cityCode': 'city_code',
    'magnitudeGte': 'magnitude_gte',
    'magnitudeLte': 'magnitude_lte',
    'depthGte': 'depth_gte',
    'depthLte': 'depth_lte',
    'intensityGte': 'intensity_gte',
    'intensityLte': 'intensity_lte',
    'epicenterCodes': 'epicenter_codes',
    'earthquakeType': 'earthquake_type',
    'telegramTypes': 'telegram_types',
    'originTimeGte': 'origin_time_gte',
    'originTimeLte': 'origin_time_lte',
    'maxLpgmIntensityGte': 'max_lpgm_intensity_gte',
    'maxLpgmIntensityLte': 'max_lpgm_intensity_lte',
    'latitudeGte': 'latitude_gte',
    'latitudeLte': 'latitude_lte',
    'longitudeGte': 'longitude_gte',
    'longitudeLte': 'longitude_lte',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakeHistoryParameterCityToJson(
  EarthquakeHistoryParameterCity instance,
) => <String, dynamic>{
  'sort_by': _$EarthquakeSortByEnumMap[instance.sortBy]!,
  'sort_order': _$SortOrderEnumMap[instance.sortOrder]!,
  'city_code': instance.cityCode,
  'limit': instance.limit,
  'cursor': instance.cursor,
  'magnitude_gte': instance.magnitudeGte,
  'magnitude_lte': instance.magnitudeLte,
  'depth_gte': instance.depthGte,
  'depth_lte': instance.depthLte,
  'intensity_gte': _$JmaIntensityEnumMap[instance.intensityGte],
  'intensity_lte': _$JmaIntensityEnumMap[instance.intensityLte],
  'statuses': instance.statuses
      ?.map((e) => _$TelegramStatusEnumMap[e]!)
      .toList(),
  'epicenter_codes': instance.epicenterCodes,
  'earthquake_type': _$EarthquakeTypeEnumMap[instance.earthquakeType],
  'datasource': _$EarthquakeDataSourceEnumMap[instance.datasource],
  'telegram_types': instance.telegramTypes
      ?.map((e) => _$EarthquakeTelegramTypeEnumMap[e]!)
      .toList(),
  'origin_time_gte': instance.originTimeGte,
  'origin_time_lte': instance.originTimeLte,
  'max_lpgm_intensity_gte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityGte],
  'max_lpgm_intensity_lte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityLte],
  'latitude_gte': instance.latitudeGte,
  'latitude_lte': instance.latitudeLte,
  'longitude_gte': instance.longitudeGte,
  'longitude_lte': instance.longitudeLte,
  'runtimeType': instance.$type,
};

EarthquakeHistoryParameterStation _$EarthquakeHistoryParameterStationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeHistoryParameterStation',
  json,
  ($checkedConvert) {
    final val = EarthquakeHistoryParameterStation(
      sortBy: $checkedConvert(
        'sort_by',
        (v) => $enumDecode(_$EarthquakeSortByEnumMap, v),
      ),
      sortOrder: $checkedConvert(
        'sort_order',
        (v) => $enumDecode(_$SortOrderEnumMap, v),
      ),
      stationCode: $checkedConvert('station_code', (v) => v as String),
      limit: $checkedConvert('limit', (v) => (v as num?)?.toInt()),
      cursor: $checkedConvert('cursor', (v) => v as String?),
      magnitudeGte: $checkedConvert(
        'magnitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      magnitudeLte: $checkedConvert(
        'magnitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      depthGte: $checkedConvert('depth_gte', (v) => (v as num?)?.toInt()),
      depthLte: $checkedConvert('depth_lte', (v) => (v as num?)?.toInt()),
      intensityGte: $checkedConvert(
        'intensity_gte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      intensityLte: $checkedConvert(
        'intensity_lte',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      statuses: $checkedConvert(
        'statuses',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$TelegramStatusEnumMap, e))
            .toList(),
      ),
      epicenterCodes: $checkedConvert(
        'epicenter_codes',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
      ),
      earthquakeType: $checkedConvert(
        'earthquake_type',
        (v) => $enumDecodeNullable(_$EarthquakeTypeEnumMap, v),
      ),
      datasource: $checkedConvert(
        'datasource',
        (v) => $enumDecodeNullable(_$EarthquakeDataSourceEnumMap, v),
      ),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>?)
            ?.map((e) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, e))
            .toList(),
      ),
      originTimeGte: $checkedConvert(
        'origin_time_gte',
        (v) => v == null ? null : Date.fromJson(v),
      ),
      originTimeLte: $checkedConvert(
        'origin_time_lte',
        (v) => v == null ? null : Date.fromJson(v),
      ),
      maxLpgmIntensityGte: $checkedConvert(
        'max_lpgm_intensity_gte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      maxLpgmIntensityLte: $checkedConvert(
        'max_lpgm_intensity_lte',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      latitudeGte: $checkedConvert(
        'latitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      latitudeLte: $checkedConvert(
        'latitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      longitudeGte: $checkedConvert(
        'longitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      longitudeLte: $checkedConvert(
        'longitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'sortBy': 'sort_by',
    'sortOrder': 'sort_order',
    'stationCode': 'station_code',
    'magnitudeGte': 'magnitude_gte',
    'magnitudeLte': 'magnitude_lte',
    'depthGte': 'depth_gte',
    'depthLte': 'depth_lte',
    'intensityGte': 'intensity_gte',
    'intensityLte': 'intensity_lte',
    'epicenterCodes': 'epicenter_codes',
    'earthquakeType': 'earthquake_type',
    'telegramTypes': 'telegram_types',
    'originTimeGte': 'origin_time_gte',
    'originTimeLte': 'origin_time_lte',
    'maxLpgmIntensityGte': 'max_lpgm_intensity_gte',
    'maxLpgmIntensityLte': 'max_lpgm_intensity_lte',
    'latitudeGte': 'latitude_gte',
    'latitudeLte': 'latitude_lte',
    'longitudeGte': 'longitude_gte',
    'longitudeLte': 'longitude_lte',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakeHistoryParameterStationToJson(
  EarthquakeHistoryParameterStation instance,
) => <String, dynamic>{
  'sort_by': _$EarthquakeSortByEnumMap[instance.sortBy]!,
  'sort_order': _$SortOrderEnumMap[instance.sortOrder]!,
  'station_code': instance.stationCode,
  'limit': instance.limit,
  'cursor': instance.cursor,
  'magnitude_gte': instance.magnitudeGte,
  'magnitude_lte': instance.magnitudeLte,
  'depth_gte': instance.depthGte,
  'depth_lte': instance.depthLte,
  'intensity_gte': _$JmaIntensityEnumMap[instance.intensityGte],
  'intensity_lte': _$JmaIntensityEnumMap[instance.intensityLte],
  'statuses': instance.statuses
      ?.map((e) => _$TelegramStatusEnumMap[e]!)
      .toList(),
  'epicenter_codes': instance.epicenterCodes,
  'earthquake_type': _$EarthquakeTypeEnumMap[instance.earthquakeType],
  'datasource': _$EarthquakeDataSourceEnumMap[instance.datasource],
  'telegram_types': instance.telegramTypes
      ?.map((e) => _$EarthquakeTelegramTypeEnumMap[e]!)
      .toList(),
  'origin_time_gte': instance.originTimeGte,
  'origin_time_lte': instance.originTimeLte,
  'max_lpgm_intensity_gte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityGte],
  'max_lpgm_intensity_lte':
      _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensityLte],
  'latitude_gte': instance.latitudeGte,
  'latitude_lte': instance.latitudeLte,
  'longitude_gte': instance.longitudeGte,
  'longitude_lte': instance.longitudeLte,
  'runtimeType': instance.$type,
};
