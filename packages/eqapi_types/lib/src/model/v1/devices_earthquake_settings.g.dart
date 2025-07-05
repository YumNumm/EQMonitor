// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'devices_earthquake_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DevicesEarthquakeSettings _$DevicesEarthquakeSettingsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_DevicesEarthquakeSettings',
  json,
  ($checkedConvert) {
    final val = _DevicesEarthquakeSettings(
      id: $checkedConvert('id', (v) => v as String),
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v),
      ),
      regionId: $checkedConvert('region_id', (v) => (v as num).toInt()),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'minJmaIntensity': 'min_jma_intensity',
    'regionId': 'region_id',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$DevicesEarthquakeSettingsToJson(
  _DevicesEarthquakeSettings instance,
) => <String, dynamic>{
  'id': instance.id,
  'min_jma_intensity': _$JmaForecastIntensityEnumMap[instance.minJmaIntensity]!,
  'region_id': instance.regionId,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$JmaForecastIntensityEnumMap = {
  JmaForecastIntensity.zero: '0',
  JmaForecastIntensity.one: '1',
  JmaForecastIntensity.two: '2',
  JmaForecastIntensity.three: '3',
  JmaForecastIntensity.four: '4',
  JmaForecastIntensity.fiveLower: '5-',
  JmaForecastIntensity.fiveUpper: '5+',
  JmaForecastIntensity.sixLower: '6-',
  JmaForecastIntensity.sixUpper: '6+',
  JmaForecastIntensity.seven: '7',
  JmaForecastIntensity.unknown: '不明',
};
