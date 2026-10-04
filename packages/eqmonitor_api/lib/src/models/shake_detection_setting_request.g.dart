// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_setting_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionSettingRequest _$ShakeDetectionSettingRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ShakeDetectionSettingRequest',
  json,
  ($checkedConvert) {
    final val = _ShakeDetectionSettingRequest(
      targetType: $checkedConvert(
        'target_type',
        (v) => $enumDecode(_$ShakeDetectionTargetTypeEnumMap, v),
      ),
      regionCode: $checkedConvert('region_code', (v) => v as String?),
      enabled: $checkedConvert('enabled', (v) => v as bool),
      minLevel: $checkedConvert(
        'min_level',
        (v) => $enumDecode(_$ShakeDetectionLevelEnumMap, v),
      ),
      sound: $checkedConvert('sound', (v) => v as String? ?? 'default'),
      interruptionLevel: $checkedConvert(
        'interruption_level',
        (v) =>
            $enumDecodeNullable(_$InterruptionLevelEnumMap, v) ??
            InterruptionLevel.active,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'targetType': 'target_type',
    'regionCode': 'region_code',
    'minLevel': 'min_level',
    'interruptionLevel': 'interruption_level',
  },
);

Map<String, dynamic> _$ShakeDetectionSettingRequestToJson(
  _ShakeDetectionSettingRequest instance,
) => <String, dynamic>{
  'target_type': instance.targetType,
  'region_code': instance.regionCode,
  'enabled': instance.enabled,
  'min_level': instance.minLevel,
  'sound': instance.sound,
  'interruption_level': instance.interruptionLevel,
};

const _$ShakeDetectionTargetTypeEnumMap = {
  ShakeDetectionTargetType.currentLocation: 'current_location',
  ShakeDetectionTargetType.nationwide: 'nationwide',
  ShakeDetectionTargetType.region: 'region',
};

const _$ShakeDetectionLevelEnumMap = {
  ShakeDetectionLevel.weaker: 'Weaker',
  ShakeDetectionLevel.weak: 'Weak',
  ShakeDetectionLevel.medium: 'Medium',
  ShakeDetectionLevel.strong: 'Strong',
  ShakeDetectionLevel.stronger: 'Stronger',
};

const _$InterruptionLevelEnumMap = {
  InterruptionLevel.passive: 'passive',
  InterruptionLevel.active: 'active',
  InterruptionLevel.timeSensitive: 'time_sensitive',
  InterruptionLevel.critical: 'critical',
};
