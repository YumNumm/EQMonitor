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
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toDouble()),
          originTime: $checkedConvert(
              'origin_time', (v) => DateTime.parse(v as String)),
          originTimePrecision: $checkedConvert('origin_time_precision',
              (v) => $enumDecode(_$OriginTimePrecisionEnumMap, v)),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
          maxIntensityIsEarly:
              $checkedConvert('max_intensity_is_early', (v) => v as bool),
          regions: $checkedConvert(
              'regions',
              (v) => (v as List<dynamic>)
                  .map((e) => EarthquakeEarlyEventRegion.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          cities: $checkedConvert(
              'cities',
              (v) => (v as List<dynamic>)
                  .map((e) => EarthquakeEarlyEventObservationCity.fromJson(
                      e as Map<String, dynamic>))
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
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'depth': instance.depth,
      'origin_time': instance.originTime.toIso8601String(),
      'origin_time_precision':
          _$OriginTimePrecisionEnumMap[instance.originTimePrecision]!,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
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

const _$JmaIntensityEnumMap = {
  JmaIntensity.one: '1',
  JmaIntensity.two: '2',
  JmaIntensity.three: '3',
  JmaIntensity.four: '4',
  JmaIntensity.fiveLower: '5-',
  JmaIntensity.fiveUpper: '5+',
  JmaIntensity.sixLower: '6-',
  JmaIntensity.sixUpper: '6+',
  JmaIntensity.seven: '7',
  JmaIntensity.fiveUpperNoInput: '!5-',
};

_$EarthquakeEarlyEventRegionImpl _$$EarthquakeEarlyEventRegionImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeEarlyEventRegionImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeEarlyEventRegionImpl(
          name: $checkedConvert('name', (v) => v as String?),
          code: $checkedConvert('code', (v) => v as String?),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'maxIntensity': 'max_intensity'},
    );

Map<String, dynamic> _$$EarthquakeEarlyEventRegionImplToJson(
        _$EarthquakeEarlyEventRegionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
    };

_$EarthquakeEarlyEventObservationCityImpl
    _$$EarthquakeEarlyEventObservationCityImplFromJson(
            Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$EarthquakeEarlyEventObservationCityImpl',
          json,
          ($checkedConvert) {
            final val = _$EarthquakeEarlyEventObservationCityImpl(
              name: $checkedConvert('name', (v) => v as String),
              code: $checkedConvert('code', (v) => v as String?),
              maxIntensity: $checkedConvert('max_intensity',
                  (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
              observationPoints: $checkedConvert(
                  'observation_points',
                  (v) => (v as List<dynamic>)
                      .map((e) => EarthquakeEarlyEventObservationPoint.fromJson(
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

Map<String, dynamic> _$$EarthquakeEarlyEventObservationCityImplToJson(
        _$EarthquakeEarlyEventObservationCityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
      'observation_points': instance.observationPoints,
    };

_$EarthquakeEarlyEventObservationPointImpl
    _$$EarthquakeEarlyEventObservationPointImplFromJson(
            Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$EarthquakeEarlyEventObservationPointImpl',
          json,
          ($checkedConvert) {
            final val = _$EarthquakeEarlyEventObservationPointImpl(
              lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
              lon: $checkedConvert('lon', (v) => (v as num).toDouble()),
              name: $checkedConvert('name', (v) => v as String),
              intensity: $checkedConvert(
                  'intensity', (v) => $enumDecode(_$JmaIntensityEnumMap, v)),
            );
            return val;
          },
        );

Map<String, dynamic> _$$EarthquakeEarlyEventObservationPointImplToJson(
        _$EarthquakeEarlyEventObservationPointImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'name': instance.name,
      'intensity': _$JmaIntensityEnumMap[instance.intensity]!,
    };
