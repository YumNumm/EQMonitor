// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_setting_patch_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegionSettingPatchRequest _$RegionSettingPatchRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RegionSettingPatchRequest',
  json,
  ($checkedConvert) {
    final val = _RegionSettingPatchRequest(
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool,
      ),
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) =>
            $enumDecode(_$RegionSettingPatchRequestMinJmaIntensityEnumMap, v),
      ),
      regionName: $checkedConvert('region_name', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'isCurrentLocation': 'is_current_location',
    'minJmaIntensity': 'min_jma_intensity',
    'regionName': 'region_name',
  },
);

Map<String, dynamic> _$RegionSettingPatchRequestToJson(
  _RegionSettingPatchRequest instance,
) => <String, dynamic>{
  'is_current_location': instance.isCurrentLocation,
  'min_jma_intensity': instance.minJmaIntensity,
  'region_name': ?instance.regionName,
};

const _$RegionSettingPatchRequestMinJmaIntensityEnumMap = {
  RegionSettingPatchRequestMinJmaIntensity.value0: 0,
  RegionSettingPatchRequestMinJmaIntensity.value1: 1,
  RegionSettingPatchRequestMinJmaIntensity.value2: 2,
  RegionSettingPatchRequestMinJmaIntensity.value3: 3,
  RegionSettingPatchRequestMinJmaIntensity.value4: 4,
  RegionSettingPatchRequestMinJmaIntensity.value5unknown: '!5-',
  RegionSettingPatchRequestMinJmaIntensity.value5minus: '5-',
  RegionSettingPatchRequestMinJmaIntensity.value5plus: '5+',
  RegionSettingPatchRequestMinJmaIntensity.value6minus: '6-',
  RegionSettingPatchRequestMinJmaIntensity.value6plus: '6+',
  RegionSettingPatchRequestMinJmaIntensity.value7: 7,
};
