// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EewV1Impl _$$EewV1ImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$EewV1Impl',
      json,
      ($checkedConvert) {
        final val = _$EewV1Impl(
          id: $checkedConvert('id', (v) => v as int),
          eventId: $checkedConvert('eventId', (v) => v as int),
          type: $checkedConvert('type', (v) => v as String),
          schemaType: $checkedConvert('schemaType', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          infoType: $checkedConvert('infoType', (v) => v as String),
          serialno: $checkedConvert('serialno', (v) => v as int?),
          headline: $checkedConvert('headline', (v) => v as String?),
          isCanceled: $checkedConvert('isCanceled', (v) => v as bool),
          isWarning: $checkedConvert('isWarning', (v) => v as bool?),
          isLastInfo: $checkedConvert('isLastInfo', (v) => v as bool),
          originTime: $checkedConvert('originTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          arrivalTime: $checkedConvert('arrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          hypoName: $checkedConvert('hypoName', (v) => v as String?),
          depth: $checkedConvert('depth', (v) => v as int?),
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          forecastMaxIntensity: $checkedConvert('forecastMaxIntensity',
              (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v)),
          forecastMaxLpgmIntensity: $checkedConvert('forecastMaxLpgmIntensity',
              (v) => $enumDecodeNullable(_$JmaForecastLgIntensityEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EewV1ImplToJson(_$EewV1Impl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'type': instance.type,
      'schemaType': instance.schemaType,
      'status': instance.status,
      'infoType': instance.infoType,
      'serialno': instance.serialno,
      'headline': instance.headline,
      'isCanceled': instance.isCanceled,
      'isWarning': instance.isWarning,
      'isLastInfo': instance.isLastInfo,
      'originTime': instance.originTime?.toIso8601String(),
      'arrivalTime': instance.arrivalTime?.toIso8601String(),
      'hypoName': instance.hypoName,
      'depth': instance.depth,
      'magnitude': instance.magnitude,
      'forecastMaxIntensity':
          _$JmaForecastIntensityEnumMap[instance.forecastMaxIntensity],
      'forecastMaxLpgmIntensity':
          _$JmaForecastLgIntensityEnumMap[instance.forecastMaxLpgmIntensity],
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

const _$JmaForecastLgIntensityEnumMap = {
  JmaForecastLgIntensity.zero: '0',
  JmaForecastLgIntensity.one: '1',
  JmaForecastLgIntensity.two: '2',
  JmaForecastLgIntensity.three: '3',
  JmaForecastLgIntensity.four: '4',
  JmaForecastLgIntensity.unknown: '不明',
};
