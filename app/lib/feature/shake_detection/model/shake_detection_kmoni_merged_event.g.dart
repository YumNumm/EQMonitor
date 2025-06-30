// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'shake_detection_kmoni_merged_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionKmoniMergedEvent _$ShakeDetectionKmoniMergedEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionKmoniMergedEvent', json, ($checkedConvert) {
  final val = _ShakeDetectionKmoniMergedEvent(
    event: $checkedConvert(
      'event',
      (v) => ShakeDetectionEvent.fromJson(v as Map<String, dynamic>),
    ),
    regions: $checkedConvert(
      'regions',
      (v) => (v as List<dynamic>)
          .map(
            (e) => ShakeDetectionKmoniMergedRegion.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ShakeDetectionKmoniMergedEventToJson(
  _ShakeDetectionKmoniMergedEvent instance,
) => <String, dynamic>{'event': instance.event, 'regions': instance.regions};

_ShakeDetectionKmoniMergedRegion _$ShakeDetectionKmoniMergedRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionKmoniMergedRegion', json, (
  $checkedConvert,
) {
  final val = _ShakeDetectionKmoniMergedRegion(
    name: $checkedConvert('name', (v) => v as String),
    maxIntensity: $checkedConvert(
      'maxIntensity',
      (v) =>
          $enumDecodeNullable(
            _$JmaForecastIntensityEnumMap,
            v,
            unknownValue: JmaForecastIntensity.unknown,
          ) ??
          JmaForecastIntensity.unknown,
    ),
    points: $checkedConvert(
      'points',
      (v) => (v as List<dynamic>)
          .map(
            (e) => ShakeDetectionKmoniMergedPoint.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ShakeDetectionKmoniMergedRegionToJson(
  _ShakeDetectionKmoniMergedRegion instance,
) => <String, dynamic>{
  'name': instance.name,
  'maxIntensity': _$JmaForecastIntensityEnumMap[instance.maxIntensity]!,
  'points': instance.points,
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

_ShakeDetectionKmoniMergedPoint _$ShakeDetectionKmoniMergedPointFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionKmoniMergedPoint', json, ($checkedConvert) {
  final val = _ShakeDetectionKmoniMergedPoint(
    intensity: $checkedConvert(
      'intensity',
      (v) =>
          $enumDecodeNullable(
            _$JmaForecastIntensityEnumMap,
            v,
            unknownValue: JmaForecastIntensity.unknown,
          ) ??
          JmaForecastIntensity.unknown,
    ),
    code: $checkedConvert('code', (v) => v as String),
    point: $checkedConvert(
      'point',
      (v) => KyoshinObservationPoint.fromJson(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$ShakeDetectionKmoniMergedPointToJson(
  _ShakeDetectionKmoniMergedPoint instance,
) => <String, dynamic>{
  'intensity': _$JmaForecastIntensityEnumMap[instance.intensity]!,
  'code': instance.code,
  'point': _pointToJson(instance.point),
};
