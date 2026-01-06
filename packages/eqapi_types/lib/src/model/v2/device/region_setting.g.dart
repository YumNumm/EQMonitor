// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'region_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegionSetting _$RegionSettingFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_RegionSetting',
      json,
      ($checkedConvert) {
        final val = _RegionSetting(
          regionId: $checkedConvert('region_id', (v) => (v as num).toInt()),
          regionName: $checkedConvert('region_name', (v) => v as String?),
          isCurrentLocation: $checkedConvert(
            'is_current_location',
            (v) => v as bool,
          ),
          minJmaIntensity: $checkedConvert(
            'min_jma_intensity',
            (v) => $enumDecode(_$DeviceJmaIntensityEnumMap, v),
          ),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'regionId': 'region_id',
        'regionName': 'region_name',
        'isCurrentLocation': 'is_current_location',
        'minJmaIntensity': 'min_jma_intensity',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
      },
    );

Map<String, dynamic> _$RegionSettingToJson(
  _RegionSetting instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'region_name': instance.regionName,
  'is_current_location': instance.isCurrentLocation,
  'min_jma_intensity': _$DeviceJmaIntensityEnumMap[instance.minJmaIntensity]!,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

const _$DeviceJmaIntensityEnumMap = {
  DeviceJmaIntensity.zero: '0',
  DeviceJmaIntensity.one: '1',
  DeviceJmaIntensity.two: '2',
  DeviceJmaIntensity.three: '3',
  DeviceJmaIntensity.four: '4',
  DeviceJmaIntensity.unknownFiveLower: '!5-',
  DeviceJmaIntensity.fiveLower: '5-',
  DeviceJmaIntensity.fiveUpper: '5+',
  DeviceJmaIntensity.sixLower: '6-',
  DeviceJmaIntensity.sixUpper: '6+',
  DeviceJmaIntensity.seven: '7',
};

_RegionSettingRequest _$RegionSettingRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RegionSettingRequest',
  json,
  ($checkedConvert) {
    final val = _RegionSettingRequest(
      regionId: $checkedConvert('region_id', (v) => (v as num).toInt()),
      regionName: $checkedConvert('region_name', (v) => v as String?),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool,
      ),
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) => $enumDecode(_$DeviceJmaIntensityEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionId': 'region_id',
    'regionName': 'region_name',
    'isCurrentLocation': 'is_current_location',
    'minJmaIntensity': 'min_jma_intensity',
  },
);

Map<String, dynamic> _$RegionSettingRequestToJson(
  _RegionSettingRequest instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'region_name': instance.regionName,
  'is_current_location': instance.isCurrentLocation,
  'min_jma_intensity': _$DeviceJmaIntensityEnumMap[instance.minJmaIntensity]!,
};

_RegionSettingPatchRequest _$RegionSettingPatchRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RegionSettingPatchRequest',
  json,
  ($checkedConvert) {
    final val = _RegionSettingPatchRequest(
      regionName: $checkedConvert('region_name', (v) => v as String?),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool?,
      ),
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) => $enumDecodeNullable(_$DeviceJmaIntensityEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionName': 'region_name',
    'isCurrentLocation': 'is_current_location',
    'minJmaIntensity': 'min_jma_intensity',
  },
);

Map<String, dynamic> _$RegionSettingPatchRequestToJson(
  _RegionSettingPatchRequest instance,
) => <String, dynamic>{
  'region_name': instance.regionName,
  'is_current_location': instance.isCurrentLocation,
  'min_jma_intensity': _$DeviceJmaIntensityEnumMap[instance.minJmaIntensity],
};
