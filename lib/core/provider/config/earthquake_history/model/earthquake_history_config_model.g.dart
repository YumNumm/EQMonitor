// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeHistoryConfigModelImpl _$$EarthquakeHistoryConfigModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeHistoryConfigModelImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeHistoryConfigModelImpl(
          list: $checkedConvert(
              'list',
              (v) => EarthquakeHistoryListConfig.fromJson(
                  v as Map<String, dynamic>)),
          detail: $checkedConvert(
              'detail',
              (v) => EarthquakeHistoryDetailConfig.fromJson(
                  v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeHistoryConfigModelImplToJson(
        _$EarthquakeHistoryConfigModelImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'detail': instance.detail,
    };

_$EarthquakeHistoryListConfigImpl _$$EarthquakeHistoryListConfigImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeHistoryListConfigImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeHistoryListConfigImpl(
          isFillBackground:
              $checkedConvert('isFillBackground', (v) => v as bool? ?? true),
          includeTestTelegrams: $checkedConvert(
              'includeTestTelegrams', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeHistoryListConfigImplToJson(
        _$EarthquakeHistoryListConfigImpl instance) =>
    <String, dynamic>{
      'isFillBackground': instance.isFillBackground,
      'includeTestTelegrams': instance.includeTestTelegrams,
    };

_$EarthquakeHistoryDetailConfigImpl
    _$$EarthquakeHistoryDetailConfigImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$EarthquakeHistoryDetailConfigImpl',
          json,
          ($checkedConvert) {
            final val = _$EarthquakeHistoryDetailConfigImpl(
              intensityDisplayMode: $checkedConvert(
                  'intensityDisplayMode',
                  (v) =>
                      $enumDecodeNullable(_$IntensityDisplayModeEnumMap, v) ??
                      IntensityDisplayMode.fillCity),
            );
            return val;
          },
        );

Map<String, dynamic> _$$EarthquakeHistoryDetailConfigImplToJson(
        _$EarthquakeHistoryDetailConfigImpl instance) =>
    <String, dynamic>{
      'intensityDisplayMode':
          _$IntensityDisplayModeEnumMap[instance.intensityDisplayMode]!,
    };

const _$IntensityDisplayModeEnumMap = {
  IntensityDisplayMode.icon: 'icon',
  IntensityDisplayMode.fillCity: 'fillCity',
  IntensityDisplayMode.fillPrefecture: 'fillPrefecture',
  IntensityDisplayMode.iconAndFillPrefecture: 'iconAndFillPrefecture',
};
