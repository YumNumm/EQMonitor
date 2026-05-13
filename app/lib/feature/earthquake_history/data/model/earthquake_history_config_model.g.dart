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
    detail: $checkedConvert(
      'detail',
      (v) => EarthquakeHistoryDetailConfig.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeHistoryConfigToJson(
  _EarthquakeHistoryConfig instance,
) => <String, dynamic>{'list': instance.list, 'detail': instance.detail};

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
  RegionSearchType.city: 'city',
};

_EarthquakeHistoryDetailConfig _$EarthquakeHistoryDetailConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeHistoryDetailConfig',
  json,
  ($checkedConvert) {
    final val = _EarthquakeHistoryDetailConfig(
      iconMode: $checkedConvert(
        'icon_mode',
        (v) =>
            $enumDecodeNullable(
              _$EarthquakeHistoryIconModeEnumMap,
              v,
              unknownValue: EarthquakeHistoryIconMode.auto,
            ) ??
            EarthquakeHistoryIconMode.auto,
      ),
      fillMode: $checkedConvert(
        'fill_mode',
        (v) =>
            $enumDecodeNullable(
              _$EarthquakeHistoryFillModeEnumMap,
              v,
              unknownValue: EarthquakeHistoryFillMode.none,
            ) ??
            EarthquakeHistoryFillMode.matchIcon,
      ),
      stationDisplayMode: $checkedConvert(
        'station_display_mode',
        (v) =>
            $enumDecodeNullable(_$StationDisplayModeEnumMap, v) ??
            StationDisplayMode.maxFocused,
      ),
      hypocenterDisplayMode: $checkedConvert(
        'hypocenter_display_mode',
        (v) =>
            $enumDecodeNullable(_$HypocenterDisplayModeEnumMap, v) ??
            HypocenterDisplayMode.zoomFade,
      ),
      showHypocenterError: $checkedConvert(
        'show_hypocenter_error',
        (v) => v as bool? ?? false,
      ),
      showStationLabel: $checkedConvert(
        'show_station_label',
        (v) => v as bool? ?? false,
      ),
      useEstimatedIntensityWhenAvailable: $checkedConvert(
        'use_estimated_intensity_when_available',
        (v) => v as bool? ?? true,
      ),
      showLegend: $checkedConvert('show_legend', (v) => v as bool? ?? true),
      showingLpgmIntensity: $checkedConvert(
        'showing_lpgm_intensity',
        (v) => v as bool? ?? false,
      ),
      showStation: $checkedConvert('show_station', (v) => v as bool? ?? true),
    );
    return val;
  },
  fieldKeyMap: const {
    'iconMode': 'icon_mode',
    'fillMode': 'fill_mode',
    'stationDisplayMode': 'station_display_mode',
    'hypocenterDisplayMode': 'hypocenter_display_mode',
    'showHypocenterError': 'show_hypocenter_error',
    'showStationLabel': 'show_station_label',
    'useEstimatedIntensityWhenAvailable':
        'use_estimated_intensity_when_available',
    'showLegend': 'show_legend',
    'showingLpgmIntensity': 'showing_lpgm_intensity',
    'showStation': 'show_station',
  },
);

Map<String, dynamic> _$EarthquakeHistoryDetailConfigToJson(
  _EarthquakeHistoryDetailConfig instance,
) => <String, dynamic>{
  'icon_mode': _$EarthquakeHistoryIconModeEnumMap[instance.iconMode]!,
  'fill_mode': _$EarthquakeHistoryFillModeEnumMap[instance.fillMode]!,
  'station_display_mode':
      _$StationDisplayModeEnumMap[instance.stationDisplayMode]!,
  'hypocenter_display_mode':
      _$HypocenterDisplayModeEnumMap[instance.hypocenterDisplayMode]!,
  'show_hypocenter_error': instance.showHypocenterError,
  'show_station_label': instance.showStationLabel,
  'use_estimated_intensity_when_available':
      instance.useEstimatedIntensityWhenAvailable,
  'show_legend': instance.showLegend,
  'showing_lpgm_intensity': instance.showingLpgmIntensity,
  'show_station': instance.showStation,
};

const _$EarthquakeHistoryIconModeEnumMap = {
  EarthquakeHistoryIconMode.auto: 'auto',
  EarthquakeHistoryIconMode.station: 'station',
  EarthquakeHistoryIconMode.municipality: 'municipality',
  EarthquakeHistoryIconMode.region: 'region',
  EarthquakeHistoryIconMode.none: 'none',
};

const _$EarthquakeHistoryFillModeEnumMap = {
  EarthquakeHistoryFillMode.none: 'none',
  EarthquakeHistoryFillMode.matchIcon: 'matchIcon',
};

const _$StationDisplayModeEnumMap = {
  StationDisplayMode.maxFocused: 'maxFocused',
  StationDisplayMode.normal: 'normal',
  StationDisplayMode.allMinimized: 'allMinimized',
};

const _$HypocenterDisplayModeEnumMap = {
  HypocenterDisplayMode.zoomFade: 'zoomFade',
  HypocenterDisplayMode.alwaysOpaque: 'alwaysOpaque',
  HypocenterDisplayMode.belowStations: 'belowStations',
};
