// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeV1Impl _$$EarthquakeV1ImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeV1Impl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeV1Impl(
          id: $checkedConvert('id', (v) => v as int),
          eventId: $checkedConvert('eventId', (v) => v as int),
          status: $checkedConvert('status', (v) => v as String),
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          magnitudeCondition:
              $checkedConvert('magnitudeCondition', (v) => v as String?),
          maxIntensity: $checkedConvert('maxIntensity',
              (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
          maxLpgmIntensity: $checkedConvert('maxLpgmIntensity',
              (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v)),
          depth: $checkedConvert('depth', (v) => v as int?),
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          epicenterCode: $checkedConvert('epicenterCode', (v) => v as int?),
          epicenterDetailCode:
              $checkedConvert('epicenterDetailCode', (v) => v as int?),
          arrivalTime: $checkedConvert('arrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          originTime: $checkedConvert('originTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          latestHeadline:
              $checkedConvert('latestHeadline', (v) => v as String?),
          maxIntensityREgionIds: $checkedConvert('maxIntensityREgionIds',
              (v) => (v as List<dynamic>?)?.map((e) => e as int).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeV1ImplToJson(_$EarthquakeV1Impl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'status': instance.status,
      'magnitude': instance.magnitude,
      'magnitudeCondition': instance.magnitudeCondition,
      'maxIntensity': _$JmaIntensityEnumMap[instance.maxIntensity],
      'maxLpgmIntensity': _$JmaLgIntensityEnumMap[instance.maxLpgmIntensity],
      'depth': instance.depth,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'epicenterCode': instance.epicenterCode,
      'epicenterDetailCode': instance.epicenterDetailCode,
      'arrivalTime': instance.arrivalTime?.toIso8601String(),
      'originTime': instance.originTime?.toIso8601String(),
      'latestHeadline': instance.latestHeadline,
      'maxIntensityREgionIds': instance.maxIntensityREgionIds,
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

const _$JmaLgIntensityEnumMap = {
  JmaLgIntensity.zero: '0',
  JmaLgIntensity.one: '1',
  JmaLgIntensity.two: '2',
  JmaLgIntensity.three: '3',
  JmaLgIntensity.four: '4',
};
