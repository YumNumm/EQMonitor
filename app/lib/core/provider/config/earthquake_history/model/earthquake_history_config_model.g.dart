// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'earthquake_history_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeHistoryConfigModelImpl _$$EarthquakeHistoryConfigModelImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$EarthquakeHistoryConfigModelImpl', json, (
  $checkedConvert,
) {
  final val = _$EarthquakeHistoryConfigModelImpl(
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

Map<String, dynamic> _$$EarthquakeHistoryConfigModelImplToJson(
  _$EarthquakeHistoryConfigModelImpl instance,
) => <String, dynamic>{'list': instance.list, 'detail': instance.detail};

_$EarthquakeHistoryListConfigImpl _$$EarthquakeHistoryListConfigImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$EarthquakeHistoryListConfigImpl',
  json,
  ($checkedConvert) {
    final val = _$EarthquakeHistoryListConfigImpl(
      isFillBackground: $checkedConvert(
        'is_fill_background',
        (v) => v as bool? ?? true,
      ),
      includeTestTelegrams: $checkedConvert(
        'include_test_telegrams',
        (v) => v as bool? ?? false,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'isFillBackground': 'is_fill_background',
    'includeTestTelegrams': 'include_test_telegrams',
  },
);

Map<String, dynamic> _$$EarthquakeHistoryListConfigImplToJson(
  _$EarthquakeHistoryListConfigImpl instance,
) => <String, dynamic>{
  'is_fill_background': instance.isFillBackground,
  'include_test_telegrams': instance.includeTestTelegrams,
};

_$EarthquakeHistoryDetailConfigImpl
_$$EarthquakeHistoryDetailConfigImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeHistoryDetailConfigImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeHistoryDetailConfigImpl(
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

Map<String, dynamic> _$$EarthquakeHistoryDetailConfigImplToJson(
  _$EarthquakeHistoryDetailConfigImpl instance,
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
