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
      subRegionId: $checkedConvert('sub_region_id', (v) => v as String?),
      minLevel: $checkedConvert(
        'min_level',
        (v) => $enumDecode(_$ShakeDetectionLevelEnumMap, v),
      ),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool,
      ),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      updatedAt: $checkedConvert('updated_at', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'subRegionId': 'sub_region_id',
    'minLevel': 'min_level',
    'isCurrentLocation': 'is_current_location',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$ShakeDetectionSettingResponseToJson(
  _ShakeDetectionSettingResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'sub_region_id': instance.subRegionId,
  'min_level': instance.minLevel,
  'is_current_location': instance.isCurrentLocation,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

const _$ShakeDetectionLevelEnumMap = {
  ShakeDetectionLevel.weaker: 'Weaker',
  ShakeDetectionLevel.weak: 'Weak',
  ShakeDetectionLevel.medium: 'Medium',
  ShakeDetectionLevel.strong: 'Strong',
  ShakeDetectionLevel.stronger: 'Stronger',
};
