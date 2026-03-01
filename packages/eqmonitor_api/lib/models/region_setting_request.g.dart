// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_setting_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegionSettingRequest _$RegionSettingRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RegionSettingRequest',
  json,
  ($checkedConvert) {
    final val = _RegionSettingRequest(
      regionId: $checkedConvert('region_id', (v) => v as num),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool,
      ),
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) => $enumDecode(_$RegionSettingRequestMinJmaIntensityEnumMap, v),
      ),
      regionName: $checkedConvert('region_name', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionId': 'region_id',
    'isCurrentLocation': 'is_current_location',
    'minJmaIntensity': 'min_jma_intensity',
    'regionName': 'region_name',
  },
);

Map<String, dynamic> _$RegionSettingRequestToJson(
  _RegionSettingRequest instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'is_current_location': instance.isCurrentLocation,
  'min_jma_intensity': instance.minJmaIntensity,
  'region_name': ?instance.regionName,
};

const _$RegionSettingRequestMinJmaIntensityEnumMap = {
  RegionSettingRequestMinJmaIntensity.value0: 0,
  RegionSettingRequestMinJmaIntensity.value1: 1,
  RegionSettingRequestMinJmaIntensity.value2: 2,
  RegionSettingRequestMinJmaIntensity.value3: 3,
  RegionSettingRequestMinJmaIntensity.value4: 4,
  RegionSettingRequestMinJmaIntensity.undefined0: '!5-',
  RegionSettingRequestMinJmaIntensity.value5: '5-',
  RegionSettingRequestMinJmaIntensity.value5: '5+',
  RegionSettingRequestMinJmaIntensity.value6: '6-',
  RegionSettingRequestMinJmaIntensity.value6: '6+',
  RegionSettingRequestMinJmaIntensity.value7: 7,
};
