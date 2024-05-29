// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'notification_local_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationLocalSettingsModelImpl
    _$$NotificationLocalSettingsModelImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$NotificationLocalSettingsModelImpl',
          json,
          ($checkedConvert) {
            final val = _$NotificationLocalSettingsModelImpl(
              eew: $checkedConvert(
                  'eew',
                  (v) => v == null
                      ? const EewSettings()
                      : EewSettings.fromJson(v as Map<String, dynamic>)),
              earthquake: $checkedConvert(
                  'earthquake',
                  (v) => v == null
                      ? const EarthquakeSettings()
                      : EarthquakeSettings.fromJson(v as Map<String, dynamic>)),
            );
            return val;
          },
        );

Map<String, dynamic> _$$NotificationLocalSettingsModelImplToJson(
        _$NotificationLocalSettingsModelImpl instance) =>
    <String, dynamic>{
      'eew': instance.eew,
      'earthquake': instance.earthquake,
    };

_$EewSettingsImpl _$$EewSettingsImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EewSettingsImpl',
      json,
      ($checkedConvert) {
        final val = _$EewSettingsImpl(
          emergencyIntensity: $checkedConvert(
              'emergencyIntensity',
              (v) =>
                  $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v) ??
                  null),
          silentIntensity: $checkedConvert(
              'silentIntensity',
              (v) =>
                  $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v) ??
                  null),
          regions: $checkedConvert(
              'regions',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Region.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EewSettingsImplToJson(_$EewSettingsImpl instance) =>
    <String, dynamic>{
      'emergencyIntensity':
          _$JmaForecastIntensityEnumMap[instance.emergencyIntensity],
      'silentIntensity':
          _$JmaForecastIntensityEnumMap[instance.silentIntensity],
      'regions': instance.regions,
    };

const _$JmaForecastIntensityEnumMap = {
  JmaForecastIntensity.zero: '0',
  JmaForecastIntensity.one: '1',
  JmaForecastIntensity.two: '2',
  JmaForecastIntensity.three: '3',
  JmaForecastIntensity.four: '4',
  JmaForecastIntensity.fiveLower: '5-',
  JmaForecastIntensity.fiveUpper: '5+',
  JmaForecastIntensity.sixLower: '6-',
  JmaForecastIntensity.sixUpper: '6+',
  JmaForecastIntensity.seven: '7',
  JmaForecastIntensity.unknown: '不明',
};

_$EarthquakeSettingsImpl _$$EarthquakeSettingsImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeSettingsImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeSettingsImpl(
          emergencyIntensity: $checkedConvert(
              'emergencyIntensity',
              (v) =>
                  $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v) ??
                  null),
          silentIntensity: $checkedConvert(
              'silentIntensity',
              (v) =>
                  $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v) ??
                  null),
          regions: $checkedConvert(
              'regions',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Region.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeSettingsImplToJson(
        _$EarthquakeSettingsImpl instance) =>
    <String, dynamic>{
      'emergencyIntensity':
          _$JmaForecastIntensityEnumMap[instance.emergencyIntensity],
      'silentIntensity':
          _$JmaForecastIntensityEnumMap[instance.silentIntensity],
      'regions': instance.regions,
    };

_$RegionImpl _$$RegionImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$RegionImpl',
      json,
      ($checkedConvert) {
        final val = _$RegionImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          emergencyIntensity: $checkedConvert('emergencyIntensity',
              (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
          silentIntensity: $checkedConvert('silentIntensity',
              (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
          isMain: $checkedConvert('isMain', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$$RegionImplToJson(_$RegionImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'emergencyIntensity':
          _$JmaForecastIntensityEnumMap[instance.emergencyIntensity]!,
      'silentIntensity':
          _$JmaForecastIntensityEnumMap[instance.silentIntensity]!,
      'isMain': instance.isMain,
    };
