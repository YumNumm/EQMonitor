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
        (v) => v == null
            ? null
            : const JmaIntensityJsonConverter().fromJson(v as String?),
      ),
      silentIntensity: $checkedConvert(
        'silent_intensity',
        (v) => v == null
            ? null
            : const JmaIntensityJsonConverter().fromJson(v as String?),
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

Map<String, dynamic> _$EewSettingsToJson(_EewSettings instance) =>
    <String, dynamic>{
      'emergency_intensity': const JmaIntensityJsonConverter().toJson(
        instance.emergencyIntensity,
      ),
      'silent_intensity': const JmaIntensityJsonConverter().toJson(
        instance.silentIntensity,
      ),
      'regions': instance.regions,
    };

_EarthquakeSettings _$EarthquakeSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EarthquakeSettings',
      json,
      ($checkedConvert) {
        final val = _EarthquakeSettings(
          emergencyIntensity: $checkedConvert(
            'emergency_intensity',
            (v) => v == null
                ? null
                : const JmaIntensityJsonConverter().fromJson(v as String?),
          ),
          silentIntensity: $checkedConvert(
            'silent_intensity',
            (v) => v == null
                ? null
                : const JmaIntensityJsonConverter().fromJson(v as String?),
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

Map<String, dynamic> _$EarthquakeSettingsToJson(_EarthquakeSettings instance) =>
    <String, dynamic>{
      'emergency_intensity': const JmaIntensityJsonConverter().toJson(
        instance.emergencyIntensity,
      ),
      'silent_intensity': const JmaIntensityJsonConverter().toJson(
        instance.silentIntensity,
      ),
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
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      silentIntensity: $checkedConvert(
        'silent_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
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
  'emergency_intensity': _$JmaIntensityEnumMap[instance.emergencyIntensity]!,
  'silent_intensity': _$JmaIntensityEnumMap[instance.silentIntensity]!,
  'is_main': instance.isMain,
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};
