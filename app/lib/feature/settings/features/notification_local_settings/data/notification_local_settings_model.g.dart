// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_local_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationLocalSettingsModel _$NotificationLocalSettingsModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_NotificationLocalSettingsModel', json, ($checkedConvert) {
  final val = _NotificationLocalSettingsModel(
    eew: $checkedConvert(
      'eew',
      (v) => v == null
          ? const EewSettings()
          : EewSettings.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => v == null
          ? const EarthquakeSettings()
          : EarthquakeSettings.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$NotificationLocalSettingsModelToJson(
  _NotificationLocalSettingsModel instance,
) => <String, dynamic>{'eew': instance.eew, 'earthquake': instance.earthquake};

_EewSettings _$EewSettingsFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_EewSettings',
  json,
  ($checkedConvert) {
    final val = _EewSettings(
      emergencyIntensity: $checkedConvert(
        'emergency_intensity',
        (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v) ?? null,
      ),
      silentIntensity: $checkedConvert(
        'silent_intensity',
        (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v) ?? null,
      ),
      regions: $checkedConvert(
        'regions',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => Region.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'emergencyIntensity': 'emergency_intensity',
    'silentIntensity': 'silent_intensity',
  },
);

Map<String, dynamic> _$EewSettingsToJson(
  _EewSettings instance,
) => <String, dynamic>{
  'emergency_intensity':
      _$JmaForecastIntensityEnumMap[instance.emergencyIntensity],
  'silent_intensity': _$JmaForecastIntensityEnumMap[instance.silentIntensity],
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

_EarthquakeSettings _$EarthquakeSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EarthquakeSettings',
      json,
      ($checkedConvert) {
        final val = _EarthquakeSettings(
          emergencyIntensity: $checkedConvert(
            'emergency_intensity',
            (v) =>
                $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v) ?? null,
          ),
          silentIntensity: $checkedConvert(
            'silent_intensity',
            (v) =>
                $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v) ?? null,
          ),
          regions: $checkedConvert(
            'regions',
            (v) =>
                (v as List<dynamic>?)
                    ?.map((e) => Region.fromJson(e as Map<String, dynamic>))
                    .toList() ??
                const [],
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'emergencyIntensity': 'emergency_intensity',
        'silentIntensity': 'silent_intensity',
      },
    );

Map<String, dynamic> _$EarthquakeSettingsToJson(
  _EarthquakeSettings instance,
) => <String, dynamic>{
  'emergency_intensity':
      _$JmaForecastIntensityEnumMap[instance.emergencyIntensity],
  'silent_intensity': _$JmaForecastIntensityEnumMap[instance.silentIntensity],
  'regions': instance.regions,
};

_Region _$RegionFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Region',
  json,
  ($checkedConvert) {
    final val = _Region(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      emergencyIntensity: $checkedConvert(
        'emergency_intensity',
        (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v),
      ),
      silentIntensity: $checkedConvert(
        'silent_intensity',
        (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v),
      ),
      isMain: $checkedConvert('is_main', (v) => v as bool),
    );
    return val;
  },
  fieldKeyMap: const {
    'emergencyIntensity': 'emergency_intensity',
    'silentIntensity': 'silent_intensity',
    'isMain': 'is_main',
  },
);

Map<String, dynamic> _$RegionToJson(_Region instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'emergency_intensity':
      _$JmaForecastIntensityEnumMap[instance.emergencyIntensity]!,
  'silent_intensity': _$JmaForecastIntensityEnumMap[instance.silentIntensity]!,
  'is_main': instance.isMain,
};
