// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeListResponse _$EarthquakeListResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeListResponse',
  json,
  ($checkedConvert) {
    final val = _EarthquakeListResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map((e) => EarthquakePartial.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$EarthquakeListResponseToJson(
  _EarthquakeListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': instance.nextToken,
  'next_pooling': instance.nextPooling,
};

_EarthquakeDetailResponse _$EarthquakeDetailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeDetailResponse', json, ($checkedConvert) {
  final val = _EarthquakeDetailResponse(
    earthquake: $checkedConvert(
      'earthquake',
      (v) => Earthquake.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeDetailResponseToJson(
  _EarthquakeDetailResponse instance,
) => <String, dynamic>{'earthquake': instance.earthquake};

_IntensityRegionInfo _$IntensityRegionInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityRegionInfo',
      json,
      ($checkedConvert) {
        final val = _IntensityRegionInfo(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          intensity: $checkedConvert(
            'intensity',
            (v) => $enumDecodeNullable(_$IntensityValueEnumMap, v),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => $enumDecodeNullable(_$LpgmIntensityValueEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'},
    );

Map<String, dynamic> _$IntensityRegionInfoToJson(
  _IntensityRegionInfo instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'intensity': _$IntensityValueEnumMap[instance.intensity],
  'lpgm_intensity': _$LpgmIntensityValueEnumMap[instance.lpgmIntensity],
};

const _$IntensityValueEnumMap = {
  IntensityValue.zero: '0',
  IntensityValue.one: '1',
  IntensityValue.two: '2',
  IntensityValue.three: '3',
  IntensityValue.four: '4',
  IntensityValue.fiveLowerNoInput: '!5-',
  IntensityValue.fiveLower: '5-',
  IntensityValue.fiveUpper: '5+',
  IntensityValue.sixLower: '6-',
  IntensityValue.sixUpper: '6+',
  IntensityValue.seven: '7',
};

const _$LpgmIntensityValueEnumMap = {
  LpgmIntensityValue.zero: '0',
  LpgmIntensityValue.one: '1',
  LpgmIntensityValue.two: '2',
  LpgmIntensityValue.three: '3',
  LpgmIntensityValue.four: '4',
};

_IntensityStationInfo _$IntensityStationInfoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityStationInfo',
  json,
  ($checkedConvert) {
    final val = _IntensityStationInfo(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      intensity: $checkedConvert(
        'intensity',
        (v) => $enumDecodeNullable(_$IntensityValueEnumMap, v),
      ),
      lpgmIntensity: $checkedConvert(
        'lpgm_intensity',
        (v) => $enumDecodeNullable(_$LpgmIntensityValueEnumMap, v),
      ),
      sva: $checkedConvert('sva', (v) => (v as num?)?.toDouble()),
      prePeriods: $checkedConvert(
        'pre_periods',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) =>
                  IntensityStationPrePeriod.fromJson(e as Map<String, dynamic>),
            )
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

Map<String, dynamic> _$IntensityStationInfoToJson(
  _IntensityStationInfo instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'intensity': _$IntensityValueEnumMap[instance.intensity],
  'lpgm_intensity': _$LpgmIntensityValueEnumMap[instance.lpgmIntensity],
  'sva': instance.sva,
  'pre_periods': instance.prePeriods,
};

_IntensityStationPrePeriod _$IntensityStationPrePeriodFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityStationPrePeriod',
  json,
  ($checkedConvert) {
    final val = _IntensityStationPrePeriod(
      band: $checkedConvert('band', (v) => (v as num).toInt()),
      lpgmIntensity: $checkedConvert('lpgm_intensity', (v) => v as String),
      sva: $checkedConvert('sva', (v) => (v as num).toDouble()),
    );
    return val;
  },
  fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'},
);

Map<String, dynamic> _$IntensityStationPrePeriodToJson(
  _IntensityStationPrePeriod instance,
) => <String, dynamic>{
  'band': instance.band,
  'lpgm_intensity': instance.lpgmIntensity,
  'sva': instance.sva,
};

_IntensityRegionSearchItem _$IntensityRegionSearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityRegionSearchItem', json, ($checkedConvert) {
  final val = _IntensityRegionSearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    region: $checkedConvert(
      'region',
      (v) => IntensityRegionInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityRegionSearchItemToJson(
  _IntensityRegionSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'region': instance.region,
  'earthquake': instance.earthquake,
};

_IntensityPrefectureSearchItem _$IntensityPrefectureSearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityPrefectureSearchItem', json, ($checkedConvert) {
  final val = _IntensityPrefectureSearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    prefecture: $checkedConvert(
      'prefecture',
      (v) => IntensityRegionInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityPrefectureSearchItemToJson(
  _IntensityPrefectureSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'prefecture': instance.prefecture,
  'earthquake': instance.earthquake,
};

_IntensityCitySearchItem _$IntensityCitySearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityCitySearchItem', json, ($checkedConvert) {
  final val = _IntensityCitySearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    city: $checkedConvert(
      'city',
      (v) => IntensityRegionInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityCitySearchItemToJson(
  _IntensityCitySearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'city': instance.city,
  'earthquake': instance.earthquake,
};

_IntensityStationSearchItem _$IntensityStationSearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityStationSearchItem', json, ($checkedConvert) {
  final val = _IntensityStationSearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    station: $checkedConvert(
      'station',
      (v) => IntensityStationInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityStationSearchItemToJson(
  _IntensityStationSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'station': instance.station,
  'earthquake': instance.earthquake,
};

_IntensityRegionSearchResponse _$IntensityRegionSearchResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityRegionSearchResponse',
  json,
  ($checkedConvert) {
    final val = _IntensityRegionSearchResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  IntensityRegionSearchItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$IntensityRegionSearchResponseToJson(
  _IntensityRegionSearchResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': instance.nextToken,
  'next_pooling': instance.nextPooling,
};

_IntensityPrefectureSearchResponse _$IntensityPrefectureSearchResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityPrefectureSearchResponse',
  json,
  ($checkedConvert) {
    final val = _IntensityPrefectureSearchResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map(
              (e) => IntensityPrefectureSearchItem.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$IntensityPrefectureSearchResponseToJson(
  _IntensityPrefectureSearchResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': instance.nextToken,
  'next_pooling': instance.nextPooling,
};

_IntensityCitySearchResponse _$IntensityCitySearchResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityCitySearchResponse',
  json,
  ($checkedConvert) {
    final val = _IntensityCitySearchResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  IntensityCitySearchItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$IntensityCitySearchResponseToJson(
  _IntensityCitySearchResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': instance.nextToken,
  'next_pooling': instance.nextPooling,
};

_IntensityStationSearchResponse _$IntensityStationSearchResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityStationSearchResponse',
  json,
  ($checkedConvert) {
    final val = _IntensityStationSearchResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map(
              (e) => IntensityStationSearchItem.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$IntensityStationSearchResponseToJson(
  _IntensityStationSearchResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': instance.nextToken,
  'next_pooling': instance.nextPooling,
};

_EpicenterInfo _$EpicenterInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EpicenterInfo', json, ($checkedConvert) {
      final val = _EpicenterInfo(
        code: $checkedConvert('code', (v) => (v as num).toInt()),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$EpicenterInfoToJson(_EpicenterInfo instance) =>
    <String, dynamic>{'code': instance.code, 'name': instance.name};

_EpicenterSearchItem _$EpicenterSearchItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EpicenterSearchItem', json, ($checkedConvert) {
      final val = _EpicenterSearchItem(
        eventId: $checkedConvert('event_id', (v) => v as String),
        epicenter: $checkedConvert(
          'epicenter',
          (v) => EpicenterInfo.fromJson(v as Map<String, dynamic>),
        ),
        earthquake: $checkedConvert(
          'earthquake',
          (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$EpicenterSearchItemToJson(
  _EpicenterSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'epicenter': instance.epicenter,
  'earthquake': instance.earthquake,
};

_EpicenterSearchResponse _$EpicenterSearchResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EpicenterSearchResponse',
  json,
  ($checkedConvert) {
    final val = _EpicenterSearchResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map((e) => EpicenterSearchItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$EpicenterSearchResponseToJson(
  _EpicenterSearchResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': instance.nextToken,
  'next_pooling': instance.nextPooling,
};
