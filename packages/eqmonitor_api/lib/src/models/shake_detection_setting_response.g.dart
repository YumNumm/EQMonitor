// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionSettingResponse _$ShakeDetectionSettingResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ShakeDetectionSettingResponse',
  json,
  ($checkedConvert) {
    final val = _ShakeDetectionSettingResponse(
      id: $checkedConvert('id', (v) => v as String),
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
      createdAt: $checkedConvert('created_at', (v) => v as String),
      updatedAt: $checkedConvert('updated_at', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'targetType': 'target_type',
    'regionCode': 'region_code',
    'minLevel': 'min_level',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$ShakeDetectionSettingResponseToJson(
  _ShakeDetectionSettingResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'target_type': instance.targetType,
  'region_code': instance.regionCode,
  'enabled': instance.enabled,
  'min_level': instance.minLevel,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
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
