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
      intensityFillMode: $checkedConvert(
        'intensity_fill_mode',
        (v) =>
            $enumDecodeNullable(_$IntensityFillModeEnumMap, v) ??
            IntensityFillMode.fillCity,
      ),
      showIntensityIcon: $checkedConvert(
        'show_intensity_icon',
        (v) => v as bool? ?? true,
      ),
      showingLpgmIntensity: $checkedConvert(
        'showing_lpgm_intensity',
        (v) => v as bool? ?? false,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'intensityFillMode': 'intensity_fill_mode',
    'showIntensityIcon': 'show_intensity_icon',
    'showingLpgmIntensity': 'showing_lpgm_intensity',
  },
);

Map<String, dynamic> _$EarthquakeHistoryDetailConfigToJson(
  _EarthquakeHistoryDetailConfig instance,
) => <String, dynamic>{
  'intensity_fill_mode':
      _$IntensityFillModeEnumMap[instance.intensityFillMode]!,
  'show_intensity_icon': instance.showIntensityIcon,
  'showing_lpgm_intensity': instance.showingLpgmIntensity,
};

const _$IntensityFillModeEnumMap = {
  IntensityFillMode.fillCity: 'fillCity',
  IntensityFillMode.fillRegion: 'fillRegion',
  IntensityFillMode.none: 'none',
};
