// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegionSettingResponse _$RegionSettingResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RegionSettingResponse',
  json,
  ($checkedConvert) {
    final val = _RegionSettingResponse(
      regionId: $checkedConvert('region_id', (v) => v as num),
      regionName: $checkedConvert('region_name', (v) => v as String?),
      cityCode: $checkedConvert('city_code', (v) => v as String?),
      cityName: $checkedConvert('city_name', (v) => v as String?),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool,
      ),
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      updatedAt: $checkedConvert('updated_at', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionId': 'region_id',
    'regionName': 'region_name',
    'cityCode': 'city_code',
    'cityName': 'city_name',
    'isCurrentLocation': 'is_current_location',
    'minJmaIntensity': 'min_jma_intensity',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$RegionSettingResponseToJson(
  _RegionSettingResponse instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'region_name': instance.regionName,
  'city_code': instance.cityCode,
  'city_name': instance.cityName,
  'is_current_location': instance.isCurrentLocation,
  'min_jma_intensity': instance.minJmaIntensity,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
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
