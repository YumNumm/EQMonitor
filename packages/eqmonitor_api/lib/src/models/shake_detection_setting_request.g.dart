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
      subRegionId: $checkedConvert('sub_region_id', (v) => v as String?),
      prefectureCode: $checkedConvert('prefecture_code', (v) => v as String?),
      cityCode: $checkedConvert('city_code', (v) => v as String?),
      minLevel: $checkedConvert(
        'min_level',
        (v) => $enumDecode(_$ShakeDetectionLevelEnumMap, v),
      ),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'subRegionId': 'sub_region_id',
    'prefectureCode': 'prefecture_code',
    'cityCode': 'city_code',
    'minLevel': 'min_level',
    'isCurrentLocation': 'is_current_location',
  },
);

Map<String, dynamic> _$ShakeDetectionSettingRequestToJson(
  _ShakeDetectionSettingRequest instance,
) => <String, dynamic>{
  'sub_region_id': instance.subRegionId,
  'prefecture_code': instance.prefectureCode,
  'city_code': instance.cityCode,
  'min_level': instance.minLevel,
  'is_current_location': instance.isCurrentLocation,
};

const _$ShakeDetectionLevelEnumMap = {
  ShakeDetectionLevel.weaker: 'Weaker',
  ShakeDetectionLevel.weak: 'Weak',
  ShakeDetectionLevel.medium: 'Medium',
  ShakeDetectionLevel.strong: 'Strong',
  ShakeDetectionLevel.stronger: 'Stronger',
};
