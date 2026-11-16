// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionSettingsModel _$ShakeDetectionSettingsModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ShakeDetectionSettingsModel',
  json,
  ($checkedConvert) {
    final val = _ShakeDetectionSettingsModel(
      isEnabled: $checkedConvert('is_enabled', (v) => v as bool? ?? false),
      isBackfillEnabled: $checkedConvert(
        'is_backfill_enabled',
        (v) => v as bool? ?? true,
      ),
      parameterOverrides: $checkedConvert(
        'parameter_overrides',
        (v) =>
            (v as Map<String, dynamic>?)?.map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            ) ??
            const <String, double>{},
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'isEnabled': 'is_enabled',
    'isBackfillEnabled': 'is_backfill_enabled',
    'parameterOverrides': 'parameter_overrides',
  },
);

Map<String, dynamic> _$ShakeDetectionSettingsModelToJson(
  _ShakeDetectionSettingsModel instance,
) => <String, dynamic>{
  'is_enabled': instance.isEnabled,
  'is_backfill_enabled': instance.isBackfillEnabled,
  'parameter_overrides': instance.parameterOverrides,
};
