// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeParameter _$EarthquakeParameterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeParameter', json, ($checkedConvert) {
      final val = _EarthquakeParameter(
        metadata: $checkedConvert(
          'metadata',
          (v) => ParameterMetadata.fromJson(v as Map<String, dynamic>),
        ),
        prefectures: $checkedConvert(
          'prefectures',
          (v) => (v as List<dynamic>)
              .map(
                (e) => EarthquakeParameterPrefectureItem.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeParameterToJson(
  _EarthquakeParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'prefectures': instance.prefectures,
};

_EarthquakeParameterPrefectureItem _$EarthquakeParameterPrefectureItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeParameterPrefectureItem', json, (
  $checkedConvert,
) {
  final val = _EarthquakeParameterPrefectureItem(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    regions: $checkedConvert(
      'regions',
      (v) => (v as List<dynamic>)
          .map(
            (e) => EarthquakeParameterRegionItem.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeParameterPrefectureItemToJson(
  _EarthquakeParameterPrefectureItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'regions': instance.regions,
};

_EarthquakeParameterRegionItem _$EarthquakeParameterRegionItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeParameterRegionItem', json, ($checkedConvert) {
  final val = _EarthquakeParameterRegionItem(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    kana: $checkedConvert('kana', (v) => v as String?),
    cities: $checkedConvert(
      'cities',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                EarthquakeParameterCityItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeParameterRegionItemToJson(
  _EarthquakeParameterRegionItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
  'cities': instance.cities,
};

_EarthquakeParameterCityItem _$EarthquakeParameterCityItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeParameterCityItem', json, ($checkedConvert) {
  final val = _EarthquakeParameterCityItem(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    kana: $checkedConvert('kana', (v) => v as String?),
    stations: $checkedConvert(
      'stations',
      (v) => (v as List<dynamic>)
          .map(
            (e) => EarthquakeParameterStationItem.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeParameterCityItemToJson(
  _EarthquakeParameterCityItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
  'stations': instance.stations,
};

_EarthquakeParameterStationItem _$EarthquakeParameterStationItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeParameterStationItem',
  json,
  ($checkedConvert) {
    final val = _EarthquakeParameterStationItem(
      code: $checkedConvert('code', (v) => v as String),
      noCode: $checkedConvert('no_code', (v) => v as String),
      name: $checkedConvert(
        'name',
        (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
      ),
      kana: $checkedConvert('kana', (v) => v as String?),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$EarthquakeStationStatusEnumMap, v),
      ),
      sourceStatus: $checkedConvert('source_status', (v) => v as String),
      owner: $checkedConvert('owner', (v) => v as String),
      location: $checkedConvert(
        'location',
        (v) => LatLng.fromJson(v as Map<String, dynamic>),
      ),
      arv400: $checkedConvert('arv_400', (v) => (v as num?)?.toDouble()),
    );
    return val;
  },
  fieldKeyMap: const {
    'noCode': 'no_code',
    'sourceStatus': 'source_status',
    'arv400': 'arv_400',
  },
);

Map<String, dynamic> _$EarthquakeParameterStationItemToJson(
  _EarthquakeParameterStationItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'no_code': instance.noCode,
  'name': instance.name,
  'kana': instance.kana,
  'status': _$EarthquakeStationStatusEnumMap[instance.status]!,
  'source_status': instance.sourceStatus,
  'owner': instance.owner,
  'location': instance.location,
  'arv_400': instance.arv400,
};

const _$EarthquakeStationStatusEnumMap = {
  EarthquakeStationStatus.operating: 'operating',
  EarthquakeStationStatus.changed: 'changed',
  EarthquakeStationStatus.valueNew: 'new',
  EarthquakeStationStatus.abolished: 'abolished',
  EarthquakeStationStatus.unknown: 'unknown',
};
