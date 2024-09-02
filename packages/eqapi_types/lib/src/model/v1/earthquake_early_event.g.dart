// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake_early_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeEarlyEventImpl _$$EarthquakeEarlyEventImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeEarlyEventImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeEarlyEventImpl(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          lat: $checkedConvert('lat', (v) => (v as num?)?.toDouble()),
          lon: $checkedConvert('lon', (v) => (v as num?)?.toDouble()),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toDouble()),
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          originTime: $checkedConvert(
              'origin_time', (v) => DateTime.parse(v as String)),
          originTimePrecision: $checkedConvert('origin_time_precision',
              (v) => $enumDecode(_$OriginTimePrecisionEnumMap, v)),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v)),
          maxIntensityIsEarly:
              $checkedConvert('max_intensity_is_early', (v) => v as bool),
          regions: $checkedConvert(
              'regions',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      EarthquakeEarlyRegion.fromJson(e as Map<String, dynamic>))
                  .toList()),
          cities: $checkedConvert(
              'cities',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      EarthquakeEarlyCity.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'originTime': 'origin_time',
        'originTimePrecision': 'origin_time_precision',
        'maxIntensity': 'max_intensity',
        'maxIntensityIsEarly': 'max_intensity_is_early'
      },
    );

Map<String, dynamic> _$$EarthquakeEarlyEventImplToJson(
        _$EarthquakeEarlyEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'depth': instance.depth,
      'magnitude': instance.magnitude,
      'origin_time': instance.originTime.toIso8601String(),
      'origin_time_precision':
          _$OriginTimePrecisionEnumMap[instance.originTimePrecision]!,
      'max_intensity': _$JmaForecastIntensityEnumMap[instance.maxIntensity],
      'max_intensity_is_early': instance.maxIntensityIsEarly,
      'regions': instance.regions,
      'cities': instance.cities,
    };

const _$OriginTimePrecisionEnumMap = {
  OriginTimePrecision.month: 'month',
  OriginTimePrecision.day: 'day',
  OriginTimePrecision.hour: 'hour',
  OriginTimePrecision.minute: 'minute',
  OriginTimePrecision.second: 'second',
  OriginTimePrecision.millisecond: 'millisecond',
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

_$EarthquakeEarlyRegionImpl _$$EarthquakeEarlyRegionImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeEarlyRegionImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeEarlyRegionImpl(
          name: $checkedConvert('name', (v) => v as String),
          code: $checkedConvert('code', (v) => v as String),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'maxIntensity': 'max_intensity'},
    );

Map<String, dynamic> _$$EarthquakeEarlyRegionImplToJson(
        _$EarthquakeEarlyRegionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'max_intensity': _$JmaForecastIntensityEnumMap[instance.maxIntensity]!,
    };

_$EarthquakeEarlyCityImpl _$$EarthquakeEarlyCityImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeEarlyCityImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeEarlyCityImpl(
          name: $checkedConvert('name', (v) => v as String),
          code: $checkedConvert('code', (v) => v as String?),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
          observationPoints: $checkedConvert(
              'observation_points',
              (v) => (v as List<dynamic>)
                  .map((e) => EarthquakeEarlyObservationPoint.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'maxIntensity': 'max_intensity',
        'observationPoints': 'observation_points'
      },
    );

Map<String, dynamic> _$$EarthquakeEarlyCityImplToJson(
        _$EarthquakeEarlyCityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'max_intensity': _$JmaForecastIntensityEnumMap[instance.maxIntensity]!,
      'observation_points': instance.observationPoints,
    };

_$EarthquakeEarlyObservationPointImpl
    _$$EarthquakeEarlyObservationPointImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$EarthquakeEarlyObservationPointImpl',
          json,
          ($checkedConvert) {
            final val = _$EarthquakeEarlyObservationPointImpl(
              name: $checkedConvert('name', (v) => v as String),
              lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
              lon: $checkedConvert('lon', (v) => (v as num).toDouble()),
              intensity: $checkedConvert('intensity',
                  (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
            );
            return val;
          },
        );

Map<String, dynamic> _$$EarthquakeEarlyObservationPointImplToJson(
        _$EarthquakeEarlyObservationPointImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'intensity': _$JmaForecastIntensityEnumMap[instance.intensity]!,
    };
