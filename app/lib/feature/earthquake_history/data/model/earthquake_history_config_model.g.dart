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
    details: $checkedConvert(
      'details',
      (v) => v == null
          ? const EarthquakeHistoryDetailsConfig()
          : EarthquakeHistoryDetailsConfig.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeHistoryConfigToJson(
  _EarthquakeHistoryConfig instance,
) => <String, dynamic>{
  'list': instance.list.toJson(),
  'details': instance.details.toJson(),
};

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
      dateHeaderDisplayMode: $checkedConvert(
        'date_header_display_mode',
        (v) =>
            $enumDecodeNullable(_$DateHeaderDisplayModeEnumMap, v) ??
            DateHeaderDisplayMode.onlyWhenDateSort,
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
    'dateHeaderDisplayMode': 'date_header_display_mode',
    'designatedRegionSearchType': 'designated_region_search_type',
    'designatedRegionCode': 'designated_region_code',
    'designatedRegionName': 'designated_region_name',
  },
);

Map<String, dynamic> _$EarthquakeHistoryListConfigToJson(
  _EarthquakeHistoryListConfig instance,
) => <String, dynamic>{
  'is_fill_background': instance.isFillBackground,
  'date_header_display_mode':
      _$DateHeaderDisplayModeEnumMap[instance.dateHeaderDisplayMode]!,
  'designated_region_search_type':
      _$RegionSearchTypeEnumMap[instance.designatedRegionSearchType],
  'designated_region_code': instance.designatedRegionCode,
  'designated_region_name': instance.designatedRegionName,
};

const _$DateHeaderDisplayModeEnumMap = {
  DateHeaderDisplayMode.always: 'always',
  DateHeaderDisplayMode.onlyWhenDateSort: 'onlyWhenDateSort',
  DateHeaderDisplayMode.never: 'never',
};

const _$RegionSearchTypeEnumMap = {
  RegionSearchType.prefecture: 'prefecture',
  RegionSearchType.region: 'region',
  RegionSearchType.city: 'city',
  RegionSearchType.station: 'station',
};

_EarthquakeHistoryDetailsConfig _$EarthquakeHistoryDetailsConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeHistoryDetailsConfig',
  json,
  ($checkedConvert) {
    final val = _EarthquakeHistoryDetailsConfig(
      stationDisplayMode: $checkedConvert(
        'station_display_mode',
        (v) =>
            $enumDecodeNullable(_$StationDisplayModeEnumMap, v) ??
            StationDisplayMode.auto,
      ),
    );
    return val;
  },
  fieldKeyMap: const {'stationDisplayMode': 'station_display_mode'},
);

Map<String, dynamic> _$EarthquakeHistoryDetailsConfigToJson(
  _EarthquakeHistoryDetailsConfig instance,
) => <String, dynamic>{
  'station_display_mode':
      _$StationDisplayModeEnumMap[instance.stationDisplayMode]!,
};

const _$StationDisplayModeEnumMap = {
  StationDisplayMode.auto: 'auto',
  StationDisplayMode.maxFocused: 'maxFocused',
  StationDisplayMode.normal: 'normal',
  StationDisplayMode.allMinimized: 'allMinimized',
};
