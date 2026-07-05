// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeHistoryConfig _$EarthquakeHistoryConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeHistoryConfig', json, ($checkedConvert) {
  final val = _EarthquakeHistoryConfig(
    list: $checkedConvert(
      'list',
      (v) => EarthquakeHistoryListConfig.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeHistoryConfigToJson(
  _EarthquakeHistoryConfig instance,
) => <String, dynamic>{'list': instance.list};

_EarthquakeHistoryListConfig _$EarthquakeHistoryListConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeHistoryListConfig',
  json,
  ($checkedConvert) {
    final val = _EarthquakeHistoryListConfig(
      isFillBackground: $checkedConvert(
        'is_fill_background',
        (v) => v as bool? ?? true,
      ),
      designatedRegionSearchType: $checkedConvert(
        'designated_region_search_type',
        (v) => $enumDecodeNullable(_$RegionSearchTypeEnumMap, v),
      ),
      designatedRegionCode: $checkedConvert(
        'designated_region_code',
        (v) => v as String?,
      ),
      designatedRegionName: $checkedConvert(
        'designated_region_name',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'isFillBackground': 'is_fill_background',
    'designatedRegionSearchType': 'designated_region_search_type',
    'designatedRegionCode': 'designated_region_code',
    'designatedRegionName': 'designated_region_name',
  },
);

Map<String, dynamic> _$EarthquakeHistoryListConfigToJson(
  _EarthquakeHistoryListConfig instance,
) => <String, dynamic>{
  'is_fill_background': instance.isFillBackground,
  'designated_region_search_type':
      _$RegionSearchTypeEnumMap[instance.designatedRegionSearchType],
  'designated_region_code': instance.designatedRegionCode,
  'designated_region_name': instance.designatedRegionName,
};

const _$RegionSearchTypeEnumMap = {
  RegionSearchType.prefecture: 'prefecture',
  RegionSearchType.region: 'region',
  RegionSearchType.city: 'city',
  RegionSearchType.station: 'station',
};
