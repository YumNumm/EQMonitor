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
              (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
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
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
      'max_intensity_is_early': instance.maxIntensityIsEarly,
      'name': instance.name,
      'origin_time': instance.originTime.toIso8601String(),
      'origin_time_precision':
          _$OriginTimePrecisionEnumMap[instance.originTimePrecision]!,
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

const _$OriginTimePrecisionEnumMap = {
  OriginTimePrecision.month: 'month',
  OriginTimePrecision.day: 'day',
  OriginTimePrecision.hour: 'hour',
  OriginTimePrecision.minute: 'minute',
  OriginTimePrecision.second: 'second',
  OriginTimePrecision.millisecond: 'millisecond',
};

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
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          originTime: $checkedConvert(
              'origin_time', (v) => DateTime.parse(v as String)),
          originTimePrecision: $checkedConvert('origin_time_precision',
              (v) => $enumDecode(_$OriginTimePrecisionEnumMap, v)),
          maxIntensity: $checkedConvert('max_intensity',
              (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
          regions: $checkedConvert(
              'regions',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      EarthquakeEarlyRegion.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'originTime': 'origin_time',
        'originTimePrecision': 'origin_time_precision',
        'maxIntensity': 'max_intensity'
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
      'magnitude': instance.magnitude,
      'origin_time': instance.originTime.toIso8601String(),
      'origin_time_precision':
          _$OriginTimePrecisionEnumMap[instance.originTimePrecision]!,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
      'regions': instance.regions,
    };

_$EarthquakeEarlyRegionImpl _$$EarthquakeEarlyRegionImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeEarlyRegionImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeEarlyRegionImpl(
          name: $checkedConvert('name', (v) => v as String),
          code: $checkedConvert('code', (v) => (v as num).toInt()),
          maxIntensity: $checkedConvert(
              'max_intensity', (v) => $enumDecode(_$JmaIntensityEnumMap, v)),
          cities: $checkedConvert(
              'cities',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      EarthquakeEarlyCity.fromJson(e as Map<String, dynamic>))
                  .toList()),
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
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
      'cities': instance.cities,
    };

_$EarthquakeEarlyCityImpl _$$EarthquakeEarlyCityImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeEarlyCityImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeEarlyCityImpl(
          name: $checkedConvert('name', (v) => v as String),
          code: $checkedConvert('code', (v) => (v as num).toInt()),
          maxIntensity: $checkedConvert(
              'max_intensity', (v) => $enumDecode(_$JmaIntensityEnumMap, v)),
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
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
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
              latitude:
                  $checkedConvert('latitude', (v) => (v as num).toDouble()),
              longitude:
                  $checkedConvert('longitude', (v) => (v as num).toDouble()),
              intensity: $checkedConvert(
                  'intensity', (v) => $enumDecode(_$JmaIntensityEnumMap, v)),
            );
            return val;
          },
        );

Map<String, dynamic> _$$EarthquakeEarlyObservationPointImplToJson(
        _$EarthquakeEarlyObservationPointImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'intensity': _$JmaIntensityEnumMap[instance.intensity]!,
    };
