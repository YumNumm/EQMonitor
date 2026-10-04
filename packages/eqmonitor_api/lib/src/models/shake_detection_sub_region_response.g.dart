// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_sub_region_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionSubRegionResponse _$ShakeDetectionSubRegionResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('_ShakeDetectionSubRegionResponse', json, ($checkedConvert) {
      final val = _ShakeDetectionSubRegionResponse(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ShakeDetectionSubRegionResponseToJson(
  _ShakeDetectionSubRegionResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
};
