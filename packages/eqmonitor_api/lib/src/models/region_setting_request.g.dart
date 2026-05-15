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
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      regionName: $checkedConvert('region_name', (v) => v as String?),
      cityCode: $checkedConvert('city_code', (v) => v as String?),
      cityName: $checkedConvert('city_name', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionId': 'region_id',
    'isCurrentLocation': 'is_current_location',
    'minJmaIntensity': 'min_jma_intensity',
    'regionName': 'region_name',
    'cityCode': 'city_code',
    'cityName': 'city_name',
  },
);

Map<String, dynamic> _$RegionSettingRequestToJson(
  _RegionSettingRequest instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'is_current_location': instance.isCurrentLocation,
  'min_jma_intensity': instance.minJmaIntensity,
  'region_name': ?instance.regionName,
  'city_code': ?instance.cityCode,
  'city_name': ?instance.cityName,
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.value0: '0',
  JmaIntensity.value1: '1',
  JmaIntensity.value2: '2',
  JmaIntensity.value3: '3',
  JmaIntensity.value4: '4',
  JmaIntensity.value5unknown: '!5-',
  JmaIntensity.value5minus: '5-',
  JmaIntensity.value5plus: '5+',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: '7',
};
