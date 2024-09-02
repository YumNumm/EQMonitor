// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake_early.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeEarlyImpl _$$EarthquakeEarlyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeEarlyImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeEarlyImpl(
          id: $checkedConvert('id', (v) => v as String),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v)),
          maxIntensityIsEarly:
              $checkedConvert('max_intensity_is_early', (v) => v as bool),
          name: $checkedConvert('name', (v) => v as String),
          originTime: $checkedConvert(
              'origin_time', (v) => DateTime.parse(v as String)),
          originTimePrecision: $checkedConvert('origin_time_precision',
              (v) => $enumDecode(_$OriginTimePrecisionEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'maxIntensity': 'max_intensity',
        'maxIntensityIsEarly': 'max_intensity_is_early',
        'originTime': 'origin_time',
        'originTimePrecision': 'origin_time_precision'
      },
    );

Map<String, dynamic> _$$EarthquakeEarlyImplToJson(
        _$EarthquakeEarlyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'depth': instance.depth,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'magnitude': instance.magnitude,
      'max_intensity': _$JmaForecastIntensityEnumMap[instance.maxIntensity],
      'max_intensity_is_early': instance.maxIntensityIsEarly,
      'name': instance.name,
      'origin_time': instance.originTime.toIso8601String(),
      'origin_time_precision':
          _$OriginTimePrecisionEnumMap[instance.originTimePrecision]!,
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

const _$OriginTimePrecisionEnumMap = {
  OriginTimePrecision.month: 'month',
  OriginTimePrecision.day: 'day',
  OriginTimePrecision.hour: 'hour',
  OriginTimePrecision.minute: 'minute',
  OriginTimePrecision.second: 'second',
  OriginTimePrecision.millisecond: 'millisecond',
};
