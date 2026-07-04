// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_partial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakePartialNormal _$EarthquakePartialNormalFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakePartialNormal',
  json,
  ($checkedConvert) {
    final val = EarthquakePartialNormal(
      eventId: $checkedConvert('event_id', (v) => v as String),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      originTimePrecision: $checkedConvert(
        'origin_time_precision',
        (v) => $enumDecode(_$OriginTimePrecisionEnumMap, v),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      dataSources: $checkedConvert(
        'data_sources',
        (v) => (v as List<dynamic>)
            .map((e) => $enumDecode(_$EarthquakeDataSourceEnumMap, e))
            .toList(),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => v == null
            ? null
            : EarthquakeHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      intensity: $checkedConvert(
        'intensity',
        (v) => v == null
            ? null
            : EarthquakeIntensityPartial.fromJson(v as Map<String, dynamic>),
      ),
      earthquakeType: $checkedConvert(
        'earthquake_type',
        (v) => $enumDecode(_$EarthquakeTypeEnumMap, v),
      ),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>)
            .map((e) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, e))
            .toList(),
      ),
      estimatedIntensityTileUrl: $checkedConvert(
        'estimated_intensity_tile_url',
        (v) => v as String?,
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'originTime': 'origin_time',
    'originTimePrecision': 'origin_time_precision',
    'arrivalTime': 'arrival_time',
    'dataSources': 'data_sources',
    'earthquakeType': 'earthquake_type',
    'telegramTypes': 'telegram_types',
    'estimatedIntensityTileUrl': 'estimated_intensity_tile_url',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakePartialNormalToJson(
  EarthquakePartialNormal instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'status': _$TelegramStatusEnumMap[instance.status]!,
  'origin_time': instance.originTime?.toIso8601String(),
  'origin_time_precision':
      _$OriginTimePrecisionEnumMap[instance.originTimePrecision]!,
  'arrival_time': instance.arrivalTime?.toIso8601String(),
  'data_sources': instance.dataSources
      .map((e) => _$EarthquakeDataSourceEnumMap[e]!)
      .toList(),
  'hypocenter': instance.hypocenter,
  'intensity': instance.intensity,
  'earthquake_type': _$EarthquakeTypeEnumMap[instance.earthquakeType]!,
  'telegram_types': instance.telegramTypes
      .map((e) => _$EarthquakeTelegramTypeEnumMap[e]!)
      .toList(),
  'estimated_intensity_tile_url': instance.estimatedIntensityTileUrl,
  'runtimeType': instance.$type,
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$OriginTimePrecisionEnumMap = {
  OriginTimePrecision.millisecond: 'MILLISECOND',
  OriginTimePrecision.second: 'SECOND',
  OriginTimePrecision.minute: 'MINUTE',
  OriginTimePrecision.hour: 'HOUR',
  OriginTimePrecision.day: 'DAY',
  OriginTimePrecision.month: 'MONTH',
};

const _$EarthquakeDataSourceEnumMap = {
  EarthquakeDataSource.jmaIntensityDatabase: 'JMA_INTENSITY_DATABASE',
  EarthquakeDataSource.jmaDisasterInformationXml:
      'JMA_DISASTER_INFORMATION_XML',
};

const _$EarthquakeTypeEnumMap = {
  EarthquakeType.normal: 'NORMAL',
  EarthquakeType.distant: 'DISTANT',
  EarthquakeType.volcano: 'VOLCANO',
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

EarthquakePartialPrefecture _$EarthquakePartialPrefectureFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakePartialPrefecture',
  json,
  ($checkedConvert) {
    final val = EarthquakePartialPrefecture(
      prefectureIntensity: $checkedConvert(
        'prefecture_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      earthquake: $checkedConvert(
        'earthquake',
        (v) => EarthquakePartialNormal.fromJson(v as Map<String, dynamic>),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'prefectureIntensity': 'prefecture_intensity',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakePartialPrefectureToJson(
  EarthquakePartialPrefecture instance,
) => <String, dynamic>{
  'prefecture_intensity': _$JmaIntensityEnumMap[instance.prefectureIntensity]!,
  'earthquake': instance.earthquake,
  'runtimeType': instance.$type,
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

EarthquakePartialRegion _$EarthquakePartialRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakePartialRegion',
  json,
  ($checkedConvert) {
    final val = EarthquakePartialRegion(
      regionIntensity: $checkedConvert(
        'region_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      earthquake: $checkedConvert(
        'earthquake',
        (v) => EarthquakePartialNormal.fromJson(v as Map<String, dynamic>),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionIntensity': 'region_intensity',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakePartialRegionToJson(
  EarthquakePartialRegion instance,
) => <String, dynamic>{
  'region_intensity': _$JmaIntensityEnumMap[instance.regionIntensity]!,
  'earthquake': instance.earthquake,
  'runtimeType': instance.$type,
};

EarthquakePartialCity _$EarthquakePartialCityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakePartialCity',
  json,
  ($checkedConvert) {
    final val = EarthquakePartialCity(
      cityIntensity: $checkedConvert(
        'city_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      earthquake: $checkedConvert(
        'earthquake',
        (v) => EarthquakePartialNormal.fromJson(v as Map<String, dynamic>),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'cityIntensity': 'city_intensity',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakePartialCityToJson(
  EarthquakePartialCity instance,
) => <String, dynamic>{
  'city_intensity': _$JmaIntensityEnumMap[instance.cityIntensity]!,
  'earthquake': instance.earthquake,
  'runtimeType': instance.$type,
};

EarthquakePartialStation _$EarthquakePartialStationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakePartialStation',
  json,
  ($checkedConvert) {
    final val = EarthquakePartialStation(
      stationIntensity: $checkedConvert(
        'station_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      earthquake: $checkedConvert(
        'earthquake',
        (v) => EarthquakePartialNormal.fromJson(v as Map<String, dynamic>),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'stationIntensity': 'station_intensity',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakePartialStationToJson(
  EarthquakePartialStation instance,
) => <String, dynamic>{
  'station_intensity': _$JmaIntensityEnumMap[instance.stationIntensity]!,
  'earthquake': instance.earthquake,
  'runtimeType': instance.$type,
};

_IntensityAreaInfo _$IntensityAreaInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_IntensityAreaInfo', json, ($checkedConvert) {
      final val = _IntensityAreaInfo(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert(
          'name',
          (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
        ),
        intensity: $checkedConvert(
          'intensity',
          (v) => $enumDecode(_$JmaIntensityEnumMap, v),
        ),
        lpgmIntensity: $checkedConvert(
          'lpgm_intensity',
          (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
        ),
      );
      return val;
    }, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$IntensityAreaInfoToJson(_IntensityAreaInfo instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'intensity': _$JmaIntensityEnumMap[instance.intensity]!,
      'lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.lpgmIntensity],
    };

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};

_StationSearchInfo _$StationSearchInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_StationSearchInfo',
      json,
      ($checkedConvert) {
        final val = _StationSearchInfo(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert(
            'name',
            (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
          ),
          intensity: $checkedConvert(
            'intensity',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
          ),
          sva: $checkedConvert('sva', (v) => (v as num?)?.toDouble()),
          prePeriods: $checkedConvert(
            'pre_periods',
            (v) => (v as List<dynamic>?)
                ?.map((e) => PrePeriod.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'lpgmIntensity': 'lpgm_intensity',
        'prePeriods': 'pre_periods',
      },
    );

Map<String, dynamic> _$StationSearchInfoToJson(_StationSearchInfo instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'intensity': _$JmaIntensityEnumMap[instance.intensity],
      'lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.lpgmIntensity],
      'sva': instance.sva,
      'pre_periods': instance.prePeriods,
    };
